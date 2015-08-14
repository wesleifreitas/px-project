/**
 * Module pxNavBar
 */
angular.module('pxNavBar', [])
    .value('pxNavBarConfig', {

    })
    .directive('pxNavBar', ['pxNavBarConfig', 'pxConfig', function(pxGridConfig, pxConfig) {
        return {
            restrict: 'E',
            replace: true,
            transclude: false,
            templateUrl: pxConfig.PX_PACKAGE + 'px/system/view/navBar.cfm',
            link: function(scope, element, attrs) {

                scope.logo = pxConfig.PX_PACKAGE + 'px/system/assets/richsolutions/richsolutions_bola_200x200.jpg';
            }
        }
    }])
    .controller('pxNavBarCtrl', ['pxConfig', '$scope', '$http', function(pxConfig, $scope, $http) {
        $scope.templates =
            [{
                name: 'pxProjectAction.html',
                url: pxConfig.PX_PACKAGE + 'px/custom/view/pxProjectAction.html'
            }, {
                name: '',
                url: ''
            }];

        $scope.template = $scope.templates[1];

        //console.log($scope.template);

        $scope.showView = function(componente) {

            var params = new Object();
            params.com_id = componente;
            params.pathname = document.location.pathname;
            params.pxProjectPackage = pxConfig.PX_PACKAGE;

            $http({
                method: 'POST',
                url: pxConfig.PX_PACKAGE + 'px/system/model/navBar.cfc?method=getView',
                params: params
            }).success(function(result) {

                var headerView = result.qComponente[0].MEN_NOMECAMINHO.split(result.qComponente[0].MEN_NOMECAMINHO.split('»')[result.qComponente[0].MEN_NOMECAMINHO.split('»').length - 1])

                $scope.view = new Object();
                $scope.view.result = result;
                $scope.view.men_id = result.qComponente[0].MEN_ID;
                $scope.view.caminho = result.qComponente[0].MEN_NOMECAMINHO;
                $scope.view.header = headerView[0];
                $scope.view.titulo = result.qComponente[0].MEN_NOMECAMINHO.split('»')[result.qComponente[0].MEN_NOMECAMINHO.split('»').length - 1];
                $scope.view.icon = result.qComponente[0].COM_ICON;

                $scope.templates[1].name = result.qComponente[0].COM_VIEW;
                $scope.templates[1].url = result.qComponente[0].COM_VIEW;

            }).
            error(function(data, status, headers, config) {
                // Erro
                alert('Ops! Ocorreu um erro inesperado.\nPor favor contate o administrador do sistema!');
            });
        }
    }]);