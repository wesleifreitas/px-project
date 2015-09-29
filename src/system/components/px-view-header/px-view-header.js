(function() {
    'use strict';

    angular.module('pxViewHeader', [])
        .value('pxViewHeaderConfig', {

        })
        .directive('pxViewHeader', ['pxViewHeaderConfig', 'pxConfig', function(pxViewHeaderConfig, pxConfig) {
            return {
                restrict: 'E',
                replace: true,
                transclude: false,
                templateUrl: pxConfig.PX_PACKAGE + 'system/components/px-view-header/px-view-header.html',

                link: function(scope, element, attrs) {
                    // Manipulação e Eventos DOM
                },
                controller: function($scope, $element, $attrs) {
                    // Controller
                }
            };
        }]);
})();