<?php

include_once(DIR_SYSTEM . 'library/kazshipping/kazshipping.php');
include_once(DIR_SYSTEM . 'library/kazpost/Classes/PHPExcel/IOFactory.php');
@include_once(DIR_SYSTEM . 'license/sllic.lic');

class ModelShippingKazpost extends Model
{

    function getQuote($address)
    {
        $extension = version_compare(VERSION, '2.3.0', '>=') ? "extension/" : "";
        $this->load->language($extension . 'shipping/kazpost');
        $server = $this->config->get('kazpost_api_server');
        $file = $server === '2' ? $this->config->get('kazpost_server2_xls') : $this->config->get('kazpost_server1_xls');
        $methods = $server === '2' ? unserialize($this->config->get('kazpost_methods-server2')) : unserialize($this->config->get('kazpost_methods-server1'));
        $sheet = $this->config->get('kazpost_fromto_sheetname');
        $code =  $server === '2' ? 1 : 0;

        // проверим, что адрес попадает в геозону
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "zone_to_geo_zone WHERE geo_zone_id = '" . (int) $this->config->get('kazpost_geo_zone_id') . "' AND country_id = '" . (int) $address['country_id'] . "' AND (zone_id = '" . (int) $address['zone_id'] . "' OR zone_id = '0')");

        if (!$this->config->get('kazpost_geo_zone_id')) {
            $status = true;
        } elseif ($query->num_rows) {
            $status = true;
        } else {
            $status = false;
        }

        $method_data = array();

