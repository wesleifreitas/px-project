define(['../controllers/module'], function(controllers) {
    'use strict';

    // Controller
    controllers.controller('exemploCtrl', exemploCtrl);

    exemploCtrl.$inject = ['exemploService', 'pxConfig', '$scope', '$element', '$attrs', '$mdDialog'];

    function exemploCtrl(exemploService, pxConfig, $scope, $element, $attrs, $mdDialog) {
        // Variáveis gerais - Start

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
         * Exemplo: <px-data-grid px-control="gridControl">
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
        $scope.formTitle = "Formulário";
        $scope.add = function(event) {
            $scope.formTitle = "Formulário de Adicionar";
            $scope.action = "insert";

            formCtrl.$inject = ['$scope', '$mdDialog'];
            $mdDialog.show({
                scope: $scope,
                preserveScope: true,
                controller: formCtrl,
                templateUrl: 'custom/exemplo/exemplo-form.html',
                parent: angular.element(document.body),
                targetEvent: event,
                clickOutsideToClose: false
            });
        };
    }
    // Controller - Formulário
    function formCtrl($scope, $mdDialog) {
        /**
         * Controle do formulário
         * Note que a propriedade 'control' da directive px-form é igual a 'formControl'
         * Exemplo: <px-form px-control="formControl">
         * @type {Object}
         */
        $scope.formControl = {};

        /**
         * Inicializa formulário
         * @return {void}
         */
        $scope.formInit = function() {
            $scope.formConfig = {
                pk: [{
                    field: 'exe_id',
                    type: 'int'
                }],
                fields: [{
                    field: 'exe_nome',
                    type: 'string',
                    element: 'nome'
                }, {
                    field: 'exe_cpf',
                    type: 'string',
                    element: 'cpf'
                }]
            }
        };

        $scope.insert = function() {
            console.info(' $scope.formControl', $scope.formControl);
            $scope.formControl.insert();
            $mdDialog.hide();
        };

        $scope.cancel = function() {
            $mdDialog.cancel();
        };
    }
});