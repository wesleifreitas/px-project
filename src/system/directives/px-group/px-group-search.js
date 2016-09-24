define(['../../directives/module'], function(directives) {
    'use strict';
    directives.directive('pxGroupSearch', ['pxConfig', function(pxConfig) {
        return {
            restrict: 'E',
            replace: true,
            templateUrl: pxConfig.PX_PACKAGE + 'system/directives/px-group/px-group-search.html',
            scope: {
                itemClick: '&pxItemClick'
            },
            link: function(scope, element, attrs) {},
            controller: ['$scope', '$timeout', function($scope, $timeout) {
                // Controle da listagem no formulário grupo
                $scope.dgGroupControl = {};
                // Inicializar listagem
                $scope.dgGroupInit = function() {

                };
                // Configurações da listagem
                $scope.dgGroupConfig = {
                    schema: 'dbo',
                    table: 'grupo',
                    fields: [{
                        pk: true,
                        title: 'Grupo',
                        field: 'grupo_id',
                        type: 'int',
                        identity: true
                    }, {
                        title: 'Nome',
                        field: 'grupo_nome',
                        type: 'varchar',
                        filter: 'filtro_grupo_nome',
                        filterOperator: '%LIKE%'
                    }]
                };
                // Atualizar listagem
                $scope.getDataGrupo = function() {
                    //Recuperar dados para a listagem
                    $scope.dgGroupControl.getData();
                };
                // Evento item click
                $scope.dgGroupItemClick = function(event) {
                    $scope.itemClick({
                        event: event
                    });
                };
            }]
        };
    }])
});