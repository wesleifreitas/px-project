define(["../../services/module"],function(n){"use strict";function r(){function n(n,r,t){var u=t?function(r){return t(r[n])}:function(r){return r[n]};return r=r?-1:1,function(n,t){return n=u(n),t=u(t),r*((n>t)-(t>n))}}var r={};return r.sortOn=n,r}n.factory("pxArrayUtil",r),r.$inject=[]});