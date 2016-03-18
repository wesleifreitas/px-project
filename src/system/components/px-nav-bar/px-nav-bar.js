define(['../../directives/module'], function(directives) {
    'use strict';

    directives.directive('pxNavBar', ['pxConfig', '$compile', '$parse', '$timeout', function(pxConfig, $compile, $parse, $timeout) {
            return {
                restrict: 'E',
                replace: true,
                transclude: false,
                templateUrl: pxConfig.PX_PACKAGE + 'system/components/px-nav-bar/px-nav-bar.html',
                link: function(scope, element, attrs) {
                    scope.logo = pxConfig.PX_PACKAGE + 'system/assets/richsolutions/richsolutions_bola_200x200.jpg';
                    scope.$watch(attrs.content, function() {
                        element.html($parse(attrs.content)(scope));
                        $compile(element.contents())(scope);
                    }, true);

                    // Inicializar menu
                    $timeout(scope.getNavBar, 1000);
                }
            };
        }])
        .controller('pxNavBarCtrl', ['pxConfig', '$scope', '$http', '$rootScope', function(pxConfig, $scope, $http, $rootScope) {

            $scope.templates = [{
                name: '?.html',
                url: '?.html'
            }, {
                name: '',
                url: ''
            }];

            $scope.template = $scope.templates[1];

            $scope.navBar = '<div class="app-bar darcula px-no-radius"><span class="app-bar-element place-left" href="...">Por favor aguarde, carregando barra de navegação...</span></div>';

            $scope.getNavBar = function() {

                var params = {};
                params.pro_id = 0;                
                params.isMobile = $scope.isMobile();
                params.user = $rootScope.globals.currentUser.usu_id;
                
                $http({
                    method: 'POST',
                    url: pxConfig.PX_PACKAGE + 'system/components/px-nav-bar/px-nav-bar.cfc?method=getNavBar',
                    params: params
                }).success(function(response) {
                    $scope.navBar = response.navBar;
                }).
                error(function(data, status, headers, config) {
                    // Erro
                    alert('Ops! Ocorreu um erro inesperado.\nPor favor contate o administrador do sistema!');
                });
            };

            $scope.showView = function(view) {
                console.info($scope.isMobile());

                if ($scope.isMobile() || $('.app-bar-pullbutton.automatic')) {
                    // "Resetar" menu                    
                    $('.app-bar-pullbutton.automatic').trigger('click');                    
                }

                var params = {};
                params.men_id = view;
                params.pathname = pxConfig.PROJECT_SRC; //document.location.pathname;
                params.pxProjectPackage = pxConfig.PX_PACKAGE;

                $http({
                    method: 'POST',
                    url: pxConfig.PX_PACKAGE + 'system/components/px-nav-bar/px-nav-bar.cfc?method=getView',
                    params: params
                }).success(function(response) {
                    //console.info('response',response);
                    //$location.path('/'+response.qView.COM_VIEW);

                    var headerView = response.qView[0].MEN_NOMECAMINHO.split(response.qView[0].MEN_NOMECAMINHO.split('»')[response.qView[0].MEN_NOMECAMINHO.split('»').length - 1]);

                    $scope.view = {};
                    $scope.view.response = response;
                    $scope.view.men_id = response.qView[0].MEN_ID;
                    $scope.view.caminho = response.qView[0].MEN_NOMECAMINHO;
                    $scope.view.header = headerView[0];
                    $scope.view.titulo = response.qView[0].MEN_NOMECAMINHO.split('»')[response.qView[0].MEN_NOMECAMINHO.split('»').length - 1];
                    $scope.view.icon = response.qView[0].COM_ICON;

                    $scope.templates[1].name = response.qView[0].COM_VIEW;
                    $scope.templates[1].url = response.qView[0].COM_VIEW;

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
        }]);
});