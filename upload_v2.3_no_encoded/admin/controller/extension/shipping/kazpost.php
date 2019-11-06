<?php

include_once(DIR_SYSTEM . 'library/kazshipping/kazshipping.php');
include_once(DIR_SYSTEM . 'library/kazpost/Classes/PHPExcel/IOFactory.php');
define('MODULE_VERSION', 'v2.1.6');

class ControllerShippingKazpost extends Controller
{

    private $error = array();

    public function index()
    {
        $extension = version_compare(VERSION, '2.3.0', '>=') ? "extension/" : "";
        $link = version_compare(VERSION, '2.3.0', '>=') ? "extension/extension" : "extension/shipping";
        $this->load->language($extension . 'shipping/kazpost');

        $this->document->setTitle($this->language->get('heading_title'));

        $this->load->model('setting/setting');

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

            $this->request->post['kazpost_methods-server1'] = serialize($this->request->post['kazpost_methods-server1']);
            $this->request->post['kazpost_methods-server2'] = serialize($this->request->post['kazpost_methods-server2']);

            $this->model_setting_setting->editSetting('kazpost', $this->request->post);

            $this->session->data['success'] = $this->language->get('text_success');

            $this->response->redirect($this->url->link($link, 'token=' . $this->session->data['token'], 'SSL'));
        }

        $data['heading_title'] = $this->language->get('heading_title') . ' ' . MODULE_VERSION;
        $data['kazpost_title'] = $this->language->get('kazpost_title');
        $data['ems_title'] = $this->language->get('ems_title');

        $data['tab_general'] = $this->language->get('tab_general');
        $data['tab_data'] = $this->language->get('tab_data');
        $data['tab_kazpost'] = $this->language->get('tab_kazpost');
        $data['tab_calc'] = $this->language->get('tab_calc');
        $data['tab_support'] = $this->language->get('tab_support');

        $data['column_name'] = $this->language->get('column_name');
        $data['column_path'] = $this->language->get('column_path');
        $data['column_sheet'] = $this->language->get('column_sheet');
        $data['column_try'] = $this->language->get('column_try');
        $data['column_method_name'] = $this->language->get('column_method_name');
        $data['column_sort_order'] = $this->language->get('column_sort_order');
        $data['column_action'] = $this->language->get('column_action');
        $data['column_product'] = $this->language->get('column_product');
        $data['column_sendmethod'] = $this->language->get('column_sendmethod');
        $data['column_mailcat'] = $this->language->get('column_mailcat');
        $data['column_specmarks'] = $this->language->get('column_specmarks');
        $data['column_sndrctg'] = $this->language->get('column_sndrctg');

        $data['text_edit'] = $this->language->get('text_edit');
        $data['text_enabled'] = $this->language->get('text_enabled');
        $data['text_disabled'] = $this->language->get('text_disabled');
        $data['text_all_zones'] = $this->language->get('text_all_zones');
        $data['text_none'] = $this->language->get('text_none');
        $data['text_no_results'] = $this->language->get('text_no_results');
        $data['text_confirm'] = $this->language->get('text_confirm');
        $data['text_mailcat'] = $this->language->get('text_mailcat');
        $data['text_fromto'] = $this->language->get('text_fromto');
        $data['text_size'] = $this->language->get('text_size');
        $data['text_sendmethod'] = $this->language->get('text_sendmethod');
        $data['text_pagination'] = $this->language->get('text_pagination');
        $data['text_server1'] = $this->language->get('text_server1');
        $data['text_server2'] = $this->language->get('text_server2');

