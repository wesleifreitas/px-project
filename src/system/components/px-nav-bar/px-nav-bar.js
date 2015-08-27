(function () {
    'use strict';

    angular.module('pxNavBar', [])
        .value('pxNavBarConfig', {})
        .directive('pxNavBar', ['pxNavBarConfig', 'pxConfig', function (pxDataGridConfig, pxConfig) {
            return {
                restrict: 'E',
                replace: true,
                transclude: false,
                templateUrl: pxConfig.PX_PACKAGE + 'system/components/px-nav-bar/px-nav-bar.cfm',
                link: function (scope, element, attrs) {

                    scope.logo = pxConfig.PX_PACKAGE + 'system/assets/richsolutions/richsolutions_bola_200x200.jpg';
                }
            };
    }])
        .controller('pxNavBarCtrl', ['pxConfig', '$scope', '$http', function (pxConfig, $scope, $http) {
            $scope.templates = [{
                name: '?.html',
                url: pxConfig.PX_PACKAGE + '?.html'
            }, {
                name: '',
                url: ''
            }];

            $scope.template = $scope.templates[1];

            //console.log($scope.template);

            $scope.showView = function (view) {

                var params = {};
                params.com_id = view;
                params.pathname = pxConfig.PROJECT_SRC; //document.location.pathname;
                params.pxProjectPackage = pxConfig.PX_PACKAGE;

                $http({
                    method: 'POST',
                    url: pxConfig.PX_PACKAGE + 'system/components/px-nav-bar/px-nav-bar.cfc?method=getView',
                    params: params
                }).success(function (result) {

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
                error(function (data, status, headers, config) {
                    // Erro
                    alert('Ops! Ocorreu um erro inesperado.\nPor favor contate o administrador do sistema!');
                });
            };
    }]);
})();
