define(["../controllers/module"],function(e){"use strict";e.controller("HomeCtrl",["pxConfig","pxCssLoader","UserService","$rootScope","$scope","$location","$timeout","$mdSidenav","$mdUtil","$mdDialog","$log","$locale",function(e,o,n,t,l,i,c,r,u,a,s,m){function f(e){var o=u.debounce(function(){r(e).toggle().then(function(){})},300);return o}o.load(),l.menus=[{name:"Exemplo",title:"Phoenix » View - Exemplo",icon:"glyphicon glyphicon-education home-icon",view:"custom/exemplo/exemplo.html"}],l.iconShowView=function(e,o){angular.isDefined(o.view)?(l.formTitle=o.title,a.show({scope:l,preserveScope:!0,templateUrl:o.view,parent:angular.element(document.body),targetEvent:e,clickOutsideToClose:!1})):alert("Função não disponível no momento")},e.LOCALE&&(require(["moment"],function(o){o.locale(e.LOCALE)}),numeral.language(e.LOCALE.toLowerCase()));var g=this;g.user=null,g.allUsers=[],g.loadCurrentUser=function(){},g.loadAllUsers=function(){},g.deleteUser=function(e){},g.initController=void 0,g.toggleLeft=f("left"),l.toggleRight=f("right"),l.logout=function(){i.path("/login")},-1!=navigator.userAgent.toLowerCase().search(/(android|avantgo|blackberry|bolt|boost|cricket|docomo|fone|hiptop|mini|mobi|palm|phone|pie|tablet|up\.browser|up\.link|webos|wos)/i)&&($("html").click(function(){document.getElementById("menu").style.display="none"}),$("#menu").click(function(e){e.stopPropagation()}))}]).controller("LeftCtrl"[function(e,o,n,t){e.close=function(){n("left").close().then(function(){})}}]).controller("RightCtrl",["$scope","$timeout","$mdSidenav","$log",function(e,o,n,t){e.close=function(){n("right").close().then(function(){})}}])});