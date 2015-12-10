define(['../../services/module'], function(services) {
    'use strict';
    services.factory('pxUtil', pxUtil);
    pxUtil.$inject = ['pxConfig'];

    function pxUtil(pxConfig) {
        var service = {};
        service.filterOperator = filterOperator;
        service.setFilterObject = setFilterObject;
        service.getFieldValueObject = getFieldValueObject;
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
         * Definir filterObject de campos
         * @param {array}  array        campos que serão processados
         * @param {Boolean} isPxForm    são campos de um px-form?
         * @param {String} groupTable   tabela de grupo
         */
        function setFilterObject(array, isPxForm, groupTable) {
            // Loop na array
            angular.forEach(array, function(index) {
                if (index.filterGroup) {
                    index.field = index.field || getGroupConfig(groupTable).item;
                    index.type = 'int';
                    index.filterOperator = '=';
                    index.filterOptions = index.filterOptions || {
                        field: getGroupConfig(groupTable).item,
                        selectedItem: getGroupConfig().item
                    };
                }
                // Valor do filtro
                index.filterObject = {};
                // Verificar se operação é IN
                // Exemplo: SELECT * FROM MY_TABLE WHERE FIELD1 IN (1,2,3)
                if (index.filterOperator === 'IN') {
                    // Indicar que o valor do filtro é uma lista
                    index.filterList = true;
                } else {
                    // Indicar que o valor do filtro NÃO é uma lista
                    index.filterList = false;
                }
                // Verificar se possui campo de filtro
                // Caso possua campo de filtro será definido o 'filterObject'
                // filterObject armazena dados do filtro que será realizado no campo
                if (angular.isDefined(index.filter)) {
                    var selectorName = '#' + index.filter;
                    var selectorValue = index.filter;

                    // Verifica se o filtro group
                    if (index.filterGroup) {
                        selectorName += '_groupSearch_inputSearch';
                        selectorValue = 'selectedItem';
                    }
                    // Verificar se o filtro é um px-input-search
                    else if (angular.isDefined(angular.element($(selectorName + '_inputSearch').get(0)).scope())) {
                        selectorName += '_inputSearch';
                        selectorValue = 'selectedItem';
                    }
                    // Verifica seu o scope do elemento angular possui valor definido
                    if (angular.isDefined(angular.element($(selectorName).get(0)).scope()) && angular.element($(selectorName).get(0)).scope().hasOwnProperty(selectorValue)) {
                        // filtro                        
                        var filter = angular.element($(selectorName).get(0)).scope()[selectorValue];
                        // Se filtro for undefined, o filtro será considerado inválido
                        if (!angular.isDefined(filter)) {
                            return;
                        }

                        var tempField = index.field;
                        var tempValue = filter;

                        // Se possuir configuração avançada de fitro (filterOptions)
                        if (angular.isDefined(index.filterOptions)) {
                            tempField = index.filterOptions.field;
                            // value recebe o que foi configurado em index.filterOptions.selectedItem
                            // por exemplo se o filtro for um select, o ng-model pode ser um objeto {id: 1, name: 'teste'}
                            // neste caso é necessário definir qual chave do objeto representa o valor a ser filtrado
                            if (filter) {
                                tempValue = filter[index.filterOptions.selectedItem];
                                if (!angular.isDefined(tempValue)) {
                                    tempValue = filter[index.filterOptions.selectedItem.toUpperCase()];
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
                            index.filterObject = {
                                field: tempField,
                                value: tempValue
                            };
                        } else {
                            index.filterObject = {};
                        }
                    } else {
                        // Se não possuir um valor válido no ng-model o valor recebe vazio
                        index.filterObject = {};
                    }
                    // Armazenar valor do filtro que será enviado ao back-end
                    index.filterObject.value = filterOperator(index.filterObject.value, index.filterOperator);
                } else if (angular.isDefined(index.filterValue)) {
                    index.filterObject = {
                        field: index.field,
                        value: filterOperator(index.filterValue, index.filterOperator)
                    };
                }
            });
            return array;
        }
        /**
         * Retonar valor de uma estrutura de campo px-project
         * @param  {Object} object Estrutura do campo, por exemplo {element: txtName}
         * @return {String}        Valor da estrutura de campo px-project
         */
        function getFieldValueObject(object) {

            var selectorName = '#' + object.element;
            var selectorValue = document.getElementById(object.element).getAttribute('ng-model');

            if (angular.isDefined(angular.element($(selectorName + '_inputSearch').get(0)).scope())) {
                selectorName += '_inputSearch';
                selectorValue = 'selectedItem';
            }

            var element = angular.element($(selectorName).get(0));

            // Verificar seu o scope do elemento angular possui valor definido
            if (angular.isDefined(element.scope()) && element.scope().hasOwnProperty(selectorValue)) {
                var value = angular.element($(selectorName).get(0)).scope()[selectorValue];

                if (!angular.isDefined(value)) {
                    return {
                        value: null,
                        element: element
                    };
                }

                if (angular.isDefined(object.fieldValueOptions)) {
                    if (value) {
                        value = value[object.fieldValueOptions.selectedItem];
                        if (!angular.isDefined(value)) {
                            value = value[object.fieldValueOptions.selectedItem.toUpperCase()];
                        }
                        if (value === '%') {
                            return {
                                value: null,
                                element: element
                            };
                        }
                    } else {
                        return {
                            value: null,
                            element: element
                        };
                    }
                }
                return {
                    value: value,
                    element: element
                };
            } else {
                return {
                    value: null,
                    element: element
                };
            }
        }
        /**
         * Retornar configuração group
         * @return {Object} configuração group
         */
        function getGroupConfig(table) {
            var group = {};
            var table = table || pxConfig.GROUP_TABLE;
            if (pxConfig.GROUP_SUFFIX === '') {
                group.item = pxConfig.GROUP_ITEM;
                group.label = pxConfig.GROUP_LABEL;
            } else {
                group.item = table + '_' + pxConfig.GROUP_ITEM_SUFFIX;
                group.label = table + '_' + pxConfig.GROUP_LABEL_SUFFIX;
                for (var i = 0; i < pxConfig.GROUP_REPLACE.length; i++) {
                    group.item = group.item.replace(pxConfig.GROUP_REPLACE[i], '');
                    group.label = group.label.replace(pxConfig.GROUP_REPLACE[i], '');
                };
            }
            return group;
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