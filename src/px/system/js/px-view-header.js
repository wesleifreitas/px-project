// Componente <px-view-header>
// Cabeçalho para as view/.
app.directive('pxViewHeader', ['$timeout', function(timer) {
    return {
        restrict: 'E',
        replace: true,
        transclude: false,
        templateUrl: pxProjectPackage() + 'px/system/view/viewHeader.html',

        link: function(scope, element, attrs) {
            // Manipulação e Eventos DOM
        },
        controller: function($scope, $element, $attrs) {

        }
    }
}]);