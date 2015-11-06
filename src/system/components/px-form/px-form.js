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

                // Chama evento px-init
                $timeout(scope.init, 0);
            },
            controller: pxFormCtrl
        };
    }]);

    pxFormCtrl.$inject = ['pxFormService', 'pxArrayUtil', '$scope', '$http', '$timeout'];

    function pxFormCtrl(pxFormService, pxArrayUtil, $scope, $http, $timeout) {
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

            angular.forEach(fields, function(index) {

                index.valueObject = {};

                if (angular.isDefined(index.element)) {

                    var selectorName = '#' + index.element;
                    var selectorValue = index.element;

                    // Verifica se o campo é um px-complete
                    if (angular.isDefined(angular.element($(selectorName + '_pxComplete').get(0)).scope())) {

                        selectorName += '_pxComplete';
                        selectorValue = 'selectedItem';
                    }

                    // Verifica seu o scope do elemento angular possui valor definido
                    if (angular.element($(selectorName).get(0)).scope().hasOwnProperty(selectorValue)) {

                        var fieldValue = angular.element($(selectorName).get(0)).scope()[selectorValue];

                        // Se filtro for undefined, o filtro será considerado inválido
                        if (!angular.isDefined(fieldValue)) {
                            return;
                        }

                        var tempField = index.field;
                        var tempValue = fieldValue;

                        // Se possuir configuração avançada (fieldValueOptions)
                        if (angular.isDefined(index.fieldValueOptions)) {
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
                        }

                        if (tempValue !== null && tempValue !== '') {
                            // Define o objeto de filtro do campo
                            // field é nome do campo que será filtro no banco de dados
                            // value é valor do campo, o qual será filtrado                        
                            index.valueObject = {
                                field: tempField,
                                value: tempValue
                            };
                        } else {
                            index.valueObject = {};
                        }
                    } else {
                        // Se não possuir um valor válido no ng-model o valor recebe vazio
                        index.valueObject = {};
                    }
                }
            });
            /*
            console.group('$scope.insert - var');
            console.info('table:', table);            
            console.info('fields:', fields);
            console.groupEnd();
            */
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
                var fields = objConfig.fields;
                if (!angular.isDefined(table)) {
                    table = $scope.table;
                }
                if (!angular.isDefined(fields)) {
                    fields = JSON.parse($scope.fields);
                }

                angular.forEach(fields, function(index) {
                    index.valueObject = {};
                    index.valueObject.value = data[index.field];
                });

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

                                // Verifica se o campo é um px-complete
                                if (angular.isDefined(angular.element($(selectorName + '_pxComplete').get(0)).scope())) {

                                    selectorName += '_pxComplete';
                                    selectorValue = 'selectedItem';
                                }
                                /*
                                var _ngModelCtrl = angular.element($(selectorName).data('$ngModelController'));

                                _ngModelCtrl.get(0).$parsers.push(function(value) {
                                    _ngModelCtrl.get(0).$setViewValue(response.qQuery[0][index.field]);
                                    return response.qQuery[0][index.field];
                                });
                                */
                                var _element = angular.element($(selectorName).get(0));

                                // Se possuir configuração avançada (fieldValueOptions)
                                if (angular.isDefined(index.fieldValueOptions)) {

                                    if (_element.scope().hasOwnProperty(selectorValue)) {
                                        _element.scope()[index.field] = _element.scope()[index.field][pxArrayUtil.getIndexByProperty(_element.scope()[index.field], index.fieldValueOptions.selectedItem, response.qQuery[0][index.field])]
                                    } else {
                                        console.error('pxForm:', 'Scope ' + selectorValue + ' sem valor inicial definido');
                                    }
                                } else {
                                    _element.scope()[index.field] = response.qQuery[0][index.field];
                                }
                            }
                        });
                    } else {
                        alert('Ops! Ocorreu um erro inesperado.\nPor favor contate o administrador do sistema!');
                    }
                });
            }, 0);
        }
    }
});