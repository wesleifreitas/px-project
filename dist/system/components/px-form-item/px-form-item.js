define(["../../directives/module"],function(e){"use strict";e.directive("pxEnter",[function(){return function(e,r,n){r.bind("keydown keypress",function(r){13===r.which&&(e.$apply(function(){e.$eval(n.pxEnter)}),r.preventDefault())})}}]).directive("pxValidNumber",[function(){return{require:"?ngModel",link:function(e,r,n,t){t&&(t.$parsers.push(function(e){var r=e.replace(/[^0-9]+/g,"");return e!==r&&(t.$setViewValue(r),t.$render()),r}),r.bind("keypress",function(e){32===e.keyCode&&e.preventDefault()}))}}}]).directive("pxBrCnpjMask",["$compile",function(e){return{priority:100,restrict:"A",scope:{cleanValue:"@cleanValue"},require:"?ngModel",link:function(r,n,t,i){i&&(angular.isDefined(t.uiMask)||(t.$set("uiMask","99.999.999/9999-99"),e(n)(r)),i.$parsers.push(function(e){var r=e.replace(/[^0-9]+/g,"");return e!==r&&i.$setViewValue(r),r}))}}}]).directive("pxBrCpfMask",["$compile",function(e){return{priority:100,restrict:"A",scope:{cleanValue:"@cleanValue"},require:"?ngModel",link:function(r,n,t,i){i&&(angular.isDefined(t.uiMask)||(t.$set("uiMask","999.999.999-99"),e(n)(r)),i.$parsers.push(function(e){var r=e.replace(/[^0-9]+/g,"");return e!==r&&i.$setViewValue(r),r}))}}}]).directive("pxBrPhoneMask",["$compile",function(e){return{priority:100,restrict:"A",scope:{cleanValue:"@cleanValue",validPhone8:"@validPhone8",validPhone9:"@validPhone9"},bindToController:!1,require:"?ngModel",link:function(r,n,t,i){i&&(angular.isDefined(t.uiMask)||(t.$set("uiMask","(99) 9999-9999?9"),e(n)(r)),n.bind("focusout",function(e){(r.cleanValue.length<11||!angular.isDefined(r.validPhone8))&&(t.$set("uiMask","(99) 9999-9999"),i.$setViewValue(r.cleanValue),r.validPhone9=!1,r.validPhone8=!0)}),n.bind("focusin",function(e){angular.isDefined(r.cleanValue)||(r.cleanValue=""),r.cleanValue.length<11&&(t.$set("uiMask","(99) 9999-9999?9"),i.$setViewValue(r.cleanValue),r.validPhone9=!1,r.validPhone8=!1)}),n.bind("keyup",function(e){11===r.cleanValue.length&&r.validPhone9===!1||!angular.isDefined(r.validPhone9)?(t.$set("uiMask","(99) ?99999-9999"),i.$setViewValue(r.cleanValue),r.validPhone9=!0,r.validPhone8=!1):(10===r.cleanValue.length&&r.validPhone8===!1||!angular.isDefined(r.validPhone8))&&(t.$set("uiMask","(99) 9999-9999?9"),i.$setViewValue(r.cleanValue),r.validPhone9=!1,r.validPhone8=!0)}),i.$parsers.push(function(e){var n=e.replace(/[^0-9]+/g,"");return r.cleanValue=n,e!==n&&i.$setViewValue(n),n}))}}}]).directive("pxNumberMask",["$filter","$locale",function(e,r){return{restrict:"A",scope:{cleanValue:"@cleanValue",currency:"=pxCurrency",currencySymbol:"@pxCurrencySymbol",numberSuffix:"@pxNumberSuffix",decimalSeparator:"@pxDecimalSeparator",thousandsSeparator:"@pxThousandsSeparator",numberPrecision:"@pxNumberPrecision",useNegative:"=pxUseNegative",usePositiveSymbol:"=pxUsePositiveSymbol"},require:"?ngModel",link:function(e,n,t,i){function a(e){for(var r="",n=0;n<e.length;n++){var t=e.charAt(n);0===r.length&&"0"===t&&(t=!1),t&&t.match(u)&&(g?r.length<g&&(r+=t):r+=t)}return r}function l(e){if(""===e)return e;for(;e.length<h+1;)e="0"+e;return e}function s(e){if(""===e)return y=!0,e;if(e===c+r.NUMBER_FORMATS.DECIMAL_SEP)return"0";var n=l(a(e)),t="",i=0;0===h&&(d="",s="");var s=n.substr(n.length-h,h),u=n.substr(0,n.length-h);if(n=0===h?u:u+d+s,f||""!==$.trim(f)){for(var o=u.length;o>0;o--){var g=u.substr(o-1,1);i++,i%3===0&&(g=f+g),t=g+t}t.substr(0,1)===f&&(t=t.substring(1,t.length)),n=0===h?t:t+d+s}return!m||0===u&&0===s||(n=-1!==e.indexOf("-")&&e.indexOf("+")<e.indexOf("-")?"-"+n:v?"+"+n:""+n),c&&(n=c+n),p&&(n+=p),n}if(n.css({zIndex:0}),i){var u=/[0-9]/,o=e.pxCurrency||!1,c=e.currencySymbol||"",p=e.numberSuffix||"",d=e.decimalSeparator||r.NUMBER_FORMATS.DECIMAL_SEP,f=e.thousandsSeparator||r.NUMBER_FORMATS.GROUP_SEP,h=Number(e.numberPrecision)||2,m=e.useNegative||!1,v=e.usePositiveSymbol||!1;o&&""===c&&(c=r.NUMBER_FORMATS.CURRENCY_SYM);var g=!1,y=!0;i.$parsers.push(function(e){var r="";return"0"===e||""===e&&y!==!1?"0"===e.trim()&&y===!0?0:(y=!0,""):(r=s(e),e!==r&&(i.$setViewValue(r),i.$render()),isNaN(numeral().unformat(r))?0:numeral().unformat(r))})}}}}]).directive("pxComplete",["pxConfig","pxUtil","$parse","$http","$sce","$timeout",function(e,r,n,t,i,a){return{restrict:"EA",scope:{id:"@id",placeholder:"@placeholder",table:"@pxTable",fields:"@pxFields",orderBy:"@pxOrderBy",recordCount:"@pxRecordCount",selectedItem:"=pxSelectedItem",url:"@pxUrl",responseQuery:"@pxResponseQuery",localQuery:"@pxLocalQuery",inputClass:"@pxInputClass",searchFields:"@searchfields"},require:"?ngModel",templateUrl:e.PX_PACKAGE+"system/components/px-form-item/px-complete.html",link:function(n,i,l,s){if(s){n.lastSearchTerm=null,n.currentIndex=null,n.justChanged=!1,n.searchTimer=null,n.hideTimer=null,n.searching=!1,n.pause=400,n.minLength=3,n.searchStr=null;var u=function(e,r){return e.length>=n.minLength&&e!==r};n.processResults=function(e,r,t){if(e&&e.length>0){n.results=[];for(var i=0;i<e.length;i++){for(var a="",l="",s=0;s<t.length;s++){var u="";t[s].labelField&&(u=e[i][t[s].field],angular.isDefined(u)||(u=e[i][t[s].field.toUpperCase()]),a+=t[s].title+u+" "),t[s].descriptionField&&(u=e[i][t[s].field],angular.isDefined(u)||(u=e[i][t[s].field.toUpperCase()]),l+=t[s].title+u+" ")}var o={title:a,description:l,item:e[i]};n.results[n.results.length]=o}}else n.results=[]},n.searchTimerComplete=function(i){var a=JSON.parse(n.fields);if(i.length>=n.minLength)if(n.localQuery)console.warn("px-complete:","função localQuery não implementada!"),n.searching=!1,n.processResults(JSON.parse(n.localQuery),i);else{angular.forEach(a,function(e){e.search&&(e.filterObject={},e.filterObject={field:e.field,value:r.filterOperator(i,e.filterOperator)})});var l={};l.table=n.table,l.fields=angular.toJson(a),l.orderBy=n.orderBy,angular.isDefined(n.recordCount)&&""!==n.recordCount||(n.recordCount=4),l.rows=n.recordCount,angular.isDefined(n.url)&&""!==n.url||(n.url=e.PX_PACKAGE+"system/components/px-form-item/px-form-item.cfc?method=getData"),t({method:"POST",url:n.url,dataType:"json",params:l}).success(function(e,r,t,l){console.info("response",e),angular.isDefined(n.responseQuery)&&""!==n.responseQuery||(n.responseQuery="qQuery"),n.searching=!1,n.processResults(n.responseQuery?e[n.responseQuery]:e,i,a)}).error(function(e,r,n,t){alert("Ops! Ocorreu um erro inesperado.\nPor favor contate o administrador do sistema!")})}},n.hideResults=function(){n.hideTimer=a(function(){n.showDropdown=!1},n.pause)},n.resetHideResults=function(){n.hideTimer&&a.cancel(n.hideTimer)},n.hoverRow=function(e){n.currentIndex=e},n.keyPressed=function(e){38!==e.which&&40!==e.which&&13!==e.which?n.searchStr&&""!==n.searchStr?u(n.searchStr,n.lastSearchTerm)&&(n.lastSearchTerm=n.searchStr,n.showDropdown=!0,n.currentIndex=-1,n.results=[],n.searchTimer&&a.cancel(n.searchTimer),n.searching=!0,n.searchTimer=a(function(){n.searchTimerComplete(n.searchStr)},n.pause)):(n.showDropdown=!1,n.lastSearchTerm=null):e.preventDefault()},n.selectResult=function(e){n.searchStr=n.lastSearchTerm=e.title,n.selectedItem=e.item,n.showDropdown=!1,n.results=[]};var o=i.find("input");o.on("keyup",n.keyPressed),i.on("keyup",function(e){40===e.which?(n.results&&n.currentIndex+1<n.results.length&&(n.currentIndex++,n.$apply(),e.preventDefault(),e.stopPropagation()),n.$apply()):38===e.which?n.currentIndex>=1&&(n.currentIndex--,n.$apply(),e.preventDefault(),e.stopPropagation()):13===e.which?n.results&&n.currentIndex>=0&&n.currentIndex<n.results.length?(n.selectResult(n.results[n.currentIndex]),n.$apply(),e.preventDefault(),e.stopPropagation()):(n.results=[],n.$apply(),e.preventDefault(),e.stopPropagation()):27===e.which?(n.results=[],n.showDropdown=!1,n.$apply()):8===e.which&&(n.selectedItem=null,n.$apply())})}}}}])});