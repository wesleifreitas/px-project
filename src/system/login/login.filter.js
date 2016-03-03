define(['../filters/module'], function(filters) {
	'use strict';
	
	filters.filter('loginWorking', [function() {
		return function(working) {			
			if (working) {
				return 'working fa fa-circle-o-notch fa-spin fa-2x';
			} else {
				return '';
			}
		}
	}]);

	return filters;
});