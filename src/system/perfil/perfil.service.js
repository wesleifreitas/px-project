define(['../services/module'], function(services) {
    'use strict';

    services.factory('perfilService', perfilService);

    perfilService.$inject = ['pxConfig', 'pxArrayUtil', '$http', '$rootScope'];

    function perfilService(pxConfig, pxArrayUtil, $http, $rootScope) {

        var service = {};

        service.status = status;
        service.jsTreeMenu = jsTreeMenu;
        service.saveTreeMenu = saveTreeMenu;

        return service;

        /**
         * '[status description]'
         * @param  {[type]} showAll [description]
         * @return {[type]}         [description]
         */
        function status(showAll) {

            var arrayData = [];

            if (showAll) {
                arrayData = [{
                    name: 'Todos',
                    id: '%'
                }, {
                    name: 'Ativo',
                    id: 1
                }, {
                    name: 'Inativo',
                    id: 0
                }];
            } else {
                arrayData = [{
                    name: 'Ativo',
                    id: 1
                }, {
                    name: 'Inativo',
                    id: 0
                }];
            }

            return arrayData.sort(pxArrayUtil.sortOn('id'));
        }

        /**
         * Construir jsTreeMenu com base nas permissões de acesso de menus (dbo.acesso)
         * @param  {[Number}  id       id do perfil
         * @param  {Function} callback função callback
         * @return {Void}            
         */
        function jsTreeMenu(id, callback) {
            var params = {
                dsn: pxConfig.PROJECT_DSN,
                user: $rootScope.globals.currentUser.usu_id,
                id: id,
                pro_id: pxConfig.PROJECT_ID
            };
            $http({
                method: 'POST',
                url: pxConfig.PX_PACKAGE + 'system/perfil/perfil.cfc?method=jsTreeMenu',
                params: params
            }).success(function(response) {
                callback(response);
            }).
            error(function(data, status, headers, config) {
                // Erro
                alert('Ops! Ocorreu um erro inesperado.\nPor favor contate o administrador do sistema!');
            });
        }

        function saveTreeMenu(id, data, callback) {
            var params = {
                dsn: pxConfig.PROJECT_DSN,
                user: $rootScope.globals.currentUser.usu_id,
                id: id,
                data: angular.toJson(data)
            };
            $http({
                method: 'POST',
                url: pxConfig.PX_PACKAGE + 'system/perfil/perfil.cfc?method=saveTreeMenu',
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