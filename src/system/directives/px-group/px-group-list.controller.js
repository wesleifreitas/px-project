define(['../../controllers/module'], function(controllers) {
    'use strict';

    // Controller
    controllers.controller('GrupoListCtrl', GrupoListCtrl);

    GrupoListCtrl.$inject = ['pxConfig', '$scope', '$element', '$attrs', '$mdDialog'];

    function GrupoListCtrl(pxConfig, $scope, $element, $attrs, $mdDialog) {
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
         * Note que a propriedade 'control' da directive px-data-grid é igual a 'dgGrupoControl'
         * Exemplo: <px-data-grid px-control="dgGrupoControl">
         * @type {Object}
         */
        $scope.dgGrupoControl = {};

        /**
         * Inicializa listagem
         * @return {Void}
         */
        $scope.dgGrupoInit = function() {

        };

        /**
         * Configurações da listagem
         * - fields: Colunas da listagem
         * @type {Object}
         */
        $scope.dgGrupoConfig = {
            schema: 'dbo',
            table: 'grupo',
            group: false,
            fields: [{
                pk: true,
                title: 'Código',
                field: 'grupo_id',
                type: 'int',
                filter: 'filtro_grupo_id',
                filterOperator: '='
            }, {
                title: 'Nome',
                field: 'grupo_nome',
                type: 'string',
                filter: 'filtro_grupo_nome',
                filterOperator: '%LIKE%'
            }],
        };

        /**
         * Atualizar dados da listagem
         * @return {Void}
         */
        $scope.getDataGrupo = function() {
            //Recuperar dados para a listagem
            $scope.dgGrupoControl.getData();
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

        $scope.grupoListClose = function() {
            $mdDialog.cancel();
        };
    }
});