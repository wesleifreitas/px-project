(function () {
    'use strict';

    angular.module('pxFormItem', [])
        .value('pxFormItemConfig', {})
        // pxEnter
        // Evento [ENTER]
        .directive('pxEnter', ['pxViewHeaderConfig', function (pxViewHeaderConfig) {
            return function (scope, element, attrs) {
                element.bind('keydown keypress', function (event) {
                    if (event.which === 13) {
                        scope.$apply(function () {
                            scope.$eval(attrs.pxEnter);
                        });
                        event.preventDefault();
                    }
                });
            };
        }])
        // pxValidNumber
        // Digitar somente números
        .directive('pxValidNumber', ['pxViewHeaderConfig', function (pxViewHeaderConfig) {
            return {
                require: '?ngModel',
                link: function (scope, element, attrs, ngModelCtrl) {

                    if (!ngModelCtrl) {
                        return;
                    }

                    ngModelCtrl.$parsers.push(function (value) {
                        var clean = value.replace(/[^0-9]+/g, '');
                        if (value !== clean) {
                            ngModelCtrl.$setViewValue(clean);
                            ngModelCtrl.$render();
                        }
                        return clean;
                    });

                    element.bind('keypress', function (event) {
                        if (event.keyCode === 32) {
                            event.preventDefault();
                        }
                    });
                }
            };
        }])
        // pxBrCnpjMask
        // 99.999.999/9999-99
        .directive('pxBrCnpjMask', ['pxViewHeaderConfig', '$compile', function (pxViewHeaderConfig, $compile) {
            return {
                priority: 100,
                restrict: 'A',
                scope: {
                    cleanValue: '@cleanValue'
                },
                require: '?ngModel',
                link: function (scope, element, attrs, ngModelCtrl) {

                    if (!ngModelCtrl) {
                        return;
                    }

                    // Verifica se NÃO possui uiMask definido
                    if (!angular.isDefined(attrs.uiMask)) {
                        // Define uiMask
                        attrs.$set('uiMask', '99.999.999/9999-99');
                        $compile(element)(scope);
                    }

                    ngModelCtrl.$parsers.push(function (value) {
                        var clean = value.replace(/[^0-9]+/g, '');
                        if (value !== clean) {
                            // Atualizar campo com o valor digitado
                            ngModelCtrl.$setViewValue(clean);
                            //ngModelCtrl.$render();
                        }
                        return clean;
                    });
                }
            };
        }])
        // pxBrCpfMask
        // 999.999.999-99
        .directive('pxBrCpfMask', ['pxViewHeaderConfig', '$compile', function (pxViewHeaderConfig, $compile) {
            return {
                priority: 100,
                restrict: 'A',
                scope: {
                    cleanValue: '@cleanValue'
                },
                require: '?ngModel',
                link: function (scope, element, attrs, ngModelCtrl) {

                    if (!ngModelCtrl) {
                        return;
                    }

                    // Verifica se NÃO possui uiMask definido
                    if (!angular.isDefined(attrs.uiMask)) {
                        // Define uiMask
                        attrs.$set('uiMask', '999.999.999-99');
                        $compile(element)(scope);
                    }

                    ngModelCtrl.$parsers.push(function (value) {
                        var clean = value.replace(/[^0-9]+/g, '');
                        if (value !== clean) {
                            // Atualizar campo com o valor digitado
                            ngModelCtrl.$setViewValue(clean);
                            //ngModelCtrl.$render();
                        }
                        return clean;
                    });
                }
            };
        }])
        // pxBrPhoneMask
        // (99) 9999-9999 / (99) 9999-9999?9
        // (99) 99999-999
        .directive('pxBrPhoneMask', ['pxViewHeaderConfig', '$compile', function (pxViewHeaderConfig, $compile) {
            return {
                priority: 100,
                restrict: 'A',
                scope: {
                    cleanValue: '@cleanValue',
                    validPhone8: '@validPhone8',
                    validPhone9: '@validPhone9'
                },
                bindToController: false,
                require: '?ngModel',
                link: function (scope, element, attrs, ngModelCtrl) {

                    if (!ngModelCtrl) {
                        return;
                    }

                    // Verifica se NÃO possui uiMask definido
                    if (!angular.isDefined(attrs.uiMask)) {
                        // Define uiMask
                        attrs.$set('uiMask', '(99) 9999-9999?9');
                        $compile(element)(scope);
                    }

                    // Evento focusout
                    element.bind('focusout', function (event) {
                        if (scope.cleanValue.length < 11 || !angular.isDefined(scope.validPhone8)) {
                            // Atualizar uiMask para telefone com 8 dígitos
                            attrs.$set('uiMask', '(99) 9999-9999');
                            // Atualizar campo com o valor digitado e váriaveis de controle
                            ngModelCtrl.$setViewValue(scope.cleanValue);
                            //ngModelCtrl.$render();
                            scope.validPhone9 = false;
                            scope.validPhone8 = true;
                        }
                    });

                    // Evento focusin
                    element.bind('focusin', function (event) {
                        if (!angular.isDefined(scope.cleanValue)) {
                            scope.cleanValue = '';
                        }

                        // Verifica se o telefone digitado possui menos que 11 dígitos
                        if (scope.cleanValue.length < 11) {
                            // Atualizar uiMask para telefone com 8 dígitos, deixando um digitado a mais como opcional
                            attrs.$set('uiMask', '(99) 9999-9999?9');
                            // Atualizar campo com o valor digitado e váriaveis de controle
                            ngModelCtrl.$setViewValue(scope.cleanValue);
                            //ngModelCtrl.$render();
                            scope.validPhone9 = false;
                            scope.validPhone8 = false;
                        }
                    });

                    element.bind('keyup', function (event) {
                        // Se possuir 11 dígitos e não estiver validado
                        // Telefone com 11 dígitos é um telefone com 9 dígitos mais dois dígitos do DDD
                        if (scope.cleanValue.length === 11 && scope.validPhone9 === false || !angular.isDefined(scope.validPhone9)) {

                            // Atualizar uiMask para telefone com 9 dígitos
                            attrs.$set('uiMask', '(99) ?99999-9999');
                            // Atualizar campo com o valor digitado e váriaveis de controle
                            ngModelCtrl.$setViewValue(scope.cleanValue);
                            //ngModelCtrl.$render();
                            scope.validPhone9 = true;
                            scope.validPhone8 = false;

                        } else if (scope.cleanValue.length === 10 && scope.validPhone8 === false || !angular.isDefined(scope.validPhone8)) {

                            // Atualizar uiMask para telefone com 8 dígitos
                            attrs.$set('uiMask', '(99) 9999-9999?9');
                            // Atualizar campo com o valor digitado e váriaveis de controle
                            ngModelCtrl.$setViewValue(scope.cleanValue);
                            //ngModelCtrl.$render();
                            scope.validPhone9 = false;
                            scope.validPhone8 = true;
                        }
                    });

                    ngModelCtrl.$parsers.push(function (value) {
                        var clean = value.replace(/[^0-9]+/g, '');
                        scope.cleanValue = clean;
                        if (value !== clean) {
                            // Atualizar campo com o valor digitado
                            ngModelCtrl.$setViewValue(clean);
                            //ngModelCtrl.$render();
                        }
                        return clean;
                    });
                }
            };
        }])
        // pxNumberMask
        .directive('pxNumberMask', ['pxViewHeaderConfig', '$filter', '$locale', function (pxViewHeaderConfig, $filter, $locale) {
            return {
                restrict: 'A',
                scope: {
                    cleanValue: '@cleanValue'
                },
                require: '?ngModel',
                link: function (scope, element, attrs, ngModelCtrl) {

                    //console.info('$locale', $locale);

                    if (!ngModelCtrl) {
                        return;
                    }

                    if (!angular.isDefined(attrs.pxEnableNumbers)) {
                        attrs.$set('pxEnableNumbers', /[0-9]/);
                    }

                    if (!angular.isDefined(attrs.pxCurrency)) {
                        attrs.$set('pxCurrency', false);
                    }

                    if (!angular.isDefined(attrs.pxCurrencySymbol)) {
                        attrs.$set('pxCurrencySymbol', '');
                    }

                    if (!angular.isDefined(attrs.pxNumberSuffix)) {
                        attrs.$set('pxNumberSuffix', '');
                    }

                    if (!angular.isDefined(attrs.pxDecimalSeparator)) {
                        attrs.$set('pxDecimalSeparator', $locale.NUMBER_FORMATS.DECIMAL_SEP);
                    }

                    if (!angular.isDefined(attrs.pxThousandsSeparator)) {
                        attrs.$set('pxThousandsSeparator', $locale.NUMBER_FORMATS.GROUP_SEP);
                    }

                    if (!angular.isDefined(attrs.pxNumberPrecision)) {
                        attrs.$set('pxNumberPrecision', 2);
                    }

                    if (!angular.isDefined(attrs.pxUseNegative)) {
                        attrs.$set('pxUseNegative', false);
                    }

                    if (!angular.isDefined(attrs.pxUsePositive)) {
                        attrs.$set('pxUsePositive', false);
                    }

                    if (attrs.pxUsePositive) {
                        attrs.$set('pxUseNegative', false);
                    }

                    if (attrs.pxCurrency && attrs.pxCurrencySymbol === '') {
                        attrs.$set('pxCurrencySymbol', $locale.NUMBER_FORMATS.CURRENCY_SYM);
                    }

                    var limit = false;

                    var emptyValue = true;

                    ngModelCtrl.$parsers.push(function (value) {

                        var clean = '';
                        if (value !== '0' && (value !== '' || emptyValue === false)) {
                            clean = numberFormatter(value);
                        } else if (value.trim() === '0' && emptyValue === true) {
                            return 0;
                        } else {
                            emptyValue = true;
                            return '';
                        }
                        if (value !== clean) {
                            ngModelCtrl.$setViewValue(clean);
                            ngModelCtrl.$render();
                        }

                        if (isNaN(numeral().unformat(clean))) {
                            return 0;
                        } else {
                            return numeral().unformat(clean);
                        }
                    });

                    function toNumber(str) {
                        var formatted = '';
                        for (var i = 0; i < (str.length); i++) {
                            var char_ = str.charAt(i);
                            if (formatted.length === 0 && char_ === '0') {
                                char_ = false;
                            }
                            if (char_ && char_.match(attrs.pxEnableNumbers)) {
                                if (limit) {
                                    if (formatted.length < limit) {
                                        formatted = formatted + char_;
                                    }
                                } else {
                                    formatted = formatted + char_;
                                }
                            }
                        }
                        return formatted;
                    }

                    function fillWithZero(str) {
                        if (str === '') {
                            return str;
                        }

                        while (str.length < (attrs.pxNumberPrecision + 1)) {
                            str = '0' + str;
                        }
                        return str;
                    }

                    function numberFormatter(str) {

                        if (str === '') {
                            emptyValue = true;
                            return str;
                        } else if (str === (attrs.pxCurrencySymbol + $locale.NUMBER_FORMATS.DECIMAL_SEP)) {
                            return '0';
                        }

                        //emptyValue = false;


                        var formatted = fillWithZero(toNumber(str));
                        var thousandsFormatted = '';
                        var thousandsCount = 0;
                        if (attrs.pxNumberPrecision === 0) {
                            attrs.pxDecimalSeparator = '';
                            centsVal = '';
                        }
                        var centsVal = formatted.substr(formatted.length - attrs.pxNumberPrecision, attrs.pxNumberPrecision);
                        var integerVal = formatted.substr(0, formatted.length - attrs.pxNumberPrecision);
                        formatted = (attrs.pxNumberPrecision === 0) ? integerVal : integerVal + attrs.pxDecimalSeparator + centsVal;
                        if (attrs.pxThousandsSeparator || $.trim(attrs.pxThousandsSeparator) !== '') {
                            for (var j = integerVal.length; j > 0; j--) {
                                var char_ = integerVal.substr(j - 1, 1);
                                thousandsCount++;
                                if (thousandsCount % 3 === 0) {
                                    char_ = attrs.pxThousandsSeparator + char_;
                                }
                                thousandsFormatted = char_ + thousandsFormatted;
                            }
                            if (thousandsFormatted.substr(0, 1) === attrs.pxThousandsSeparator) {
                                thousandsFormatted = thousandsFormatted.substring(1, thousandsFormatted.length);
                            }
                            formatted = (attrs.pxNumberPrecision === 0) ? thousandsFormatted : thousandsFormatted + attrs.pxDecimalSeparator + centsVal;
                        }
                        if (attrs.pxUseNegative && (integerVal !== 0 || centsVal !== 0)) {
                            if (str.indexOf('-') !== -1 && str.indexOf('+') < str.indexOf('-')) {
                                formatted = '-' + formatted;
                            } else {
                                if (!attrs.pxUsePositive) {
                                    formatted = '' + formatted;
                                } else {
                                    formatted = '+' + formatted;
                                }
                            }
                        }
                        if (attrs.pxCurrencySymbol) {
                            formatted = attrs.pxCurrencySymbol + formatted;
                        }
                        if (attrs.pxNumberSuffix) {
                            formatted = formatted + attrs.pxNumberSuffix;
                        }
                        return formatted;
                    }
                }
            };
        }])
        // pxComplete
        .directive('pxComplete', function (pxConfig, pxUtil, $parse, $http, $sce, $timeout) {
            return {
                restrict: 'EA',
                scope: {
                    id: '@id',
                    placeholder: '@placeholder',
                    table: '@pxTable',
                    fields: '@pxFields',
                    orderBy: '@pxOrderBy',
                    recordCount: '@pxRecordCount',
                    selectedItem: '=pxSelectedItem',
                    url: '@pxUrl',
                    responseQuery: '@pxResponseQuery',
                    localQuery: '@pxLocalQuery',
                    inputClass: '@pxInputClass',
                    searchFields: '@searchfields'
                },
                require: '?ngModel',
                templateUrl: pxConfig.PX_PACKAGE + 'system/components/px-form-item/px-complete.html',

                link: function (scope, element, attrs, ngModelCtrl) {

                    if (!ngModelCtrl) {
                        return;
                    }

                    scope.lastSearchTerm = null;
                    scope.currentIndex = null;
                    scope.justChanged = false;
                    scope.searchTimer = null;
                    scope.hideTimer = null;
                    scope.searching = false;
                    scope.pause = 400;
                    scope.minLength = 3;
                    scope.searchStr = null;

                    var isNewSearchNeeded = function (newTerm, oldTerm) {
                        return newTerm.length >= scope.minLength && newTerm !== oldTerm;
                    };

                    scope.processResults = function (response, str, arrayFields) {
                        if (response && response.length > 0) {

                            scope.results = [];

                            for (var i = 0; i < response.length; i++) {

                                var textValue = '';
                                var description = '';

                                for (var j = 0; j < arrayFields.length; j++) {

                                    var tempValue = '';

                                    if (arrayFields[j].labelField) {

                                        tempValue = response[i][arrayFields[j].field];

                                        if (!angular.isDefined(tempValue)) {
                                            tempValue = response[i][arrayFields[j].field.toUpperCase()];
                                        }

                                        textValue += arrayFields[j].title + tempValue + ' ';
                                    }

                                    if (arrayFields[j].descriptionField) {

                                        tempValue = response[i][arrayFields[j].field];

                                        if (!angular.isDefined(tempValue)) {
                                            tempValue = response[i][arrayFields[j].field.toUpperCase()];
                                        }

                                        description += arrayFields[j].title + tempValue + ' ';
                                    }
                                }

                                var resultRow = {
                                    title: textValue,
                                    description: description,
                                    item: response[i]
                                };
                                scope.results[scope.results.length] = resultRow;
                            }
                        } else {
                            scope.results = [];
                        }
                    };

                    scope.searchTimerComplete = function (str) {
                        // Início da pesquisa

                        var arrayFields = JSON.parse(scope.fields);

                        if (str.length >= scope.minLength) {
                            if (scope.localQuery) {

                                console.warn('px-complete', 'função localQuery não implementada!');

                                scope.searching = false;
                                scope.processResults(JSON.parse(scope.localQuery), str);

                            } else {

                                // Loop na configuração de campos
                                angular.forEach(arrayFields, function (index) {
                                    if (index.search) {
                                        // Valor do filtro
                                        index.filterObject = {};

                                        index.filterObject = {
                                            field: index.field,
                                            value: pxUtil.filterOperator(str, index.filterOperator)
                                        };
                                    }
                                });

                                var params = {};
                                params.table = scope.table;
                                params.fields = angular.toJson(arrayFields);
                                params.orderBy = scope.orderBy;

                                if (!angular.isDefined(scope.recordCount) || scope.recordCount === '') {
                                    scope.recordCount = 4;
                                }

                                params.rows = scope.recordCount;

                                if (!angular.isDefined(scope.url) || scope.url === '') {
                                    scope.url = pxConfig.PX_PACKAGE + 'system/components/px-form-item/px-form-item.cfc?method=getData';
                                }

                                $http({
                                    method: 'POST',
                                    url: scope.url,
                                    dataType: 'json',
                                    params: params
                                }).success(function (response, status, headers, config) {
                                    console.info('response', response);
                                    if (!angular.isDefined(scope.responseQuery) || scope.responseQuery === '') {
                                        scope.responseQuery = 'qQuery';
                                    }

                                    scope.searching = false;
                                    scope.processResults(((scope.responseQuery) ? response[scope.responseQuery] : response), str, arrayFields);

                                }).
                                error(function (data, status, headers, config) {
                                    // Erro
                                    alert('Ops! Ocorreu um erro inesperado.\nPor favor contate o administrador do sistema!');
                                });
                            }
                        }
                    };

                    scope.hideResults = function () {
                        scope.hideTimer = $timeout(function () {
                            scope.showDropdown = false;
                        }, scope.pause);
                    };

                    scope.resetHideResults = function () {
                        if (scope.hideTimer) {
                            $timeout.cancel(scope.hideTimer);
                        }
                    };

                    scope.hoverRow = function (index) {
                        scope.currentIndex = index;
                    };

                    scope.keyPressed = function (event) {
                        if (!(event.which === 38 || event.which === 40 || event.which === 13)) {
                            if (!scope.searchStr || scope.searchStr === '') {
                                scope.showDropdown = false;
                                scope.lastSearchTerm = null;
                            } else if (isNewSearchNeeded(scope.searchStr, scope.lastSearchTerm)) {
                                scope.lastSearchTerm = scope.searchStr;
                                scope.showDropdown = true;
                                scope.currentIndex = -1;
                                scope.results = [];

                                if (scope.searchTimer) {
                                    $timeout.cancel(scope.searchTimer);
                                }

                                scope.searching = true;

                                scope.searchTimer = $timeout(function () {
                                    scope.searchTimerComplete(scope.searchStr);
                                }, scope.pause);
                            }
                        } else {
                            event.preventDefault();
                        }
                    };

                    scope.selectResult = function (result) {

                        scope.searchStr = scope.lastSearchTerm = result.title;
                        scope.selectedItem = result.item;
                        scope.showDropdown = false;
                        scope.results = [];
                        //scope.$apply();
                    };

                    var inputField = element.find('input');

                    inputField.on('keyup', scope.keyPressed);

                    element.on('keyup', function (event) {
                        if (event.which === 40) {
                            if (scope.results && (scope.currentIndex + 1) < scope.results.length) {
                                scope.currentIndex++;
                                scope.$apply();
                                event.preventDefault();
                                event.stopPropagation();
                            }

                            scope.$apply();
                        } else if (event.which === 38) {
                            if (scope.currentIndex >= 1) {
                                scope.currentIndex--;
                                scope.$apply();
                                event.preventDefault();
                                event.stopPropagation();
                            }

                        } else if (event.which === 13) {
                            if (scope.results && scope.currentIndex >= 0 && scope.currentIndex < scope.results.length) {
                                scope.selectResult(scope.results[scope.currentIndex]);
                                scope.$apply();
                                event.preventDefault();
                                event.stopPropagation();
                            } else {
                                scope.results = [];
                                scope.$apply();
                                event.preventDefault();
                                event.stopPropagation();
                            }

                        } else if (event.which === 27) {
                            scope.results = [];
                            scope.showDropdown = false;
                            scope.$apply();
                        } else if (event.which === 8) {
                            scope.selectedItem = null;
                            scope.$apply();
                        }
                    });

                }
            };
        });
})();
