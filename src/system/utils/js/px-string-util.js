define(['../../services/module'], function(services) {
    'use strict';

    services.factory('pxStringUtil', pxStringUtil);

    pxStringUtil.$inject = [];

    function pxStringUtil() {

        var service = {};

        service.pad = pad;

        return service;

        /**
         * Preencher string
         * Note que é utizado o parâmetro pré-preenchimento (pad) devido a perfomance
         * Mais detalhes em http://jsperf.com/string-padding-performance
         * @param  {String} pad     pré-preenchimento, exemplo '0000000000'
         * @param  {String} str     string que será preenchida
         * @param  {Boolean} padLeft preencher à esquerda?
         * @return {String}         string preenchida
         */
        function pad(pad, str, padLeft) {
            if (typeof str === 'undefined')
                return pad;
            if (padLeft) {
                return (pad + str).slice(-pad.length);
            } else {
                return (str + pad).substring(0, pad.length);
            }
        }
    }
});