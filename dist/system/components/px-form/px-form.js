define(["../../directives/module"],function(e){"use strict";function l(e,l,a,n,i,t,r){n.insertUpdate=function(a){var i=JSON.parse(n.config),t=i.table,o=i.fields;if(angular.isDefined(t)||(t=n.table),angular.isDefined(o)||(o=JSON.parse(n.fields)),n.group=n.group||e.GROUP,angular.isDefined(i.group)&&(n.group=i.group),angular.isDefined(i.groupItem)&&(n.groupItem=i.groupItem),angular.isDefined(i.groupLabel)&&(n.groupLabel=i.groupLabel),n.table=t,n.group===!0){if(""===e.GROUP_SUFFIX)n.groupItem=n.groupItem||e.GROUP_ITEM;else if(!angular.isDefined(n.groupItem)){n.groupItem=n.groupItem||n.table+"_"+e.GROUP_ITEM_SUFFIX;for(var s=0;s<e.GROUP_REPLACE.length;s++)n.groupItem=n.groupItem.replace(e.GROUP_REPLACE[s],"")}if(""===e.GROUP_SUFFIX)n.groupLabel=n.groupLabel||e.GROUP_LABEL;else if(!angular.isDefined(n.groupLabel)){n.groupLabel=n.groupLabel||e.GROUP_TABLE+"_"+e.GROUP_LABEL_SUFFIX;for(var s=0;s<e.GROUP_REPLACE.length;s++)n.groupLabel=n.groupLabel.replace(e.GROUP_REPLACE[s],"")}}angular.forEach(o,function(l){if(l.valueObject={},angular.isDefined(l.insert)||l.identity===!0?angular.isDefined(l.insert)||(l.insert=!1):l.insert=!0,angular.isDefined(l.update)||l.identity===!0?angular.isDefined(l.update)||(l.update=!1):l.update=!0,angular.isDefined(l.hash)&&l.hash&&(angular.isDefined(l.algorithm)||(l.algorithm="SHA-512")),angular.isDefined(l.element)){var i="#"+l.element,t=l.element;angular.isDefined(angular.element($(i+"_inputSearch").get(0)).scope())&&(i+="_inputSearch",t="selectedItem");var o=angular.element($(i).get(0));if(angular.isDefined(o.context)||console.error("pxForm: elemento não encontrado no html, verifique a propriedade element",l),"checkbox"===o.context.type&&(angular.isDefined(o.scope()[t])&&""!==o.scope()[t]||(o.scope()[t]=!1),angular.isDefined(l.fieldValueOptions)&&(o.scope()[t]===!0?o.scope()[t]=l.fieldValueOptions.checked:o.scope()[t]=l.fieldValueOptions.unchecked)),o.scope().hasOwnProperty(t)){var s=o.scope()[t];if(!angular.isDefined(s))return void(1!==r.globals.currentUser.per_developer&&l.field===n.groupItem&&(""===e.GROUP_ITEM?l.valueObject={field:l.field,value:r.globals.currentUser[(e.GROUP_TABLE+"_"+e.GROUP_ITEM_SUFFIX).toLowerCase()]}:l.valueObject={field:l.field,value:r.globals.currentUser[e.GROUP_ITEM.toLowerCase()]}));var u=l.field,c=s;angular.isDefined(l.fieldValueOptions)&&"checkbox"!==angular.element($(i).get(0)).context.type&&(u=l.fieldValueOptions.field,s?(c=s[l.fieldValueOptions.selectedItem],angular.isDefined(c)||(c=s[l.fieldValueOptions.selectedItem.toUpperCase()]),"%"===c&&(c=null)):c=null,angular.isDefined(o.scope().labelField)?angular.isDefined(s[o.scope().labelField])?l.labelField={field:o.scope().labelField,value:s[o.scope().labelField]}:l.labelField={field:o.scope().labelField,value:s[o.scope().labelField.toUpperCase()]}:angular.isDefined(l.fieldValueOptions.selectedLabel)&&(l.labelField={field:l.labelField,value:s[l.fieldValueOptions.selectedLabel]})),null!==c&&""!==c?l.valueObject={field:u,value:c}:"string"===l.type?l.valueObject={field:u,value:""}:(l.valueObject={},l.insert=!1,l.update=!1)}else l.valueObject={},l.insert=!1,l.update=!1}else angular.isDefined(l.user)&&l.user?(l.type="int",l.valueObject={field:l.field,value:r.globals.currentUser.usu_id}):angular.isDefined(l.insertGetDate)&&l.insertGetDate?"insert"===a?(l.type="datetime",l.valueObject={field:l.field,value:"",getDate:!0}):l.update=!1:angular.isDefined(l.updateGetDate)&&l.updateGetDate?(l.type="datetime",l.valueObject={field:l.field,value:"",getDate:!0}):l.valueObject={field:l.field,value:""};!angular.isDefined(l["default"])||null!==l.valueObject.value&&""!==l.valueObject.value||(l.valueObject.value=l["default"])}),n.debug&&(console.group("$scope.insertUpdate"),console.info("action:",a),console.info("table:",t),console.info("fields (new):",o),console.info("oldForm:",n.oldForm),console.groupEnd());var u="";angular.isDefined(n.oldForm)&&(u=angular.toJson(n.oldForm)),l.insertUpdate(a,t,angular.toJson(o),u,function(e){n.debug&&console.info("pxFormService.insertUpdate response: ",e),e.success?(n.callback&&n.callback({event:e}),n.clean()):alert("Ops! Ocorreu um erro inesperado.\nPor favor contate o administrador do sistema!")})},n.select=function(e){t(function(){var i=JSON.parse(n.config),r=i.table,o=i.view,s=i.fields;angular.isDefined(r)||(r=n.table),angular.isDefined(o)||(o=n.view),angular.isDefined(s)||(s=JSON.parse(n.fields)),angular.forEach(s,function(l){if(l.valueObject={},l.valueObject.value=e[l.field],angular.isDefined(l.select)?l.select=!1:l.select=!0,angular.isDefined(angular.element($("#"+l.element+"_inputSearch").get(0)).scope()))if(""!==angular.element($("#"+l.element+"_inputSearch").get(0)).scope().fields){var a=angular.element($("#"+l.element+"_inputSearch").get(0)).scope().fields;angular.forEach(a,function(e){e.labelField&&s.push({field:e.field,select:!0})})}else console.error("pxForm: componente px-input-search com propriedade fields inválida",l)}),n.debug&&(console.group("$scope.select"),console.info("table:",r),console.info("view:",o),console.info("fields:",s),console.groupEnd()),angular.isDefined(o)&&""!==o&&(r=o),l.select(r,angular.toJson(s),function(e){n.debug&&console.info("pxFormService.select response: ",e),e.success?(n.oldForm=e.qQuery[0],angular.forEach(s,function(l){if(angular.isDefined(l.element)){var n="#"+l.element,i=l.element,r=!1;if(angular.isDefined(angular.element($(n+"_inputSearch").get(0)).scope())){n+="_inputSearch",i="selectedItem";var r=!0}var o=(angular.element($(n).data("$ngModelController")),angular.element($(n).get(0))),s=String(e.qQuery[0][l.field]);if(angular.isDefined(e.qQuery[0][l.field])||(s=String(e.qQuery[0][l.field.toUpperCase()])),!angular.isDefined(o.context))return void console.error("pxForm: elemento não encontrado no html, verifique a propriedade element",l);if("checkbox"===o.context.type&&(s=angular.isDefined(l.fieldValueOptions)?l.fieldValueOptions.checked===s?!0:!1:"1"===s?!0:!1),angular.isDefined(l.fieldValueOptions)&&"checkbox"!==o.context.type)if(o.scope().hasOwnProperty(i))if(r){var u=angular.copy(e.qQuery[0]);angular.isDefined(l.fieldValueOptions.selectedItem)||console.error("pxForm: selectedItem não definido em fieldValueOptions",l),u[l.fieldValueOptions.selectedItem]=s,o.scope().setValue(u)}else o.scope()[l.field]=o.scope()[l.field][a.getIndexByProperty(o.scope()[l.field],l.fieldValueOptions.selectedItem,s)];else console.error("pxForm:","Scope "+i+" sem valor inicial definido");else o.scope().pxForm=!0,angular.isDefined(o.scope().pxForm2mask)&&(o.scope().cleanValue=s,o.scope().pxForm2mask(s)),o.scope()[l.field]=s,t(function(){o.trigger("keyup")},0)}}),n.callback&&(e.action="select",n.callback({event:e}))):alert("Ops! Ocorreu um erro inesperado.\nPor favor contate o administrador do sistema!")})},0)},n.clean=function(){if(angular.isDefined(n.config)&&""!==n.config){var e=JSON.parse(n.config),l=e.table,a=e.fields;angular.isDefined(l)||(l=n.table),angular.isDefined(a)||(a=JSON.parse(n.fields)),angular.forEach(a,function(e){if(e.valueObject={},angular.isDefined(e.element)){var l="#"+e.element,a=e.element;angular.isDefined(angular.element($(l+"_inputSearch").get(0)).scope())&&(l+="_inputSearch",a="selectedItem");var n=(angular.element($(l).data("$ngModelController")),angular.element($(l).get(0))),i="";angular.isDefined(e.fieldValueOptions)?n.scope().hasOwnProperty(a)&&(n.scope()[e.field]=i):n.scope()[e.field]=i}})}}}e.directive("pxForm",["$timeout",function(e){return{restrict:"E",replace:!1,transclude:!1,template:"<div></div>",scope:{debug:"=pxDebug",config:"@pxConfig",view:"@pxView",table:"@pxTable",fields:"@pxFields",init:"&pxInit",callback:"&pxCallback",control:"=pxControl"},link:function(l,a,n){l.internalControl=l.control||{},l.internalControl.insert=function(){l.insertUpdate("insert")},l.internalControl.select=function(e){l.select(e)},l.internalControl.update=function(){l.insertUpdate("update")},l.internalControl.clean=function(){l.clean()},e(l.init,0)},controller:l}}]),l.$inject=["pxConfig","pxFormService","pxArrayUtil","$scope","$http","$timeout","$rootScope"]});