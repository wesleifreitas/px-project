define(['../controllers/module'], function(controllers) {
    'use strict';

    // Controller
    controllers.controller('Exemplo2ListCtrl', Exemplo2ListCtrl);

    Exemplo2ListCtrl.$inject = ['pxConfig', '$scope', '$element', '$attrs', '$mdDialog'];

    function Exemplo2ListCtrl(pxConfig, $scope, $element, $attrs, $mdDialog) {
        // Variáveis gerais - Start
        /**
         * Variável de controle de visualição do Filtro Avançado
         * @type {Boolean}
         */
        $scope.expand = false;
        /**
         * Responsável por realizar o efeito de expandir o Filtro Avançado
         * @return {Void}
         */
        $scope.showFilter = function() {
            var $header = $('#headerSearch');
            var $content = $header.next();
            $content.slideToggle(500, function() {});
            $scope.filterExpand = !$scope.filterExpand;
            $header.blur();
        };
        // Variáveis gerais - End

        // Variáveis gerais - Start

        // Filtro - Start 

        // Filtro - End

        // Listagem - Start

        /**
         * Controle da listagem
         * Note que a propriedade 'control' da directive px-data-grid é igual a 'dgExemploControl'
         * Exemplo: <px-data-grid px-control="dgExemploControl">
         * @type {Object}
         */
        $scope.dgExemplo2Control = {};

        /**
         * Inicializa listagem
         * @return {Void}
         */
        $scope.dgExemplo2Init = function() {
            /**
             * Configurações da listagem
             * - fields: Colunas da listagem
             * @type {Object}
             */
            $scope.dgExemplo2Config = {
                schema: 'dbo',
                table: 'exemplo2',
                group: false,
                orderBy: [{
                    field: 'exe2_categoria',
                    sort: 'asc'
                }],
                fields: [{
                    pk: true,
                    title: 'id',
                    field: 'exe2_id',
                    type: 'int'
                }, {
                    title: 'Categoria',
                    field: 'exe2_categoria',
                    type: 'string',
                    filter: 'filtroCategoria',
                    filterOperator: '%LIKE%'
                }, {
                    title: 'Descrição',
                    field: 'exe2_descricao',
                    type: 'string'
                }],
            };
        };

        /**
         * Atualizar dados da listagem
         * @return {Void}
         */
        $scope.getDataExemplo2 = function() {
            //Recuperar dados para a listagem
            $scope.dgExemplo2Control.getData();
        };

        /**
         * Evento itemClick
         * @param  {Object} event dados do evento itemClick
         * @return {Void}
         */
        $scope.itemClick = function(event) {
            $scope.callback(event);
            $mdDialog.hide();
        };

        $scope.close = function() {
            $mdDialog.cancel();
        };
    }
});