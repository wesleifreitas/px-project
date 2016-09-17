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

            var data = {
                dsn: pxConfig.PROJECT_DSN,
                cfcPath: pxConfig.PX_CFC_PATH,
                action: action,
                table: table,
                fields: fields,
                oldForm: oldForm
            };
            $http({
                method: 'POST',
                url: '../../../rest/px-project/system/px-form/insertUpdate',
                data: data
            }).then(function successCallback(response) {
                callback(response);
            }, function errorCallback(response) {
                alert('Ops! Ocorreu um erro inesperado.\nPor favor contate o administrador do sistema!');
            });
            return;
            $http({
                method: 'POST',
                url: pxConfig.PX_PACKAGE + 'system/directives/px-form/px-form.cfc?method=insertUpdate',
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

            var data = {
                dsn: pxConfig.PROJECT_DSN,
                cfcPath: pxConfig.PX_CFC_PATH,
                table: table,
                fields: fields,                
            };

            $http({
                method: 'POST',
                url: '../../../rest/px-project/system/px-form/getData',
                data: data
            }).then(function successCallback(response) {
                callback(response);
            }, function errorCallback(response) {
                alert('Ops! Ocorreu um erro inesperado.\nPor favor contate o administrador do sistema!');
            });            
        }
    }
});