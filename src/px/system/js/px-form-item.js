/**
 * Chamar função ao pressionar a tecla 'Enter'
 */
app.directive('pxEnter', function() {
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
});

/**
 * Digitar somente números
 */
app.directive('pxValidNumber', function() {
  return {
    require: '?ngModel',
    link: function(scope, element, attrs, ngModelCtrl) {
      if (!ngModelCtrl) {
        return;
      }

      ngModelCtrl.$parsers.push(function(val) {
        var clean = val.replace(/[^0-9]+/g, '');
        if (val !== clean) {
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
});

/**
 * Máscara CNPJ
 * 99.999.999/9999-99
 */
app.directive('pxBrCnpjMask', function($compile) {
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

      ngModelCtrl.$parsers.push(function(val) {
        var clean = val.replace(/[^0-9]+/g, '');
        if (val !== clean) {
          // Atualizar campo com o valor digitado
          ngModelCtrl.$setViewValue(clean);
          //ngModelCtrl.$render();          
        }
        return clean;
      });
    }
  };
});

/**
 * Máscara CPF
 * 999.999.999-99
 */
app.directive('pxBrCpfMask', function($compile) {
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

      ngModelCtrl.$parsers.push(function(val) {
        var clean = val.replace(/[^0-9]+/g, '');
        if (val !== clean) {
          // Atualizar campo com o valor digitado
          ngModelCtrl.$setViewValue(clean);
          //ngModelCtrl.$render();          
        }
        return clean;
      });
    }
  };
});

/**
 * Máscara Telefone 
 * (99) 9999-9999 / (99) 9999-9999?9
 * (99) 99999-9999
 */
app.directive('pxBrPhoneMask', function($compile) {
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

      ngModelCtrl.$parsers.push(function(val) {
        var clean = val.replace(/[^0-9]+/g, '');
        scope.cleanValue = clean;
        if (val !== clean) {
          // Atualizar campo com o valor digitado
          ngModelCtrl.$setViewValue(clean);
          //ngModelCtrl.$render();          
        }
        return clean;
      });
    }
  };
});

app.directive('pxCurrencyMask', ['$filter', function($filter) {
  return {
    restrict: 'A',
    scope: {
      cleanValue: '@cleanValue'
    },
    require: '?ngModel',
    link: function(scope, element, attrs, ngModelCtrl) {
      if (!ngModelCtrl) return;

      var format = {
        prefix: '',
        centsSeparator: ',',
        thousandsSeparator: '.'
      };

      var formatSql = {
        prefix: '',
        centsSeparator: '.',
        thousandsSeparator: ''
      };

      ngModelCtrl.$parsers.unshift(function(value) {
        var clean = element.priceFormat(formatSql).val();
        element.priceFormat(format);
        //console.log('parsers', element[0].value);
        //console.log('clean', clean);
        return clean; //element[0].value;
      });

      ngModelCtrl.$formatters.unshift(function(value) {
        element[0].value = ngModelCtrl.$modelValue * 0;
        element.priceFormat(format);
        //console.log('formatters', element[0].value);
        return element[0].value;
      })
    }
  };
}]);

