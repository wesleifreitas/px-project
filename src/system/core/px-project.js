(function () {

    app = angular.module('app', ['pxConfig', 'pxLoader', 'ngRoute', 'ngCookies', 'ngMaterial', 'ui.mask', 'pxNavBar', 'pxViewHeader', 'pxDataGrid', 'pxFormItem']);

    app.config(['pxConfig', '$routeProvider', '$locationProvider', function (pxConfig, $routeProvider, $locationProvider) {
        $routeProvider.when('/login', {
            templateUrl: pxConfig.PX_PACKAGE + 'system/login/login.html',
            controller: 'loginCtrl',
            controllerAs: 'vm'
        });
        $routeProvider.when('/home', {
            templateUrl: pxConfig.PX_PACKAGE + 'system/view/home.html',
            controller: 'homeCtrl',
            controllerAs: 'vm'
        });
        $routeProvider.when('/', {
            templateUrl: pxConfig.PX_PACKAGE + 'system/home/home.html',
            controller: 'homeCtrl',
            controllerAs: 'vm'
        });
        $routeProvider.otherwise({
            redirectTo: '/login'
        });


}]);

    app.config(function ($mdThemingProvider) {
        //red, pink, purple, deep-purple, indigo, blue, light-blue, cyan, teal, green, light-green, lime, yellow, amber, orange, deep-orange, brown, grey, blue-grey
        $mdThemingProvider.theme('default')
            .primaryPalette('grey')
            .accentPalette('blue');

        /*
        $mdThemingProvider.theme('darkTheme')
            .primaryPalette('blue')
        */
    });

    app.run(function ($rootScope, $location, $cookieStore, $http) {
        // keep user logged in after page refresh
        $rootScope.globals = $cookieStore.get('globals') || {};
        if ($rootScope.globals.currentUser) {
            $http.defaults.headers.common['Authorization'] = 'Basic ' + $rootScope.globals.currentUser.authdata; // jshint ignore:line
        }

        $rootScope.$on('$locationChangeStart', function (event, next, current) {
            // redirect to login page if not logged in and trying to access a restricted page
            var restrictedPage = $.inArray($location.path(), ['/login', '/register']) === -1;
            var loggedIn = $rootScope.globals.currentUser;
            if (restrictedPage && !loggedIn) {
                $location.path('/login');
            }
        });
    });
})();