        if ($status) {

            // Прикинем вес
            if ($this->config->get('config_weight_class_id') == 1) {
                $weight = $this->cart->getWeight() * 1000;
            } else {
                $weight = $this->cart->getWeight();
            }

            $destination_city = mb_strtolower(trim(explode(',', $address['city'])[0]), 'UTF-8');
            $destination_id = false;

            $objPHPExcel = PHPExcel_IOFactory::load(DIR_SYSTEM . $file);
            $objPHPExcel->setActiveSheetIndexByName($this->config->get('kazpost_fromto_sheetname'));
            $aSheet = $code === 0 ? $objPHPExcel->getActiveSheet()->toArray(true, true) : $objPHPExcel->getActiveSheet()->toArray(true, true, true);

            foreach ($aSheet as $aSheet) {
                if ($destination_city == mb_strtolower(trim($aSheet[$code + 1]), 'UTF-8')) {
                    $destination_id = $aSheet[$code];
                }
            }

            $quote_data = array();
            $q = 0;

            // переключаемся на пользовательский обработчик
            function myErrorHandler($errno, $errstr, $errfile, $errline)
            {
                if (!(error_reporting() & $errno)) {
                    // Этот код ошибки не включен в error_reporting,
                    // так что пусть обрабатываются стандартным обработчиком ошибок PHP
                    return false;
                }

                switch ($errno) {
                    case E_USER_ERROR:
                        echo "<b>Пользовательская ОШИБКА</b> [$errno] $errstr<br />\n";
                        echo "  Фатальная ошибка в строке $errline файла $errfile";
                        echo ", PHP " . PHP_VERSION . " (" . PHP_OS . ")<br />\n";
                        echo "Завершение работы...<br />\n";
                        exit(1);
                        break;

                    case E_USER_WARNING:
                        echo "$errstr";
                        break;

                    case E_USER_NOTICE:
                        echo "<b>Пользовательское УВЕДОМЛЕНИЕ</b> [$errno] $errstr<br />\n";
                        break;

                    default:
                        //  echo "Неизвестная ошибка: [$errno] $errstr<br />\n";
                        break;
                }

                /* Не запускаем внутренний обработчик ошибок PHP */
                return true;
            }

            $crashesn = 0;
            $max_connect = 3;

            foreach ($methods as $method) {
                // расчет стоимости этой доставки
                if ($destination_id) {
                    if (class_exists('Vendor')) {
                        $vendor = new Vendor();
                    }
                    $vendor->franchise();

                    if ($server === '1') {
                        $client = new KazpostWebClient();
                        $mailinfo = new MailInfo();
                        $mailinfo->Product = ($method['product_id'] !== '-1') ? $method['product_id'] : '';
                        $mailinfo->MailCat = ($method['mailcat_id'] !== '-1') ? $method['mailcat_id'] : '';
                        $mailinfo->SendMethod = ($method['sendmethod_id'] !== '-1') ? $method['sendmethod_id'] : '';
                        $mailinfo->SpecMarks = ($method['specmarks_id'] !== '-1') ? $method['specmarks_id'] : '';
                        $mailinfo->Weight = $weight;
                        $mailinfo->From = $this->config->get('kazpost_origin_id');
                        $mailinfo->To = $destination_id;
                        $params = new stdClass();
                        $params->MailInfo = $mailinfo;

                        $old_error_handler = set_error_handler("myErrorHandler");
                        do {
                            try {                                
                                $response = $client->GetPostRate($params);
                                if (is_soap_fault($response)) {
                                    throw new \Exception('Данные недоступны');
                                } else {
                                    $crashesn = $max_connect;
                                    restore_error_handler();
                                }
                            } catch (\Exception $e) {
                                $crashesn++;

                                if ($crashesn < $max_connect) {
                                    sleep(1);
                                } else {
                                    $response->ResponseInfo->ResponseText = '';
                                    trigger_error("Сервер недоступен", E_USER_WARNING);
                                }
                            }
                        } while ($crashesn < $max_connect);

                        if (!isset($response->PostRate)) {
                            $rate = 'null';
                        } else {
                            $rate = $response->PostRate;
                        }
                    }

                    if ($server === '2') {
                        $client = new KazpostWebClient2();
                        $info = new GetPostRateInfo();
                        $info->SndrCtg = ($method['sndrctg_id'] !== '-1') ? $method['sndrctg_id'] : '';
                        $info->Product = ($method['product_id'] !== '-1') ? $method['product_id'] : '';
                        $info->MailCat = ($method['mailcat_id'] !== '-1') ? $method['mailcat_id'] : '';
                        $info->SendMethod = ($method['sendmethod_id'] !== '-1') ? $method['sendmethod_id'] : '';
                        $info->Value =  $this->config->get('kazpost_declared_value');
                        $info->Weight = $weight;
                        $info->From = $this->config->get('kazpost_origin_id2');
                        $info->To = $destination_id;
                        $info->PostMark =  '';
                        $params = new stdClass();
                        $params->GetPostRateInfo = $info;

                        $old_error_handler = set_error_handler("myErrorHandler");
                        do {
                            try {                                
                                $response = $client->GetPostRate($params);
                                if (is_soap_fault($response)) {
                                    throw new \Exception('Данные недоступны');
                                } else {
                                    $crashesn = $max_connect;
                                    restore_error_handler();
                                }
                            } catch (\Exception $e) {
                                $crashesn++;

                                if ($crashesn < $max_connect) {
                                    sleep(1);
                                } else {
                                    $response->ResponseInfo->ResponseText = '';
                                    trigger_error("Сервер недоступен", E_USER_WARNING);
                                }
                            }
                        } while ($crashesn < $max_connect);

                        if (!isset($response->Sum)) {
                            $rate = 'null';
                        } else {
                            $rate = $response->Sum;
                        }
                    }

                    if ($this->config->get('kazpost_pack') != 'null' && $rate != 'null') {  // упаковка
                        $rate += (int) $this->config->get('kazpost_pack');
                    }

                    // теперь выдача результатов расчета на checkout

                    $quote_data['kazpost_' . (string) $q] = array(
                        'code' => 'kazpost.kazpost_' . (string) $q,
                        'title' => $this->language->get('text_description') . $method['name'],
                        'cost' => ($rate === 'null') ? $response->ResponseInfo->ResponseText : $rate,
                        'tax_class_id' => $this->config->get('kazpost_tax_class_id'),
                        'text' => $this->currency->format($this->tax->calculate($rate, $this->config->get('kazpost_tax_class_id'), $this->config->get('config_tax')), 'KZT', 1),
                        'sort_order' => $method['sort_order'],
                    );
                } else {

                    $quote_data['kazpost_' . (string) $q] = array(
                        'code' => 'kazpost.kazpost_' . (string) $q,
                        'title' => $this->language->get('text_description') . $method['name'],
                        'cost' => 0,
                        'tax_class_id' => $this->config->get('kazpost_tax_class_id'),
                        'text' => $this->language->get('error_destination_city'),
                        'sort_order' => $method['sort_order'],
                    );
                }

                $q++;
            }

            $sort_order = array();

            foreach ($quote_data as $key => $value) {
                $sort_order[$key] = $value['sort_order'];
            }

            array_multisort($sort_order, SORT_ASC, $quote_data);

            $method_data = array(
                'code' => 'kazpost',
                'title' => $this->language->get('text_title'),
                'quote' => $quote_data,
                'sort_order' => $this->config->get('kazpost_sort_order'),
                'error' => false
            );
        }
        return $method_data;
    }
}

class ModelExtensionShippingKazpost extends ModelShippingKazpost
{ }
