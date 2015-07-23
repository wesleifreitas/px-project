var app = angular.module('app', ['ngRoute', 'ngCookies', 'ngSanitize', 'ngMaterial']);

app.config(['$routeProvider', function($routeProvider, $locationProvider) {
    $routeProvider.when('/login', {
        templateUrl: pxProjectPackage() + 'px/system/view/login.html',
        controller: 'loginCtrl',
        controllerAs: 'vm'
    });
    $routeProvider.when('/home', {
        templateUrl: pxProjectPackage() + 'px/system/view/home.html',
        controller: 'homeCtrl',
        controllerAs: 'vm'
    });
    $routeProvider.when('/', {
        templateUrl: pxProjectPackage() + 'px/system/view/home.html',
        controller: 'homeCtrl',
        controllerAs: 'vm'
    });
    $routeProvider.otherwise({
        redirectTo: '/login'
    });


}]);

app.config(function($mdThemingProvider) {
    //red, pink, purple, deep-purple, indigo, blue, light-blue, cyan, teal, green, light-green, lime, yellow, amber, orange, deep-orange, brown, grey, blue-grey
    $mdThemingProvider.theme('default')
        .primaryPalette('grey')
        .accentPalette('blue');

    $mdThemingProvider.theme('darkTheme')
        .primaryPalette('blue')
});

app.controller('homeCtrl2', function($scope, $timeout, $mdSidenav, $mdUtil, $log) {
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
                        $log.debug("toggle " + navID + " is done");
                    });
            }, 300);
            return debounceFn;
        }
    })
    .controller('LeftCtrl', function($scope, $timeout, $mdSidenav, $log) {
        $scope.close = function() {
            $mdSidenav('left').close()
                .then(function() {
                    $log.debug("close LEFT is done");
                });
        };
    })
    .controller('RightCtrl', function($scope, $timeout, $mdSidenav, $log) {
        $scope.close = function() {
            $mdSidenav('right').close()
                .then(function() {
                    $log.debug("close RIGHT is done");
                });
        };
    });

app.run(function($rootScope, $location, $cookieStore, $http) {
    // keep user logged in after page refresh
    $rootScope.globals = $cookieStore.get('globals') || {};
    if ($rootScope.globals.currentUser) {
        $http.defaults.headers.common['Authorization'] = 'Basic ' + $rootScope.globals.currentUser.authdata; // jshint ignore:line
    }

    $rootScope.$on('$locationChangeStart', function(event, next, current) {
        // redirect to login page if not logged in and trying to access a restricted page
        var restrictedPage = $.inArray($location.path(), ['/login', '/register']) === -1;
        var loggedIn = $rootScope.globals.currentUser;
        if (restrictedPage && !loggedIn) {
            $location.path('/login');
        }
    });
});