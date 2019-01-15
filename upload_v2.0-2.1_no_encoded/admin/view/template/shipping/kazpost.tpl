<?php echo $header; ?>
<?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <button type="button" form="form-kazpost" onclick="$('#form-kazpost').submit();" data-toggle="tooltip"
                    title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
                <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i
                        class="fa fa-reply"></i></a>
            </div>
            <h1>
                <?php echo $heading_title; ?>
            </h1>
            <ul class="breadcrumb">
                <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                <li><a href="<?php echo $breadcrumb['href']; ?>">
                        <?php echo $breadcrumb['text']; ?></a></li>
                <?php } ?>
            </ul>
        </div>
    </div>
    <div class="container-fluid">
        <?php if ($error_warning) { ?>
        <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i>
            <?php echo $error_warning; ?>
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
        <?php } ?>
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-pencil"></i>
                    <?php echo $text_edit; ?>
                </h3>
                <div id="ajaxloader" style="display: none; position: relative; float: right;"><i class="fa fa-circle-o-notch fa-spin"></i>
                    <?php echo 'loading'; ?>
                </div>
            </div>
            <div class="panel-body">
                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-kazpost"
                    class="form-horizontal">
                    <div id="tabs">
                        <ul class="nav nav-tabs">
                            <li><a href="#tab-general" data-toggle="tab"><i class="fa fa-cogs"></i>
                                    <?php echo $tab_general; ?> </a></li>
                            <li><a href="#tab-database" data-toggle="tab"><i class="fa fa-database"></i>
                                    <?php echo $tab_data; ?> </a></li>
                            <li class="active"><a href="#tab-kazpost" data-toggle="tab"><i class="fa fa-truck"></i>
                                    <?php echo $tab_kazpost; ?></a> </li>
                            <li><a href="#tab-calc" data-toggle="tab"><i class="fa fa-plane"></i>
                                    <?php echo $tab_calc; ?></a> </li>
                            <li><a href="#tab-support" data-toggle="tab"><i class="fa fa-life-ring"></i>
                                    <?php echo $tab_support; ?></a> </li>
                        </ul>
                        <div class="tab-content">
                            <div class="tab-pane active" id="tab-general">
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-tax-class">
                                        <?php echo $entry_tax_class; ?></label>
                                    <div class="col-sm-10">
                                        <select name="kazpost_tax_class_id" id="input-tax-class" class="form-control">
                                            <option value="0">
                                                <?php echo $text_none; ?>
                                            </option>
                                            <?php foreach ($tax_classes as $tax_class) { ?>
                                            <?php if ($tax_class['tax_class_id'] == $kazpost_tax_class_id) { ?>
                                            <option value="<?php echo $tax_class['tax_class_id']; ?>" selected="selected">
                                                <?php echo $tax_class['title']; ?>
                                            </option>
                                            <?php } else { ?>
                                            <option value="<?php echo $tax_class['tax_class_id']; ?>">
                                                <?php echo $tax_class['title']; ?>
                                            </option>
                                            <?php } ?>
                                            <?php } ?>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-geo-zone">
                                        <?php echo $entry_geo_zone; ?></label>
                                    <div class="col-sm-10">
                                        <select name="kazpost_geo_zone_id" id="input-geo-zone" class="form-control">
                                            <option value="0">
                                                <?php echo $text_all_zones; ?>
                                            </option>
                                            <?php foreach ($geo_zones as $geo_zone) { ?>
                                            <?php if ($geo_zone['geo_zone_id'] == $kazpost_geo_zone_id) { ?>
                                            <option value="<?php echo $geo_zone['geo_zone_id']; ?>" selected="selected">
                                                <?php echo $geo_zone['name']; ?>
                                            </option>
                                            <?php } else { ?>
                                            <option value="<?php echo $geo_zone['geo_zone_id']; ?>">
                                                <?php echo $geo_zone['name']; ?>
                                            </option>
                                            <?php } ?>
                                            <?php } ?>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_api_server; ?>">
                                            <?php echo $entry_api_server; ?></span></label>
                                    <div class="col-sm-10">
                                        <label class="radio-inline">
                                            <?php if ($kazpost_api_server == '1') { ?>
                                            <input type="radio" name="kazpost_api_server" value="1" checked="checked" />
                                            <?php echo $text_server1; ?>
                                            <?php } else { ?>
                                            <input type="radio" name="kazpost_api_server" value="1" />
                                            <?php echo $text_server1; ?>
                                            <?php } ?>
                                        </label>
                                        <label class="radio-inline">
                                            <?php if ($kazpost_api_server == '2') { ?>
                                            <input type="radio" name="kazpost_api_server" value="2" checked="checked" />
                                            <?php echo $text_server2; ?>
                                            <?php } else { ?>
                                            <input type="radio" name="kazpost_api_server" value="2" />
                                            <?php echo $text_server2; ?>
                                            <?php } ?>
                                        </label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-pack">
                                        <?php echo $entry_pack; ?></label>
                                    <div class="col-sm-10">
                                        <input type="text" name="kazpost_pack" value="<?php echo $kazpost_pack; ?>"
                                            placeholder="<?php echo $entry_pack; ?>" id="input-pack" class="form-control" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-value"><span data-toggle="tooltip"
                                            title="<?php echo $help_declared_value; ?>">
                                            <?php echo $entry_declared_value; ?></span></label>
                                    <div class="col-sm-10">
                                        <input type="text" name="kazpost_declared_value" value="<?php echo $kazpost_declared_value; ?>"
                                            id="input-value" class="form-control" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-status">
                                        <?php echo $entry_status; ?></label>
                                    <div class="col-sm-10">
                                        <select name="kazpost_status" id="input-status" class="form-control">
                                            <?php if ($kazpost_status) { ?>
                                            <option value="1" selected="selected">
                                                <?php echo $text_enabled; ?>
                                            </option>
                                            <option value="0">
                                                <?php echo $text_disabled; ?>
                                            </option>
                                            <?php } else { ?>
                                            <option value="1">
                                                <?php echo $text_enabled; ?>
                                            </option>
                                            <option value="0" selected="selected">
                                                <?php echo $text_disabled; ?>
                                            </option>
                                            <?php } ?>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-sort-order">
                                        <?php echo $entry_sort_order; ?></label>
                                    <div class="col-sm-10">
                                        <input type="text" name="kazpost_sort_order" value="<?php echo $kazpost_sort_order; ?>"
                                            placeholder="<?php echo $entry_sort_order; ?>" id="input-sort-order" class="form-control" />
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane" id="tab-database">
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-server1-xls"><span data-toggle="tooltip"
                                            title="<?php echo $help_data_xls; ?>">
                                            <?php echo $entry_server1_xls; ?></span></label>
                                    <div class="col-sm-10">
                                        <input type="text" name="kazpost_server1_xls" value="<?php echo $kazpost_server1_xls; ?>"
                                            id="input-server1-xls" class="form-control" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-server2-xls"><span data-toggle="tooltip"
                                            title="<?php echo $help_data_xls; ?>">
                                            <?php echo $entry_server2_xls; ?></span></label>
                                    <div class="col-sm-10">
                                        <input type="text" name="kazpost_server2_xls" value="<?php echo $kazpost_server2_xls; ?>"
                                            id="input-server2-xls" class="form-control" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-fromto-sheet"><span data-toggle="tooltip"
                                            title="<?php echo $help_fromto_sheetname; ?>">
                                            <?php echo $entry_fromto_sheetname; ?></span></label>
                                    <div class="col-sm-10">
                                        <input type="text" name="kazpost_fromto_sheetname" value="<?php echo $kazpost_fromto_sheetname; ?>"
                                            id="input-fromto-sheet" class="form-control" />
                                    </div>
                                </div>
                                <div class="form-group required">
                                    <label class="col-sm-2 control-label" for="input-origin1"><span data-toggle="tooltip"
                                            title="<?php echo $help_origin; ?>">
                                            <?php echo $entry_origin1; ?></span></label>
                                    <div class="col-sm-10">
                                        <input type="text" name="kazpost_origin_city-1" value="<?php echo $kazpost_origin_city1; ?>"
                                            placeholder="<?php echo $entry_origin1; ?>" id="input-fromto1" class="form-control" />
                                        <input type="hidden" name="kazpost_origin_id1" value="<?php echo $kazpost_origin_id1; ?>" />
                                    </div>
                                </div>
                                <div class="form-group required">
                                    <label class="col-sm-2 control-label" for="input-origin2"><span data-toggle="tooltip"
                                            title="<?php echo $help_origin; ?>">
                                            <?php echo $entry_origin2; ?></span></label>
                                    <div class="col-sm-10">
                                        <input type="text" name="kazpost_origin_city-2" value="<?php echo $kazpost_origin_city2; ?>"
                                            placeholder="<?php echo $entry_origin2; ?>" id="input-fromto2" class="form-control" />
                                        <input type="hidden" name="kazpost_origin_id2" value="<?php echo $kazpost_origin_id2; ?>" />
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane" id="tab-kazpost">
                                <div class="col-xs-1">
                                    <ul class="nav nav-tabs tabs-left" id="verticalTab">
                                        <li><a href="#tab-server1" data-toggle="tab">
                                                <?php echo $text_server1 ?></a></li>
                                        <li><a href="#tab-server2" data-toggle="tab">
                                                <?php echo $text_server2 ?></a></li>
                                    </ul>
                                </div>
                                <div class="col-xs-11">
                                    <div class="tab-content">
                                        <div class="tab-pane" id="tab-server1">
                                            <div class="container-fluid">
                                                <div class="pull-right">
                                                    <button type="button" data-toggle="tooltip" title="<?php echo $button_add; ?>"
                                                        class="btn btn-primary" onclick="addrow('server1')"><i class="fa fa-plus"></i></button>
                                                </div>
                                                <h3 class="panel-title"><i class="fa fa-list"></i>
                                                    <?php echo $kazpost_title; ?>
                                                </h3>
                                            </div>
                                            <div class="panel-body">
                                                <div class="table-responsive">
                                                    <table class="table table-bordered table-hover" id="tab-method-server1">
                                                        <thead>
                                                            <tr>
                                                                <td style="width: 1px;" class="text-center"><input type="checkbox" /></td>
                                                                <td class="text-left">
                                                                    <?php echo $column_name; ?>
                                                                </td>
                                                                <td class="text-right">
                                                                    <?php echo $column_product; ?>
                                                                </td>
                                                                <td class="text-right">
                                                                    <?php echo $column_sendmethod; ?>
                                                                </td>
                                                                <td class="text-right">
                                                                    <?php echo $column_mailcat; ?>
                                                                </td>
                                                                <td class="text-right">
                                                                    <?php echo $column_specmarks; ?>
                                                                </td>
                                                                <td class="text-right">
                                                                    <?php echo $column_sort_order; ?>
                                                                </td>
                                                                <td class="text-right">
                                                                    <?php echo $column_action; ?>
                                                                </td>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <?php if ($kazpost_methods) { ?>
                                                            <?php foreach ($kazpost_methods as $deliverymethod) { ?>
                                                            <tr>
                                                                <td class="text-center">
                                                                    <?php echo $deliverymethod['id']; ?>
                                                                </td>
                                                                <td class="text-left"><input type="text" name="kazpost_methods-server1[<?php echo $deliverymethod['id']; ?>][name]"
                                                                        value="<?php echo $deliverymethod['name']; ?>"
                                                                        placeholder="<?php echo $help_data_input; ?>"
                                                                        id="server1-name" class="form-control" />
                                                                    <input type="hidden" name="kazpost_methods-server1[<?php echo $deliverymethod['id']; ?>][id]"
                                                                        value="<?php echo $deliverymethod['id']; ?>" /></td>
                                                                <td class="text-left"><input type="text" name="kazpost_methods-server1[<?php echo $deliverymethod['id']; ?>][product]"
                                                                        value="<?php echo $deliverymethod['product']; ?>"
                                                                        placeholder="<?php echo $help_data_select; ?>"
                                                                        id="server1-Product" class="form-control" />
                                                                    <input type="hidden" name="kazpost_methods-server1[<?php echo $deliverymethod['id']; ?>][product_id]"
                                                                        value="<?php echo $deliverymethod['product_id']; ?>" /></td>
                                                                <td class="text-left"><input type="text" name="kazpost_methods-server1[<?php echo $deliverymethod['id']; ?>][sendmethod]"
                                                                        value="<?php echo $deliverymethod['sendmethod']; ?>"
                                                                        placeholder="<?php echo $help_data_select; ?>"
                                                                        id="server1-SendMethod" class="form-control" />
                                                                    <input type="hidden" name="kazpost_methods-server1[<?php echo $deliverymethod['id']; ?>][sendmethod_id]"
                                                                        value="<?php echo $deliverymethod['sendmethod_id']; ?>" /></td>
                                                                <td class="text-left"><input type="text" name="kazpost_methods-server1[<?php echo $deliverymethod['id']; ?>][mailcat]"
                                                                        value="<?php echo $deliverymethod['mailcat']; ?>"
                                                                        placeholder="<?php echo $help_data_select; ?>"
                                                                        id="server1-MailCat" class="form-control" />
                                                                    <input type="hidden" name="kazpost_methods-server1[<?php echo $deliverymethod['id']; ?>][mailcat_id]"
                                                                        value="<?php echo $deliverymethod['mailcat_id']; ?>" /></td>
                                                                <td class="text-left"><input type="text" name="kazpost_methods-server1[<?php echo $deliverymethod['id']; ?>][specmarks]"
                                                                        value="<?php echo $deliverymethod['specmarks']; ?>"
                                                                        placeholder="<?php echo $help_data_select; ?>"
                                                                        id="server1-SpecMarks" class="form-control" />
                                                                    <input type="hidden" name="kazpost_methods-server1[<?php echo $deliverymethod['id']; ?>][specmarks_id]"
                                                                        value="<?php echo $deliverymethod['specmarks_id']; ?>" /></td>
                                                                <td class="text-left"><input type="text" name="kazpost_methods-server1[<?php echo $deliverymethod['id']; ?>][sort_order]"
                                                                        value="<?php echo $deliverymethod['sort_order']; ?>"
                                                                        placeholder="<?php echo $help_data_input; ?>"
                                                                        id="server1-sort_order" class="form-control" /></td>
                                                                <td class="text-right"><button type="button"
                                                                        data-toggle="tooltip" title="<?php echo $button_delete; ?>"
                                                                        class="btn btn-danger"><i class="fa fa-trash-o"></i></button></td>
                                                            </tr>
                                                            <?php } ?>
                                                            <?php } else { ?>
                                                            <tr>
                                                                <td class="text-center" colspan="8" id="no_result">
                                                                    <?php echo $text_no_results; ?>
                                                                </td>
                                                            </tr>
                                                            <?php } ?>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="tab-pane" id="tab-server2">
                                            <div class="container-fluid">
                                                <div class="pull-right">
                                                    <button type="button" data-toggle="tooltip" title="<?php echo $button_add; ?>"
                                                        class="btn btn-primary" onclick="addrow('server2')"><i class="fa fa-plus"></i></button>
                                                </div>
                                                <h3 class="panel-title"><i class="fa fa-list"></i>
                                                    <?php echo $kazpost_title; ?>
                                                </h3>
                                            </div>
                                            <div class="panel-body">
                                                <div class="table-responsive">
                                                    <table class="table table-bordered table-hover" id="tab-method-server2">
                                                        <thead>
                                                            <tr>
                                                                <td style="width: 1px;" class="text-center"><input type="checkbox" /></td>
                                                                <td class="text-left">
                                                                    <?php echo $column_name; ?>
                                                                </td>
                                                                <td class="text-right">
                                                                    <?php echo $column_product; ?>
                                                                </td>
                                                                <td class="text-right">
                                                                    <?php echo $column_sendmethod; ?>
                                                                </td>
                                                                <td class="text-right">
                                                                    <?php echo $column_mailcat; ?>
                                                                </td>
                                                                <td class="text-right">
                                                                    <?php echo $column_sndrctg; ?>
                                                                </td>
                                                                <td class="text-right">
                                                                    <?php echo $column_sort_order; ?>
                                                                </td>
                                                                <td class="text-right">
                                                                    <?php echo $column_action; ?>
                                                                </td>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <?php if ($kazpost_methods2) { ?>
                                                            <?php foreach ($kazpost_methods2 as $deliverymethod2) { ?>
                                                            <tr>
                                                                <td class="text-center">
                                                                    <?php echo $deliverymethod2['id']; ?>
                                                                </td>
                                                                <td class="text-left"><input type="text" name="kazpost_methods-server2[<?php echo $deliverymethod2['id']; ?>][name]"
                                                                        value="<?php echo $deliverymethod2['name']; ?>"
                                                                        placeholder="<?php echo $help_data_input; ?>"
                                                                        id="server2-name" class="form-control" />
                                                                    <input type="hidden" name="kazpost_methods-server2[<?php echo $deliverymethod2['id']; ?>][id]"
                                                                        value="<?php echo $deliverymethod2['id']; ?>" /></td>
                                                                <td class="text-left"><input type="text" name="kazpost_methods-server2[<?php echo $deliverymethod2['id']; ?>][product]"
                                                                        value="<?php echo $deliverymethod2['product']; ?>"
                                                                        placeholder="<?php echo $help_data_select; ?>"
                                                                        id="server2-Product" class="form-control" />
                                                                    <input type="hidden" name="kazpost_methods-server2[<?php echo $deliverymethod2['id']; ?>][product_id]"
                                                                        value="<?php echo $deliverymethod2['product_id']; ?>" /></td>
                                                                <td class="text-left"><input type="text" name="kazpost_methods-server2[<?php echo $deliverymethod2['id']; ?>][sendmethod]"
                                                                        value="<?php echo $deliverymethod2['sendmethod']; ?>"
                                                                        placeholder="<?php echo $help_data_select; ?>"
                                                                        id="server2-SendMethod" class="form-control" />
                                                                    <input type="hidden" name="kazpost_methods-server2[<?php echo $deliverymethod2['id']; ?>][sendmethod_id]"
                                                                        value="<?php echo $deliverymethod2['sendmethod_id']; ?>" /></td>
                                                                <td class="text-left"><input type="text" name="kazpost_methods-server2[<?php echo $deliverymethod2['id']; ?>][mailcat]"
                                                                        value="<?php echo $deliverymethod2['mailcat']; ?>"
                                                                        placeholder="<?php echo $help_data_select; ?>"
                                                                        id="server2-MailCat" class="form-control" />
                                                                    <input type="hidden" name="kazpost_methods-server2[<?php echo $deliverymethod2['id']; ?>][mailcat_id]"
                                                                        value="<?php echo $deliverymethod2['mailcat_id']; ?>" /></td>
                                                                <td class="text-left"><input type="text" name="kazpost_methods-server2[<?php echo $deliverymethod2['id']; ?>][sndrctg]"
                                                                        value="<?php echo $deliverymethod2['sndrctg']; ?>"
                                                                        placeholder="<?php echo $help_data_select; ?>"
                                                                        id="server2-SndrCtg" class="form-control" />
                                                                    <input type="hidden" name="kazpost_methods-server2[<?php echo $deliverymethod2['id']; ?>][sndrctg_id]"
                                                                        value="<?php echo $deliverymethod2['sndrctg_id']; ?>" /></td>
                                                                <td class="text-left"><input type="text" name="kazpost_methods-server2[<?php echo $deliverymethod2['id']; ?>][sort_order]"
                                                                        value="<?php echo $deliverymethod2['sort_order']; ?>"
                                                                        placeholder="<?php echo $help_data_input; ?>"
                                                                        id="server2-sort_order" class="form-control" /></td>
                                                                <td class="text-right"><button type="button"
                                                                        data-toggle="tooltip" title="<?php echo $button_delete; ?>"
                                                                        class="btn btn-danger"><i class="fa fa-trash-o"></i></button></td>
                                                            </tr>
                                                            <?php } ?>
                                                            <?php } else { ?>
                                                            <tr>
                                                                <td class="text-center" colspan="8" id="no_result">
                                                                    <?php echo $text_no_results; ?>
                                                                </td>
                                                            </tr>
                                                            <?php } ?>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane" id="tab-calc">
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-method;">
                                        <?php echo $column_method_name; ?></label>
                                    <div class="col-sm-10">
                                        <select name="method_id" id="input-method" class="form-control">
                                            <?php if ($kazpost_api_server == '1') { ?>
                                            <?php foreach ($kazpost_methods as $calc_method) { ?>
                                            <option value="<?php echo $calc_method['id']; ?>">
                                                <?php echo $calc_method['name']; ?>
                                            </option>
                                            <?php } ?>
                                            <?php } ?>
                                            <?php if ($kazpost_api_server == '2') { ?>
                                            <?php foreach ($kazpost_methods2 as $calc_method) { ?>
                                            <option value="<?php echo $calc_method['id']; ?>">
                                                <?php echo $calc_method['name']; ?>
                                            </option>
                                            <?php } ?>
                                            <?php } ?>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-weight">
                                        <?php echo $entry_weight; ?></label>
                                    <div class="col-sm-10">
                                        <input type="text" name="weight" value="<?php echo $weight; ?>" placeholder="<?php echo $help_data_input; ?>"
                                            id="input-weight" class="form-control" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-destination">
                                        <?php echo $entry_to; ?></label>
                                    <div class="col-sm-10">
                                        <input type="text" name="destination" value="<?php echo $destination; ?>"
                                            placeholder="<?php echo $help_data_select; ?>" id="input-fromto" class="form-control" />
                                        <input type="hidden" name="destination_id" value="<?php echo $destination_id; ?>"
                                            id="input-destination_id" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-rate">
                                        <?php echo $entry_rate; ?></label>
                                    <div class="col-sm-10">
                                        <input type="text" name="rate" readonly="true" value="" id="input-rate" class="form-control" />

                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane" id="tab-support">
                                <fieldset>
                                    <legend>Служба поддержки</legend>
                                    <address>
                                        По всем вопросам, связаннымы с работой модуля обращайтесь:<br />
                                        <i class="fa fa-skype"></i> sl271261414<br />
                                        <strong>E-mail:</strong> <a href="mailto:#">comtronics@mail.ru</a><br />
                                        <strong>Сайт-демо:</strong> <a href="http://demo.radiocity.kz">demo.radiocity.kz</a>
                                    </address>
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
	/*  vertical tabs  */
