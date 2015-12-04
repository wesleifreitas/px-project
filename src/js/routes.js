define(['./app'], function(app) {
    'use strict';

    app.config(['pxConfig', '$routeProvider', '$locationProvider', '$mdThemingProvider', function(pxConfig, $routeProvider, $locationProvider, $mdThemingProvider) {
        $routeProvider.when('/login', {
            templateUrl: pxConfig.PX_PACKAGE + 'system/login/login.html',
            controller: 'LoginCtrl',
            controllerAs: 'vm'
        });
        $routeProvider.when('/home', {
            templateUrl: pxConfig.PX_PACKAGE + 'system/home/home.html',
            controller: 'HomeCtrl',
            controllerAs: 'vm'
        });
        $routeProvider.when('/', {
            templateUrl: pxConfig.PX_PACKAGE + 'system/home/home.html',
            controller: 'HomeCtrl',
            controllerAs: 'vm'
        });
        $routeProvider.otherwise({
            redirectTo: '/login'
        });

        // https://material.angularjs.org/latest/Theming/01_introduction
        $mdThemingProvider.theme('default')
            .primaryPalette('grey')
            .accentPalette('blue');
    }]);

    app.run(function(pxConfig, $rootScope, $location, $cookieStore, $http) {
        // Verifica se o login é obrigatório
        if (pxConfig.LOGIN_REQUIRED) {
            // manter usuário logado após atualização de página
            $rootScope.globals = $cookieStore.get('globals') || {};
            if ($rootScope.globals.currentUser) {
                $http.defaults.headers.common['Authorization'] = 'Basic ' + $rootScope.globals.currentUser.authdata; // jshint ignore:line
            }

            $rootScope.$on('$locationChangeStart', function(event, next, current) {
                // redirecionar para a página de login se não estiver logado e tentar acessar uma página restrita                
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