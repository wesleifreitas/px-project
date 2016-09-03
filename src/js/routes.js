define(['./app'], function(app) {
    'use strict';

    app.config(['pxConfig', '$routeProvider', '$stateProvider', '$urlRouterProvider', '$locationProvider', '$mdThemingProvider', function(pxConfig, $routeProvider, $stateProvider, $urlRouterProvider, $locationProvider, $mdThemingProvider) {

        // Package Phoenix Project
        var PX_PACKAGE = '';
        // Caminho de componentes ColdFusion (Phoenix Project)
        // Ex.: 'my-project.src'
        var PX_CFC_PATH = 'px-project.src' + PX_PACKAGE.replace(/\/|\\/g, ".");

        angular.extend(pxConfig, {
            PX_PACKAGE: PX_PACKAGE, // Package Phoenix Project
            PX_CFC_PATH: PX_CFC_PATH,
            LIB: 'lib/', // Componentes externos
            PROJECT_ID: 0, // Identificação do projeto (table: px.project)
            PROJECT_NAME: 'Phoenix Project', // Nome do projeto
            PROJECT_SRC: 'px-project/src/', // Source do projeto
            PROJECT_CSS: [
                PX_PACKAGE + 'system/login/login.css',
                'lib/bootstrap/dist/css/bootstrap.min.css',
                'lib/angular-material/angular-material.min.css',
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

        if (pxConfig.PX_PACKAGE !== '') {
            pxConfig.PX_PACKAGE += '/';
        }

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
            })
            .state('home.exemplo', {
                url: '/exemplo',
                templateUrl: 'custom/exemplo/exemplo.html'
            })
            /*
            $routeProvider.when('/login', {
                templateUrl: pxConfig.PX_PACKAGE + 'system/login/login.cfm',
                controller: 'LoginCtrl',
                controllerAs: 'vm'
            });
            $routeProvider.when('/home', {
                templateUrl: pxConfig.PX_PACKAGE + 'system/home/home.cfm',
                controller: 'HomeCtrl',
                controllerAs: 'vm'
            });
            $routeProvider.when('/', {
                templateUrl: pxConfig.PX_PACKAGE + 'system/home/home.cfm',
                controller: 'HomeCtrl',
                controllerAs: 'vm'
            });
            $routeProvider.otherwise({
                redirectTo: '/login'
            });
            */
            // https://material.angularjs.org/latest/Theming/01_introduction
            // Available palettes: red, pink, purple, deep-purple, indigo, blue, light-blue, cyan, teal, green, light-green, lime, yellow, amber, orange, deep-orange, brown, grey, blue-grey
        $mdThemingProvider.theme('default')
            .primaryPalette('blue-grey')
            .accentPalette('grey');
    }]);

    app.run(function(pxConfig, $rootScope, $location, $cookieStore, $http, AuthenticationService) {
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
                    AuthenticationService.LoggedIn(function(response) {
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