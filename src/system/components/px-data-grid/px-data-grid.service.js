define(['../../services/module'], function(services) {
    'use strict';

    services.factory('pxDataGridService', pxDataGridService);

    pxDataGridService.$inject = ['pxConfig', '$http', '$rootScope'];

    function pxDataGridService(pxConfig, $http, $rootScope) {
        var service = {};

        service.select = select;
        service.remove = remove;

        return service;

        function select(data, callback) {

            data.dsn = pxConfig.PROJECT_DSN;
            data.cfcPath = pxConfig.PX_CFC_PATH;
            data.user = $rootScope.globals.currentUser.usu_id;            
            
            if(!angular.isDefined(data.orderBy)){
                data.orderBy = '';
            }

            if(!angular.isDefined(data.groupItem)){
                data.groupItem = '';
            }

            if(!angular.isDefined(data.groupLabel)){
                data.groupLabel = '';
            }

            if(!angular.isDefined(data.where)){
                data.where = '';
            }

            $http({
                method: 'POST',
                url: 'http://localhost:8500/rest/px-project/system/px-data-grid/getData',
                data: data
            }).then(function successCallback(response) {
                callback(response);
            }, function errorCallback(response) {
                alert('Ops! Ocorreu um erro inesperado.\nPor favor contate o administrador do sistema!');
            });
        }

        function remove(data, callback) {

            data.dsn = pxConfig.PROJECT_DSN;
            data.cfcPath = pxConfig.PX_CFC_PATH;
            data.user = $rootScope.globals.currentUser.usu_id;            

            $http({
                method: 'POST',
                url: 'http://localhost:8500/rest/px-project/system/px-data-grid/removeData',
                data: data
            }).then(function successCallback(response) {
                callback(response);
            }, function errorCallback(response) {
                alert('Ops! Ocorreu um erro inesperado.\nPor favor contate o administrador do sistema!');
            });
        }
    }
});