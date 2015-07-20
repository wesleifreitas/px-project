'use strict';

app.controller('homeCtrl', ['$scope', 'loginService', function($scope, loginService) {

	$scope.logout = function() {
		loginService.logout();
	}

}])