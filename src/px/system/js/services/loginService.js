'use strict';
app.factory('loginService', function($http, $location, sessionService) {
	return {
		login: function(data, scope) {

			// https://docs.angularjs.org/api/ng/service/$http
			$http({
				method: 'POST',
				url: pxProjectPackage() + 'px/system/model/login.cfc?method=login',
				params: data
			}).success(function(result) {

				// login válido
				if (result.length == 1) {

					console.log('loginService: login válido');
					console.log(result);
					console.log(Array(result).length);

					$location.path('/home');

				} else { // login inválido

					console.log('loginService: login inválido');
					console.log(result);
					$('#loginDiv').effect('shake', {
						direction: 'left',
						distance: 10,
						times: 3
					});

				}

			}).
			error(function(data, status, headers, config) {
				// Erro
				alert('Ops! Ocorreu um erro inesperado.\nPor favor contate o administrador do sistema!');
			});

		},
		logout: function() {
			$location.path('/login');
			//[?]
		},
		islogged: function() {
			//[?]
		}
	}

});