        $data['entry_tax_class'] = $this->language->get('entry_tax_class');
        $data['entry_geo_zone'] = $this->language->get('entry_geo_zone');
        $data['entry_status'] = $this->language->get('entry_status');
        $data['entry_sort_order'] = $this->language->get('entry_sort_order');
        $data['entry_origin1'] = $this->language->get('entry_origin1');
        $data['entry_origin2'] = $this->language->get('entry_origin2');
        $data['entry_weight'] = $this->language->get('entry_weight');
        $data['entry_to'] = $this->language->get('entry_to');
        $data['entry_rate'] = $this->language->get('entry_rate');
        $data['entry_pack'] = $this->language->get('entry_pack');
        $data['entry_declared_value'] = $this->language->get('entry_declared_value');
        $data['entry_api_server'] = $this->language->get('entry_api_server');
        $data['entry_server1_xls'] = $this->language->get('entry_server1_xls');
        $data['entry_server2_xls'] = $this->language->get('entry_server2_xls');
        $data['entry_fromto_sheetname'] = $this->language->get('entry_fromto_sheetname');

        $data['help_origin'] = $this->language->get('help_origin');
        $data['help_data_xls'] = $this->language->get('help_data_xls');
        $data['help_data_select'] = $this->language->get('help_data_select');
        $data['help_data_input'] = $this->language->get('help_data_input');
        $data['help_kazpost_try'] = $this->language->get('help_kazpost_try');
        $data['help_api_server'] = $this->language->get('help_api_server');
        $data['help_declared_value'] = $this->language->get('help_declared_value');
        $data['help_fromto_sheetname'] = $this->language->get('help_fromto_sheetname');

        $data['button_save'] = $this->language->get('button_save');
        $data['button_cancel'] = $this->language->get('button_cancel');
        $data['button_add'] = $this->language->get('button_add');
        $data['button_edit'] = $this->language->get('button_edit');
        $data['button_delete'] = $this->language->get('button_delete');

        $data['error_ajax_responce'] = $this->language->get('error_ajax_responce');
        $data['error_origin'] = $this->language->get('error_origin');

        if (isset($this->error['warning'])) {
            $data['error_warning'] = $this->error['warning'];
        } else {
            $data['error_warning'] = '';
        }

