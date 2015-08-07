angular.module('pxFormItem', [])
  .value('pxFormItemConfig', {

  })
  /**
   * Chamar função ao pressionar a tecla 'Enter'
   */
  .directive('pxEnter', ['pxViewHeaderConfig', function(pxViewHeaderConfig) {
    return function(scope, element, attrs) {
      element.bind("keydown keypress", function(event) {
        if (event.which === 13) {
          scope.$apply(function() {
            scope.$eval(attrs.pxEnter);
          });
          event.preventDefault();
        }
      });
    };
  }])
  /**
   * Digitar somente números
   */
  .directive('pxValidNumber', ['pxViewHeaderConfig', function(pxViewHeaderConfig) {
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
  /**
   * Máscara CNPJ
   * 99.999.999/9999-99
   */
  .directive('pxBrCnpjMask', ['pxViewHeaderConfig', '$compile', function(pxViewHeaderConfig, $compile) {
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
  /**
   * Máscara CPF
   * 999.999.999-99
   */
  .directive('pxBrCpfMask', ['pxViewHeaderConfig', '$compile', function(pxViewHeaderConfig, $compile) {
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
  /**
   * Máscara Telefone 
   * (99) 9999-9999 / (99) 9999-9999?9
   * (99) 99999-9999
   */
  .directive('pxBrPhoneMask', ['pxViewHeaderConfig', '$compile', function(pxViewHeaderConfig, $compile) {
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
          attrs.$set('uiMask', '(99) 9999-9999?9')
          $compile(element)(scope);
        }

        // Evento focusout     
        element.bind('focusout', function(event) {
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
        element.bind('focusin', function(event) {
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

        element.bind("keyup", function(event) {
          // Se possuir 11 dígitos e não estiver validado
          // Telefone com 11 dígitos é um telefone com 9 dígitos mais dois dígitos do DDD
          if (scope.cleanValue.length == 11 && scope.validPhone9 == false || !angular.isDefined(scope.validPhone9)) {

            // Atualizar uiMask para telefone com 9 dígitos
            attrs.$set('uiMask', '(99) ?99999-9999');
            // Atualizar campo com o valor digitado e váriaveis de controle
            ngModelCtrl.$setViewValue(scope.cleanValue);
            //ngModelCtrl.$render();
            scope.validPhone9 = true;
            scope.validPhone8 = false;

          } else if (scope.cleanValue.length == 10 && scope.validPhone8 == false || !angular.isDefined(scope.validPhone8)) {

            // Atualizar uiMask para telefone com 8 dígitos
            attrs.$set('uiMask', '(99) 9999-9999?9');
            // Atualizar campo com o valor digitado e váriaveis de controle
            ngModelCtrl.$setViewValue(scope.cleanValue);
            //ngModelCtrl.$render();
            scope.validPhone9 = false;
            scope.validPhone8 = true;
          }
        });

        ngModelCtrl.$parsers.push(function(value) {
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
  /**
   * Máscara Número
   */
  .directive('pxNumberMask', ['pxViewHeaderConfig', '$filter', '$locale', function(pxViewHeaderConfig, $filter, $locale) {
    return {
      restrict: 'A',
      scope: {
        cleanValue: '@cleanValue'
      },
      require: '?ngModel',
      link: function(scope, element, attrs, ngModelCtrl) {

        //console.info('$locale', $locale);

        if (!ngModelCtrl) {
          return
        };

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

        if (attrs.pxCurrency && attrs.pxCurrencySymbol == '') {
          attrs.$set('pxCurrencySymbol', $locale.NUMBER_FORMATS.CURRENCY_SYM);
        }

        var limit = false;

        ngModelCtrl.$parsers.push(function(value) {

          var formatValue = numberFormatter(value);

          if (value !== formatValue) {
            ngModelCtrl.$setViewValue(formatValue);
            ngModelCtrl.$render();
          }

          if (formatValue == '') {
            return formatValue;
          } else if (formatValue == (attrs.pxCurrencySymbol + '.')) {
            return 0
          } else {
            return numeral().unformat(formatValue);
          }
        });

        function toNumber(str) {
          var formatted = '';
          for (var i = 0; i < (str.length); i++) {
            char_ = str.charAt(i);
            if (formatted.length == 0 && char_ == 0) char_ = false;
            if (char_ && char_.match(attrs.pxEnableNumbers)) {
              if (limit) {
                if (formatted.length < limit) formatted = formatted + char_
              } else {
                formatted = formatted + char_
              }
            }
          }
          return formatted
        }

        function fillWithZero(str) {
          if (str == '') {
            return str;
          }

          while (str.length < (attrs.pxNumberPrecision + 1)) str = '0' + str;
          return str
        }

        function numberFormatter(str) {

          var clean = str;
          if (clean == '') {
            return clean;
          } else if (clean == (attrs.pxCurrencySymbol + '.')) {
            return 0;
          }


          var formatted = fillWithZero(toNumber(str));
          var thousandsFormatted = '';
          var thousandsCount = 0;
          if (attrs.pxNumberPrecision == 0) {
            attrs.pxDecimalSeparator = "";
            centsVal = ""
          }
          var centsVal = formatted.substr(formatted.length - attrs.pxNumberPrecision, attrs.pxNumberPrecision);
          var integerVal = formatted.substr(0, formatted.length - attrs.pxNumberPrecision);
          formatted = (attrs.pxNumberPrecision == 0) ? integerVal : integerVal + attrs.pxDecimalSeparator + centsVal;
          if (attrs.pxThousandsSeparator || $.trim(attrs.pxThousandsSeparator) != "") {
            for (var j = integerVal.length; j > 0; j--) {
              char_ = integerVal.substr(j - 1, 1);
              thousandsCount++;
              if (thousandsCount % 3 == 0) char_ = attrs.pxThousandsSeparator + char_;
              thousandsFormatted = char_ + thousandsFormatted
            }
            if (thousandsFormatted.substr(0, 1) == attrs.pxThousandsSeparator) thousandsFormatted = thousandsFormatted.substring(1, thousandsFormatted.length);
            formatted = (attrs.pxNumberPrecision == 0) ? thousandsFormatted : thousandsFormatted + attrs.pxDecimalSeparator + centsVal
          }
          if (attrs.pxUseNegative && (integerVal != 0 || centsVal != 0)) {
            if (str.indexOf('-') != -1 && str.indexOf('+') < str.indexOf('-')) {
              formatted = '-' + formatted
            } else {
              if (!attrs.pxUsePositive) formatted = '' + formatted;
              else formatted = '+' + formatted
            }
          }
          if (attrs.pxCurrencySymbol) formatted = attrs.pxCurrencySymbol + formatted;
          if (attrs.pxNumberSuffix) formatted = formatted + attrs.pxNumberSuffix;
          return formatted;
        }
      }
    };
  }]);