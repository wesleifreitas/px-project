require.config({
    paths: {
        'angular': '../lib/angular/angular.min',
        'angular-locale_pt-br': '../lib/angular-i18n/angular-locale_pt-br',
        'angular-route': '../lib/angular-route/angular-route.min',
        'angular-ui-router': '../lib/angular-ui-router/release/angular-ui-router.min',
        'angular-cookies': '../lib/angular-cookies/angular-cookies.min',
        'angular-resource': '../lib/angular-resource/angular-resource.min',
        'angular-animate': '../lib/angular-animate/angular-animate.min',
        'angular-aria': '../lib/angular-aria/angular-aria.min',
        'angular-material': '../lib/angular-material/angular-material.min',
        'angular-messages': '../lib/angular-messages/angular-messages.min',
        'angular-ui-mask': '../lib/angular-ui-mask/dist/mask.min',
        'jquery': '../lib/jquery/dist/jquery.min',
        'jquery-ui': '../lib/jquery-ui/jquery-ui.min',
        'dataTables': '../lib/datatables/media/js/jquery.dataTables.min',
        'moment': '../lib/moment/min/moment-with-locales.min',
        'numeral': '../lib/numeral/min/numeral.min',
        'numeral-languages': '../lib/numeral/min/languages.min',
        'jstree': '../lib/jstree/dist/jstree.min',
        'px-module': '../lib/px-module/dist/px-full/px-full'
    },
    shim: {
        'angular': {
            exports: 'angular'
        },
        'angular-locale_pt-br': {
            deps: ['angular']
        },
        'angular-route': {
            deps: ['angular']
        },
        'angular-ui-router': {
            deps: ['angular']
        },
        'angular-cookies': {
            deps: ['angular']
        },
        'angular-resource': {
            deps: ['angular']
        },
        'angular-animate': {
            deps: ['angular']
        },
        'angular-aria': {
            deps: ['angular']
        },
        'angular-messages': {
            deps: ['angular']
        },
        'angular-material': {
            deps: ['angular']
        },
        'angular-ui-mask': {
            deps: ['angular']
        },
        'numeral-languages': {
            deps: ['numeral']
        },
        'jstree': {
            deps: ['jquery']
        },
        'px-module': {
            deps: ['angular', 'jquery']
        }
    }
});

// Angular Bootstrap 
require(['./app', './config'], function(app) {
    // initialisation code defined within app.js
    app.init();
});