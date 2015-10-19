(function() {
    'use strict';

    angular.module('pxForm', [])
        .value('pxFormConfig', {})
        .directive('pxForm', ['pxFormConfig', function(pxFormConfig) {
            return {
                restrict: 'E',
                replace: true,
                scope: {
                    control: '='
                },
                link: function(scope, element, attrs) {

                    // alert('pxForm');
                    // http://stackoverflow.com/questions/23141854/adding-asterisk-to-required-fields-in-bootstrap-3
                    console.warn('pxForm: directive em desenvolvimento');
                    
                    scope.internalControl = scope.control || {};
                }
            };
        }])
})();