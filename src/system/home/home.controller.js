define(['../controllers/module'], function(controllers) {
    'use strict';

    controllers.controller('HomeCtrl', ['pxConfig', 'pxCssLoader', 'AuthenticationService', '$rootScope', '$scope', '$location', '$timeout', '$mdSidenav', '$mdUtil', '$mdDialog', '$log', '$locale', function(pxConfig, pxCssLoader, AuthenticationService, $rootScope, $scope, $location, $timeout, $mdSidenav, $mdUtil, $mdDialog, $log, $locale) {

            pxCssLoader.load();

            $scope.menus = [{
                name: 'Exemplo', // Nome do ícone
                title: 'Phoenix » View - Exemplo', // Título do dialog
                icon: 'glyphicon glyphicon-education home-icon', // Ícone
                view: 'custom/exemplo/exemplo.html' // Tela
            }];

            $scope.iconShowView = function iconShowView(event, menu) {
                if (angular.isDefined(menu.view)) {
                    // Inicializar título do formulário      
                    $scope.formTitle = menu.title;
                    $mdDialog.show({
                        scope: $scope,
                        preserveScope: true,
                        templateUrl: menu.view,
                        parent: angular.element(document.body),
                        targetEvent: event,
                        clickOutsideToClose: false
                    });
                } else {
                    alert('Função não disponível no momento')
                        /*            
                        $mdDialog.show'(
                            $mdDialog.alert()
                            .parent(angular.element(document.body))
                            .clickOutsideToClose(true)
                            .title('Aviso')
                            .textContent('Função não disponível no momento.')
                            .ariaLabel('')
                            .ok('Fechar')
                            .targetEvent(ev)
                        );
                        */
                }
            }

            if (pxConfig.LOCALE) {

                // Carrega moment.js como moment
                require(['moment'], function(moment) {
                    moment.locale(pxConfig.LOCALE);
                });

                // Definir language da lib numeral.js
                // http://numeraljs.com/                                                               
                numeral.language(pxConfig.LOCALE.toLowerCase());
            }

            var vm = this;

            vm.user = null;
            vm.allUsers = [];

            vm.loadCurrentUser = function loadCurrentUser() {
                /*
                UserService.GetByUsername($rootScope.globals.currentUser.username)
                    .then(function(user) {
                        vm.user = user;
                    });
                */
            };

            vm.loadAllUsers = function loadAllUsers() {
                /*
                UserService.GetAll()
                    .then(function(users) {
                        vm.allUsers = users;
                    });
                */
            };

            vm.deleteUser = function deleteUser(id) {
                /*
                UserService.Delete(id)
                    .then(function() {
                        vm.loadAllUsers();
                    });
                */
            };

            vm.initController = function initController() {
                /*
                vm.loadCurrentUser();
                vm.loadAllUsers();
                */
            }();

            $scope.toggleLeft = buildToggler('left');
            $scope.toggleRight = buildToggler('right');
            /**
             * Build handler to open/close a SideNav; when animation finishes
             * report completion in console
             */
            function buildToggler(navID) {
                var debounceFn = $mdUtil.debounce(function() {
                    $mdSidenav(navID)
                        .toggle()
                        .then(function() {
                            //$log.debug("toggle " + navID + " is done");
                        });
                }, 300);
                return debounceFn;
            }

            // Sair do sistema
            $scope.logout = function logout() {
                AuthenticationService.Logout(function(response) {
                    //console.info(response);
                })
                $location.path('/login');
            };

            if (navigator.userAgent.toLowerCase().search(/(android|avantgo|blackberry|bolt|boost|cricket|docomo|fone|hiptop|mini|mobi|palm|phone|pie|tablet|up\.browser|up\.link|webos|wos)/i) != -1) {
                $('html').click(function() {
                    // "Minimizar" menu
                    document.getElementById("menu").style.display = "none";
                });

                $('#menu').click(function(event) {
                    event.stopPropagation();
                });
            }
        }])
        .controller('LeftCtrl' ['$scope', '$timeout', '$mdSidenav', '$log', function($scope, $timeout, $mdSidenav, $log) {
            $scope.close = function() {
                $mdSidenav('left').close()
                    .then(function() {
                        //$log.debug("close LEFT is done");
                    });
            };
        }])
        .controller('RightCtrl', ['$scope', '$timeout', '$mdSidenav', '$log', function($scope, $timeout, $mdSidenav, $log) {
            $scope.close = function() {
                $mdSidenav('right').close()
                    .then(function() {
                        //$log.debug("close RIGHT is done");
                    });
            };
        }]);
});