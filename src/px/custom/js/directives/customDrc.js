'use strict';
app.directive('pxCustomDirectiveExemplo', function() {
    return {
        restrict: 'E',
        replace: true,
        transclude: false,
        templateUrl: 'px/custom/view/directiveExemplo.html',
        link: function(scope, element, attrs) {
            // Manipulação e Eventos DOM

        }
    };
});

/*
app.directive('outroComponente', function() {
    return {
        restrict: 'E',
        replace: true,
        transclude: false,
        templateUrl: 'px/custom/view/outroComponente.html',
        link: function (scope, element, attrs) {
            // Manipulação e Eventos DOM


        }
    };
});
*/
