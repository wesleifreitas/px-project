(function () {
    'use strict';

    app.controller('loginCtrl', ['$location', 'AuthenticationService', 'FlashService', function ($location, AuthenticationService, FlashService) {

        var vm = this;

        vm.initController = function initController() {
            // reset login status
            AuthenticationService.ClearCredentials();
        }();


        vm.login = function login() {
            vm.dataLoading = true;
            AuthenticationService.Login(vm.username, vm.password, function (response) {
                if (response.success) {
                    AuthenticationService.SetCredentials(vm.username, vm.password);
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
        };
    }]);
})();
