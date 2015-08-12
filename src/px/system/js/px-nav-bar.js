/**
 * Module pxNavBar
 */
angular.module('pxNavBar', [])
    .value('pxNavBarConfig', {

    })
    .directive('pxNavBar', ['pxNavBarConfig', function(pxGridConfig) {
        return {
            restrict: 'E',
            replace: true,
            transclude: false,
            templateUrl: pxProjectPackage() + 'px/system/view/navBar.cfm',
            link: function(scope, element, attrs) {

                scope.logo = pxProjectPackage() + 'px/system/assets/richsolutions/richsolutions_bola_200x200.jpg';
            }
        }
    }])
    .controller('pxNavBarCtrl', ['$scope', '$http', function($scope, $http) {
        $scope.templates =
            [{
                name: 'pxProjectAction.html',
                url: pxProjectPackage() + 'px/custom/view/pxProjectAction.html'
            }, {
                name: '',
                url: ''
            }];

        $scope.template = $scope.templates[1];

        //console.log($scope.template);

        $scope.apresentarView = function(componente) {

            var params = new Object();
            params.com_id = componente;
            params.pathname = document.location.pathname;
            params.pxProjectPackage = pxProjectPackage();

            $http({
                method: 'POST',
                url: pxProjectPackage() + 'px/system/model/navBar.cfc?method=getView',
                params: params
            }).success(function(result) {
                console.info(result);
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