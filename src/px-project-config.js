/**
 * Componentes Phoenix Project
 * @return {[type]} [description]
 */
function pxProjectPackage() {
	return '';
};

$(function() {

	// Custom Controllers
	var controller = [];

	// Loop em controller
	$.each(controller, function(i, item) {
		$("<script/>").attr('src', pxProjectPackage() + item.file).appendTo($('head'));
	});

	// Angular Material Theme
	// https://material.angularjs.org/latest/#/Theming/01_introduction
	/*
	app.config(function($mdThemingProvider) {
		//red, pink, purple, deep-purple, indigo, blue, light-blue, cyan, teal, green, light-green, lime, yellow, amber, orange, deep-orange, brown, grey, blue-grey
		$mdThemingProvider.theme('default')
			.primaryPalette('blue-grey')
			.accentPalette('grey');

		$mdThemingProvider.theme('darkTheme')
			.primaryPalette('grey')
	});
	*/
});