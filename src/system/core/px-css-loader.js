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
            
            // Loop em pxConfig.PROJECT_CSS
            $.each(pxConfig.PROJECT_CSS, function(i, item) {
                $('<link rel="stylesheet"/>').attr('href', item).appendTo($('head'));
            });
        }
    }
});