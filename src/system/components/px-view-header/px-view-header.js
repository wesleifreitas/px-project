define(['../../directives/module'], function(directives) {
    'use strict';

    directives.directive('pxViewHeader', ['pxConfig', function(pxConfig) {
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
});