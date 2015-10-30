define(['../../services/module'], function(services) {
    'use strict';

    services.factory('pxDataGridService', pxDataGridService);

    pxDataGridService.$inject = ['pxConfig', '$http'];

    function pxDataGridService(pxConfig, $http) {
        var service = {};

        service.remove = remove;

        return service;

        function remove(table, fields, selectedItems, callback) {

            var params = {
                dsn: pxConfig.PROJECT_DSN,
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