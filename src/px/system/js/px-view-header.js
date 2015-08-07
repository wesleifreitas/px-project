/**
 * Module pxViewHeader
 */
angular.module('pxViewHeader', [])
    .value('pxViewHeaderConfig', {

    })
    .directive('pxViewHeader', ['pxViewHeaderConfig', function(pxViewHeaderConfig) {
        return {
            restrict: 'E',
            replace: true,
            transclude: false,
            templateUrl: pxProjectPackage() + 'px/system/view/viewHeader.html',

            link: function(scope, element, attrs) {
                // Manipulação e Eventos DOM
            },
            controller: function($scope, $element, $attrs) {
                // Controller
            }
        }
    }]);