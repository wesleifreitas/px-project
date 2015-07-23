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
});