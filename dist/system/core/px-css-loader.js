define(["../services/module"],function(e){"use strict";function t(e){function t(){var t=document.getElementById("px-loading"),s=window.getComputedStyle(t),o=s.getPropertyValue("display");if("none"!=o){var a=[{file:e.PX_PACKAGE+"system/core/external/metro-bootstrap.css"},{file:e.PX_PACKAGE+"system/core/external/metro-bootstrap-responsive.css"},{file:e.LIB+"bootstrap/dist/css/bootstrap.min.css"},{file:"http://cdn.datatables.net/plug-ins/1.10.7/integration/bootstrap/3/dataTables.bootstrap.css"},{file:e.LIB+"angular-material/angular-material.min.css"},{file:"https://fonts.googleapis.com/css?family=RobotoDraft:300,400,500,700,400italic"},{file:"https://fonts.googleapis.com/icon?family=Material+Icons"},{file:"https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css"},{file:e.PX_PACKAGE+"system/login/login.css"},{file:e.PX_PACKAGE+"system/components/px-view-header/px-view-header.css"},{file:e.PX_PACKAGE+"system/components/px-data-grid/px-data-grid.css"},{file:e.PX_PACKAGE+"system/components/px-form-item/px-form-item.css"},{file:e.PX_PACKAGE+"system/core/px-project.css"}];$.each(a,function(e,t){$('<link rel="stylesheet"/>').attr("href",t.file).appendTo($("head"))}),$('<link rel="stylesheet"/>').attr("href","styles.css").appendTo($("head")),$('<link rel="stylesheet"/>').attr("href",e.PX_PACKAGE+"system/core/px-project.css").appendTo($("head"))}}var s={};return s.load=t,s}e.factory("pxCssLoader",t),t.$inject=["pxConfig"]});