.tabs-left, .tabs-right {
    border-bottom: none;
    padding-top: 2px;
}
.tabs-left {
    border-right: 1px solid #ddd;
}
.tabs-right {
    border-left: 1px solid #ddd;
}
.tabs-left>li, .tabs-right>li {
    float: none;
    margin-bottom: 2px;
}
.tabs-left>li {
    margin-right: -1px;
}
.tabs-right>li {
    margin-left: -1px;
}
.tabs-left>li.active>a,
.tabs-left>li.active>a:hover,
.tabs-left>li.active>a:focus {
    border-bottom-color: #ddd;
    border-right-color: transparent;
}

.tabs-right>li.active>a,
.tabs-right>li.active>a:hover,
.tabs-right>li.active>a:focus {
    border-bottom: 1px solid #ddd;
    border-left-color: transparent;
}
.tabs-left>li>a {
    border-radius: 4px 0 0 4px;
    margin-right: 0;
    display:block;
}
.tabs-right>li>a {
    border-radius: 0 4px 4px 0;
    margin-right: 0;
}

.control-label.required:before {
    content: '* ';
    color: #F00;
    font-weight: bold;
}

table.form > tbody > tr > td {	
    width: 200px;
}
</style>
<script type="text/javascript">< !--
        // var filename, sheet, row;

        $('#tabs a:first').tab('show');
    $('#verticalTab a:first').tab('show');

    $('input[name=\'kazpost_origin_city-1\'], input[name=\'kazpost_origin_city-2\'], input[name=\'destination\']').autocomplete({
        source: function (request, response) {
            var server, filename, sheet;
            if (this.name == 'destination') {
                server = $('input[name=\'kazpost_api_server\']:checked').val();
            } else {
                server = this.name.split(/-/g)[1];
            }
            filename = $('input[name=\'kazpost_server' + server + '_xls\']').val();
            sheet = "<?php echo $kazpost_fromto_sheetname; ?>";
            $.ajax({
                url: 'index.php?route=shipping/kazpost/autocomplete&token=<?php echo $token; ?>&file=' + filename + '&sheet=' + sheet + '&server=' + server,
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

    var settings = {
        source: function (request, response) {
            var catalog = $(this).attr('id').split(/-/g);
            var filename = $('input[name=\'kazpost_' + catalog[0] + '_xls\']').val();
            var processing = 'autocomplete';
            //if ( catalog[0] == 'server1' && (catalog[1] == 'Product' || catalog[1] == 'SpecMarks')) {            
            //	processing = 'apicomplete';
            //} else {                   
            //     processing = 'autocomplete';            
            // }

            $.ajax({
                url: 'index.php?route=shipping/kazpost/' + processing + '&token=<?php echo $token; ?>&file=' + filename + '&sheet=' + catalog[1] + '&server=' + catalog[0],
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
    };

    $('input[name *= \\[product\\]], input[name *=\\[specmarks\\]], input[name *= \\[sendmethod\\]], input[name *=\\[mailcat\\]], input[name *=\\[sndrctg\\]]').not('[type=hidden]').autocomplete(settings);


    function addrow(server) {
        $('tr:has(#no_result)').remove();
        //     row = $('#tab-method >tbody >tr').not(':has(#no_result)').length;
        var row = $('#tab-method-' + server + ' >tbody >tr').length;

        html = '<tr>';
        html += '<td class="text-center">' + row + '</td>';
        html += '<td class="text-left"><input type="text" name="kazpost_methods-' + server + '[' + row + '][name]" value="" placeholder="<?php echo $help_data_input; ?>" id="' + server + '-name" class="form-control" />';
        html += '<input type="hidden" name="kazpost_methods-' + server + '[' + row + '][id]" value="' + row + '" /></td>';
        html += '<td class="text-left"><input type="text" name="kazpost_methods-' + server + '[' + row + '][product]" value="" placeholder="<?php echo $help_data_select; ?>" id="' + server + '-Product" class="form-control" />';
        html += '<input type="hidden" name="kazpost_methods-' + server + '[' + row + '][product_id]" value="" /></td>';
        html += '<td class="text-left"><input type="text" name="kazpost_methods-' + server + '[' + row + '][sendmethod]" value="" placeholder="<?php echo $help_data_select; ?>" id="' + server + '-SendMethod" class="form-control" />';
        html += '<input type="hidden" name="kazpost_methods-' + server + '[' + row + '][sendmethod_id]" value="" /></td>';
        html += '<td class="text-left"><input type="text" name="kazpost_methods-' + server + '[' + row + '][mailcat]" value="" placeholder="<?php echo $help_data_select; ?>" id="' + server + '-MailCat" class="form-control" />';
        html += '<input type="hidden" name="kazpost_methods-' + server + '[' + row + '][mailcat_id]" value="" /></td>';
        if (server == "server1") {
            html += '<td class="text-left"><input type="text" name="kazpost_methods-' + server + '[' + row + '][specmarks]" value="" placeholder="<?php echo $help_data_select; ?>" id="' + server + '-SpecMarks" class="form-control" />';
            html += '<input type="hidden" name="kazpost_methods-' + server + '[' + row + '][specmarks_id]" value="" /></td>';
        }
        if (server == "server2") {
            html += '<td class="text-left"><input type="text" name="kazpost_methods-' + server + '[' + row + '][sndrctg]" value="" placeholder="<?php echo $help_data_select; ?>" id="' + server + '-SndrCtg" class="form-control" />';
            html += '<input type="hidden" name="kazpost_methods-' + server + '[' + row + '][sndrctg_id]" value="" /></td>';
        }
        html += '<td class="text-right"><input type="text" name="kazpost_methods-' + server + '[' + row + '][sort_order]" value="" placeholder="<?php echo $help_data_input; ?>" id="' + server + '-sort_order" class="form-control" /></td>';
        html += '<td class="text-right"><button type="button" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger"><i class="fa fa-trash-o"></i></button></td>';
        html += '</tr>';

        $('#tab-method-' + server + ' > tbody:last').append(html);

        $('input[name *= \\[product\\]], input[name *=\\[specmarks\\]], input[name *= \\[sendmethod\\]], input[name *=\\[mailcat\\]], input[name *=\\[sndrctg\\]]').not('[type=hidden]').autocomplete(settings);
    }


    $('[id ^= tab-method] >tbody').on('click', '.btn-danger', function () {
        if (confirm('<?php echo $text_confirm; ?>')) {
            $(this).closest('tr').remove();
            $('[id ^= tab-method] >tbody').find('tr').each(function (i, e) {
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
                server: $('input[name=\'kazpost_api_server\']:checked').val(),
            },
            beforeSend: function () {
                $("#ajaxloader").show();
            },
            complete: function () {
                $("#ajaxloader").hide();
            },
            success: function (rate) {
                $('#input-rate').val(rate);
            }
        });
    });
//--></script>
<?php echo $footer; ?>