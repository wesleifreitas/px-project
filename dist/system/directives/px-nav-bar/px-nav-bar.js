define(["../../directives/module"],function(o){"use strict";function e(o,e,r,t,n){e.getNavBar=function(){var n={};n.pro_id=angular.toJson(o.PROJECT_ID),n.isMobile=e.isMobile(),n.user=t.globals.currentUser.usu_id,n.dsn=o.PROJECT_DSN,r({method:"POST",url:o.PX_PACKAGE+"system/directives/px-nav-bar/px-nav-bar.cfc?method=getNavBar",params:n}).success(function(o){e.navBar=o.navBar}).error(function(o,e,r,t){alert("Ops! Ocorreu um erro inesperado.\nPor favor contate o administrador do sistema!")})},e.showView=function(e){var t={dsn:o.PROJECT_DSN,men_id:e};r({method:"POST",url:o.PX_PACKAGE+"system/directives/px-nav-bar/px-nav-bar.cfc?method=getView",params:t}).success(function(o){console.info("response",o),n.path("/home/"+o.state)}).error(function(o,e,r,t){alert("Ops! Ocorreu um erro inesperado.\nPor favor contate o administrador do sistema!")})},e.isMobile=function(){var o=navigator.userAgent.toLowerCase();return-1!=o.search(/(android|avantgo|blackberry|bolt|boost|cricket|docomo|fone|hiptop|mini|mobi|palm|phone|pie|tablet|up\.browser|up\.link|webos|wos)/i)?!0:!1},e.getNavBar()}o.directive("pxNavBar",["$compile",function(o){return{restrict:"E",transclude:!0,scope:{title:"@"},link:function(e,r,t){var n=e.$watch("navBar",function(t,a){t!==a&&(r.html(e.navBar),o(r.contents())(e),n())})},controller:e}}]),e.$inject=["pxConfig","$scope","$http","$rootScope","$location"]});