(function($) {
  $.fn.priceFormat = function(options) {
    var defaults = {
      prefix: 'US$ ',
      suffix: '',
      centsSeparator: '.',
      thousandsSeparator: ',',
      limit: false,
      centsLimit: 2,
      clearPrefix: false,
      clearSufix: false,
      allowNegative: false,
      insertPlusSign: false
    };
    var options = $.extend(defaults, options);
    return this.each(function() {
      var obj = $(this);
      var is_number = /[0-9]/;
      var prefix = options.prefix;
      var suffix = options.suffix;
      var centsSeparator = options.centsSeparator;
      var thousandsSeparator = options.thousandsSeparator;
      var limit = options.limit;
      var centsLimit = options.centsLimit;
      var clearPrefix = options.clearPrefix;
      var clearSuffix = options.clearSuffix;
      var allowNegative = options.allowNegative;
      var insertPlusSign = options.insertPlusSign;
      if (insertPlusSign) allowNegative = true;

      function to_numbers(str) {
        var formatted = '';
        for (var i = 0; i < (str.length); i++) {
          char_ = str.charAt(i);
          if (formatted.length == 0 && char_ == 0) char_ = false;
          if (char_ && char_.match(is_number)) {
            if (limit) {
              if (formatted.length < limit) formatted = formatted + char_
            } else {
              formatted = formatted + char_
            }
          }
        }
        return formatted
      }

      function fill_with_zeroes(str) {
        while (str.length < (centsLimit + 1)) str = '0' + str;
        return str
      }

      function price_format(str) {
        var formatted = fill_with_zeroes(to_numbers(str));
        var thousandsFormatted = '';
        var thousandsCount = 0;
        if (centsLimit == 0) {
          centsSeparator = "";
          centsVal = ""
        }
        var centsVal = formatted.substr(formatted.length - centsLimit, centsLimit);
        var integerVal = formatted.substr(0, formatted.length - centsLimit);
        formatted = (centsLimit == 0) ? integerVal : integerVal + centsSeparator + centsVal;
        if (thousandsSeparator || $.trim(thousandsSeparator) != "") {
          for (var j = integerVal.length; j > 0; j--) {
            char_ = integerVal.substr(j - 1, 1);
            thousandsCount++;
            if (thousandsCount % 3 == 0) char_ = thousandsSeparator + char_;
            thousandsFormatted = char_ + thousandsFormatted
          }
          if (thousandsFormatted.substr(0, 1) == thousandsSeparator) thousandsFormatted = thousandsFormatted.substring(1, thousandsFormatted.length);
          formatted = (centsLimit == 0) ? thousandsFormatted : thousandsFormatted + centsSeparator + centsVal
        }
        if (allowNegative && (integerVal != 0 || centsVal != 0)) {
          if (str.indexOf('-') != -1 && str.indexOf('+') < str.indexOf('-')) {
            formatted = '-' + formatted
          } else {
            if (!insertPlusSign) formatted = '' + formatted;
            else formatted = '+' + formatted
          }
        }
        if (prefix) formatted = prefix + formatted;
        if (suffix) formatted = formatted + suffix;
        return formatted
      }

      function key_check(e) {
        var code = (e.keyCode ? e.keyCode : e.which);
        var typed = String.fromCharCode(code);
        var functional = false;
        var str = obj.val();
        var newValue = price_format(str + typed);
        if ((code >= 48 && code <= 57) || (code >= 96 && code <= 105)) functional = true;
        if (code == 8) functional = true;
        if (code == 9) functional = true;
        if (code == 13) functional = true;
        if (code == 46) functional = true;
        if (code == 37) functional = true;
        if (code == 39) functional = true;
        if (allowNegative && (code == 189 || code == 109)) functional = true;
        if (insertPlusSign && (code == 187 || code == 107)) functional = true;
        if (!functional) {
          e.preventDefault();
          e.stopPropagation();
          if (str != newValue) obj.val(newValue)
        }
      }

      function price_it() {
        var str = obj.val();
        var price = price_format(str);
        if (str != price) obj.val(price)
      }

      function add_prefix() {
        var val = obj.val();
        obj.val(prefix + val)
      }

      function add_suffix() {
        var val = obj.val();
        obj.val(val + suffix)
      }

      function clear_prefix() {
        if ($.trim(prefix) != '' && clearPrefix) {
          var array = obj.val().split(prefix);
          obj.val(array[1])
        }
      }

      function clear_suffix() {
        if ($.trim(suffix) != '' && clearSuffix) {
          var array = obj.val().split(suffix);
          obj.val(array[0])
        }
      }
      $(this).bind('keydown.price_format', key_check);
      $(this).bind('keyup.price_format', price_it);
      $(this).bind('focusout.price_format', price_it);
      if (clearPrefix) {
        $(this).bind('focusout.price_format', function() {
          clear_prefix()
        });
        $(this).bind('focusin.price_format', function() {
          add_prefix()
        })
      }
      if (clearSuffix) {
        $(this).bind('focusout.price_format', function() {
          clear_suffix()
        });
        $(this).bind('focusin.price_format', function() {
          add_suffix()
        })
      }
      if ($(this).val().length > 0) {
        price_it();
        clear_prefix();
        clear_suffix()
      }
    })
  };
  $.fn.unpriceFormat = function() {
    return $(this).unbind(".price_format")
  };
  $.fn.unmask = function() {
    var field = $(this).val();
    var result = "";
    for (var f in field) {
      if (!isNaN(field[f]) || field[f] == "-") result += field[f]
    }
    return result
  }
})(jQuery);