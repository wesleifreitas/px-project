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

            var _url = angular.copy(pxConfig.PX_PACKAGE);
            if (_url !== '') {
                _url += '/';
            }

            var cssLoader = [{
                file: pxConfig.LIB + 'angular-material/angular-material.min.css'
            }, {
                file: 'https://fonts.googleapis.com/css?family=RobotoDraft:300,400,500,700,400italic'
            }, {
                file: 'https://fonts.googleapis.com/icon?family=Material+Icons'
            }, {
                file: 'https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css'
            }, {
                file: _url + 'system/core/external/jstree/themes/proton/style.css'
            }, {
                file: _url + 'system/components/px-view-header/px-view-header.css'
            }, {
                file: _url + 'system/components/px-data-grid/px-data-grid.css'
            }, {
                file: _url + 'system/components/px-form-item/px-form-item.css'
            }, {
                file: _url + 'system/core/px-project.css'
            }];

            // Loop em cssLoader
            $.each(cssLoader, function(i, item) {
                $('<link rel="stylesheet"/>').attr('href', item.file).appendTo($('head'));
            });

            // Loop em pxConfig.PROJECT_CSS
            $.each(pxConfig.PROJECT_CSS, function(i, item) {
                $('<link rel="stylesheet"/>').attr('href', item).appendTo($('head'));
            });
        }
    }
});