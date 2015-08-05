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