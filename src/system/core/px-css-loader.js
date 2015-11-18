define(['../services/module'], function(services) {
    'use strict';

    services.factory('pxCssLoader', pxCssLoader);

    pxCssLoader.$inject = ['pxConfig'];

    function pxCssLoader(pxConfig) {
        var service = {};

        service.load = load;

        return service;

        function load() {


            var element = document.getElementById('px-loading'),
                style = window.getComputedStyle(element),
                display = style.getPropertyValue('display');

            if (display == 'none') {
                return;
            }

            var cssLoader = [{
                file: pxConfig.PX_PACKAGE + 'system/core/external/metro-bootstrap.css'
            }, {
                file: pxConfig.PX_PACKAGE + 'system/core/external/metro-bootstrap-responsive.css'
            }, {
                file: pxConfig.LIB + 'bootstrap/dist/css/bootstrap.min.css'
            }, {
                file: 'http://cdn.datatables.net/plug-ins/1.10.7/integration/bootstrap/3/dataTables.bootstrap.css'
            }, {
                file: pxConfig.LIB + 'angular-material/angular-material.min.css'
            }, {
                file: 'https://fonts.googleapis.com/css?family=RobotoDraft:300,400,500,700,400italic'
            }, {
                file: 'https://fonts.googleapis.com/icon?family=Material+Icons'
            }, {
                file: 'https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css'
            }, {
                file: pxConfig.PX_PACKAGE + 'system/core/external/jstree/themes/proton/style.css'
            }, {
                file: pxConfig.PX_PACKAGE + 'system/login/login.css'
            }, {
                file: pxConfig.PX_PACKAGE + 'system/components/px-view-header/px-view-header.css'
            }, {
                file: pxConfig.PX_PACKAGE + 'system/components/px-data-grid/px-data-grid.css'
            }, {
                file: pxConfig.PX_PACKAGE + 'system/components/px-form-item/px-form-item.css'
            }, {
                file: pxConfig.PX_PACKAGE + 'system/core/px-project.css'
            }];

            // Loop em cssLoader
            $.each(cssLoader, function(i, item) {
                $('<link rel="stylesheet"/>').attr('href', item.file).appendTo($('head'));
            });
            $('<link rel="stylesheet"/>').attr('href', 'styles.css').appendTo($('head'));            
        }
    }
});