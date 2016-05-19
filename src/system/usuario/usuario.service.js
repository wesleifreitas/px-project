define(['../services/module'], function(services) {
    'use strict';

    services.factory('usuarioService', usuarioService);

    usuarioService.$inject = ['pxConfig', 'pxArrayUtil', '$http'];

    function usuarioService(pxConfig, pxArrayUtil, $http) {

        var service = {};

        service.status = status;
        service.sendEmail = sendEmail;

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
                    name: 'Bloqueado',
                    id: 2
                }, {
                    name: 'Ativo',
                    id: 1
                }, {
                    name: 'Inativo',
                    id: 0
                }];
            } else {
                arrayData = [{
                    name: 'Bloqueado',
                    id: 2
                }, {
                    name: 'Ativo',
                    id: 1
                }, {
                    name: 'Inativo',
                    id: 0
                }];
            }

            return arrayData.sort(pxArrayUtil.sortOn('id'));
        }

        function sendEmail(email, nome, callback) {
            var params = {
                email: email,
                nome: nome
            };
            $http({
                method: 'POST',
                url: pxConfig.PX_PACKAGE + '/system/usuario/usuario.cfc?method=sendEmail',
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