define(["../services/module"],function(e){"use strict";function r(e,r,t,a,n,i){function c(o,t,a){var n={username:o,password:t};r({method:"POST",url:e.PX_PACKAGE+"system/login/login.cfc?method=login",params:n}).success(function(e){a(e)}).error(function(e,r,o,t){alert("Ops! Ocorreu um erro inesperado.\nPor favor contate o administrador do sistema!")})}function s(e,n,i){var c=o.encode(e+":"+n);a.globals={currentUser:{username:e,authdata:c}},angular.forEach(i.qQuery[0],function(e,r){a.globals.currentUser[r.toLowerCase()]=e}),r.defaults.headers.common.Authorization="Basic "+c,t.put("globals",a.globals)}function d(){a.globals={},t.remove("globals"),r.defaults.headers.common.Authorization="Basic "}function u(e,o,t,a){var n={id:e,username:o,password:t};r({method:"POST",url:"custom/login/login.cfc?method=redefine",params:n}).success(function(e){a(e)}).error(function(e,r,o,t){alert("Ops! Ocorreu um erro inesperado.\nPor favor contate o administrador do sistema!")})}function h(e,o,t){var a={username:e,email:o};r({method:"POST",url:"custom/login/login.cfc?method=recover",params:a}).success(function(e){t(e)}).error(function(e,r,o,t){alert("Ops! Ocorreu um erro inesperado.\nPor favor contate o administrador do sistema!")})}var l={};return l.Login=c,l.SetCredentials=s,l.ClearCredentials=d,l.Redefine=u,l.Recover=h,l}e.factory("AuthenticationService",r),r.$inject=["pxConfig","$http","$cookieStore","$rootScope","$timeout","UserService"];var o={keyStr:"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=",encode:function(e){var r,o,t,a,n,i="",c="",s="",d=0;do r=e.charCodeAt(d++),o=e.charCodeAt(d++),c=e.charCodeAt(d++),t=r>>2,a=(3&r)<<4|o>>4,n=(15&o)<<2|c>>6,s=63&c,isNaN(o)?n=s=64:isNaN(c)&&(s=64),i=i+this.keyStr.charAt(t)+this.keyStr.charAt(a)+this.keyStr.charAt(n)+this.keyStr.charAt(s),r=o=c="",t=a=n=s="";while(d<e.length);return i},decode:function(e){var r,o,t,a,n,i="",c="",s="",d=0,u=/[^A-Za-z0-9\+\/\=]/g;u.exec(e)&&window.alert("There were invalid base64 characters in the input text.\nValid base64 characters are A-Z, a-z, 0-9, '+', '/',and '='\nExpect errors in decoding."),e=e.replace(/[^A-Za-z0-9\+\/\=]/g,"");do t=this.keyStr.indexOf(e.charAt(d++)),a=this.keyStr.indexOf(e.charAt(d++)),n=this.keyStr.indexOf(e.charAt(d++)),s=this.keyStr.indexOf(e.charAt(d++)),r=t<<2|a>>4,o=(15&a)<<4|n>>2,c=(3&n)<<6|s,i+=String.fromCharCode(r),64!==n&&(i+=String.fromCharCode(o)),64!==s&&(i+=String.fromCharCode(c)),r=o=c="",t=a=n=s="";while(d<e.length);return i}}});