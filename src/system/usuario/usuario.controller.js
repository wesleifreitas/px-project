define(['../controllers/module'], function(controllers) {
    'use strict';

    // Controller
    controllers.controller('usuarioCtrl', usuarioCtrl);

    usuarioCtrl.$inject = ['pxConfig', '$rootScope', '$scope', '$element', '$attrs', '$mdDialog', 'usuarioService'];

    function usuarioCtrl(pxConfig, $rootScope, $scope, $element, $attrs, $mdDialog, usuarioService) {
        // Variáveis gerais - Start
        $scope.dataStatus = {
            // Array: opções do select com opção "Todos"
            arrayStatusAll: usuarioService.status(true),
            // Array: opções do select sem opção "Todos"
            arrayStatus: usuarioService.status(false),
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

        // Configuração do per_id_search
        $scope.per_id_searchConfig = {
            table: 'dbo.perfil',
            fields: [{
                title: '',
                labelField: true,
                field: 'per_nome',
                search: true,
                type: 'string',
                filterOperator: '%LIKE%'
            }, {
                title: '',
                field: 'per_id',
            }]
        };

        // Configuração do grupo_search
        $scope.grupo_searchConfig = {
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
         * Inicializa listagem
         * @return {void}
         */
        $scope.gridInit = function() {
            /**
             * Configurações da listagem
             * - fields: Colunas da listagem
             * @type {object}
             */
            $scope.dgConfig = {
                table: 'dbo.usuario',
                view: 'dbo.vw_usuario',
                fields: [{
                    pk: true,
                    visible: false,
                    title: 'ID',
                    field: 'usu_id',
                    type: 'int',
                    identity: true
                }, {
                    title: 'Nome',
                    field: 'usu_nome',
                    type: 'string',
                    filter: 'filtro_usu_nome',
                    filterOperator: '%LIKE%'

                }, {
                    title: 'Login',
                    field: 'usu_login',
                    type: 'string',
                    filter: 'filtro_usu_login',
                    filterOperator: '%LIKE%'
                }, {
                    title: 'CPF',
                    field: 'usu_cpf',
                    type: 'int',
                    stringMask: '###.###.###-##',
                    filter: 'filtro_usu_cpf',
                    filterOperator: '='
                }, {
                    title: 'Status',
                    field: 'usu_ativo_label',
                    type: 'bit',
                    filter: 'filtro_usu_ativo',
                    filterOperator: '=',
                    filterOptions: {
                        field: 'usu_ativo',
                        selectedItem: 'id'
                    }
                }, {
                    title: 'Último acesso',
                    field: 'usu_ultimoAcesso',
                    type: 'datetime',
                    moment: 'dddd - DD/MM/YYYY HH:mm:ss'
                }],
            };

            // Verificar se o usuário não é master
            if (!$rootScope.globals.currentUser.per_master) {
                // Se não for usuário master: não irá recuperar usuário master
                $scope.dgConfig.where = [{
                    field: 'per_master',
                    type: 'bit',
                    filterOperator: '<>',
                    filterValue: '1'
                }];
            }
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

        // Incializar título do formulário      
        $scope.formTitle = "Formulário de Adicionar";
        /**
         * Alterar título do formulário
         */
        $scope.setFormTitle = function() {
            if ($scope.formShow === 'default') {
                if ($scope.formAction === 'insert') {
                    $scope.formTitle = "Formulário de Adicionar";
                } else {
                    $scope.formTitle = "Formulário de Editar";
                }
            } else if ($scope.formShow === 'perfil') {
                $scope.formTitle = "Selecione um perfil";

            } else if ($scope.formShow === 'grupo') {
                $scope.formTitle = "Selecione um grupo";
            }

        }

        $scope.add = function(event) {
            $scope.formAction = "insert";
            $scope.disabledSenha = false;
            $scope.setFormTitle();
            formCtrl.$inject = ['$scope', '$mdDialog', 'pxArrayUtil', 'usuarioService'];
            $mdDialog.show({
                scope: $scope,
                preserveScope: true,
                controller: formCtrl,
                templateUrl: pxConfig.PX_PACKAGE + '/system/usuario/usuario-form.html',
                parent: angular.element(document.body),
                targetEvent: event,
                clickOutsideToClose: false
            });
        };

        $scope.edit = function(event) {
            $scope.formAction = "update";
            $scope.formItemEdit = event.itemEdit;
            $scope.setFormTitle();
            formCtrl.$inject = ['$scope', '$mdDialog', 'pxArrayUtil'];
            $mdDialog.show({
                scope: $scope,
                preserveScope: true,
                controller: formCtrl,
                templateUrl: pxConfig.PX_PACKAGE + '/system/usuario/usuario-form.html',
                parent: angular.element(document.body),
                targetEvent: event,
                clickOutsideToClose: false
            });
        };
    }
    // Controller - Formulário
    function formCtrl($scope, $mdDialog, pxArrayUtil, usuarioService) {
        /**
         * Controle do formulário
         * Note que a propriedade 'control' da directive px-form é igual a 'formControl'
         * Exemplo: <px-form px-control="formControl">
         * @type {Object}
         */
        $scope.formControl = {};

        // Controle do campo per_id_searchControl
        $scope.per_id_searchControl = {};
        // Controle do campo grupo_searchControl
        $scope.grupo_searchControl = {};

        // Clicar no botão busca per_id
        $scope.per_id_searchClick = function() {
            $scope.formShow = 'perfil';
            $scope.setFormTitle();
        };
        // Clicar no botão busca grupo
        $scope.grupo_searchClick = function() {
            $scope.formShow = 'grupo';
            $scope.setFormTitle();
        };

        /**
         * Inicializa formulário
         * @return {void}
         */
        $scope.formInit = function() {
            // Definir formulário default
            $scope.formShow = 'default';

            // Limpar formulário
            $scope.formClean();

            // Configurar formulário
            $scope.formConfig = {
                table: 'dbo.usuario',
                view: 'dbo.vw_usuario',
                fields: [{
                    pk: true,
                    field: 'usu_id',
                    type: 'int',
                    identity: true
                }, {
                    field: 'grupo_id',
                    fieldValueOptions: {
                        selectedItem: 'grupo_id'
                    },
                    type: 'int',
                    element: 'grupo_id',
                    insert: false,
                    update: false
                }, {
                    field: 'usu_ativo',
                    labelField: 'usu_ativo_label',
                    fieldValueOptions: {
                        selectedItem: 'id',
                        selectedLabel: 'name'
                    },
                    type: 'int',
                    element: 'usu_ativo',
                }, {
                    field: 'per_id',
                    fieldValueOptions: {
                        selectedItem: 'per_id'
                    },
                    type: 'int',
                    element: 'per_id'
                }, {
                    field: 'usu_login',
                    type: 'string',
                    element: 'usu_login'
                }, {
                    field: 'usu_senha',
                    type: 'string',
                    element: 'usu_senha',
                    hash: true
                }, {
                    field: 'usu_senha_confirmar',
                    type: 'string',
                    element: 'usu_senha_confirmar',
                    select: false,
                    insert: false,
                    update: false
                }, {
                    field: 'usu_nome',
                    type: 'string',
                    element: 'usu_nome'
                }, {
                    field: 'usu_email',
                    type: 'string',
                    element: 'usu_email'
                }, {
                    field: 'usu_cpf',
                    type: 'int',
                    element: 'usu_cpf'
                }, {
                    field: 'usu_senhaExpira',
                    type: 'int',
                    element: 'usu_senhaExpira'
                }, {
                    field: 'usu_mudarSenha',
                    type: 'bit',
                    element: 'usu_mudarSenha'
                }, {
                    field: 'usu_tentativasLogin',
                    type: 'int',
                    element: 'usu_tentativasLogin'
                }]
            }

            $scope.usu_ativo = $scope.dataStatus.arrayStatus;

            if ($scope.formAction == 'update') {
                $scope.formControl.select($scope.formItemEdit);
                var i = pxArrayUtil.getIndexByProperty($scope.formConfig.fields, 'field', 'usu_senha');
                $scope.formConfig.fields[i].update = false;
                $scope.disabledSenha = true;
            }
        };

        /**
         * Inserir registro
         * @return {[type]} [description]
         */
        $scope.formInsert = function() {
            $scope.formControl.insert();
        };

        /**
         * Inserir registro
         * @return {[type]} [description]
         */
        $scope.formUpdate = function() {
            $scope.formControl.update();
        };

        /**
         * Função callback do formulário
         * @param  {object} event retorno do formulário
         * @return {void}
         */
        $scope.formCallback = function(event) {
            if (event.action === 'select') {
                $scope.usu_senha = '***************'
                $scope.usu_senha_confirmar = '***************'
            } else if (event.action == 'insert' && !event.error) {
                // Adicionar registro na listagem
                $scope.gridControl.addDataRow(event.data);
                $mdDialog.hide();
            } else if (event.action == 'update' && !event.error) {
                // Atualiza registro na listagem
                $scope.gridControl.updateDataRow(event.data);
                $mdDialog.hide();
            } else {
                alert('Ops! Ocorreu um erro inesperado.\nPor favor contate o administrador do sistema!');
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

        //redefinirSenha
        $scope.redefinirSenha = function() {
            $scope.usu_senha = '';
            $scope.usu_senha_confirmar = '';
            var i = pxArrayUtil.getIndexByProperty($scope.formConfig.fields, 'field', 'usu_senha');
            $scope.formConfig.fields[i].update = true;
            $scope.disabledSenha = false;
        };

        // Controle da listagem no formulário per_id
        $scope.dgPerfilControl = {};

        // Controle da listagem no formulário grupo
        $scope.dgGrupoControl = {};

        /**
         * Inicializar listagem
         * @return {Void}
         */
        $scope.dgPerfilInit = function() {
            /**
             * Configurações da listagem
             * - fields: Colunas da listagem
             * @type {Object}
             */
            $scope.dgPerfilConfig = {
                table: 'dbo.perfil',
                view: 'dbo.vw_perfil',
                fields: [{
                    pk: true,
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
        };

        $scope.dgGrupoInit = function() {
            /**
             * Configurações da listagem
             * - fields: Colunas da listagem
             * @type {Object}
             */
            $scope.dgGrupoConfig = {
                table: 'dbo.grupo',
                fields: [{
                    pk: true,
                    title: 'Grupo',
                    field: 'grupo_id',
                    type: 'int',
                    identity: true
                }, {
                    title: 'Nome',
                    field: 'grupo_nome',
                    type: 'string',
                    filter: 'filtro_grupo_nome',
                    filterOperator: '%LIKE%'
                }]
            };
        };

        // Atualizar listagem do formulário per_id
        $scope.getDataPerfil = function() {
            //Recuperar dados para a listagem
            $scope.dgPerfilControl.getData();
        };

        // Atualizar listagem do formulário grupo
        $scope.getDataGrupo = function() {
            //Recuperar dados para a listagem
            $scope.dgGrupoControl.getData();
        };

        // Evento itemClick per_id
        $scope.dgPerfilItemClick = function(event) {
            console.info('dgPerfilItemClick', $scope.per_id_searchControl.getValue());
            $scope.formShow = 'default';
            $scope.per_id_searchControl.setValue(event.itemClick);
            $scope.setFormTitle();
        };

        // Evento itemClick grupo
        $scope.dgGrupoItemClick = function(event) {
            $scope.formShow = 'default';
            $scope.grupo_searchControl.setValue(event.itemClick);
            $scope.setFormTitle();
        };
    }
});