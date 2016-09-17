define(['../../directives/module'], function(directives) {
    'use strict';

    directives.directive('pxFixed', ['pxUtil', function(pxUtil) {
        return {
            estrict: 'A',
            scope: {
                wrapper: '@pxWrapper',
                hfixed: '=pxHfixed',
                vfixed: '=pxVfixed'
            },
            link: function(scope, element, attrs, ngModelCtrl) {
                // Acesso via mobile browsers
                if (pxUtil.isMobile()) {
                    return;
                }

                scope.left = scope.left || 0;

                if (!scope.hfixed && !scope.vfixed) {
                    console.warn('px-fixed:', 'px-fixed utilizado sem px-hfixed e/ou px-vfixed');
                    return;
                }

                //element.get(0).style.width = "100%";
                //element.get(0).style.position = "relative";
                element.css({
                    width: '100%',
                    position: "relative",
                });

                /*
                $(scope.wrapper).css({
                    zIndex: 100
                });
                */

                $(scope.wrapper).scroll(function() {
                    // console.info(window.getComputedStyle(element.get(0)).getPropertyValue('left'));
                    if (scope.hfixed) {
                        element.css({
                            'left': $(this).scrollLeft()
                        });
                    }

                    if (scope.vfixed) {
                        element.css({
                            'top': $(this).scrollTop(),
                        });
                    }

                });
            }
        };
    }])
});