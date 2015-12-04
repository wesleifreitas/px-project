define(['../controllers/module'], function(controllers) {
    'use strict';

    controllers.controller('LoginCtrl', ['pxCssLoader', '$scope', '$location', 'AuthenticationService', 'FlashService', function(pxCssLoader, $scope, $location, AuthenticationService, FlashService) {

        pxCssLoader.load();

        var vm = this;

        vm.formTitle = 'Phoenix Project';
        vm.loginMessage = '';

        vm.initController = function initController() {
            // reset login status
            AuthenticationService.ClearCredentials();
        }();

        vm.login = function login() {
            if (vm.selection === 'default') {
                vm.dataLoading = true;
                AuthenticationService.Login(vm.username, vm.password, function(response) {
                    vm.loginMessage = response.message;
                    console.info(response);
                    if (response.success) {
                        if (response.qQuery[0].USU_MUDARSENHA === 1) {
                            vm.formTitle = "Alteração de senha";
                            vm.selection = 'redefine';
                            vm.id = response.qQuery[0].USU_ID;
                            return;
                        }
                        AuthenticationService.SetCredentials(vm.username, vm.password, response);
                        $location.path('/');
                    } else {
                        FlashService.Error(response.message);
                        vm.dataLoading = false;

                        $('#loginDiv').effect('shake', {
                            direction: 'left',
                            distance: 10,
                            times: 3
                        });
                    }
                });
            }
        };

        vm.recover = function recover() {
            vm.dataLoading = true;
            alert('recover');
        };

        vm.redefine = function redefine() {
            vm.dataLoading = true;

            AuthenticationService.Redefine(vm.id, vm.username, vm.usu_senha, function(response) {
                if (response.success) {
                    AuthenticationService.SetCredentials(vm.username, vm.password, response);
                    $location.path('/');
                } else {
                    vm.loginMessage = response.message;
                    FlashService.Error(response.message);
                    vm.dataLoading = false;

                    $('#loginDiv').effect('shake', {
                        direction: 'left',
                        distance: 10,
                        times: 3
                    });
                }
            });
        };

        vm.redefineForm = function redefine() {
            // Validar senha atual
            if (String(vm.password) !== String(vm.usu_senha_atual)) {
                $scope.loginForm.usu_senha_atual.$setValidity('confirm', false);
            } else {
                $scope.loginForm.usu_senha_atual.$setValidity('confirm', true);
            }

            // Validar nova senha            
            if (String(vm.usu_senha) === String(vm.password)) {
                $scope.loginForm.usu_senha.$setValidity('equal', false);
            } else {
                $scope.loginForm.usu_senha.$setValidity('equal', true);

                if (String(vm.usu_senha) !== String(vm.usu_senha_confirmar)) {
                    $scope.loginForm.usu_senha_confirmar.$setValidity('confirm', false);
                } else {
                    $scope.loginForm.usu_senha_confirmar.$setValidity('confirm', true);
                }
            }
        };

        vm.recover = function redefine() {
            vm.dataLoading = true;
            AuthenticationService.Recover(vm.username, vm.email, function(response) {
                if (response.success) {
                    alert('Foi enviado um e-mail para ' + vm.email + ' com as instruções de recuperação de login');
                    vm.showLogin();
                } else {
                    vm.loginMessage = response.message;
                    FlashService.Error(response.message);
                    vm.dataLoading = false;

                    $('#loginDiv').effect('shake', {
                        direction: 'left',
                        distance: 10,
                        times: 3
                    });
                }
            });
        };

        vm.showRecover = function showRecover() {
            vm.password = '';
            vm.loginMessage = '';
            vm.formTitle = "Esqueci minha senha";
            vm.selection = 'recover';
        };

        vm.showLogin = function showLogin() {
            vm.password = '';
            vm.email = '';
            vm.usu_senha_atual = ''
            vm.usu_senha = '';
            vm.usu_senha_confirmar = ''
            vm.loginMessage = '';
            vm.formTitle = "Login";
            vm.selection = 'default';
        };

        vm.selection = 'default';
    }]);
});