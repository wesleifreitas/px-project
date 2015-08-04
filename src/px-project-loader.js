$(function() {

    // CSS
    var cssLoader = [{
        file: pxProjectPackage() + 'px/system/css/metro-bootstrap.css'
    }, {
        file: pxProjectPackage() + 'px/system/css/metro-bootstrap-responsive.css'
    }, {
        file: pxProjectPackage() + 'px/system/css/iconFont.css'
    }, {
        file: pxProjectPackage() + 'px/system/css/pxProject.css'
    }, {
        file: pxProjectPackage() + 'px/system/css/login.css'
    }, {
        file: pxProjectPackage() + 'px/system/css/pxGridSearch.css'
    }, {
        file: 'bower_components/bootstrap/dist/css/bootstrap.min.css'
    }, {
        file: 'http://cdn.datatables.net/plug-ins/1.10.7/integration/bootstrap/3/dataTables.bootstrap.css' // http://cdn.datatables.net/plug-ins/1.10.7/integration/bootstrap/3/dataTables.bootstrap.css
    }, {
        file: 'bower_components/angular-material/angular-material.min.css'
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
        file: 'bower_components/jquery-ui/jquery-ui.min.js'
    }, {
        file: 'bower_components/datatables/media/js/jquery.dataTables.min.js'
    }, {
        file: pxProjectPackage() + 'px/system/js/metro.min.js'
    }, {
        file: pxProjectPackage() + 'px/system/js/docs.js'
    }, {
        file: 'bower_components/angular-route/angular-route.js'
    }, {
        file: 'bower_components/angular-cookies/angular-cookies.js'
    }, {
        file: 'bower_components/angular-resource/angular-resource.js'
    }, {
        file: 'bower_components/angular-sanitize/angular-sanitize.js'
    }, {
        file: 'bower_components/angular-animate/angular-animate.min.js'
    }, {
        file: 'bower_components/angular-aria/angular-aria.min.js'
    }, {
        file: 'bower_components/angular-material/angular-material.min.js'
    }, {
        file: 'bower_components/angular-ui-mask/dist/mask.min.js'
    }, {
        file: pxProjectPackage() + 'custom/js/directives/customDrc.js'
    }, {
        file: pxProjectPackage() + 'px/system/js/controller/loginCtrl.js'
    }, {
        file: pxProjectPackage() + 'px/system/js/controller/homeCtrl.js'
    }, {
        file: pxProjectPackage() + 'px/system/js/services/authentication.service.js'
    }, {
        file: pxProjectPackage() + 'px/system/js/services/flash.service.js'
    }, {
        file: pxProjectPackage() + 'px/system/js/services/user.service.local-storage.js'
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