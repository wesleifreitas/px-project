define(['../../services/module'], function(services) {
    'use strict';

    services.factory('pxUtil', pxUtil);

    pxUtil.$inject = [];

    function pxUtil() {

        var service = {};

        service.filterOperator = filterOperator;
        service.isMobile = isMobile;

        return service;

        /**
         * Preparar o valor do filtro de acordo com seu operator
         * @param  {string} value    valor do filtro
         * @param  {string} operator operador, exemplos: "=", "%LIKE%"
         * @return {string}          filtro
         */
        function filterOperator(value, operator) {

            // Regras de filtro por Operator
            switch (operator) {

                case '%LIKE%':
                case '%LIKE':
                case 'LIKE%':
                    // Valor do filtro recebe '%' o filterOperator possua '%'
                    // Por exemplo:
                    // Se operator for igual a '%LIKE%' e valor do filtro (value) for 'teste'
                    // Neste caso 'LIKE' é substituido por 'teste' 
                    // Portanto o valor final do filtro será  '%teste%'
                    return operator.toUpperCase().replace('LIKE', value);
                    //break;

                default:
                    return value;
                    //break;
            }
        }

        /**
         * Verificar se o acesso ao sistema é via mobile browser verificando o user agent
         * @return {Boolean}
         */
        function isMobile() {
            var userAgent = navigator.userAgent.toLowerCase();
            if (userAgent.search(/(android|avantgo|blackberry|bolt|boost|cricket|docomo|fone|hiptop|mini|mobi|palm|phone|pie|tablet|up\.browser|up\.link|webos|wos)/i) != -1) {
                return true;
            } else {
                return false;
            }
        }
    }
});