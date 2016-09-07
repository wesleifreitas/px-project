define(['../controllers/module'], function(controllers) {
    'use strict';

    // Controller
    controllers.controller('PerfilCtrl', PerfilCtrl);

    PerfilCtrl.$inject = ['pxConfig', 'perfilService', '$rootScope', '$scope', '$element', '$attrs', '$mdDialog'];

    function PerfilCtrl(pxConfig, perfilService, $rootScope, $scope, $element, $attrs, $mdDialog) {
        // Variáveis gerais - Start
        $scope.dataStatus = {
            // Array: opções do select com opção "Todos"
            arrayStatusAll: perfilService.status(true),
            // Array: opções do select sem opção "Todos"
            arrayStatus: perfilService.status(false),
        };

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

        // Configuração do grupo_id_search
        $scope.grupo_id_searchConfig = {
            table: 'dbo.grupo',
            fields: [{
                title: '',
                labelField: true,
                field: 'grupo_nome',
                search: true,
                type: 'string',
                filterOperator: '%LIKE%'
            }, {
                title: '',
                field: 'grupo_id',
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
             * Configurações da listagem
             * - fields: Colunas da listagem
             * @type {object}
             */
            $scope.dgConfig = {
                schema: 'dbo',
                table: 'perfil',
                view: 'vw_perfil',
                groupItem: 'grupo_id',
                fields: [{
                    pk: true,
                    visible: false,
                    title: 'ID',
                    field: 'per_id',
                    type: 'int',
                    identity: true
                }, {
                    title: 'Nome',
                    field: 'per_nome',
                    type: 'string',
                    filter: 'filtro_per_nome',
                    filterOperator: '%LIKE%'
                }, {
                    title: 'Status',
                    field: 'per_ativo_label',
                    type: 'bit',
                    filter: 'filtro_per_ativo',
                    filterOperator: '=',
                    filterOptions: {
                        field: 'per_ativo',
                        selectedItem: 'id'
                    }
                }]
            };

            // Verificar se o usuário não é master
            if (!$rootScope.globals.currentUser.per_master) {
                // Se não for usuário master: não irá recuperar perfil master
                $scope.dgConfig.where = [{
                    field: 'per_master',
                    type: 'bit',
                    filterOperator: '<>',
                    filterValue: '1'
                }];
            }

        /**
         * Inicializa listagem
         * @return {void}
         */
        $scope.gridInit = function() {
            // Definir formulário default
            $scope.formShow = 'default';
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
        formCtrl.$inject = ['perfilService', '$scope', '$mdDialog', '$rootScope'];

        $scope.setFormTitle = function() {
            if ($scope.formShow === 'default') {
                if ($scope.formAction === 'insert') {
                    $scope.formTitle = "Formulário de Adicionar";
                } else {
                    $scope.formTitle = "Formulário de Editar";
                }
            } else if ($scope.formShow === 'grupo') {
                $scope.formTitle = "Selecione um grupo";
            }
        }

        $scope.add = function(event) {
            $scope.formAction = "insert";
            $scope.setFormTitle();
            $mdDialog.show({
                scope: $scope,
                preserveScope: true,
                controller: formCtrl,
                templateUrl: pxConfig.PX_PACKAGE + 'system/perfil/perfil-form.html',
                parent: angular.element(document.body),
                targetEvent: event,
                clickOutsideToClose: false
            });
        };

        $scope.edit = function(event) {
            $scope.formAction = "update";
            $scope.formItemEdit = event.itemEdit;
            $scope.setFormTitle();
            $mdDialog.show({
                scope: $scope,
                preserveScope: true,
                controller: formCtrl,
                templateUrl: pxConfig.PX_PACKAGE + 'system/perfil/perfil-form.html',
                parent: angular.element(document.body),
                targetEvent: event,
                clickOutsideToClose: false
            });
        };
    }
    // Controller - Formulário
    function formCtrl(perfilService, $scope, $mdDialog, $rootScope) {
        /**
         * Controle do formulário
         * Note que a propriedade 'control' da directive px-form é igual a 'formControl'
         * Exemplo: <px-form px-control="formControl">
         * @type {Object}
         */
        $scope.formControl = {};
        // Controle do campo grupo_id_searchControl
        $scope.grupo_id_searchControl = {};
        // Clicar no botão busca grupo
        $scope.grupo_id_searchClick = function() {
            $scope.formShow = 'grupo';
            $scope.setFormTitle();
        };

        /**
         * Inicializa formulário
         * @return {void}
         */
        $scope.formInit = function() {

            // Limpar formuário
            $scope.formControl.clean();

            // Configurar formulário
            $scope.formConfig = {
                table: 'dbo.perfil',
                view: 'dbo.vw_perfil',
                groupItem: 'grupo_id',
                fields: [{
                    pk: true,
                    field: 'per_id',
                    type: 'string',
                    identity: true
                }, {
                    field: 'grupo_id',
                    fieldValueOptions: {
                        selectedItem: 'grupo_id'
                    },
                    type: 'int',
                    element: 'grupo_id'
                }, {
                    field: 'per_ativo',
                    labelField: 'per_ativo_label',
                    type: 'int',
                    element: 'per_ativo',
                    fieldValueOptions: {
                        selectedItem: 'id',
                        selectedLabel: 'name'
                    }
                }, {
                    field: 'per_nome',
                    type: 'string',
                    element: 'per_nome'
                }, {
                    field: 'per_master',
                    type: 'bit',
                    element: 'per_master'
                }, {
                    field: 'per_resetarSenha',
                    type: 'bit',
                    element: 'per_resetarSenha'
                }]
            }

            $scope.per_ativo = $scope.dataStatus.arrayStatusAll;

            if ($scope.formAction === 'insert') {
                $scope.jsTree(0);
            } else if ($scope.formAction === 'update') {
                $scope.formControl.select($scope.formItemEdit);
                $scope.jsTree($scope.formItemEdit.per_id);
            }
        };

        /**
         * Inserir registro
         * @return {[type]} [description]
         */
        $scope.formInsert = function(form) {
            $scope.formControl.insert();            
        };

        /**
         * Atualizar registro
         * @return {[type]} [description]
         */
        $scope.formUpdate = function(form) {
            $scope.formControl.update();            
        };

        /**
         * Função callback do formulário
         * @param  {object} event retorno do formulário
         * @return {void}
         */
        $scope.formCallback = function(event) {
            var grupo_id = $rootScope.globals.currentUser.grupo_id;
            if ($rootScope.globals.currentUser.per_developer === 1) {
                grupo_id = $scope.grupo_id_searchControl.getValue().selectedItem.grupo_id;
            }

            if (event.action == 'insert' && !event.error) {
                // Adicionar registro na listagem
                $scope.gridControl.addDataRow(event.data);
                // Salvar treeMenu
                perfilService.saveTreeMenu(event.queryResult.IDENTITYCOL, $scope.jstreeData, function(response) {
                    //console.info('saveTreeMenu', response);
                    $mdDialog.hide();
                });
            } else if (event.action == 'update' && !event.error) {
                // Atualiza registro na listagem
                $scope.gridControl.updateDataRow(event.data);
                // Salvar treeMenu
                perfilService.saveTreeMenu(event.data.per_id, $scope.jstreeData, function(response) {
                    //console.info('saveTreeMenu', response);
                    $mdDialog.hide();
                });
            }
        };

        /**
         * Fechar formulário
         * @return {void}
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
         * @return {void}
         */
        $scope.formClean = function() {
            // Limpar formuário
            $scope.formControl.clean();
        };

        // Evento itemClick grupo
        $scope.grupo_id_itemClick = function(event) {
            $scope.formShow = 'default';
            $scope.grupo_id_searchControl.setValue(event.itemClick);
            $scope.setFormTitle();
        };

        $scope.jsTree = function(id) {

            $('#jstree').on("changed.jstree", function(e, data) {
                $scope.jstreeData = data.selected;
            });

            perfilService.jsTreeMenu(id, function(response) {
                //console.info('jsTreeMenu', response)
                response.jstree = JSON.parse(JSON.stringify(response.jstree).replace(/,"null"/g, ''));
                /*
                response.jstree = {
                    'plugins': ["wholerow", "checkbox"],
                    'core': {
                        'data': [{
                                "text": "Wholerow with checkboxes",
                                "children": [{
                                    "text": "initially selected",
                                    "state": {
                                        "selected": true
                                    }
                                }, {
                                    "text": "system icon URL",
                                }, {
                                    "text": "initially open",
                                    "state": {
                                        "opened": true
                                    },
                                    "children": [{
                                        "text": "Another node A",
                                        "children": [{
                                            "text": "Another node B"
                                        }]
                                    }]
                                }, {
                                    "text": "system icon class",
                                    "icon": "glyphicon glyphicon-leaf"
                                }]
                            },
                            "And wholerow selection"
                        ],
                        'themes': {
                            'name': 'proton',
                            'responsive': true
                        }
                    }
                };                
                */
                $('#jstree').jstree(response.jstree);
            });
        }
    }
});