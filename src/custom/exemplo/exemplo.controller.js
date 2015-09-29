(function() {
    'use strict';

    // Filter refreshDataGrid
    // Retorna o class adequado para o botão atualizar de acordo com o processamento do dataGrid
    app.filter('refreshDataGrid', function() {
        return function(working) {
            // Verifica working da px-data-grid
            // Class no botão Atualizar (Listagem)
            if (working) {
                return 'fa fa-refresh fa-spin';
            } else {
                return 'fa fa-refresh';
            }
        };
    })

    // Controller
    app.controller('exemploCtrl', ['exemploService', 'pxConfig', '$scope', '$element', '$attrs', function(exemploService, pxConfig, $scope, $element, $attrs, $rootScope) {

        // Variáveis gerais - Start

        // Define as opções de status
        $scope.dataStatus = {
            // Array: opções do select com opção "Todos"
            optionsAll: exemploService.status(true),
            // Array: opções do select sem opção "Todos"
            options: exemploService.status(false),
        };

        // Default de options para o filtro filtroStatus
        $scope.filtroStatus = exemploService.status(true)[0];

        // Configuração do filtro filtroComplete
        $scope.filtroCompleteConfig = {
            fields: [{
                title: '',
                labelField: true,
                field: 'exe_nome',
                search: true,
                type: 'string',
                filterOperator: '%LIKE%'
            }, {
                title: 'CPF: ',
                descriptionField: true,
                field: 'exe_cpf',
            }, {
                title: '',
                field: 'exe_id',
            }]
        };

        // Variáveis gerais - End

        // Listagem - Start

        /**
         * Controle da listagem
         * Note que a propriedade 'control' da directive px-data-grid é igual a 'gridControl'
         * Exemplo: <px-data-grid control="gridControl">
         * @type {Object}
         */
        $scope.gridControl = {};

        /**
         * Inicializa listagem
         * @return {void}
         */
        $scope.gridInit = function() {
            /**
             * Configurações da listagem
             * - fields: Colunas da listagem
             * @type {object}
             */
            $scope.gridConfig = {
                fields: [{
                    pk: true,
                    title: 'id',
                    field: 'exe_id',
                    type: 'int',
                    filter: 'filtroId',
                    filterOperator: '='
                }, {
                    title: 'Status',
                    field: 'exe_ativo_label',
                    type: 'bit',
                    filter: 'filtroStatus',
                    filterOperator: '=',
                    filterOptions: {
                        field: 'exe_ativo',
                        selectedItem: 'id'
                    }
                }, {
                    title: 'Nome',
                    field: 'exe_nome',
                    type: 'string',
                    filter: 'filtroNome',
                    filterOperator: '%LIKE%'
                }, {
                    title: 'Complete',
                    field: 'exe_complete',
                    type: 'bit',
                    filter: 'filtroComplete',
                    filterOperator: '=',
                    filterOptions: {
                        field: 'exe_id',
                        selectedItem: 'exe_id'
                    }
                }, {
                    title: 'CPF',
                    field: 'exe_cpf',
                    type: 'int',
                    stringMask: '###.###.###-##',
                    filter: 'filtroCPF',
                    filterOperator: '='
                }, {
                    title: 'Telefone',
                    field: 'exe_telefone',
                    type: 'string',
                    stringMask: 'brPhone',
                    filter: 'filtroTelefone',
                    filterOperator: '='
                }, {
                    title: 'Valor',
                    field: 'exe_valor',
                    type: 'decimal',
                    numeral: '0,0.00',
                    filter: 'filtroValor',
                    filterOperator: '='
                }, {
                    title: 'Data',
                    field: 'exe_data',
                    type: 'datetime',
                    moment: 'dddd - DD/MM/YYYY'
                }],
            };
        };

        /**
         * Atualizar dados da listagem
         * @return {void}
         */
        $scope.getData = function() {
            //Recuperar dados para a listagem
            $scope.gridControl.getData();
        };

        /**
         * Remover itens da listagem
         * @return {void}
         */
        $scope.remove = function() {
            // Remover itens (selecionados) da listagem
            $scope.gridControl.remove();
        };

        // Listagem - End

        /**
         * Variável de controle de visualição do Filtro Avançado
         * @type {Boolean}
         */
        $scope.expand = false;
        /**
         * Responsável por realizar o efeito de expandir o Filtro Avançado
         * @return {void}
         */
        $scope.showFilter = function() {
            var $header = $('#headerSearch');
            var $content = $header.next();
            $content.slideToggle(500, function() {});
            $scope.filterExpand = !$scope.filterExpand;
            $header.blur();
        };
    }]);
})();