        if (isset($this->error['origin'])) {
            $data['error_origin'] = $this->error['origin'];
        } else {
            $data['error_origin'] = '';
        }

        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
        );

        $data['breadcrumbs'][] = array(
            'text' => version_compare(VERSION, '2.3.0', '>=') ? $this->language->get('text_extension') : $this->language->get('text_shipping'),
            'href' => $this->url->link($link, 'token=' . $this->session->data['token'], 'SSL')
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title'),
            'href' => $this->url->link($extension . 'shipping/kazpost', 'token=' . $this->session->data['token'], 'SSL')
        );

        $data['action'] = $this->url->link($extension . 'shipping/kazpost', 'token=' . $this->session->data['token'], 'SSL');

        $data['cancel'] = $this->url->link($link, 'token=' . $this->session->data['token'], 'SSL');

        $data['token'] = $this->session->data['token'];

        if (isset($this->request->post['kazpost_tax_class_id'])) {
            $data['kazpost_tax_class_id'] = $this->request->post['kazpost_tax_class_id'];
        } else {
            $data['kazpost_tax_class_id'] = $this->config->get('kazpost_tax_class_id');
        }

        $this->load->model('localisation/tax_class');

        $data['tax_classes'] = $this->model_localisation_tax_class->getTaxClasses();

        $this->load->model('localisation/geo_zone');

        $data['geo_zones'] = $this->model_localisation_geo_zone->getGeoZones();

        if (isset($this->request->post['kazpost_geo_zone_id'])) {
            $data['kazpost_geo_zone_id'] = $this->request->post['kazpost_geo_zone_id'];
        } else {
            $data['kazpost_geo_zone_id'] = $this->config->get('kazpost_geo_zone_id');
        }

        if (isset($this->request->post['kazpost_status'])) {
            $data['kazpost_status'] = $this->request->post['kazpost_status'];
        } else {
            $data['kazpost_status'] = $this->config->get('kazpost_status');
        }

        if (isset($this->request->post['kazpost_sort_order'])) {
            $data['kazpost_sort_order'] = $this->request->post['kazpost_sort_order'];
        } else {
            $data['kazpost_sort_order'] = $this->config->get('kazpost_sort_order');
        }

        if (isset($this->request->post['kazpost_api_server'])) {
            $data['kazpost_api_server'] = $this->request->post['kazpost_api_server'];
        } else {
            $data['kazpost_api_server'] = $this->config->get('kazpost_api_server');
        }

        if (isset($this->request->post['kazpost_pack'])) {
            $data['kazpost_pack'] = $this->request->post['kazpost_pack'];
        } else {
            $data['kazpost_pack'] = $this->config->get('kazpost_pack');
        }

        if (isset($this->request->post['kazpost_declared_value'])) {
            $data['kazpost_declared_value'] = $this->request->post['kazpost_declared_value'];
        } else {
            $data['kazpost_declared_value'] = $this->config->get('kazpost_declared_value');
        }

        // Справочники
        if (isset($this->request->post['kazpost_server1_xls'])) {
            $data['kazpost_server1_xls'] = $this->request->post['kazpost_server1_xls'];
        } else {
            $data['kazpost_server1_xls'] = $this->config->get('kazpost_server1_xls');
        }

        if (isset($this->request->post['kazpost_server2_xls'])) {
            $data['kazpost_server2_xls'] = $this->request->post['kazpost_server2_xls'];
        } else {
            $data['kazpost_server2_xls'] = $this->config->get('kazpost_server2_xls');
        }

        if (isset($this->request->post['kazpost_fromto_sheetname'])) {
            $data['kazpost_fromto_sheetname'] = $this->request->post['kazpost_fromto_sheetname'];
        } else {
            $data['kazpost_fromto_sheetname'] = $this->config->get('kazpost_fromto_sheetname');
        }

        if (isset($this->request->post['kazpost_origin_city-1'])) {
            $data['kazpost_origin_city1'] = $this->request->post['kazpost_origin_city-1'];
        } else {
            $data['kazpost_origin_city1'] = $this->config->get('kazpost_origin_city-1');
        }

        if (isset($this->request->post['kazpost_origin_id1'])) {
            $data['kazpost_origin_id1'] = $this->request->post['kazpost_origin_id1'];
        } else {
            $data['kazpost_origin_id1'] = $this->config->get('kazpost_origin_id1');
        }

        if (isset($this->request->post['kazpost_origin_city-2'])) {
            $data['kazpost_origin_city2'] = $this->request->post['kazpost_origin_city-2'];
        } else {
            $data['kazpost_origin_city2'] = $this->config->get('kazpost_origin_city-2');
        }

        if (isset($this->request->post['kazpost_origin_id2'])) {
            $data['kazpost_origin_id2'] = $this->request->post['kazpost_origin_id2'];
        } else {
            $data['kazpost_origin_id2'] = $this->config->get('kazpost_origin_id2');
        }

        // Казпочта методы
        if (isset($this->session->data['success'])) {
            $data['success'] = $this->session->data['success'];
            unset($this->session->data['success']);
        } else {
            $data['success'] = '';
        }

        if ($this->config->get('kazpost_methods-server1')) {
            $data['kazpost_methods'] = unserialize($this->config->get('kazpost_methods-server1'));
        }
        if ($this->config->get('kazpost_methods-server2')) {
            $data['kazpost_methods2'] = unserialize($this->config->get('kazpost_methods-server2'));
        }

        if (isset($this->request->post['weight'])) {
            $data['weight'] = $this->request->post['weight'];
        } else {
            $data['weight'] = '';
        }

        if (isset($this->request->post['destination'])) {
            $data['destination'] = $this->request->post['destination'];
        } else {
            $data['destination'] = '';
        }

        if (isset($this->request->post['destination_id'])) {
            $data['destination_id'] = $this->request->post['destination_id'];
        } else {
            $data['destination_id'] = '';
        }

        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

        $tpl = version_compare(VERSION, '2.2.0', '>=') ? "" : ".tpl";
        $this->response->setOutput($this->load->view($extension . 'shipping/kazpost' . $tpl, $data));
        // $this->response->setOutput($this->load->view('shipping/kazpost.tpl', $data));
    }

    protected function validate()
    {
        $extension = version_compare(VERSION, '2.3.0', '>=') ? "extension/" : "";
        if (!$this->user->hasPermission('modify', $extension . 'shipping/kazpost')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        if ((utf8_strlen($this->request->post['kazpost_origin_city-1']) === 0)) {
            $this->error['origin'] = $this->language->get('error_origin');
        }

        if ((utf8_strlen($this->request->post['kazpost_origin_city-2']) === 0)) {
            $this->error['origin'] = $this->language->get('error_origin');
        }

        return !$this->error;
    }

    public function autocomplete()
    {
        $json = array();

        if (isset($this->request->get['file'])) {
            $file = $this->request->get['file'];
        } else {
            $file = '';
        }

        if (isset($this->request->get['sheet'])) {
            $sheet = $this->request->get['sheet'];
        } else {
            $sheet = '';
        }

        if (isset($this->request->get['server'])) {
            $server = $this->request->get['server'];
        } else {
            $server = '';
        }

        if ($server === "server1" && ($sheet == 'Product' || $sheet == 'SpecMarks')) {
            $client = new KazpostWebClient();
            $helperinfo = new HelperInfo();
            $params = new stdClass();

            $helperinfo->HelperType = strtoupper($sheet);
            $params->HelperInfo = $helperinfo;
            $helper = $client->GetHelper($params)->HelperList->Helper;

            foreach ($helper as $help) {
                $json[] = array(
                    'id' => $help->ID,
                    'title' => strip_tags(html_entity_decode($help->Value, ENT_QUOTES, 'UTF-8'))
                );
            }
        } else {
            $code = $sheet === "Product" || ($sheet === $this->config->get('kazpost_fromto_sheetname') && $server === '2') ? 1 : 0;

            $objPHPExcel = PHPExcel_IOFactory::load(DIR_SYSTEM . $file);
            $objPHPExcel->setActiveSheetIndexByName($sheet);
            $aSheet = $code === 0 ? $objPHPExcel->getActiveSheet()->toArray(true, true) : $objPHPExcel->getActiveSheet()->toArray(true, true, true);

            foreach ($aSheet as $aSheet) {
                if (is_numeric($aSheet[0])) {
                    $json[] = array(
                        'id' => $aSheet[$code],
                        'title' => strip_tags(html_entity_decode($aSheet[$code + 1], ENT_QUOTES, 'UTF-8'))
                    );
                }
            }
        }


        $sort_order = array();

        foreach ($json as $key => $value) {
            $sort_order[$key] = $value['title'];
        }

        array_multisort($sort_order, SORT_ASC, $json);

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

    public function apigetrate2()
    {
        $products = array(
            'P101', 'P102', 'P103', 'P104', 'P105', 'P109', 'P111', 'P112', 'P113', 'P114', 'P115', 'P118', 'P201', 'P202', 'P203', 'P204', 'P205', 'P206', 'P207', 'P208', 'P209', 'P210', 'P212', 'P213', 'P214',
        );
        $sndrctds = array('1', '2', '3', '4', '5', '6',);
        $mailcats = array('0', '1', '2', '3', '4', '5',);
        $postmarks = array(
            '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20',
            '21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35', '36', '37', '38', '39', '40',
            '41', '42', '43', '44', '45', '46', '47', '48', '49', '50', '51', '52', '53', '54', '55', '56', '57', '58', '59', '60',
            '61', '62', '63', '64', '65', '66', '67', '68', '69', '70', '71', '72', '73', '74', '75', '76', '77', '78', '79', '80',
            '81', '82', '83', '84', '85', '86', '87', '88', '89', '90', '91', '92', '93', '94', '95', '96', '97', '98', '99', '100',
            '101', '102', '103', '104', '105', '106', '107', '108', '109', '110', '111', '112', '113', '114', '115', '116', '117', '118', '119', '120',
            '121', '122', '123', '124', '125', '126', '127', '128', '129', '130', '131', '132', '133', '134', '135', '136', '137', '138', '139', '140',
            '141', '142', '143', '144', '145', '146',
        );

        $client = new KazpostWebClient2();
        $info = new GetPostRateInfo();
        set_time_limit(2200);
        //foreach ($products as $product) {
        //	foreach($mailcats as $mailcat){
        //	foreach($sndrctds as $sndrctd){
        foreach ($postmarks as $postmark) {
            $info->SndrCtg = '1';
            $info->Product = 'P104';
            $info->MailCat = '1';
            $info->SendMethod = '2';
            $info->Value = '15000';
            $info->PostMark = $postmark;
            $info->Weight = '1000';
            $info->From = $this->config->get('kazpost_origin_id2');
            $info->To = '010000';
            $params = new stdClass();
            $params->GetPostRateInfo = $info;

            $response = $client->GetPostRate($params);
            if ($response->ResponseInfo->ResponseText == "success") {
                file_put_contents("kazpost.txt", print_r($info, true), FILE_APPEND);
                file_put_contents("kazpost.txt", print_r(PHP_EOL, true), FILE_APPEND);
                file_put_contents("kazpost.txt", print_r($response, true), FILE_APPEND);
                file_put_contents("kazpost.txt", print_r(PHP_EOL, true), FILE_APPEND);
            }
            if (!isset($response->Sum)) {
                $rate = 'null';
            } else {
                $rate = $response->Sum;
            }
            //	}
            //}
            //}
        }
        if ($this->config->get('kazpost_pack') != 'null' && $rate != 'null') {  // упаковка
            $rate += (int) $this->config->get('kazpost_pack');
        }

        $this->response->setOutput(($rate === 'null') ? $response->ResponseInfo->ResponseText : $rate);
    }

    public function apigetrate()
    {

        if (isset($this->request->get['id'])) {
            $id = $this->request->get['id'];
        } else {
            $id = '';
        }

        if (isset($this->request->get['weight'])) {
            $weight = $this->request->get['weight'] * 1000;
        } else {
            $weight = '';
        }

        if (isset($this->request->get['destination_id'])) {
            $destination_id = $this->request->get['destination_id'];
        } else {
            $destination_id = '';
        }

        $rate = '';

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

        if ($this->config->get('kazpost_api_server') === '1' && $destination_id) {
            $methods = unserialize($this->config->get('kazpost_methods-server1'));
            $method = $methods[$id];

            $client = new KazpostWebClient();
            $mailinfo = new MailInfo();

            $mailinfo->Product = ($method['product_id'] !== '-1') ? $method['product_id'] : '';
            $mailinfo->MailCat = ($method['mailcat_id'] !== '-1') ? $method['mailcat_id'] : '';
            $mailinfo->SendMethod = ($method['sendmethod_id'] !== '-1') ? $method['sendmethod_id'] : '';
            $mailinfo->SpecMarks = ($method['specmarks_id'] !== '-1') ? $method['specmarks_id'] : '';
            $mailinfo->Weight = $weight;
            $mailinfo->From = $this->config->get('kazpost_origin_id1');
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
                        $response->ResponseInfo->ResponseText = ''; // иначе вылетит в конце на NOTICE $response is not obj
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

        if ($this->config->get('kazpost_api_server') === '2' && $destination_id) {
            $methods = unserialize($this->config->get('kazpost_methods-server2'));
            $method = $methods[$id];

            $client = new KazpostWebClient2();
            $info = new GetPostRateInfo();

            $info->SndrCtg = ($method['sndrctg_id'] !== '-1') ? $method['sndrctg_id'] : '';
            $info->Product = ($method['product_id'] !== '-1') ? $method['product_id'] : '';
            $info->MailCat = ($method['mailcat_id'] !== '-1') ? $method['mailcat_id'] : '';
            $info->SendMethod = ($method['sendmethod_id'] !== '-1') ? $method['sendmethod_id'] : '';
            $info->Value = $this->config->get('kazpost_declared_value');
            $info->Weight = $weight;
            $info->From = $this->config->get('kazpost_origin_id2');
            $info->To = $destination_id;
            // $info->PostMark = '';
            $params = new stdClass();
            $params->GetPostRateInfo = $info;
            /*  $funcs = $client->__getFunctions(); */

            $old_error_handler = set_error_handler("myErrorHandler");
            do {
                try {
                    // $client = new KazpostWebClient2();
                    $response = $client->GetPostRate($params);
                    if (is_soap_fault($response)) {
                        // file_put_contents('kazpost.txt', print_r("FAULT ", true), FILE_APPEND);
                        throw new \Exception('Данные недоступны');
                    } else {
                        $crashesn = $max_connect;
                        restore_error_handler();
                    }
                } catch (\Exception $e) {
                    $crashesn++;

                    if ($crashesn < $max_connect) {
                        sleep(1);
                        // file_put_contents('kazpost.txt', print_r($crashesn, true), FILE_APPEND);
                        // file_put_contents('kazpost.txt', print_r(PHP_EOL, true), FILE_APPEND);
                    } else {
                        // file_put_contents('kazpost.txt', print_r($e->getMessage(), true), FILE_APPEND);
                        // file_put_contents('kazpost.txt', print_r(PHP_EOL, true), FILE_APPEND);
                        $response->ResponseInfo->ResponseText = ''; // иначе вылетит в конце на NOTICE $response is not obj
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

        // упаковка
        if ($this->config->get('kazpost_pack') != 'null' && $rate != 'null' && $destination_id) {
            $rate += (int) $this->config->get('kazpost_pack');
        }

        $this->response->setOutput(($rate === 'null') ? $response->ResponseInfo->ResponseText : $rate);
    }

    public function install()
    {

        $data['kkazpost_geo_zone_id'] = '0';
        $data['kazpost_tax_class_id'] = '0';
        $data['kazpost_status'] = '1';
        $data['kazpost_sort_order'] = '1';
        $data['kazpost_api_server'] = '2';
        $data['kazpost_pack'] = '0';
        $data['kazpost_declared_value'] = '15000';
        $data['kazpost_origin_city-1'] = 'Петропавловск';
        $data['kazpost_origin_id1'] = '11';
        $data['kazpost_origin_city-2'] = 'Петропавловск';
        $data['kazpost_origin_id2'] = '150000';
        $data['kazpost_server1_xls'] = 'library/kazpost/spr.xls';
        $data['kazpost_server2_xls'] = 'library/kazpost/spr2.xls';
        $data['kazpost_fromto_sheetname'] = 'FromTo (Областные филиалы)';
        $data['kazpost_methods-server1'] = 'a:4:{i:0;a:11:{s:4:"name";s:37:"EMS &quot;Стандарт&quot; РК";s:2:"id";s:1:"0";s:7:"product";s:37:"EMS &quot;Стандарт&quot; РК";s:10:"product_id";s:1:"7";s:10:"sendmethod";s:8:"Авиа";s:13:"sendmethod_id";s:1:"2";'
            . 's:7:"mailcat";s:21:"Простое (ая)";s:10:"mailcat_id";s:1:"0";s:9:"specmarks";s:29:" --- Не выбрано --- ";s:12:"specmarks_id";s:2:"-1";s:10:"sort_order";s:1:"1";}i:1;a:11:{s:4:"name";s:23:"Бандероль РК";s:2:"id";'
            . 's:1:"1";s:7:"product";s:23:"Бандероль РК";s:10:"product_id";s:1:"1";s:10:"sendmethod";s:8:"Авиа";s:13:"sendmethod_id";s:1:"2";s:7:"mailcat";s:21:"Простое (ая)";s:10:"mailcat_id";s:1:"0";s:9:"specmarks";s:32:"Выдача в Почтамте";'
            . 's:12:"specmarks_id";s:2:"81";s:10:"sort_order";s:1:"2";}i:2;a:11:{s:4:"name";s:19:"Посылка РК";s:2:"id";s:1:"2";s:7:"product";s:19:"Посылка РК";s:10:"product_id";s:1:"4";s:10:"sendmethod";s:16:"Наземный";s:13:"sendmethod_id";'
            . 's:1:"1";s:7:"mailcat";s:21:"Простое (ая)";s:10:"mailcat_id";s:1:"0";s:9:"specmarks";s:29:" --- Не выбрано --- ";s:12:"specmarks_id";s:2:"-1";s:10:"sort_order";s:1:"3";}i:3;a:11:{s:4:"name";s:36:"Посылка на постамат";s:2:"id";'
            . 's:1:"3";s:7:"product";s:36:"Посылка на постамат";s:10:"product_id";s:1:"6";s:10:"sendmethod";s:16:"Наземный";s:13:"sendmethod_id";s:1:"1";s:7:"mailcat";s:21:"Простое (ая)";s:10:"mailcat_id";s:1:"0";s:9:"specmarks";'
            . 's:29:" --- Не выбрано --- ";s:12:"specmarks_id";s:2:"-1";s:10:"sort_order";s:1:"4";}}';
        $data['kazpost_methods-server2'] = 'a:4:{i:0;a:11:{s:4:"name";s:36:"EMS &quot;День в день&quot;";s:2:"id";s:1:"0";s:7:"product";s:36:"EMS &quot;День в день&quot;";s:10:"product_id";s:4:"P115";s:10:"sendmethod";s:8:"Авиа";s:13:"sendmethod_id";s:1:"2";'
            . 's:7:"mailcat";s:31:"Обыкновенное (ая)";s:10:"mailcat_id";s:1:"3";s:7:"sndrctg";s:29:"Физическое лицо";s:10:"sndrctg_id";s:1:"1";s:10:"sort_order";s:0:"";}i:1;a:11:{s:4:"name";s:40:"EMS &quot;Моя Страна&quot; РК";'
            . 's:2:"id";s:1:"1";s:7:"product";s:40:"EMS &quot;Моя Страна&quot; РК";s:10:"product_id";s:4:"P104";s:10:"sendmethod";s:8:"Авиа";s:13:"sendmethod_id";s:1:"2";s:7:"mailcat";s:16:"Заказное";s:10:"mailcat_id";s:1:"1";'
            . 's:7:"sndrctg";s:29:"Физическое лицо";s:10:"sndrctg_id";s:1:"1";s:10:"sort_order";s:0:"";}i:2;a:11:{s:4:"name";s:37:"EMS &quot;Приоритет-10&quot;";s:2:"id";s:1:"2";s:7:"product";s:37:"EMS &quot;Приоритет-10&quot;";'
            . 's:10:"product_id";s:4:"P113";s:10:"sendmethod";s:8:"Авиа";s:13:"sendmethod_id";s:1:"2";s:7:"mailcat";s:31:"Обыкновенное (ая)";s:10:"mailcat_id";s:1:"3";s:7:"sndrctg";s:29:"Физическое лицо";s:10:"sndrctg_id";'
            . 's:1:"1";s:10:"sort_order";s:0:"";}i:3;a:11:{s:4:"name";s:45:"EMS &quot;Эконом доставка&quot;";s:2:"id";s:1:"3";s:7:"product";s:45:"EMS &quot;Эконом доставка&quot;";s:10:"product_id";s:4:"P118";s:10:"sendmethod";'
            . 's:16:"Наземный";s:13:"sendmethod_id";s:1:"1";s:7:"mailcat";s:16:"Заказное";s:10:"mailcat_id";s:1:"1";s:7:"sndrctg";s:29:"Физическое лицо";s:10:"sndrctg_id";s:1:"1";s:10:"sort_order";s:0:"";}}';

        $this->load->model('setting/setting');
        $this->model_setting_setting->editSetting('kazpost', $data);
    }
}

class ControllerExtensionShippingKazpost extends ControllerShippingKazpost
{ }
