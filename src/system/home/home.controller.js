(function() {
	'use strict';

	app.controller('homeCtrl', ['pxConfig', 'UserService', '$rootScope', '$scope', '$location', '$timeout', '$mdSidenav', '$mdUtil', '$log', function(pxConfig, UserService, $rootScope, $scope, $location, $timeout, $mdSidenav, $mdUtil, $log) {

			if (pxConfig.LOCALE) {
				// Definir locale da lib moment.js
				// http://momentjs.com/docs/
				moment.locale(pxConfig.LOCALE);
			}

			var vm = this;

			vm.user = null;
			vm.allUsers = [];

			vm.loadCurrentUser = function loadCurrentUser() {
				UserService.GetByUsername($rootScope.globals.currentUser.username)
					.then(function(user) {
						vm.user = user;
					});
			}

			vm.loadAllUsers = function loadAllUsers() {
				UserService.GetAll()
					.then(function(users) {
						vm.allUsers = users;
					});
			}

			vm.deleteUser = function deleteUser(id) {
				UserService.Delete(id)
					.then(function() {
						loadAllUsers();
					});
			}

			vm.initController = function initController() {
				vm.loadCurrentUser();
				vm.loadAllUsers();
			}();

			vm.toggleLeft = buildToggler('left');
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

			$scope.logout = function logout() {
				$location.path('/login');
			}

		}])
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

})();