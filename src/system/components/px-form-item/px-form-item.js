define(['../../directives/module'], function(directives) {
    'use strict';

    directives.directive('pxEnter', [function() {
            return function(scope, element, attrs) {
                element.bind('keydown keypress', function(event) {
                    if (event.which === 13) {
                        scope.$apply(function() {
                            scope.$eval(attrs.pxEnter);
                        });
                        event.preventDefault();
                    }
                });
            };
        }])
        // showErrorsConfig
        // https://github.com/paulyoder/angular-bootstrap-show-errors
        .provider('showErrorsConfig', function() {
            var _showSuccess, _trigger;
            _showSuccess = false;
            _trigger = 'blur';
            this.showSuccess = function(showSuccess) {
                return _showSuccess = showSuccess;
            };
            this.trigger = function(trigger) {
                return _trigger = trigger;
            };
            this.$get = function() {
                return {
                    showSuccess: _showSuccess,
                    trigger: _trigger
                };
            };
        })
        // showErrors: https://github.com/paulyoder/angular-bootstrap-show-errors
        // https://github.com/paulyoder/angular-bootstrap-show-errors
        .directive('showErrors', [
            '$timeout', 'showErrorsConfig', '$interpolate',
            function($timeout, showErrorsConfig, $interpolate) {
                var getShowSuccess, getTrigger, linkFn;
                getTrigger = function(options) {
                    var trigger;
                    trigger = showErrorsConfig.trigger;
                    if (options && (options.trigger != null)) {
                        trigger = options.trigger;
                    }
                    return trigger;
                };
                getShowSuccess = function(options) {
                    var showSuccess;
                    showSuccess = showErrorsConfig.showSuccess;
                    if (options && (options.showSuccess != null)) {
                        showSuccess = options.showSuccess;
                    }
                    return showSuccess;
                };
                linkFn = function(scope, el, attrs, formCtrl) {
                    var blurred, inputEl, inputName, inputNgEl, options, showSuccess, toggleClasses, trigger;
                    blurred = false;
                    options = scope.$eval(attrs.showErrors);
                    showSuccess = getShowSuccess(options);
                    trigger = getTrigger(options);
                    inputEl = el[0].querySelector('.form-control[name]');
                    inputNgEl = angular.element(inputEl);
                    inputName = $interpolate(inputNgEl.attr('name') || '')(scope);
                    if (!inputName) {
                        throw "show-errors element has no child input elements with a 'name' attribute and a 'form-control' class";
                    }
                    inputNgEl.bind(trigger, function() {
                        blurred = true;
                        return toggleClasses(formCtrl[inputName].$invalid);
                    });
                    scope.$watch(function() {
                        return formCtrl[inputName] && formCtrl[inputName].$invalid;
                    }, function(invalid) {
                        if (!blurred) {
                            return;
                        }
                        console.info('invalid', invalid);
                        return toggleClasses(invalid);
                    });
                    scope.$on('show-errors-check-validity', function() {
                        return toggleClasses(formCtrl[inputName].$invalid);
                    });
                    scope.$on('show-errors-reset', function() {
                        return $timeout(function() {
                            el.removeClass('has-error');
                            el.removeClass('has-success');
                            return blurred = false;
                        }, 0, false);
                    });
                    return toggleClasses = function(invalid) {
                        el.toggleClass('has-error', invalid);
                        if (showSuccess) {
                            return el.toggleClass('has-success', !invalid);
                        }
                    };
                };
                return {
                    restrict: 'A',
                    require: '^form',
                    compile: function(elem, attrs) {
                        if (attrs['showErrors'].indexOf('skipFormGroupCheck') === -1) {
                            if (!(elem.hasClass('form-group') || elem.hasClass('input-group'))) {
                                throw "show-errors element does not have the 'form-group' or 'input-group' class";
                            }
                        }
                        return linkFn;
                    }
                };
            }
        ])
        // Validar campos
        // http://stackoverflow.com/questions/18063561/access-isolated-parent-scope-from-a-transcluded-directive
        // http://stackoverflow.com/questions/21488803/how-does-one-preserve-scope-with-nested-directives
        // https://groups.google.com/forum/#!topic/angular/BZqs4TXyOcw 
        .directive('pxShowError', ['$timeout', '$rootScope', function($timeout, $rootScope) {
            return {
                restrict: 'E',
                require: '^form',
                replace: true,
                transclude: false,
                template: '<p class="help-block px-show-error">{{error}}</p>',
                scope: {
                    element: '@pxElement',
                    confirm: '@pxConfirm',
                    confirmError: '@pxConfirmError',
                    minLengthError: '@pxMinlengthError'
                },
                link: function(scope, element, attrs, formCtrl) {
                    // Chama evento px-init
                    $timeout(scope.init, 0);
                },
                controller: ['$scope', function($scope) {
                    // Inicializar validação
                    $scope.init = function() {

                        // Armazena mensagem de erro de validação                        
                        $scope.error = '';
                        // Elemento que será validado
                        var _element = angular.element($('#' + $scope.element).get(0));
                        // ngModelController do elemento
                        var _ngModelCtrl = _element.data('$ngModelController');

                        var _confirm = angular.element($('#' + $scope.confirm).get(0));
                        var _confirmModelCtrl = _confirm.data('$ngModelController');

                        // Evento keyup
                        _element.on('keyup', function(event) {
                            // Verificar se possui campo de confirmação
                            if (angular.isDefined($scope.confirm)) {
                                if (String(_confirmModelCtrl.$modelValue) !== String(_ngModelCtrl.$modelValue)) {
                                    //_ngModelCtrl.$error.confirm = true;
                                    _ngModelCtrl.$setValidity('confirm', false);
                                } else {
                                    //_ngModelCtrl.$error.confirm = null;
                                    _ngModelCtrl.$setValidity('confirm', true);
                                }
                            }
                            // Verificar ser o elemento está inválido                          
                            if (_ngModelCtrl.$invalid) {
                                $scope.$apply(function() {
                                    if (_ngModelCtrl.$error.required || _ngModelCtrl.$error.requiredsearch) {
                                        $scope.error = 'Campo obrigatório';
                                    } else if (_ngModelCtrl.$error.email) {
                                        $scope.error = 'E-mail inválido';
                                    } else if (_ngModelCtrl.$error.minlength) {
                                        $scope.error = $scope.minLengthError;
                                    } else if (_ngModelCtrl.$error.confirm) {
                                        if (!angular.isDefined($scope.confirmError)) {
                                            $scope.error = 'Campo não confere';
                                        } else {
                                            $scope.error = $scope.confirmError;
                                        }
                                    } else {
                                        console.warn('px-show-error:', '$error ausente', _ngModelCtrl.$error);
                                    }
                                });

                                _element.css({
                                    borderColor: '#A94442' //'#DF0707'
                                });
                            } else {
                                $scope.$apply(function() {
                                    $scope.error = '';
                                });

                                _element.css({
                                    borderColor: '#CCCCCC'
                                });
                            }
                        });
                    }
                }]
            };
        }])
        // pxValidNumber
        // Digitar somente números
        .directive('pxValidNumber', [function() {
            return {
                require: '?ngModel',
                link: function(scope, element, attrs, ngModelCtrl) {

                    if (!ngModelCtrl) {
                        return;
                    }

                    ngModelCtrl.$parsers.push(function(value) {
                        var clean = value.replace(/[^0-9]+/g, '');
                        if (value !== clean) {
                            ngModelCtrl.$setViewValue(clean);
                            ngModelCtrl.$render();
                        }
                        return clean;
                    });

                    element.bind('keypress', function(event) {
                        if (event.keyCode === 32) {
                            event.preventDefault();
                        }
                    });
                }
            };
        }])
        // pxBrCnpjMask
        // 99.999.999/9999-99
        .directive('pxBrCnpjMask', ['$compile', function($compile) {
            return {
                priority: 100,
                restrict: 'A',
                scope: {
                    cleanValue: '@cleanValue'
                },
                require: '?ngModel',
                link: function(scope, element, attrs, ngModelCtrl) {

                    if (!ngModelCtrl) {
                        return;
                    }

                    // Verifica se NÃO possui uiMask definido
                    if (!angular.isDefined(attrs.uiMask)) {
                        // Define uiMask
                        attrs.$set('uiMask', '99.999.999/9999-99');
                        $compile(element)(scope);
                    }

                    ngModelCtrl.$parsers.push(function(value) {
                        if (angular.isDefined(value)) {
                            var clean = String(value).replace(/[^0-9]+/g, '');
                            if (value !== clean) {
                                // Atualizar campo com o valor digitado
                                ngModelCtrl.$setViewValue(clean);
                                //ngModelCtrl.$render();
                            }
                            return clean;
                        }
                    });

                    scope.value2mask = function(value) {
                        ngModelCtrl.$setViewValue(value);
                    }

                },
                controller: ['$scope', function($scope) {

                    $scope.pxForm2mask = function(value) {
                        $scope.value2mask(value);
                    }
                }]
            };
        }])
        // pxBrCpfMask
        // 999.999.999-99
        .directive('pxBrCpfMask', ['$compile', function($compile) {
            return {
                priority: 100,
                restrict: 'A',
                scope: {
                    cleanValue: '@cleanValue'
                },
                require: '?ngModel',
                link: function(scope, element, attrs, ngModelCtrl) {

                    if (!ngModelCtrl) {
                        return;
                    }

                    // Verifica se NÃO possui uiMask definido
                    if (!angular.isDefined(attrs.uiMask)) {
                        // Define uiMask
                        attrs.$set('uiMask', '999.999.999-99');
                        $compile(element)(scope);
                    }

                    ngModelCtrl.$parsers.push(function(value) {
                        if (angular.isDefined(value)) {
                            var clean = String(value).replace(/[^0-9]+/g, '');
                            if (value !== clean) {
                                // Atualizar campo com o valor digitado
                                ngModelCtrl.$setViewValue(clean);
                                //ngModelCtrl.$render();
                            }
                            return clean;
                        }
                    });

                    scope.value2mask = function(value) {
                        ngModelCtrl.$setViewValue(value);
                    }

                },
                controller: ['$scope', function($scope) {

                    $scope.pxForm2mask = function(value) {
                        $scope.value2mask(value);
                    }
                }]
            };
        }])
        // pxBrCepMask
        // 99999-999
        .directive('pxBrCepMask', ['$compile', function($compile) {
            return {
                priority: 100,
                restrict: 'A',
                scope: {
                    cleanValue: '@cleanValue'
                },
                require: '?ngModel',
                link: function(scope, element, attrs, ngModelCtrl) {

                    if (!ngModelCtrl) {
                        return;
                    }

                    // Verifica se NÃO possui uiMask definido
                    if (!angular.isDefined(attrs.uiMask)) {
                        // Define uiMask
                        attrs.$set('uiMask', '99999-999');
                        $compile(element)(scope);
                    }

                    ngModelCtrl.$parsers.push(function(value) {
                        if (angular.isDefined(value)) {
                            var clean = String(value).replace(/[^0-9]+/g, '');
                            if (value !== clean) {
                                // Atualizar campo com o valor digitado
                                ngModelCtrl.$setViewValue(clean);
                                //ngModelCtrl.$render();
                            }
                            return clean;
                        }
                    });

                    scope.value2mask = function(value) {
                        ngModelCtrl.$setViewValue(value);
                    }

                },
                controller: ['$scope', function($scope) {

                    $scope.pxForm2mask = function(value) {
                        $scope.value2mask(value);
                    }
                }]
            };
        }])

    // pxBrPhoneMask
    // (99) 9999-9999 / (99) 9999-9999?9
    // (99) 99999-999
    .directive('pxBrPhoneMask', ['$compile', function($compile) {
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
                link: function(scope, element, attrs, ngModelCtrl) {

                    if (!ngModelCtrl) {
                        return;
                    }

                    // Verifica se NÃO possui uiMask definido
                    if (!angular.isDefined(attrs.uiMask)) {
                        // Define uiMask
                        attrs.$set('uiMask', '(99) 9999-9999?9');
                        $compile(element)(scope);
                    }

                    scope.tempValue = scope.tempValue || '';

                    // Evento focusout
                    element.bind('focusout', function(event) {
                        if (angular.isDefined(scope.cleanValue)) {
                            if (scope.cleanValue.length < 11 || !angular.isDefined(scope.validPhone8)) {
                                // Atualizar uiMask para telefone com 8 dígitos
                                attrs.$set('uiMask', '(99) 9999-9999');
                                // Atualizar campo com o valor digitado e váriaveis de controle
                                ngModelCtrl.$setViewValue(scope.cleanValue);
                                //ngModelCtrl.$render();
                                scope.validPhone9 = false;
                                scope.validPhone8 = true;
                            }
                        }
                    });

                    // Evento focusin
                    element.bind('focusin', function(event) {
                        if (angular.isDefined(scope.cleanValue)) {
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
                        }
                    });

                    element.bind('keyup', function(event) {
                        if (angular.isDefined(scope.cleanValue)) {
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
                        } else {
                            //console.info('keyup', scope.cleanValue);
                            //console.info('keyup $scope.tempValue', scope.tempValue);
                            scope.cleanValue = scope.tempValue;

                            // Se possuir 11 dígitos e não estiver validado
                            // Telefone com 11 dígitos é um telefone com 9 dígitos mais dois dígitos do DDD
                            if (scope.cleanValue.length === 11 && scope.validPhone9 === false || !angular.isDefined(scope.validPhone9)) {

                                // Atualizar uiMask para telefone com 9 dígitos
                                attrs.$set('uiMask', '(99) ?99999-9999');
                                // Atualizar campo com o valor digitado e váriaveis de controle
                                //ngModelCtrl.$setViewValue(scope.cleanValue);
                                //ngModelCtrl.$render();
                                scope.validPhone9 = true;
                                scope.validPhone8 = false;

                            } else if (scope.cleanValue.length === 10 && scope.validPhone8 === false || !angular.isDefined(scope.validPhone8)) {

                                // Atualizar uiMask para telefone com 8 dígitos
                                attrs.$set('uiMask', '(99) 9999-9999?9');
                                // Atualizar campo com o valor digitado e váriaveis de controle
                                //ngModelCtrl.$setViewValue(scope.cleanValue);
                                //ngModelCtrl.$render();
                                scope.validPhone9 = false;
                                scope.validPhone8 = true;
                            }
                        }
                    });

                    ngModelCtrl.$parsers.push(function(value) {
                        if (angular.isDefined(value)) {
                            var clean = String(value).replace(/[^0-9]+/g, '');
                            scope.cleanValue = clean;
                            if (value !== clean) {
                                // Atualizar campo com o valor digitado
                                ngModelCtrl.$setViewValue(clean);
                                //ngModelCtrl.$render();
                            }
                            return clean;
                        }
                    });

                    scope.value2mask = function(value) {
                        ngModelCtrl.$setViewValue(scope.cleanValue);
                    }

                },
                controller: ['$scope', function($scope) {
                    $scope.pxForm2mask = function(value) {
                        $scope.value2mask(value);
                    }
                }]
            };
        }])
        // pxNumberMask
        .directive('pxNumberMask', ['$filter', '$locale', function($filter, $locale) {
            return {
                restrict: 'A',
                scope: {
                    cleanValue: '@cleanValue',
                    currency: '=pxCurrency',
                    currencySymbol: '@pxCurrencySymbol',
                    numberSuffix: '@pxNumberSuffix',
                    decimalSeparator: '@pxDecimalSeparator',
                    thousandsSeparator: '@pxThousandsSeparator',
                    numberPrecision: '@pxNumberPrecision',
                    useNegative: '=pxUseNegative',
                    usePositiveSymbol: '=pxUsePositiveSymbol'
                },
                require: '?ngModel',
                link: function(scope, element, attrs, ngModelCtrl) {

                    //console.info('$locale', $locale);
                    element.css({
                        zIndex: 0
                    });

                    if (!ngModelCtrl) {
                        return;
                    }

                    // Número habilitados
                    var enableNumbers = /[0-9]/;
                    // Define se o valor será moeda
                    var currency = scope.pxCurrency || false;
                    // Define símbolo do valor moeda
                    var currencySymbol = scope.currencySymbol || '';
                    // Define sufixo
                    var numberSuffix = scope.numberSuffix || '';
                    // Separador de decimal
                    var decimalSeparator = scope.decimalSeparator || $locale.NUMBER_FORMATS.DECIMAL_SEP;
                    // Separador de milhar
                    var thousandsSeparator = scope.thousandsSeparator || $locale.NUMBER_FORMATS.GROUP_SEP;
                    // Número de casas decimais
                    var numberPrecision = Number(scope.numberPrecision) || 2;
                    // Habilitar uso de número negativos
                    var useNegative = scope.useNegative || false;
                    // Usar símbolo positivo (+)
                    var usePositiveSymbol = scope.usePositiveSymbol || false;

                    if (currency && currencySymbol === '') {
                        currencySymbol = $locale.NUMBER_FORMATS.CURRENCY_SYM;
                    }

                    var limit = false;
                    var emptyValue = true;

                    ngModelCtrl.$parsers.push(function(value) {

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
                            if (char_ && char_.match(enableNumbers)) {
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

                        while (str.length < (numberPrecision + 1)) {
                            str = '0' + str;
                        }
                        return str;
                    }

                    function numberFormatter(str) {

                        if (str === '') {
                            emptyValue = true;
                            return str;
                        } else if (str === (currencySymbol + $locale.NUMBER_FORMATS.DECIMAL_SEP)) {
                            return '0';
                        }

                        //emptyValue = false;


                        var formatted = fillWithZero(toNumber(str));
                        var thousandsFormatted = '';
                        var thousandsCount = 0;
                        if (numberPrecision === 0) {
                            decimalSeparator = '';
                            centsVal = '';
                        }
                        var centsVal = formatted.substr(formatted.length - numberPrecision, numberPrecision);
                        var integerVal = formatted.substr(0, formatted.length - numberPrecision);
                        formatted = (numberPrecision === 0) ? integerVal : integerVal + decimalSeparator + centsVal;
                        if (thousandsSeparator || $.trim(thousandsSeparator) !== '') {
                            for (var j = integerVal.length; j > 0; j--) {
                                var char_ = integerVal.substr(j - 1, 1);
                                thousandsCount++;
                                if (thousandsCount % 3 === 0) {
                                    char_ = thousandsSeparator + char_;
                                }
                                thousandsFormatted = char_ + thousandsFormatted;
                            }
                            if (thousandsFormatted.substr(0, 1) === thousandsSeparator) {
                                thousandsFormatted = thousandsFormatted.substring(1, thousandsFormatted.length);
                            }
                            formatted = (numberPrecision === 0) ? thousandsFormatted : thousandsFormatted + decimalSeparator + centsVal;
                        }
                        if (useNegative && (integerVal !== 0 || centsVal !== 0)) {
                            if (str.indexOf('-') !== -1 && str.indexOf('+') < str.indexOf('-')) {
                                formatted = '-' + formatted;
                            } else {
                                if (!usePositiveSymbol) {
                                    formatted = '' + formatted;
                                } else {
                                    formatted = '+' + formatted;
                                }
                            }
                        }
                        if (currencySymbol) {
                            formatted = currencySymbol + formatted;
                        }
                        if (numberSuffix) {
                            formatted = formatted + numberSuffix;
                        }
                        return formatted;
                    }
                }
            };
        }])
        // pxInputSearch
        .directive('pxInputSearch', ['pxConfig', 'pxUtil', 'pxArrayUtil', '$parse', '$http', '$sce', '$timeout', '$mdDialog', function(pxConfig, pxUtil, pxArrayUtil, $parse, $http, $sce, $timeout, $mdDialog) {
            return {
                restrict: 'EA',
                scope: {
                    id: '@id',
                    required: '@required',
                    control: '=pxControl',
                    placeholder: '@placeholder',
                    inputClass: '@pxInputClass',
                    complete: '=pxComplete',
                    table: '@pxTable',
                    fields: '@pxFields',
                    orderBy: '@pxOrderBy',
                    recordCount: '@pxRecordCount',
                    selectedItem: '=pxSelectedItem',
                    url: '@pxUrl',
                    responseQuery: '@pxResponseQuery',
                    localQuery: '@pxLocalQuery',
                    searchFields: '@searchfields',
                    dialog: '=pxDialog',
                    searchClick: '&pxSearchClick',
                    templateUrl: '@pxTemplateUrl'
                },
                require: '?ngModel',
                templateUrl: pxConfig.PX_PACKAGE + 'system/components/px-form-item/px-input-search.html',
                link: function(scope, element, attrs, ngModelCtrl) {

                    if (!ngModelCtrl) {
                        return;
                    }

                    scope.inputClass = scope.inputClass || 'form-control';

                    if (scope.dialog) {
                        scope.inputGroup = 'input-group';
                    } else {
                        scope.inputGroup = '';
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

                    scope.internalControl = scope.control || {};

                    scope.internalControl.working = false;

                    scope.internalControl.setValue = function(value) {
                        scope.setValue(value);
                    };

                    scope.internalControl.getValue = function() {
                        return {
                            selectedItem: scope.selectedItem
                        };
                    };

                    $timeout(function() {
                        var _element = angular.element($('#' + scope.id + '_inputSearch').get(0));
                        // Evento blur
                        _element.on('blur', function(event) {
                            scope.setValidity();
                        });

                    }, 0);

                    scope.setValidity = function() {
                            var _element = angular.element($('#' + scope.id + '_inputSearch').get(0));
                            var _span = angular.element($('#' + scope.id + '_spanInputSearch').get(0));
                            if (!angular.isDefined(scope.selectedItem) || scope.selectedItem === null) {
                                ngModelCtrl.$setValidity('requiredsearch', false);
                                scope.searchStr = scope.lastSearchTerm = '';
                                scope.selectedItem = '';
                                scope.showDropdown = false;
                                scope.results = [];
                            } else {
                                var searchStrQuery = '';
                                if (angular.isDefined(scope.selectedItem)) {
                                    scope.labelField = JSON.parse(scope.fields)[pxArrayUtil.getIndexByProperty(JSON.parse(scope.fields), 'labelField', true)].field;
                                    searchStrQuery = scope.selectedItem[scope.labelField];
                                    if (!angular.isDefined(searchStrQuery)) {
                                        searchStrQuery = scope.selectedItem[scope.labelField.toUpperCase()];
                                    }
                                }
                                if (scope.searchStr !== searchStrQuery) {
                                    scope.searchStr = scope.lastSearchTerm = '';
                                    scope.selectedItem = '';
                                    scope.showDropdown = false;
                                    scope.results = [];

                                    ngModelCtrl.$setValidity('requiredsearch', false);
                                } else {
                                    ngModelCtrl.$setValidity('requiredsearch', true);
                                    ngModelCtrl.$setValidity('required', true);
                                }
                            }
                            $timeout(function() {
                                _element.trigger('keyup');
                            }, 0);
                            if (attrs.required === true) {
                                if (ngModelCtrl.$invalid) {
                                    _element.css({
                                        borderColor: '#A94442'
                                    });
                                    _span.css({
                                        borderColor: '#A94442'
                                    });

                                } else {
                                    _element.css({
                                        borderColor: '#CCCCCC'
                                    });
                                    _span.css({
                                        borderColor: '#CCCCCC'
                                    });
                                }
                            }
                        }
                        // px-modal - Start                   
                        // px-modal - End
                    var isNewSearchNeeded = function(newTerm, oldTerm) {
                        return newTerm.length >= scope.minLength && newTerm !== oldTerm;
                    };
                    // px-complete - Start
                    if (scope.complete !== true) {
                        return;
                    }
                    scope.processResults = function(response, str, arrayFields) {
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

                                        textValue += arrayFields[j].title + tempValue + '';
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

                    scope.searchTimerComplete = function(str) {
                        // Início da pesquisa

                        var arrayFields = JSON.parse(scope.fields);

                        if (str.length >= scope.minLength) {
                            if (scope.localQuery) {

                                console.warn('px-complete:', 'função localQuery não implementada!');

                                scope.searching = false;
                                scope.processResults(JSON.parse(scope.localQuery), str);

                            } else {

                                // Loop na configuração de campos
                                angular.forEach(arrayFields, function(index) {
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
                                params.dsn = pxConfig.PROJECT_DSN;
                                params.table = scope.table;
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
                                }).success(function(response, status, headers, config) {
                                    if (scope.debug) {
                                        console.info('px-input-search getData success', response);
                                    }
                                    if (!angular.isDefined(scope.responseQuery) || scope.responseQuery === '') {
                                        scope.responseQuery = 'qQuery';
                                    }

                                    scope.searching = false;
                                    scope.processResults(((scope.responseQuery) ? response[scope.responseQuery] : response), str, arrayFields);

                                }).
                                error(function(data, status, headers, config) {
                                    // Erro
                                    alert('Ops! Ocorreu um erro inesperado.\nPor favor contate o administrador do sistema!');
                                });
                            }
                        }
                    };

                    scope.hideResults = function() {
                        scope.hideTimer = $timeout(function() {
                            scope.showDropdown = false;
                        }, scope.pause);
                    };

                    scope.resetHideResults = function() {
                        if (scope.hideTimer) {
                            $timeout.cancel(scope.hideTimer);
                        }
                    };

                    scope.hoverRow = function(index) {
                        scope.currentIndex = index;
                    };

                    scope.keyPressed = function(event) {
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

                                scope.searchTimer = $timeout(function() {
                                    scope.searchTimerComplete(scope.searchStr);
                                }, scope.pause);
                            }
                        } else {
                            event.preventDefault();
                        }
                    };

                    scope.selectResult = function(result) {

                        scope.searchStr = scope.lastSearchTerm = result.title;
                        scope.selectedItem = result.item;
                        scope.showDropdown = false;
                        scope.results = [];
                        //scope.$apply();
                        scope.setValidity();
                    };

                    var inputField = element.find('input');

                    inputField.on('keyup', scope.keyPressed);

                    element.on('keyup', function(event) {
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
                    // px-complete - End
                },
                controller: ['$scope', function($scope) {
                    $scope.showDialog = function(event) {
                        $scope.searchStr = $scope.lastSearchTerm = '';
                        $scope.selectedItem = '';
                        $scope.showDropdown = false;
                        $scope.results = [];

                        $scope.searchClick({
                            event: event
                        });
                    };

                    $scope.setValue = function(data) {
                        var arrayFields = JSON.parse($scope.fields);

                        var field = arrayFields[pxArrayUtil.getIndexByProperty(arrayFields, 'labelField', true)].field;

                        var tempValue = data[field];
                        if (!angular.isDefined(tempValue)) {
                            tempValue = data[field.toUpperCase()];
                        }

                        $scope.searchStr = $scope.lastSearchTerm = tempValue;
                        $scope.selectedItem = data;
                        $scope.showDropdown = false;
                        $scope.results = [];

                        $scope.setValidity();
                        /*
                        scope.searchStr = scope.lastSearchTerm = result.title;
                        scope.selectedItem = result.item;
                        scope.showDropdown = false;
                        scope.results = [];
                        */
                    };
                }]
            };
        }]);
});