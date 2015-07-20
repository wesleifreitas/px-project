var app = angular.module('pxProjectApp', ['ngRoute', 'ngSanitize', 'ngMaterial']);


app.config(['$routeProvider', function($routeProvider) {
    $routeProvider.when('/login', {
        templateUrl: pxProjectPackage() + 'px/system/view/login.html',
        controller: 'loginCtrl'
    });
    $routeProvider.when('/home', {
        templateUrl: pxProjectPackage() + 'px/system/view/home.html',
        controller: 'homeCtrl'
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

/*
app.run(function($rootScope, $location, loginService){
    var routespermission=['/home'];  //route that require login
    $rootScope.$on('$routeChangeStart', function(){
        if( routespermission.indexOf($location.path()) !=-1)
        {
            var connected=loginService.islogged();
            connected.then(function(msg){
                if(!msg.data) $location.path('/login');
            });
        }
    });
});
*/