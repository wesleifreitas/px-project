$(function () {

    /**
     * Module pxLoader
     */
    angular.module('pxLoader', [])
        .config(function (pxConfig) {

            // CSS
            var cssLoader = [{
                file: pxConfig.PX_PACKAGE + 'system/core/external/metro-bootstrap.css'
            }, {
                file: pxConfig.PX_PACKAGE + 'system/core/external/metro-bootstrap-responsive.css'
            }, {
                file: pxConfig.PX_PACKAGE + 'system/core/px-project.css'
            }, {
                file: pxConfig.PX_PACKAGE + 'system/login/login.css'
            }, {
                file: pxConfig.EXTERNAL_COMPONENTS + 'bootstrap/dist/css/bootstrap.min.css' //  pxConfig.PX_PACKAGE + 'system/core/external/iconFont.css'
            }, {
                file: 'http://cdn.datatables.net/plug-ins/1.10.7/integration/bootstrap/3/dataTables.bootstrap.css' // http://cdn.datatables.net/plug-ins/1.10.7/integration/bootstrap/3/dataTables.bootstrap.css
            }, {
                file: pxConfig.EXTERNAL_COMPONENTS + 'angular-material/angular-material.min.css'
            }, {
                file: 'https://fonts.googleapis.com/css?family=RobotoDraft:300,400,500,700,400italic'
            }, {
                file: 'https://fonts.googleapis.com/icon?family=Material+Icons' //https://www.google.com/design/icons/
            }, {
                file: pxConfig.PX_PACKAGE + 'system/components/px-form-item/px-form-item.css'
            }];

            // Loop em cssLoader
            $.each(cssLoader, function (i, item) {
                //console.info('pxLoader - cssLoader:',item.file);
                $('<link rel="stylesheet"/>').attr('href', item.file).appendTo($('head'));
            });

            // Overwrite style
            $('<link rel="stylesheet"/>').attr('href', document.location.pathname + 'style.css').appendTo($('head'));

            // JS
            var jsLoader = [{
                file: pxConfig.EXTERNAL_COMPONENTS + 'jquery-ui/jquery-ui.min.js'
            }, {
                file: pxConfig.EXTERNAL_COMPONENTS + 'datatables/media/js/jquery.dataTables.min.js'
            }, {
                file: pxConfig.PX_PACKAGE + 'system/core/external/metro.min.js'
            }, {
                file: pxConfig.PX_PACKAGE + 'system/core/external/docs.js'
            }, {
                file: pxConfig.EXTERNAL_COMPONENTS + 'angular-route/angular-route.js'
            }, {
                file: pxConfig.EXTERNAL_COMPONENTS + 'angular-cookies/angular-cookies.js'
            }, {
                file: pxConfig.EXTERNAL_COMPONENTS + 'angular-resource/angular-resource.js'
            }, {
                file: pxConfig.EXTERNAL_COMPONENTS + 'angular-sanitize/angular-sanitize.js'
            }, {
                file: pxConfig.EXTERNAL_COMPONENTS + 'angular-animate/angular-animate.min.js'
            }, {
                file: pxConfig.EXTERNAL_COMPONENTS + 'angular-aria/angular-aria.min.js'
            }, {
                file: pxConfig.EXTERNAL_COMPONENTS + 'angular-material/angular-material.min.js'
            }, {
                file: pxConfig.EXTERNAL_COMPONENTS + 'angular-ui-mask/dist/mask.min.js'
            }, {
                file: pxConfig.EXTERNAL_COMPONENTS + 'numeral/min/numeral.min.js'
            }, {
                file: pxConfig.EXTERNAL_COMPONENTS + 'numeral/min/languages.min.js'
            }, {
                file: pxConfig.EXTERNAL_COMPONENTS + 'string-mask/src/string-mask.js'
            }, {
                file: pxConfig.EXTERNAL_COMPONENTS + 'moment/min/moment-with-locales.min.js'
            }, {
                file: pxConfig.PX_PACKAGE + 'system/utils/js/px-util.js'
            }, {
                file: pxConfig.PX_PACKAGE + 'system/utils/js/px-array-util.js'
            }, {
                file: pxConfig.PX_PACKAGE + 'system/login/login.controller.js'
            }, {
                file: pxConfig.PX_PACKAGE + 'system/home/home.controller.js'
            }, {
                file: pxConfig.PX_PACKAGE + 'system/login/authentication.service.js'
            }, {
                file: pxConfig.PX_PACKAGE + 'system/login/flash.service.js'
            }, {
                file: pxConfig.PX_PACKAGE + 'system/login/user.service.local-storage.js'
            }, {
                file: pxConfig.PX_PACKAGE + 'system/components/px-nav-bar/px-nav-bar.js'
            }, {
                file: pxConfig.PX_PACKAGE + 'system/components/px-view-header/px-view-header.js'
            }, {
                file: pxConfig.PX_PACKAGE + 'system/components/px-data-grid/px-data-grid.js'
            }, {
                file: pxConfig.PX_PACKAGE + 'system/components/px-form-item/px-form-item.js'
            }];

            // Loop em jsLoader
            $.each(jsLoader, function (i, item) {
                //console.info('pxLoader - jsLoader:',item.file);
                $("<script/>").attr('src', item.file).appendTo($('head'));
            });


            // HTML
            var htmlLoader = [];

            // loop em htmlLoader
            $.each(htmlLoader, function (i, item) {
                //console.info('pxLoader - htmlLoader:',item.file);
                $('<link rel="import"/>').attr('href', item.file).appendTo($('head'));
            });
        });
    $('body').addClass('metro');
});
