<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <button type="button" form="form-kazpost"  onclick="$('#form-kazpost').submit();" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
                <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a>
            </div>
            <h1><?php echo $heading_title; ?></h1>
            <ul class="breadcrumb">
                <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
                <?php } ?>
            </ul>
        </div>
    </div>
    <div class="container-fluid">
        <?php if ($error_warning) { ?>
            <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
                <button type="button" class="close" data-dismiss="alert">&times;</button>
            </div>
        <?php } ?>
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
                <div id="ajaxloader" style="display: none; position: relative; float: right;"><i class="fa fa-circle-o-notch fa-spin"></i>  <?php echo 'loading'; ?></div>
            </div>
            <div class="panel-body">
                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-kazpost" class="form-horizontal">
                    <div id="tabs">
                        <ul class="nav nav-tabs">
                            <li><a href="#tab-general" data-toggle="tab"><i class="fa fa-cogs"></i> <?php echo $tab_general; ?> </a></li>
                            <li><a href="#tab-database" data-toggle="tab"><i class="fa fa-database"></i> <?php echo $tab_data; ?> </a></li>
                            <li class="active"><a href="#tab-kazpost" data-toggle="tab"><i class="fa fa-truck"></i> <?php echo $tab_kazpost; ?></a> </li>
                            <li><a href="#tab-calc" data-toggle="tab"><i class="fa fa-plane"></i> <?php echo $tab_calc; ?></a> </li>
                            <li><a href="#tab-support" data-toggle="tab"><i class="fa fa-life-ring"></i> <?php echo $tab_support; ?></a> </li>
                        </ul>
                        <div class="tab-content">
                            <div class="tab-pane active" id="tab-general">
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-tax-class"><?php echo $entry_tax_class; ?></label>
                                    <div class="col-sm-10">
                                        <select name="kazpost_tax_class_id" id="input-tax-class" class="form-control">
                                            <option value="0"><?php echo $text_none; ?></option>
                                            <?php foreach ($tax_classes as $tax_class) { ?>
                                                <?php if ($tax_class['tax_class_id'] == $kazpost_tax_class_id) { ?>
                                                    <option value="<?php echo $tax_class['tax_class_id']; ?>" selected="selected"><?php echo $tax_class['title']; ?></option>
                                                <?php } else { ?>
                                                    <option value="<?php echo $tax_class['tax_class_id']; ?>"><?php echo $tax_class['title']; ?></option>
                                                <?php } ?>
                                            <?php } ?>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-geo-zone"><?php echo $entry_geo_zone; ?></label>
                                    <div class="col-sm-10">
                                        <select name="kazpost_geo_zone_id" id="input-geo-zone" class="form-control">
                                            <option value="0"><?php echo $text_all_zones; ?></option>
                                            <?php foreach ($geo_zones as $geo_zone) { ?>
                                                <?php if ($geo_zone['geo_zone_id'] == $kazpost_geo_zone_id) { ?>
                                                    <option value="<?php echo $geo_zone['geo_zone_id']; ?>" selected="selected"><?php echo $geo_zone['name']; ?></option>
                                                <?php } else { ?>
                                                    <option value="<?php echo $geo_zone['geo_zone_id']; ?>"><?php echo $geo_zone['name']; ?></option>
                                                <?php } ?>
                                            <?php } ?>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
                                    <div class="col-sm-10">
                                        <select name="kazpost_status" id="input-status" class="form-control">
                                            <?php if ($kazpost_status) { ?>
                                                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                                <option value="0"><?php echo $text_disabled; ?></option>
                                            <?php } else { ?>
                                                <option value="1"><?php echo $text_enabled; ?></option>
                                                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                            <?php } ?>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-sort-order"><?php echo $entry_sort_order; ?></label>
                                    <div class="col-sm-10">
                                        <input type="text" name="kazpost_sort_order" value="<?php echo $kazpost_sort_order; ?>" placeholder="<?php echo $entry_sort_order; ?>" id="input-sort-order" class="form-control" />
                                    </div>
                                </div>
								<div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-pack"><?php echo $entry_pack; ?></label>
                                    <div class="col-sm-10">
                                        <input type="text" name="kazpost_pack" value="<?php echo $kazpost_pack; ?>" placeholder="<?php echo $entry_pack; ?>" id="input-pack" class="form-control" />
                                    </div>
                                </div>
                                <div class="form-group required">
                                    <label class="col-sm-2 control-label" for="input-origin"><span data-toggle="tooltip" title="<?php echo $help_origin; ?>"><?php echo $entry_origin; ?></span></label>
                                    <div class="col-sm-10">
                                        <input type="text" name="kazpost_origin_city" value="<?php echo $kazpost_origin_city; ?>" placeholder="<?php echo $entry_origin; ?>" id="input-fromto" class="form-control" />
                                        <input type="hidden" name="kazpost_origin_id" value="<?php echo $kazpost_origin_id; ?>" />
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane" id="tab-database">
                                <div class="table-responsive">
                                    <table class="table table-bordered table-hover">
                                        <thead>
                                            <tr>
                                                <td class="text-left"><?php echo $column_name; ?></td>
                                                <td class="text-left"><?php echo $column_path; ?></td>
                                                <td class="text-left"><?php echo $column_sheet; ?></td>
                                                <td class="text-left"><?php echo $column_try; ?></td>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td class="text-left"><?php echo $text_sendmethod; ?></td>
                                                <td class="text-left"><input type="text" name="kazpost_sendmethod_filename" value="<?php echo $kazpost_sendmethod_filename; ?>" placeholder="<?php echo $help_data_xls; ?>" id="input-kazpost-sendmethod-filename" class="form-control" /></td>
                                                <td class="text-left"><input type="text" name="kazpost_sendmethod_sheet" value="<?php echo $kazpost_sendmethod_sheet; ?>" placeholder="<?php echo $help_data_select; ?>" id="input-kazpost-sendmethod-sheet" class="form-control" />
                                                    <input type="hidden" name="kazpost_sendmethod_sheet_id" value="<?php echo $kazpost_sendmethod_sheet_id; ?>" /></td>
                                                <td class="text-left"><input type="text" name="kazpost_sendmethod_try" value="" placeholder="<?php echo $help_kazpost_try; ?>" id="input-kazpost-sendmethod-try" class="form-control" /></td>
                                            </tr>
                                            <tr>
                                                <td class="text-left"><?php echo $text_mailcat; ?></td>
                                                <td class="text-left"><input type="text" name="kazpost_mailcat_filename" value="<?php echo $kazpost_mailcat_filename; ?>" placeholder="<?php echo $help_data_xls; ?>" id="input-kazpost-mailcat-filename" class="form-control" /></td>
                                                <td class="text-left"><input type="text" name="kazpost_mailcat_sheet" value="<?php echo $kazpost_mailcat_sheet; ?>" placeholder="<?php echo $help_data_select; ?>" id="input-kazpost-mailcat-sheet" class="form-control" />
                                                    <input type="hidden" name="kazpost_mailcat_sheet_id" value="<?php echo $kazpost_mailcat_sheet_id; ?>" /></td>
                                                <td class="text-left"><input type="text" name="kazpost_mailcat_try" value="" placeholder="<?php echo $help_kazpost_try; ?>" id="input-kazpost-mailcat-try" class="form-control" /></td>
                                            </tr>
                                            <tr>
                                                <td class="text-left" ><span data-toggle="tooltip" title="<?php echo $help_origin; ?>"><?php echo $text_fromto; ?></span></td>
                                                <td class="text-left"><input type="text" name="kazpost_fromto_filename" value="<?php echo $kazpost_fromto_filename; ?>" placeholder="<?php echo $help_data_xls; ?>" id="input-kazpost-fromto-filename" class="form-control" /></td>
                                                <td class="text-left"><input type="text" name="kazpost_fromto_sheet" value="<?php echo $kazpost_fromto_sheet; ?>" placeholder="<?php echo $help_data_select; ?>" id="input-kazpost-fromto-sheet" class="form-control" />
                                                    <input type="hidden" name="kazpost_fromto_sheet_id" value="<?php echo $kazpost_fromto_sheet_id; ?>" /></td>
                                                <td class="text-left"><input type="text" name="kazpost_fromto_try" value="" placeholder="<?php echo $help_kazpost_try; ?>" id="input-kazpost-fromto-try" class="form-control" /></td>
                                            </tr>
                                            <tr>
                                                <td class="text-left"><?php echo $text_size; ?></td>
                                                <td class="text-left"><input type="text" name="kazpost_size_filename" value="<?php echo $kazpost_size_filename; ?>" placeholder="<?php echo $help_data_xls; ?>" id="input-kazpost-to-filename" class="form-control" /></td>
                                                <td class="text-left"><input type="text" name="kazpost_size_sheet" value="<?php echo $kazpost_size_sheet; ?>" placeholder="<?php echo $help_data_select; ?>" id="input-kazpost-to-sheet" class="form-control" />
                                                    <input type="hidden" name="kazpost_size_sheet_id" value="<?php echo $kazpost_size_sheet_id; ?>" /></td>
                                                <td class="text-left"><input type="text" name="kazpost_size_try" value="" placeholder="<?php echo $help_kazpost_try; ?>" id="input-kazpost-to-try" class="form-control" /></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="tab-pane" id="tab-kazpost">
                                <div class="container-fluid">
                                    <div class="pull-right">
                                        <button type="button" data-toggle="tooltip" title="<?php echo $button_add; ?>" class="btn btn-primary" onclick="addrow()"><i class="fa fa-plus"></i></button>
                                    </div>
                                    <h3 class="panel-title"><i class="fa fa-list"></i> <?php echo $kazpost_title; ?></h3>
                                </div>
                                <div class="panel-body">
                                    <div class="table-responsive">
                                        <table class="table table-bordered table-hover" id="tab-method">
                                            <thead>
                                                <tr>
                                                    <td style="width: 1px;" class="text-center"><input type="checkbox"/></td>
                                                    <td class="text-left"><?php echo $column_name; ?></td>
                                                    <td class="text-right"><?php echo $column_product; ?></td>
                                                    <td class="text-right"><?php echo $column_sendmethod; ?></td>
                                                    <td class="text-right"><?php echo $column_mailcat; ?></td>
                                                    <td class="text-right"><?php echo $column_specmarks; ?></td>
                                                    <td class="text-right"><?php echo $column_sort_order; ?></td>
                                                    <td class="text-right"><?php echo $column_action; ?></td>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <?php if ($kazpost_methods) { ?>
                                                    <?php foreach ($kazpost_methods as $deliverymethod) { ?>
                                                        <tr>
                                                            <td class="text-center"><?php echo $deliverymethod['id']; ?></td>
                                                            <td class="text-left"><input type="text" name="kazpost_methods[<?php echo $deliverymethod['id']; ?>][name]" value="<?php echo $deliverymethod['name']; ?>" placeholder="<?php echo $help_data_input; ?>" id="input-name" class="form-control" />
                                                                <input type="hidden" name="kazpost_methods[<?php echo $deliverymethod['id']; ?>][id]" value="<?php echo $deliverymethod['id']; ?>" /></td>
                                                            <td class="text-left"><input type="text" name="kazpost_methods[<?php echo $deliverymethod['id']; ?>][product]" value="<?php echo $deliverymethod['product']; ?>" placeholder="<?php echo $help_data_select; ?>" id="input-product" class="form-control" />
                                                                <input type="hidden" name="kazpost_methods[<?php echo $deliverymethod['id']; ?>][product_id]" value="<?php echo $deliverymethod['product_id']; ?>" /></td>
                                                            <td class="text-left"><input type="text" name="kazpost_methods[<?php echo $deliverymethod['id']; ?>][sendmethod]" value="<?php echo $deliverymethod['sendmethod']; ?>" placeholder="<?php echo $help_data_select; ?>" id="input-sendmethod" class="form-control" />
                                                                <input type="hidden" name="kazpost_methods[<?php echo $deliverymethod['id']; ?>][sendmethod_id]" value="<?php echo $deliverymethod['sendmethod_id']; ?>" /></td>
                                                            <td class="text-left"><input type="text" name="kazpost_methods[<?php echo $deliverymethod['id']; ?>][mailcat]" value="<?php echo $deliverymethod['mailcat']; ?>" placeholder="<?php echo $help_data_select; ?>" id="input-mailcat" class="form-control" />
                                                                <input type="hidden" name="kazpost_methods[<?php echo $deliverymethod['id']; ?>][mailcat_id]" value="<?php echo $deliverymethod['mailcat_id']; ?>" /></td>
                                                            <td class="text-left"><input type="text" name="kazpost_methods[<?php echo $deliverymethod['id']; ?>][specmarks]" value="<?php echo $deliverymethod['specmarks']; ?>" placeholder="<?php echo $help_data_select; ?>" id="input-specmarks" class="form-control" />
                                                                <input type="hidden" name="kazpost_methods[<?php echo $deliverymethod['id']; ?>][specmarks_id]" value="<?php echo $deliverymethod['specmarks_id']; ?>" /></td>
                                                            <td class="text-left"><input type="text" name="kazpost_methods[<?php echo $deliverymethod['id']; ?>][sort_order]" value="<?php echo $deliverymethod['sort_order']; ?>" placeholder="<?php echo $help_data_input; ?>" id="input-sort_order" class="form-control" /></td>
                                                            <td class="text-right"><button type="button" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger" ><i class="fa fa-trash-o"></i></button></td>
                                                        </tr>
                                                    <?php } ?>
                                                <?php } else { ?>
                                                    <tr>
                                                        <td class="text-center" colspan="8" id="no_result"><?php echo $text_no_results; ?></td>
                                                    </tr>
                                                <?php } ?>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane" id="tab-calc">
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-method;"><?php echo $column_method_name; ?></label>
                                    <div class="col-sm-10">
                                        <select name="method_id" id="input-method" class="form-control">
                                            <?php foreach ($kazpost_methods as $calc_method) { ?>
                                                <option value="<?php echo $calc_method['id']; ?>"><?php echo $calc_method['name']; ?></option>
                                            <?php } ?>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-weight"><?php echo $entry_weight; ?></label>
                                    <div class="col-sm-10">
                                        <input type="text" name="weight" value="<?php echo $weight; ?>" placeholder="<?php echo $help_data_input; ?>" id="input-weight" class="form-control" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-destination"><?php echo $entry_to; ?></label>
                                    <div class="col-sm-10">
                                        <input type="text" name="destination" value="<?php echo $destination; ?>" placeholder="<?php echo $help_data_select; ?>" id="input-fromto" class="form-control" />
                                        <input type="hidden" name="destination_id" value="<?php echo $destination_id; ?>" id="input-destination_id" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-rate"><?php echo $entry_rate; ?></label>
                                    <div class="col-sm-10">
                                        <input type="text" name="rate" readonly="true" value=""  id="input-rate" class="form-control" />

                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane" id="tab-support">
							<fieldset>	
	    <legend>Служба поддержки</legend>
    	<address>
    		По всем вопросам, связаннымы с работой модуля обращайтесь:<br/>
