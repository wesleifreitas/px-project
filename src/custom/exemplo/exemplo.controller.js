define(['../controllers/module'], function(controllers) {
    'use strict';

    // Controller
    controllers.controller('ExemploCtrl', ExemploCtrl);

    ExemploCtrl.$inject = ['exemploService', 'pxConfig', '$scope', '$element', '$attrs', '$mdDialog'];

    function ExemploCtrl(exemploService, pxConfig, $scope, $element, $attrs, $mdDialog) {
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

        // Configuração do exe2_id
        $scope.exe2_id_searchConfig = {
            table: 'dbo.exemplo2',
            group: false,
            fields: [{
                title: '',
                labelField: true,
                field: 'exe2_categoria',
                search: true,
                type: 'string',
                filterOperator: '%LIKE%'
            }, {
                title: 'Descrição: ',
                descriptionField: true,
                field: 'exe2_descricao',
            }, {
                title: '',
                field: 'exe2_id',
            }]
        };
        // Variáveis gerais - End

        // Define as opções de status
        $scope.dataStatus = {
            // Array: opções do select com opção 'Todos'
            optionsAll: exemploService.status(true),
            // Array: opções do select sem opção 'Todos'
            options: exemploService.status(false),
        };

        // Filtro - Start 

        // Default de options para o filtro filtroStatus
        $scope.filtroStatus = exemploService.status(true)[0];

        $scope.filtro_exe2_id_searchControl = {};

        filtro_exe2_id_ctrl.$inject = ['$scope', '$mdDialog'];
        $scope.filtro_exe2_id_searchClick = function() {
            $mdDialog.show({
                scope: $scope,
                preserveScope: true,
                controller: filtro_exe2_id_ctrl,
                templateUrl: 'custom/exemplo2/exemplo2-list.html',
                parent: angular.element(document.body),
                targetEvent: event,
                clickOutsideToClose: true
            });
        }

        // Filtro - End

        // Listagem - Start

        /**
         * Controle da listagem
         * Note que a propriedade 'control' da directive px-data-grid é igual a 'dgExemplo'
         * Exemplo: <px-data-grid px-control='dgExemplo'>
         * @type {Object}
         */
        $scope.dgExemploControl = {};

        /**
         * Inicializa listagem
         * @return {Void}
         */
        $scope.dgExemploInit = function() {
            /**
             * Configurações da listagem
             * - fields: Colunas da listagem
             * @type {Object}
             */
            $scope.dgExemploConfig = {
                table: 'dbo.exemplo',
                view: 'dbo.vw_exemplo',
                orderBy: 'exe_nome',
                group: true,
                fields: [{
                    pk: true,
                    visible: false,
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
                    title: 'Categoria',
                    field: 'exe2_categoria',
                    type: 'bit',
                    filter: 'filtro_exe2_id',
                    filterOperator: '=',
                    filterOptions: {
                        field: 'exe2_id',
                        selectedItem: 'exe2_id'
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
         * @return {Void}
         */
        $scope.getData = function() {
            //Recuperar dados para a listagem
            $scope.dgExemploControl.getData();
        };

        /**
         * Remover itens da listagem
         * @return {Void}
         */
        $scope.remove = function() {
            // Remover itens (selecionados) da listagem
            $scope.dgExemploControl.remove();
        };

        // Listagem - End     

        // Inicializar título do formulário      
        $scope.formTitle = 'Formulário de Adicionar';
        /**
         * Alterar título do formulário
         */
        $scope.setFormTitle = function() {
            if ($scope.formShow === 'default') {
                if ($scope.formAction === 'insert') {
                    $scope.formTitle = 'Formulário de Adicionar';
                } else {
                    $scope.formTitle = 'Formulário de Editar';
                }
            } else if ($scope.formShow === 'exemplo2') {
                $scope.formTitle = 'Selecione uma categoria';
            }
        }


        formCtrl.$inject = ['$scope', '$mdDialog'];
        $scope.add = function(event) {
            $scope.formAction = 'insert';
            $scope.setFormTitle();

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

        $scope.edit = function(event) {
            $scope.formAction = 'update';
            $scope.formItemEdit = event.itemEdit;
            $scope.setFormTitle();

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
    // Controller - filtro_exe2_id
    function filtro_exe2_id_ctrl($scope, $mdDialog) {
        $scope.callback = function(event) {
            $scope.filtro_exe2_id_searchControl.setValue(event.itemClick);
            $mdDialog.hide();
        };
    }
    // Controller - Formulário
    function formCtrl($scope, $mdDialog) {
        /**
         * Controle do formulário
         * Note que a propriedade 'control' da directive px-form é igual a 'formControl'
         * Exemplo: <px-form px-control='formControl'>
         * @type {Object}
         */
        $scope.formControl = {};

        // Controle do campo exe2_id
        $scope.exe2_id_searchControl = {};
        // Clicar no botão busca
        $scope.exe2_id_searchClick = function() {
            $scope.formShow = 'exemplo2';
            $scope.setFormTitle();
        };

        /**
         * Inicializa formulário
         * @return {Void}
         */
        $scope.formInit = function() {
            // Definir formulário default
            $scope.formShow = 'default';

            // Limpar formuário
            $scope.formControl.clean();

            // Configurar formulário
            $scope.formConfig = {
                table: 'dbo.exemplo',
                view: 'dbo.vw_exemplo',
                fields: [{
                    pk: true,
                    field: 'exe_id',
                    type: 'string',
                    identity: true
                }, {
                    field: 'exe_checkbox',
                    type: 'bit',
                    element: 'exe_checkbox'
                }, {
                    field: 'exe_checkbox_char',
                    type: 'string',
                    element: 'exe_checkbox_char',
                    fieldValueOptions: {
                        checked: 'A',
                        unchecked: 'B'
                    }
                }, {
                    field: 'exe_nome',
                    type: 'string',
                    element: 'exe_nome',
                }, {
                    field: 'exe_cpf',
                    type: 'string',
                    element: 'exe_cpf'
                }, {
                    field: 'exe_telefone',
                    type: 'string',
                    element: 'exe_telefone'
                }, {
                    field: 'exe_cep',
                    type: 'string',
                    element: 'exe_cep'
                }, {
                    field: 'exe2_id',
                    type: 'string',
                    element: 'exe2_id',
                    fieldValueOptions: {
                        selectedItem: 'exe2_id',
                        labelField: 'exe2_categoria'
                    },
                }, {
                    field: 'exe_senha',
                    type: 'string',
                    element: 'exe_senha',
                    hash: true
                }, {
                    field: 'exe_senha_confirmar',
                    type: 'string',
                    element: 'exe_senha_confirmar',
                    select: false,
                    insert: false,
                    update: false
                }]
            }

            if ($scope.formAction == 'update') {
                $scope.formControl.select($scope.formItemEdit);
            }
        };

        /**
         * Inserir registro
         * @return {[type]} [description]
         */
        $scope.formInsert = function() {
            $scope.formControl.insert();
            $mdDialog.hide();
        };

        /**
         * Atualizar
         * @return {[type]} [description]
         */
        $scope.formUpdate = function(form) {
            $scope.formControl.update();
            $mdDialog.hide();
        };

        /**
         * Função callback do formulário
         * @param  {Object} event retorno do formulário
         * @return {Void}
         */
        $scope.formCallback = function(event) {
            if (event.action === 'select') {
                $scope.exe_senha_confirmar = event.qQuery[0].EXE_SENHA;
            } else if (event.action == 'insert') {
                // Adicionar registro na listagem
                $scope.dgExemploControl.addDataRow(event.data);
            } else if (event.action == 'update') {
                // Atualizar registro na listagem
                $scope.dgExemploControl.updateDataRow(event.data);
            }
        };

        /**
         * Fechar formulário
         * @return {Void}
         */
        $scope.formCancel = function() {
            if ($scope.formShow === 'default') {
                $mdDialog.cancel();
            } else {
                $scope.formShow = 'default';
            }
        };

        /**
         * Limpar formulário
         * @return {Void}
         */
        $scope.formClean = function() {
            // Limpar formuário
            $scope.formControl.clean();
        };

        // Controle da listagem no formulário
        $scope.dgExemplo2Control = {};

        /**
         * Inicializar listagem
         * @return {Void}
         */
        $scope.dgExemplo2Init = function() {
            /**
             * Configurações da listagem
             * - fields: Colunas da listagem
             * @type {Object}
             */
            $scope.dgExemplo2Config = {
                table: 'dbo.exemplo2',
                group: false,
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

        // Atualizar listagem do formulário
        $scope.getDataExemplo2 = function() {
            //Recuperar dados para a listagem
            $scope.dgExemplo2Control.getData();
        };

        // Evento itemClick
        $scope.dgExemplo2ItemClick = function(event) {
            $scope.formShow = 'default';
            $scope.exe2_id_searchControl.setValue(event.itemClick);
            $scope.setFormTitle();
        };
    }
});