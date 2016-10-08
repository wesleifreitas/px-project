define(['./app'], function(app) {
    'use strict';

    app.config(['pxConfig', '$routeProvider', '$stateProvider', '$urlRouterProvider', '$locationProvider', '$mdThemingProvider', function(pxConfig, $routeProvider, $stateProvider, $urlRouterProvider, $locationProvider, $mdThemingProvider) {

        // Package Phoenix Project
        var PX_PACKAGE = '';

        angular.extend(pxConfig, {
            PX_PACKAGE: PX_PACKAGE, // Package Phoenix Project
            LIB: 'lib/', // Componentes externos
            PROJECT_ID: 0, // Identificação do projeto (table: px.project)
            PROJECT_NAME: 'Phoenix Project', // Nome do projeto
            PROJECT_SRC: 'px-project/src/', // Source do projeto
            PROJECT_CSS: [
                PX_PACKAGE + 'system/login/login.css',
                PX_PACKAGE + 'system/core/external/jstree/themes/proton/style.css',
                'lib/bootstrap/dist/css/bootstrap.min.css',
                'lib/angular-material/angular-material.min.css',
                'https://fonts.googleapis.com/icon?family=Material+Icons',
                'https://fonts.googleapis.com/css?family=RobotoDraft:300,400,500,700,400italic',
                'lib/font-awesome/css/font-awesome.min.css',
                'lib/px-module/dist/px-full/px-full.min.css',
                'styles.css'
            ], // Arquivos .css

            PROJECT_DSN: 'px_project_sql', // Data Source Name (CF)
            LOCALE: 'pt-BR', // Locale
            LOGIN_REQUIRED: true, // Login obrigatório?
            GROUP: true, // Agrupar dados?
            GROUP_TABLE: 'grupo', // Tabela Group
            GROUP_ITEM_SUFFIX: '', // Sufixo do campo GROUP_ITEM
            GROUP_LABEL_SUFFIX: '', // Sufixo do campo GROUP_LABEL
            GROUP_REPLACE: [], // Substituir no nome do campo GROUP
            GROUP_ITEM: 'grupo_id', // Idetificador de GROUP (Utilizar quando GROUP_ITEM_SUFFIX === '')
            GROUP_LABEL: 'grupo_nome' // Label do GROUP (Utilizar quando GROUP_LABEL_SUFFIX === '')
        });

        // For any unmatched url, redirect to /state1
        $urlRouterProvider.otherwise("/login");

        $stateProvider
            .state('login', {
                url: "/login",
                templateUrl: pxConfig.PX_PACKAGE + 'system/login/login.cfm',
                controller: 'LoginCtrl',
                controllerAs: 'vm'
            })
            .state('home', {
                url: "/home",
                templateUrl: pxConfig.PX_PACKAGE + 'system/home/home.cfm',
                controller: 'HomeCtrl',
                controllerAs: 'vm'
            }).state('home.perfil', {
                url: '/perfil',
                templateUrl: pxConfig.PX_PACKAGE + 'system/perfil/perfil.html',
            }).state('home.usuario', {
                url: '/usuario',
                templateUrl: pxConfig.PX_PACKAGE + 'system/usuario/usuario.html',
            })
            .state('home.exemplo', {
                url: '/exemplo',
                templateUrl: 'custom/exemplo/exemplo.html'
            });

        // https://material.angularjs.org/latest/Theming/01_introduction
        // Available palettes: red, pink, purple, deep-purple, indigo, blue, light-blue, cyan, teal, green, light-green, lime, yellow, amber, orange, deep-orange, brown, grey, blue-grey
        $mdThemingProvider.theme('default')
            .primaryPalette('blue-grey')
            .accentPalette('grey');
    }]);

    app.run(function(pxConfig, $rootScope, $location, $cookieStore, $http, loginService) {
        // Verifica se o login é obrigatório
        if (pxConfig.LOGIN_REQUIRED) {
            // Manter usuário logado após atualização de página
            $rootScope.globals = $cookieStore.get('globals') || {};
            if ($rootScope.globals.currentUser) {
                $http.defaults.headers.common['Authorization'] = 'Basic ' + $rootScope.globals.currentUser.authdata; // jshint ignore:line
            }

            $rootScope.$on('$locationChangeStart', function(event, next, current) {
                /*if ($.inArray($location.path(), ['/login', '/register']) > -1) {} else {
                    // Verificar SESSION
                    loginService.LoggedIn(function(response) {
                        if (!response.loggedIn) {
                            $location.path('/login');
                        }
                    });
                }*/

                // Redirecionar para a página de login se não estiver logado e tentar acessar uma página restrita                
                var restrictedPage = $.inArray($location.path(), ['/login', '/register']) === -1;
                var loggedIn = $rootScope.globals.currentUser;
                if (restrictedPage && !loggedIn) {
                    $location.path('/login');
                } else if (restrictedPage && loggedIn && $location.path() === '/home') {
                    // Redirecionar para primeira tela (exemplo)
                    $location.path('/home/exemplo');
                }
            });
        } else {
            $rootScope.globals = {
                currentUser: {
                    username: '',
                    authdata: null
                }
            };
        }
    });

    return app;
});