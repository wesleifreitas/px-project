define(['angular',
    'angular-locale_pt-br',
    'angular-route',
    'angular-ui-router',
    'angular-cookies',
    'angular-resource',
    'angular-animate',
    'angular-aria',
    'angular-material',
    'angular-messages',
    'angular-ui-mask',
    'jquery',
    'jquery-ui',
    'dataTables',
    'moment',
    'numeral',
    'numeral-languages',
    'jstree',
    'px-module',
    '../system/login/index',
    '../system/home/index',
    '../system/controllers/index',
    '../system/directives/index',
    '../system/filters/index',
    '../system/services/index',
    '../custom/controllers/index',
    '../custom/directives/index',
    '../custom/filters/index',
    '../custom/services/index'
], function(angular) {
    var app = angular.module('myApp', [
        'ngRoute',
        'ui.router',
        'ngCookies',
        'ngMaterial',
        'ngMessages',
        'ui.mask',
        'pxConfig',
        'px-array-util',
        'px-date-util',
        'px-mask-util',
        'px-string-util',
        'px-util',
        'px-data-grid',
        'px-form-item',
        'system.controllers',
        'system.directives',
        'system.filters',
        'system.services',
        'app.controllers',
        'app.directives',
        'app.filters',
        'app.services'
    ]);

    app.init = function() {
        angular.bootstrap(document, ['myApp']);
    };

    return app;
});