<i class="fa fa-skype"></i> sl271261414<br/>
<strong>E-mail:</strong> <a href="mailto:#">comtronics@mail.ru</a><br/>
<strong>Сайт-демо:</strong> <a href="http://demo.radiocity.kz">demo.radiocity.kz</a>    	</address>
</fieldset>			
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<style>
    .dropdown-menu {
        max-height: 200px;
        max-width: 400px;
        overflow-y: auto;
        overflow-x: hidden;
        padding-right: 20px;
        font-size: 12px;
    }
</style>
<script type="text/javascript"><!--
 var filename, sheet, row;
    var storageindex = localStorage.getItem('tab');

    if (storageindex)
        $('ul.nav-tabs').find('li').eq(storageindex).addClass('active').siblings().removeClass('active')
                .parents('#tabs').find('.tab-pane').eq(storageindex).addClass('active').siblings().removeClass('active');

    $('ul.nav-tabs').on('click', 'li', function () {
        ulIndex = $(this).index();
        localStorage.setItem('tab', $(this).index());
    });


    $('input[name=\'kazpost_origin_city\'], input[name=\'destination\']').autocomplete({
        source: function (request, response) {
            filename = $('input[name=\'kazpost_fromto_filename\']').val();
            sheet = $('input[name=\'kazpost_fromto_sheet_id\']').val();
            $.ajax({
                url: 'index.php?route=shipping/kazpost/autocomplete&token=<?php echo $token; ?>&file=' + filename + '&sheet=' + sheet,
                dataType: 'json',
                beforeSend: function () {
                    $("#ajaxloader").show();
                },
                complete: function () {
                    $("#ajaxloader").hide();
                },
                success: function (json) {
                    response($.map(json, function (item) {
                        return {
                            label: item['title'],
                            value: item['id']
                        };
                    }));
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    alert('<?php echo $error_ajax_responce; ?>');
                }
            });
        },
        select: function (item) {
            $(this).val(item['label']);
            $(this).closest('div').find('input[name *= id]').val(item['value']);
            $(this).trigger('change');
        }
    });


    $('input[name $= sheet]').autocomplete({
        source: function (request, response) {
            filename = $(this).closest('tr').find('input[name *= filename]').val();
            //   sheet =  $('input[name=\'kazpost_fromto_sheet\']').val();
            $.ajax({
                url: 'index.php?route=shipping/kazpost/getSheet&token=<?php echo $token; ?>&file=' + filename,
                dataType: 'json',
                beforeSend: function () {
                    $("#ajaxloader").show();
                },
                complete: function () {
                    $("#ajaxloader").hide();
                },
                success: function (json) {
                    response($.map(json, function (item) {
                        return {
                            label: item['title'],
                            value: item['id']
                        };
                    }));
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    alert('<?php echo $error_ajax_responce; ?>');
                }
            });
        },
        select: function (item) {
            $(this).val(item['label']);
            $(this).closest('tr').find('input[name *= id]').val(item['value']);
        }
    });

    $('input[name *= try]').autocomplete({
        source: function (request, response) {
            filename = $(this).closest('tr').find('input[name *= filename]').val();
            sheet = $(this).closest('tr').find('input[name *= sheet_id]').val();
            $.ajax({
                url: 'index.php?route=shipping/kazpost/autocomplete&token=<?php echo $token; ?>&file=' + filename + '&sheet=' + sheet,
                dataType: 'json',
                beforeSend: function () {
                    $("#ajaxloader").show();
                },
                complete: function () {
                    $("#ajaxloader").hide();
                },
                success: function (json) {
                    response($.map(json, function (item) {
                        return {
                            label: item['title'],
                            value: item['id']
                        };
                    }));
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    alert('<?php echo $error_ajax_responce; ?>');
                }
            });
        },
        select: function (item) {
            return;
            //   $('input[name=\'kazpost_origin_city\']').val(item['label']);
            //   $('input[name=\'kazpost_origin_id\']').val(item['value']);
        }
    });


    $('input[name *= \\[product\\]], input[name *=\\[specmarks\\]], input[name *= \\[sendmethod\\]], input[name *=\\[mailcat\\]]').not('[type=hidden]').autocomplete({
        source: function (request, response) {
            catalog = $(this).attr('id').split(/-/g);
            switch (catalog[1]) {
                case 'product'    :
                case 'specmarks'  :
                    processing = 'apicomplete';
                    break
                case 'fromto'    :
                case 'mailcat'    :
                case 'sendmethod'  :
                    processing = 'autocomplete';
                    break
            }

            filename = $('input[name=\'kazpost_' + catalog[1] + '_filename\']').val();
            sheet = $('input[name=\'kazpost_' + catalog[1] + '_sheet_id\']').val();
            $.ajax({
                url: 'index.php?route=shipping/kazpost/' + processing + '&token=<?php echo $token; ?>&file=' + filename + '&sheet=' + sheet + '&catalog=' + catalog[1],
                dataType: 'json',
                beforeSend: function () {
                    $("#ajaxloader").show();
                },
                complete: function () {
                    $("#ajaxloader").hide();
                },
                success: function (json) {
                    json.unshift({
                        id: -1,
                        title: '<?php echo $text_none; ?>'
                    });
                    response($.map(json, function (item) {
                        return {
                            label: item['title'],
                            value: item['id']
                        };
                    }));
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    alert('<?php echo $error_ajax_responce; ?>');
                }
            });
        },
        select: function (item) {
            $(this).val(item['label']);
            $(this).closest('td').find('input[name *= id]').val(item['value']);
        }
    });


    function addrow() {
        $('tr:has(#no_result)').remove();
        //     row = $('#tab-method >tbody >tr').not(':has(#no_result)').length;
        row = $('#tab-method >tbody >tr').length;

        html = '<tr>';
        html += '<td class="text-center">' + row + '</td>';
        html += '<td class="text-left"><input type="text" name="kazpost_methods[' + row + '][name]" value="" placeholder="<?php echo $help_data_input; ?>" id="input-name" class="form-control" />';
        html += '<input type="hidden" name="kazpost_methods[' + row + '][id]" value="' + row + '" /></td>';
        html += '<td class="text-left"><input type="text" name="kazpost_methods[' + row + '][product]" value="" placeholder="<?php echo $help_data_select; ?>" id="input-product" class="form-control" />';
        html += '<input type="hidden" name="kazpost_methods[' + row + '][product_id]" value="" /></td>';
        html += '<td class="text-left"><input type="text" name="kazpost_methods[' + row + '][sendmethod]" value="" placeholder="<?php echo $help_data_select; ?>" id="input-sendmethod" class="form-control" />';
        html += '<input type="hidden" name="kazpost_methods[' + row + '][sendmethod_id]" value="" /></td>';
        html += '<td class="text-left"><input type="text" name="kazpost_methods[' + row + '][mailcat]" value="" placeholder="<?php echo $help_data_select; ?>" id="input-mailcat" class="form-control" />';
        html += '<input type="hidden" name="kazpost_methods[' + row + '][mailcat_id]" value="" /></td>';
        html += '<td class="text-left"><input type="text" name="kazpost_methods[' + row + '][specmarks]" value="" placeholder="<?php echo $help_data_select; ?>" id="input-specmarks" class="form-control" />';
        html += '<input type="hidden" name="kazpost_methods[' + row + '][specmarks_id]" value="" /></td>';
        html += '<td class="text-right"><input type="text" name="kazpost_methods[' + row + '][sort_order]" value="" placeholder="<?php echo $help_data_input; ?>" id="input-sort_order" class="form-control" /></td>';
        html += '<td class="text-right"><button type="button" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger"><i class="fa fa-trash-o"></i></button></td>';
        html += '</tr>';

        $('#tab-method > tbody:last').append(html);

        $('input[name *= \\[product\\]], input[name *=\\[specmarks\\]], input[name *= \\[sendmethod\\]], input[name *=\\[mailcat\\]]').not('[type=hidden]').autocomplete({
            source: function (request, response) {
                catalog = $(this).attr('id').split(/-/g);
                switch (catalog[1]) {
                    case 'product'    :
                    case 'specmarks'  :
                        processing = 'apicomplete';
                        break
                    case 'fromto'    :
                    case 'mailcat'    :
                    case 'sendmethod'  :
                        processing = 'autocomplete';
                        break
                }

                filename = $('input[name=\'kazpost_' + catalog[1] + '_filename\']').val();
                sheet = $('input[name=\'kazpost_' + catalog[1] + '_sheet_id\']').val();
                $.ajax({
                    url: 'index.php?route=shipping/kazpost/' + processing + '&token=<?php echo $token; ?>&file=' + filename + '&sheet=' + sheet + '&catalog=' + catalog[1],
                    dataType: 'json',
                    beforeSend: function () {
                        $("#ajaxloader").show();
                    },
                    complete: function () {
                        $("#ajaxloader").hide();
                    },
                    success: function (json) {
                        json.unshift({
                            id: -1,
                            title: '<?php echo $text_none; ?>'
                        });
                        response($.map(json, function (item) {
                            return {
                                label: item['title'],
                                value: item['id']
                            };
                        }));
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        alert('<?php echo $error_ajax_responce; ?>');
                    }
                });
            },
            select: function (item) {
                $(this).val(item['label']);
                $(this).closest('td').find('input[name *= id]').val(item['value']);
            }
        });
    }


    $('#tab-method >tbody').on('click', '.btn-danger', function () {
        if (confirm('<?php echo $text_confirm; ?>')) {
            $(this).closest('tr').remove();
            $('#tab-method >tbody').find('tr').each(function (i, e) {
                $(e).find('td').each(function (j, k) {
                    nameold = $(k).find('input').attr("name");
                    if (nameold !== undefined) {
                        nameold.replace(/\d+/g, i.toString());
                    }
                });
                $(e).find('input[name *=\\[id\\]]').val(i);
                $(e).find('>td:first').text(i);
            });
        }
    });

    $('input[name = \"weight\"], input[name=\'destination\'], select[name = \"method_id\"]').change(function () {
        $.ajax({
            url: 'index.php?route=shipping/kazpost/apigetrate&token=<?php echo $token; ?>',
            dataType: 'text',
            data: {
                weight: $('#input-weight').val(),
                destination_id: $('#input-destination_id').val(),
                id: $('#input-method').val(),
            },
            success: function (rate) {
                $('#input-rate').val(rate);
            }
        });
    });
//--></script>
<?php echo $footer; ?>