define(['../../directives/module'], function(directives) {
    'use strict';

    directives.directive('pxForm', ['$timeout', function($timeout) {
        return {
            restrict: 'E',
            replace: false,
            transclude: false,
            template: '<div></div>',
            scope: {
                debug: '=pxDebug',
                config: '@pxConfig',
                view: '@pxView',
                table: '@pxTable',
                fields: '@pxFields',
                init: '&pxInit',
                callback: '&pxCallback',
                control: '=pxControl'
            },
            link: function(scope, element, attrs) {

                scope.internalControl = scope.control || {};

                /**
                 * Inserir dados
                 */
                scope.internalControl.insert = function() {
                    scope.insertUpdate('insert');
                };

                /**
                 * Selecionar dados
                 */
                scope.internalControl.select = function(data) {
                    scope.select(data);
                };

                /**
                 * Atualizar dados
                 */
                scope.internalControl.update = function() {
                    scope.insertUpdate('update');
                };

                /**
                 * Limpar formulário
                 */
                scope.internalControl.clean = function() {
                    scope.clean();
                };

                // Chama evento px-init
                $timeout(scope.init, 0);
            },
            controller: pxFormCtrl
        };
    }]);

    pxFormCtrl.$inject = ['pxConfig', 'pxFormService', 'pxArrayUtil', '$scope', '$http', '$timeout', '$rootScope'];

    function pxFormCtrl(pxConfig, pxFormService, pxArrayUtil, $scope, $http, $timeout, $rootScope) {
        // Inserir dados        
        $scope.insertUpdate = function(action) {
            var objConfig = JSON.parse($scope.config);

            var table = objConfig.table;
            var fields = objConfig.fields;

            if (!angular.isDefined(table)) {
                table = $scope.table;
            }
            if (!angular.isDefined(fields)) {
                fields = JSON.parse($scope.fields);
            }

            // Configuração Group
            $scope.group = $scope.group || pxConfig.GROUP;
            if (angular.isDefined(objConfig.group)) {
                $scope.group = objConfig.group;
            }
            if (angular.isDefined(objConfig.groupItem)) {
                $scope.groupItem = objConfig.groupItem;
            }
            if (angular.isDefined(objConfig.groupLabel)) {
                $scope.groupLabel = objConfig.groupLabel;
            }

            $scope.table = table;

            if ($scope.group === true) {
                if (pxConfig.GROUP_SUFFIX === '') {
                    $scope.groupItem = $scope.groupItem || pxConfig.GROUP_ITEM;
                } else if (!angular.isDefined($scope.groupItem)) {
                    $scope.groupItem = $scope.groupItem || $scope.table + '_' + pxConfig.GROUP_ITEM_SUFFIX;
                    for (var i = 0; i < pxConfig.GROUP_REPLACE.length; i++) {
                        $scope.groupItem = $scope.groupItem.replace(pxConfig.GROUP_REPLACE[i], '');
                    };
                }
                if (pxConfig.GROUP_SUFFIX === '') {
                    $scope.groupLabel = $scope.groupLabel || pxConfig.GROUP_LABEL;
                } else if (!angular.isDefined($scope.groupLabel)) {
                    $scope.groupLabel = $scope.groupLabel || pxConfig.GROUP_TABLE + '_' + pxConfig.GROUP_LABEL_SUFFIX;
                    for (var i = 0; i < pxConfig.GROUP_REPLACE.length; i++) {
                        $scope.groupLabel = $scope.groupLabel.replace(pxConfig.GROUP_REPLACE[i], '');
                    };
                }
            }

            angular.forEach(fields, function(index) {
                index.valueObject = {};
                if (!angular.isDefined(index.insert) && index.identity !== true) {
                    index.insert = true;
                } else if (!angular.isDefined(index.insert)) {
                    index.insert = false;
                }

                if (!angular.isDefined(index.update) && index.identity !== true) {
                    index.update = true;
                } else if (!angular.isDefined(index.update)) {
                    index.update = false;
                }

                if (angular.isDefined(index.hash) && index.hash) {
                    if (!angular.isDefined(index.algorithm)) {
                        index.algorithm = 'SHA-512';
                    }
                }

                if (angular.isDefined(index.element)) {

                    var selectorName = '#' + index.element;
                    var selectorValue = index.element;

                    // Verifica se o campo é um px-complete
                    if (angular.isDefined(angular.element($(selectorName + '_inputSearch').get(0)).scope())) {
                        selectorName += '_inputSearch';
                        selectorValue = 'selectedItem';
                    }

                    var element = angular.element($(selectorName).get(0));

                    if (!angular.isDefined(element.context)) {
                        console.error('pxForm: elemento não encontrado no html, verifique a propriedade element', index);
                        //return;
                    }

                    // Verificar se é um checkbox
                    if (element.context.type === 'checkbox') {
                        if (!angular.isDefined(element.scope()[selectorValue]) || element.scope()[selectorValue] === '') {
                            element.scope()[selectorValue] = false;
                        }

                        // Se possuir configuração avançada (fieldValueOptions)
                        if (angular.isDefined(index.fieldValueOptions)) {
                            if (element.scope()[selectorValue] === true) {
                                element.scope()[selectorValue] = index.fieldValueOptions.checked;
                            } else {
                                element.scope()[selectorValue] = index.fieldValueOptions.unchecked;
                            }
                        }
                    }

                    // Verifica seu o scope do elemento angular possui valor definido
                    if (element.scope().hasOwnProperty(selectorValue)) {

                        var fieldValue = element.scope()[selectorValue];

                        // Se valor do campo for undefined, o filtro será considerado inválido
                        if (!angular.isDefined(fieldValue)) {                            
                            if ($rootScope.globals.currentUser.per_developer !== 1 && index.field === $scope.groupItem) {
                                console.info($rootScope.globals.currentUser)
                                if (pxConfig.GROUP_ITEM === '') {
                                    index.valueObject = {
                                        field: index.field,
                                        value: $rootScope.globals.currentUser[(pxConfig.GROUP_TABLE + '_' + pxConfig.GROUP_ITEM_SUFFIX).toLowerCase()]
                                    };
                                } else {
                                    index.valueObject = {
                                        field: index.field,
                                        value: $rootScope.globals.currentUser[pxConfig.GROUP_ITEM.toLowerCase()]
                                    };
                                }
                            }
                            return;
                        }

                        var tempField = index.field;
                        var tempValue = fieldValue;

                        // Se possuir configuração avançada (fieldValueOptions)
                        if (angular.isDefined(index.fieldValueOptions) && angular.element($(selectorName).get(0)).context.type !== 'checkbox') {

                            tempField = index.fieldValueOptions.field;
                            // value recebe o que foi configurado em index.fieldValueOptions.selectedItem
                            // por exemplo se o filtro for um select, o ng-model pode ser um objeto {id: 1, name: 'teste'}
                            // neste caso é necessário definir qual chave do objeto representa o valor a ser filtrado
                            if (fieldValue) {
                                tempValue = fieldValue[index.fieldValueOptions.selectedItem];
                                if (!angular.isDefined(tempValue)) {
                                    tempValue = fieldValue[index.fieldValueOptions.selectedItem.toUpperCase()];
                                }
                                if (tempValue === '%') {
                                    tempValue = null;
                                }
                            } else {
                                tempValue = null;
                            }
                            if (angular.isDefined(element.scope().labelField)) {
                                if (angular.isDefined(fieldValue[element.scope().labelField])) {
                                    index.labelField = {
                                        field: element.scope().labelField,
                                        value: fieldValue[element.scope().labelField]
                                    };
                                } else {
                                    index.labelField = {
                                        field: element.scope().labelField,
                                        value: fieldValue[element.scope().labelField.toUpperCase()]
                                    };
                                }
                            } else if (angular.isDefined(index.fieldValueOptions.selectedLabel)) {
                                index.labelField = {
                                    field: index.labelField,
                                    value: fieldValue[index.fieldValueOptions.selectedLabel]
                                };
                            }
                        }

                        if (tempValue !== null && tempValue !== '') {
                            // Define o objeto de filtro do campo
                            // field é nome do campo do banco de dados
                            // value é valor do campo                        
                            index.valueObject = {
                                field: tempField,
                                value: tempValue
                            };
                        } else {
                            index.valueObject = {};
                        }
                    } else {
                        console.info('index', index);
                        // Se não possuir um valor válido no ng-model o valor recebe vazio
                        index.valueObject = {};
                        index.insert = false;
                        index.update = false;
                    }
                }
                // Armazenar id do usuário
                else if (angular.isDefined(index.user) && index.user) {
                    index.type = 'int';
                    index.valueObject = {
                        field: index.field,
                        value: $rootScope.globals.currentUser.usu_id
                    };
                } else if (angular.isDefined(index.insertGetDate) && index.insertGetDate) {
                    if (action === 'insert') {
                        index.type = 'datetime';
                        index.valueObject = {
                            field: index.field,
                            value: '',
                            getDate: true
                        };
                    } else {
                        index.update = false;
                    }
                } else if (angular.isDefined(index.updateGetDate) && index.updateGetDate) {
                    index.type = 'datetime';
                    index.valueObject = {
                        field: index.field,
                        value: '',
                        getDate: true
                    };
                } else {
                    index.valueObject = {
                        field: index.field,
                        value: ''
                    };
                }
            });

            if ($scope.debug) {
                console.group('$scope.insertUpdate');
                console.info('action:', action);
                console.info('table:', table);
                console.info('fields (new):', fields);
                console.info('oldForm:', $scope.oldForm);
                console.groupEnd();
            }

            var oldForm = '';
            if (angular.isDefined($scope.oldForm)) {
                oldForm = angular.toJson($scope.oldForm)
            }

            pxFormService.insertUpdate(action, table, angular.toJson(fields), oldForm, function(response) {
                if ($scope.debug) {
                    console.info('pxFormService.insertUpdate response: ', response);
                }
                if (response.success) {
                    if ($scope.callback) {
                        // http://blog-it.hypoport.de/2013/11/06/passing-functions-to-angularjs-directives/
                        $scope.callback({
                            event: response
                        });
                    }
                    $scope.clean();
                } else {
                    alert('Ops! Ocorreu um erro inesperado.\nPor favor contate o administrador do sistema!');
                }
            });

        }

        // Selecionar      
        $scope.select = function(data) {
            $timeout(function() {
                var objConfig = JSON.parse($scope.config);

                var table = objConfig.table;
                var view = objConfig.view;
                var fields = objConfig.fields;
                if (!angular.isDefined(table)) {
                    table = $scope.table;
                }
                if (!angular.isDefined(view)) {
                    view = $scope.view;
                }
                if (!angular.isDefined(fields)) {
                    fields = JSON.parse($scope.fields);
                }

                angular.forEach(fields, function(index) {
                    index.valueObject = {};
                    index.valueObject.value = data[index.field];

                    if (!angular.isDefined(index.select)) {
                        index.select = true;
                    } else {
                        index.select = false;
                    }

                    if (angular.isDefined(angular.element($('#' + index.element + '_inputSearch').get(0)).scope())) {
                        if (angular.element($('#' + index.element + '_inputSearch').get(0)).scope().fields !== '') {
                            var fieldsSearch = angular.element($('#' + index.element + '_inputSearch').get(0)).scope().fields;

                            angular.forEach(fieldsSearch, function(j) {
                                if (j.labelField) {
                                    fields.push({
                                        field: j.field,
                                        select: true
                                    })
                                }
                            });
                        } else {
                            console.error('pxForm: componente px-input-search com propriedade fields inválida', index);
                        }
                    }

                });

                if ($scope.debug) {
                    console.group('$scope.select');
                    console.info('table:', table);
                    console.info('view:', view);
                    console.info('fields:', fields);
                    console.groupEnd();
                }
                if (angular.isDefined(view) && view !== '') {
                    table = view;
                }

                pxFormService.select(table, angular.toJson(fields), function(response) {
                    if ($scope.debug) {
                        console.info('pxFormService.select response: ', response);
                    }
                    if (response.success) {
                        // Armazenar dados recuperados
                        $scope.oldForm = response.qQuery[0];

                        angular.forEach(fields, function(index) {
                            if (angular.isDefined(index.element)) {
                                var selectorName = '#' + index.element;
                                var selectorValue = index.element;

                                var inputSearch = false;
                                // Verifica se o campo é um px-input-search
                                if (angular.isDefined(angular.element($(selectorName + '_inputSearch').get(0)).scope())) {
                                    selectorName += '_inputSearch';
                                    selectorValue = 'selectedItem';
                                    var inputSearch = true;
                                }
                                var _ngModelCtrl = angular.element($(selectorName).data('$ngModelController'));
                                var _element = angular.element($(selectorName).get(0));
                                var _value = String(response.qQuery[0][index.field]);
                                if (!angular.isDefined(response.qQuery[0][index.field])) {
                                    _value = String(response.qQuery[0][index.field.toUpperCase()]);
                                }

                                if (!angular.isDefined(_element.context)) {
                                    console.error('pxForm: elemento não encontrado no html, verifique a propriedade element', index);
                                    return;
                                } else if (_element.context.type === 'checkbox') {
                                    if (angular.isDefined(index.fieldValueOptions)) {
                                        if (index.fieldValueOptions.checked === _value) {
                                            _value = true;
                                        } else {
                                            _value = false;
                                        }
                                    } else if (_value === '1') {
                                        _value = true;
                                    } else {
                                        _value = false;
                                    }
                                }

                                if (angular.isDefined(index.fieldValueOptions) && _element.context.type !== 'checkbox') {
                                    if (_element.scope().hasOwnProperty(selectorValue)) {
                                        if (!inputSearch) {
                                            _element.scope()[index.field] = _element.scope()[index.field][pxArrayUtil.getIndexByProperty(_element.scope()[index.field], index.fieldValueOptions.selectedItem, _value)]
                                        } else {
                                            var searchValue = angular.copy(response.qQuery[0]);
                                            if (!angular.isDefined(index.fieldValueOptions.selectedItem)) {
                                                console.error('pxForm: selectedItem não definido em fieldValueOptions', index);
                                            }
                                            searchValue[index.fieldValueOptions.selectedItem] = _value;
                                            _element.scope().setValue(searchValue);

                                        }
                                    } else {
                                        console.error('pxForm:', 'Scope ' + selectorValue + ' sem valor inicial definido');
                                    }
                                } else {
                                    _element.scope().pxForm = true;
                                    if (angular.isDefined(_element.scope().pxForm2mask)) {

                                        //_ngModelCtrl.cleanValue = _value;
                                        _element.scope().cleanValue = _value;
                                        _element.scope().pxForm2mask(_value);

                                    }
                                    _element.scope()[index.field] = _value;

                                    $timeout(function() {
                                        _element.trigger('keyup');
                                    }, 0);

                                }
                            }
                        });

                        if ($scope.callback) {
                            response.action = 'select';
                            $scope.callback({
                                event: response
                            });
                        }
                    } else {
                        alert('Ops! Ocorreu um erro inesperado.\nPor favor contate o administrador do sistema!');
                    }
                });
            }, 0);
        }

        // Limpar formulário      
        $scope.clean = function() {

            if (!angular.isDefined($scope.config) || $scope.config === '') {
                return;
            }

            var objConfig = JSON.parse($scope.config);

            var table = objConfig.table;
            var fields = objConfig.fields;
            if (!angular.isDefined(table)) {
                table = $scope.table;
            }
            if (!angular.isDefined(fields)) {
                fields = JSON.parse($scope.fields);
            }

            angular.forEach(fields, function(index) {
                index.valueObject = {};
                if (angular.isDefined(index.element)) {
                    var selectorName = '#' + index.element;
                    var selectorValue = index.element;

                    // Verifica se o campo é um px-complete
                    if (angular.isDefined(angular.element($(selectorName + '_inputSearch').get(0)).scope())) {

                        selectorName += '_inputSearch';
                        selectorValue = 'selectedItem';
                    }

                    var _ngModelCtrl = angular.element($(selectorName).data('$ngModelController'));

                    var _element = angular.element($(selectorName).get(0));

                    var _value = '';

                    if (angular.isDefined(index.fieldValueOptions)) {
                        if (_element.scope().hasOwnProperty(selectorValue)) {
                            _element.scope()[index.field] = _value;
                        }
                    } else {
                        /*
                        if (angular.isDefined(_element.scope().pxForm2mask)) {
                            _element.scope().cleanValue = _value;
                            _element.scope().pxForm2mask(_value);
                        } 
                        */
                        _element.scope()[index.field] = _value;
                    }
                }
            });
        }
    }
});