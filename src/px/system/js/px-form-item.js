/**
 * Máscara CNPJ
 * 99.999.999/9999-99
 */
app.directive('pxBrCnpjMask', function($compile) {
  return {
    priority: 100,
    restrict: 'A',
    scope: false,
    bindToController: false,
    require: '?ngModel',
    link: function(scope, element, attrs, ngModelCtrl) {

      if (!ngModelCtrl) {
        return;
      }

      // Verifica se NÃO possui uiMask definido
      if (!angular.isDefined(attrs.uiMask)) {
        // Define uiMask
        attrs.$set('uiMask', '99.999.999/9999-99')
        $compile(element)(scope);
      }

      ngModelCtrl.$parsers.push(function(val) {});
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
    scope: false,
    bindToController: false,
    require: '?ngModel',
    link: function(scope, element, attrs, ngModelCtrl) {

      if (!ngModelCtrl) {
        return;
      }

      // Verifica se NÃO possui uiMask definido
      if (!angular.isDefined(attrs.uiMask)) {
        // Define uiMask
        attrs.$set('uiMask', '999.999.999-99')
        $compile(element)(scope);
      }

      ngModelCtrl.$parsers.push(function(val) {});
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
    scope: false,
    bindToController: false,
    require: '?ngModel',
    link: function(scope, element, attrs, ngModelCtrl) {

      if (!ngModelCtrl) {
        return;
      }

      // Armaneza telefone digitado
      scope.currentPhone = scope.currentPhone || '';
      // É um telefone com 9 dígitos?
      scope.validPhone9 = scope.validPhone9 || false;
      // É um telefone com 8 dígitos
      scope.validPhone8 = scope.validPhone8 || false;

      // Verifica se NÃO possui uiMask definido
      if (!angular.isDefined(attrs.uiMask)) {
        // Define uiMask
        attrs.$set('uiMask', '(99) 9999-9999?9')
        $compile(element)(scope);
      }

      // Evento focusout
      element.bind('focusout', function(event) {
        // Se possuir 11 dígitos e não estiver validado
        // Telefone com 11 dígitos é um telefone com 9 dígitos mais dois dígitos do DDD
        if (scope.currentPhone.length == 11 && scope.validPhone9 == false) {
          // Atualizar uiMask para telefone com 9 dígitos
          attrs.$set('uiMask', '(99) 99999-9999');
          // Atualizar campo com o valor digitado e váriaveis de controle
          ngModelCtrl.$setViewValue(scope.currentPhone);
          ngModelCtrl.$render();
          scope.validPhone9 = true;
          scope.validPhone8 = false;
        } else if (scope.currentPhone.length < 11 && scope.validPhone8 == false) {
          // Atualizar uiMask para telefone com 8 dígitos
          attrs.$set('uiMask', '(99) 9999-9999');
          // Atualizar campo com o valor digitado e váriaveis de controle
          ngModelCtrl.$setViewValue(scope.currentPhone);
          ngModelCtrl.$render();
          scope.validPhone9 = false;
          scope.validPhone8 = true;
        }
      });

      // Evento focusin
      element.bind('focusin', function(event) {
        // Verifica se o telefone digitado possui menos que 11 dígitos
        if (scope.currentPhone.length < 11) {
          // Atualizar uiMask para telefone com 8 dígitos, deixando um digitado a mais como opcional
          attrs.$set('uiMask', '(99) 9999-9999?9');
          // Atualizar campo com o valor digitado e váriaveis de controle
          ngModelCtrl.$setViewValue(scope.currentPhone);
          ngModelCtrl.$render();
          scope.validPhone9 = false;
          scope.validPhone8 = false;
        }
      });

      ngModelCtrl.$parsers.push(function(val) {
        // Se val (valor digitado) foi direfente que vazio
        // Note que para a verificação são considerados somente números
        if (val.replace(/[^0-9]+/g, '') != '') {
          // Armazena valor digitado
          scope.currentPhone = val.replace(/[^0-9]+/g, '');
        } else {
          // Atualizar campo com o último valor válido digitado
          ngModelCtrl.$setViewValue(scope.currentPhone);
          ngModelCtrl.$render();
        }
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