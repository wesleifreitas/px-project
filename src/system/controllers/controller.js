define(['./module'], function(controllers) {
    'use strict';

    controllers.controller('pxCtrl', pxCtrl);

    pxCtrl.$inject = [];

    function pxCtrl() {
        var vm = this;
        alert();
    }
});