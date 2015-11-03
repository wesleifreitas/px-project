define(['../../services/module'], function(services) {
    'use strict';

    services.factory('pxFormService', pxFormService);

    pxFormService.$inject = ['pxConfig', '$http'];

    function pxFormService(pxConfig, $http) {
        var service = {};

        service.insert = insert;

        return service;

        function insert(table, pk, fields, callback) {

            var params = {
                dsn: pxConfig.PROJECT_DSN,
                table: table,
                pk: pk,
                fields: fields
            };
            $http({
                method: 'POST',
                url: pxConfig.PX_PACKAGE + 'system/components/px-form/px-form.cfc?method=insert',
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