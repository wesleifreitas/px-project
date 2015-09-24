(function() {
    'use strict';

    angular.module('pxNavBar', [])
        .value('pxNavBarConfig', {})
        .directive('pxNavBar', ['pxNavBarConfig', 'pxConfig', '$compile', '$parse', '$timeout', function(pxDataGridConfig, pxConfig, $compile, $parse, $timeout) {
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

                    // Inicializa menu
                    $timeout(scope.getNavBar, 1000);
                }
            };
        }])
        .controller('pxNavBarCtrl', ['pxConfig', '$scope', '$http', function(pxConfig, $scope, $http) {

            $scope.templates = [{
                name: '?.html',
                url: pxConfig.PX_PACKAGE + '?.html'
            }, {
                name: '',
                url: ''
            }];

            $scope.template = $scope.templates[1];

            $scope.navBar = '<div class="navbar-content px-no-radius"><a class="pull-menu" href=""></a><ul id="menu" class="element-menu px-no-radius"><span class="element bg-dark" title="">Por favor aguarde, carregando barra de navegação...</span><div class="element place-right px-pointer" ng-click="toggleRight()"><a class="element-menu"><span class="glyphicon glyphicon-option-vertical" aria-hidden="true"></span></a></div><span class="element-divider place-right"></span><button class="element image-button image-left place-right bg-dark">Phoenix Project - pxproject.com.br<img id="topMenuImgLogo" ng-src="{{logo}}" /></button></ul></div>';

            $scope.getNavBar = function() {

                var params = {};

                $http({
                    method: 'POST',
                    url: pxConfig.PX_PACKAGE + 'system/components/px-nav-bar/px-nav-bar.cfc?method=getNavBar',
                    params: params
                }).success(function(response) {
                    //console.info('getNavBar: ', response);                    
                    $scope.navBar = response.navBar;
                }).
                error(function(data, status, headers, config) {
                    // Erro
                    alert('Ops! Ocorreu um erro inesperado.\nPor favor contate o administrador do sistema!');
                });
            };

            $scope.showView = function(view) {

                var params = {};
                params.com_id = view;
                params.pathname = pxConfig.PROJECT_SRC; //document.location.pathname;
                params.pxProjectPackage = pxConfig.PX_PACKAGE;

                $http({
                    method: 'POST',
                    url: pxConfig.PX_PACKAGE + 'system/components/px-nav-bar/px-nav-bar.cfc?method=getView',
                    params: params
                }).success(function(result) {

                    var headerView = result.qView[0].MEN_NOMECAMINHO.split(result.qView[0].MEN_NOMECAMINHO.split('»')[result.qView[0].MEN_NOMECAMINHO.split('»').length - 1]);

                    $scope.view = {};
                    $scope.view.result = result;
                    $scope.view.men_id = result.qView[0].MEN_ID;
                    $scope.view.caminho = result.qView[0].MEN_NOMECAMINHO;
                    $scope.view.header = headerView[0];
                    $scope.view.titulo = result.qView[0].MEN_NOMECAMINHO.split('»')[result.qView[0].MEN_NOMECAMINHO.split('»').length - 1];
                    $scope.view.icon = result.qView[0].COM_ICON;

                    $scope.templates[1].name = result.qView[0].COM_VIEW;
                    $scope.templates[1].url = result.qView[0].COM_VIEW;

                }).
                error(function(data, status, headers, config) {
                    // Erro
                    alert('Ops! Ocorreu um erro inesperado.\nPor favor contate o administrador do sistema!');
                });
            };
        }]);
})();