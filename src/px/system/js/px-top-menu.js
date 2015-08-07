/**
 * Module pxTopMenu
 */
angular.module('pxTopMenu', [])
    .value('pxTopMenuConfig', {

    })
    .directive('pxTopMenu', ['pxTopMenuConfig', function(pxGridConfig) {
        return {
            restrict: 'E',
            replace: true,
            transclude: false,
            templateUrl: pxProjectPackage() + 'px/system/view/topMenu.cfm',
            link: function(scope, element, attrs) {

                scope.logo = pxProjectPackage() + 'px/system/assets/richsolutions/richsolutions_bola_200x200.jpg';
            }
        }
    }])
    .controller('pxTopMenuCtrl', ['$scope', '$http', function($scope, $http) {
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
                url: pxProjectPackage() + 'px/system/model/menu.cfc?method=recuperaComponente',
                params: params
            }).success(function(result) {
                var headerView = result.QCOMPONENTE[0].MEN_NOMECAMINHO.split(result.QCOMPONENTE[0].MEN_NOMECAMINHO.split('»')[result.QCOMPONENTE[0].MEN_NOMECAMINHO.split('»').length - 1])

                $scope.view = new Object();
                $scope.view.result = result;
                $scope.view.men_id = result.QCOMPONENTE[0].MEN_ID;
                $scope.view.caminho = result.QCOMPONENTE[0].MEN_NOMECAMINHO;
                $scope.view.header = headerView[0];
                $scope.view.titulo = result.QCOMPONENTE[0].MEN_NOMECAMINHO.split('»')[result.QCOMPONENTE[0].MEN_NOMECAMINHO.split('»').length - 1];
                $scope.view.icon = result.QCOMPONENTE[0].COM_ICON;

                $scope.templates[1].name = result.QCOMPONENTE[0].COM_VIEW;
                $scope.templates[1].url = result.QCOMPONENTE[0].COM_VIEW;

            }).
            error(function(data, status, headers, config) {
                // Erro
                alert('Ops! Ocorreu um erro inesperado.\nPor favor contate o administrador do sistema!');
            });
        }
    }]);