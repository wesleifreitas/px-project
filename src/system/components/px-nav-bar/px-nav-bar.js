define(['../../directives/module'], function(directives) {
    'use strict';

    directives.directive('pxNavBar', ['$compile', function($compile) {
        return {
            restrict: 'E',
            transclude: true,
            scope: {
                title: '@'
            },
            link: function(scope, element, attrs) {

                var watchNavBar = scope.$watch('navBar', function(newValue, oldValue) {
                    console.info('newValue', newValue);
                    console.info('oldValue', oldValue);
                    if (newValue !== oldValue) {
                        console.info('watchNavBar');
                        element.html(scope.navBar);
                        $compile(element.contents())(scope);
                        watchNavBar();
                    }
                });
            },
            controller: pxNavBarCtrl
        };
    }]);

    pxNavBarCtrl.$inject = ['pxConfig', '$scope', '$http', '$rootScope', '$location'];

    function pxNavBarCtrl(pxConfig, $scope, $http, $rootScope, $location) {

        $scope.getNavBar = function() {

            var params = {};
            params.pro_id = angular.toJson(pxConfig.PROJECT_ID);
            params.isMobile = $scope.isMobile();
            params.user = $rootScope.globals.currentUser.usu_id;
            params.dsn = pxConfig.PROJECT_DSN;

            $http({
                method: 'POST',
                url: pxConfig.PX_PACKAGE + 'system/components/px-nav-bar/px-nav-bar.cfc?method=getNavBar',
                params: params
            }).success(function(response) {
                console.info('getNavBar', response);
                $scope.navBar = response.navBar;
            }).
            error(function(data, status, headers, config) {
                // Erro
                alert('Ops! Ocorreu um erro inesperado.\nPor favor contate o administrador do sistema!');
            });
        };

        $scope.showView = function(view) {
            /*if ($scope.isMobile() || $('.app-bar-pullbutton.automatic')) {
                // "Resetar" menu                    
                $('.app-bar-pullbutton.automatic').trigger('click');
            }*/

            var params = {};
            params.men_id = view;
            params.pathname = pxConfig.PROJECT_SRC; //document.location.pathname;
            params.pxProjectPackage = pxConfig.PX_PACKAGE;
            params.dsn = pxConfig.PROJECT_DSN;

            $http({
                method: 'POST',
                url: pxConfig.PX_PACKAGE + 'system/components/px-nav-bar/px-nav-bar.cfc?method=getView',
                params: params
            }).success(function(response) {
                console.info('response', response);
                $location.path('/home/' + response.state);
            }).
            error(function(data, status, headers, config) {
                // Erro
                alert('Ops! Ocorreu um erro inesperado.\nPor favor contate o administrador do sistema!');
            });
        };

        $scope.isMobile = function() {
            var userAgent = navigator.userAgent.toLowerCase();
            if (userAgent.search(/(android|avantgo|blackberry|bolt|boost|cricket|docomo|fone|hiptop|mini|mobi|palm|phone|pie|tablet|up\.browser|up\.link|webos|wos)/i) != -1) {
                return true;
            } else {
                return false;
            }
        };

        // Inicializar menu
        $scope.getNavBar();
    }
});