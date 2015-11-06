define(['../../services/module'], function(services) {
    'use strict';

    services.factory('pxFormService', pxFormService);

    pxFormService.$inject = ['pxConfig', '$http'];

    function pxFormService(pxConfig, $http) {
        var service = {};

        service.insertUpdate = insertUpdate;
        service.select = select;

        return service;

        function insertUpdate(action, table, fields, oldForm, callback) {

            var params = {
                dsn: pxConfig.PROJECT_DSN,
                action: action,
                table: table,
                fields: fields,
                oldForm: oldForm
            };
            $http({
                method: 'POST',
                url: pxConfig.PX_PACKAGE + 'system/components/px-form/px-form.cfc?method=insertUpdate',
                params: params
            }).success(function(response) {
                callback(response);
            }).
            error(function(data, status, headers, config) {
                // Erro
                alert('Ops! Ocorreu um erro inesperado.\nPor favor contate o administrador do sistema!');
            });
        }

        function select(table, fields, callback) {

            var params = {
                dsn: pxConfig.PROJECT_DSN,
                table: table,
                fields: fields
            };
            $http({
                method: 'POST',
                url: pxConfig.PX_PACKAGE + 'system/components/px-form/px-form.cfc?method=select',
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