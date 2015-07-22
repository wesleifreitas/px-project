$(function() {

    // CSS
    var cssLoader = [{
        file: pxProjectPackage() + 'css/metro-bootstrap.css'
    }, {
        file: pxProjectPackage() + 'css/metro-bootstrap-responsive.css'
    }, {
        file: pxProjectPackage() + 'css/iconFont.css'
    }, {
        file: pxProjectPackage() + 'px/system/css/pxProject.css'
    }, {
        file: pxProjectPackage() + 'px/system/css/login.css'
    }, {
        file: pxProjectPackage() + 'px/system/css/pxGridSearch.css'
    }, {
        file: 'http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css'
    }, {
        file: 'http://cdn.datatables.net/plug-ins/1.10.7/integration/bootstrap/3/dataTables.bootstrap.css'
    }, {
        file: 'https://ajax.googleapis.com/ajax/libs/angular_material/0.9.4/angular-material.min.css'
    }, {
        file: 'https://fonts.googleapis.com/css?family=RobotoDraft:300,400,500,700,400italic'
    }, {
        file: 'https://fonts.googleapis.com/icon?family=Material+Icons' //https://www.google.com/design/icons/
    }];


    // Loop em cssLoader
    $.each(cssLoader, function(i, item) {
        //console.log(document.location.pathname + item.file);
        $('<link rel="stylesheet"/>').attr('href', item.file).appendTo($('head'));
    });

    // Overwrite style
    $('<link rel="stylesheet"/>').attr('href', document.location.pathname + 'style.css').appendTo($('head'));


    // JS
    var jsLoader = [{
        file: 'https://code.jquery.com/ui/1.11.4/jquery-ui.min.js'
    }, {
        file: pxProjectPackage() + 'lib/jquery/jquery.widget.min.js'
    }, {
        file: pxProjectPackage() + 'lib/jquery/jquery.mousewheel.js'
    }, {
        file: 'http://cdn.datatables.net/1.10.7/js/jquery.dataTables.min.js'
    }, {
        file: pxProjectPackage() + 'lib/metro/metro.min.js'
    }, {
        file: pxProjectPackage() + 'lib/metro/docs.js'
    }, {
        file: pxProjectPackage() + 'lib/angular/angular-route.js'
    }, {
        file: pxProjectPackage() + 'lib/angular/angular-sanitize.js'
    }, {
        file: pxProjectPackage() + 'lib/angular/angular-animate.min.js'
    }, {
        file: pxProjectPackage() + 'lib/angular/angular-aria.min.js'
    }, {
        file: pxProjectPackage() + 'lib/angular/angular-material.min.js'
    }, {
        file: pxProjectPackage() + 'px/custom/js/directives/customDrc.js'
    }, {
        file: pxProjectPackage() + 'px/system/js/controller/loginCtrl.js'
    }, {
        file: pxProjectPackage() + 'px/system/js/controller/homeCtrl.js'
    }, {
        file: pxProjectPackage() + 'px/system/js/services/loginService.js'
    }, {
        file: pxProjectPackage() + 'px/system/js/services/sessionService.js'
    }, {
        file: pxProjectPackage() + 'px/system/js/px-top-menu.js'
    }, {
        file: pxProjectPackage() + 'px/system/js/px-view-header.js'
    }, {
        file: pxProjectPackage() + 'px/system/js/px-grid.js'
    }, {
        file: pxProjectPackage() + 'px/system/js/px-form-item.js'
    }];

    // Loop em jsLoader
    $.each(jsLoader, function(i, item) {
        $("<script/>").attr('src', item.file).appendTo($('head'));
    });


    // HTML
    var htmlLoader = [];

    // loop em htmlLoader
    $.each(htmlLoader, function(i, item) {
        $('<link rel="import"/>').attr('href', pxProjectPackage() + item.file).appendTo($('head'));
    });

});