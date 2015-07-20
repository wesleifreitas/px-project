'use strict';

app.controller('loginCtrl', ['$scope', 'loginService', function($scope, loginService) {

	$scope.login = function(data) {

		//console.log('login');
		//console.log(data);

		if (data.usuario != '') {

			loginService.login(data, $scope); // Chama serviço de login
		}

	};
}]);