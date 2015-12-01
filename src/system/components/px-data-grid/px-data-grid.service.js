define(['../../services/module'], function(services) {
    'use strict';

    services.factory('pxDataGridService', pxDataGridService);

    pxDataGridService.$inject = ['pxConfig', '$http', '$rootScope'];

    function pxDataGridService(pxConfig, $http, $rootScope) {
        var service = {};

        service.select = select;
        service.remove = remove;

        return service;

        function select(params, callback) {
            params.dsn = pxConfig.PROJECT_DSN;
            params.user = $rootScope.globals.currentUser.usu_id;

            $http({
                method: 'POST',
                url: pxConfig.PX_PACKAGE + 'system/components/px-data-grid/px-data-grid.cfc?method=getData',
                dataType: 'json',
                params: params
            }).success(function(response) {
                callback(response);
            }).
            error(function(data, status, headers, config) {
                // Erro
                alert('Ops! Ocorreu um erro inesperado.\nPor favor contate o administrador do sistema!');
            });

        }

        function remove(table, fields, selectedItems, callback) {

            var params = {
                dsn: pxConfig.PROJECT_DSN,
                user: $rootScope.globals.currentUser.usu_id,
                table: table,
                fields: fields,
                selectedItems: selectedItems
            };
            $http({
                method: 'POST',
                url: pxConfig.PX_PACKAGE + 'system/components/px-data-grid/px-data-grid.cfc?method=removeData',
                params: params
            }).success(function(response) {
                callback(response);
            }).
            error(function(data, status, headers, config) {
                // Erro
                alert('Ops! Ocorreu um erro inesperado.\nPor favor contate o administrador do sistema!');
            });
        }
    }
});