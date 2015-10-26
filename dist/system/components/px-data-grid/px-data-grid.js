define(["../../directives/module"],function(e){"use strict";function t(e,t,a,r,n,o){e.pxTableReady=!1,e.currentPage=0,e.$watch("pxTableReady",function(t,r){t===!0&&a(e.pxDataGridGetData,0)}),e.reset=function(){e.currentPage=0,e.currentRecordCount=0,e.internalControl.selectedItems=[],e.internalControl.rowsSelected=[]},e.pxDataGridGetData=function(){e.rowsSelected=[];var t="";t+="l",t+="t",t+="i",t+="p",t+="r";var a={};e.ajaxUrl&&(a.ajax={url:e.ajaxUrl,dataSrc:""}),a.language={processing:"Processando...",search:"Filtrar registros carregados",lengthMenu:"Visualizar _MENU_ registros",info:"Monstrando de _START_ a _END_ no total de _TOTAL_ registros.",infoEmpty:"Nenhum registro encontrado",zeroRecords:"Nenhum registro encontrado",emptyTable:"Nenhum registro encontrado.",infoFiltered:"",paginate:{first:"Primeira",previous:"« Anterior",next:"Próxima »",last:"Última"}},n.isMobile()&&(a.pagingType="simple",a.pageLength=8),a.bFilter=!0,a.bLengthChange=e.lengthChange,a.lengthMenu=e.lengthMenu,a.sDom=t,a.bProcessing=!0,a.aoColumns=e.aoColumns,a.destroy=!0,e.check&&(a.columnDefs=[{targets:0,searchable:!1,orderable:!1,className:"dt-body-center",render:function(e,t,a,r){return"<input type='checkbox'>"}}]),a.order=[],a.rowCallback=function(t,a,r){var n=a.pxDataGridRowNumber;-1!==$.inArray(n,e.rowsSelected)&&($(t).find('input[type="checkbox"]').prop("checked",!0),$(t).addClass("selected"))},requirejs(["datatables"],function(){$("#pxTable").dataTable(a)}),e.pxTableReady=!1,e.dataInit===!0&&e.getData(0,e.rowsProcess),requirejs(["datatables"],function(){$("#pxTable").DataTable();e.internalControl.table=$("#pxTable").DataTable()}),$("#pxTable").on("page.dt",function(){var t=e.internalControl.table.page.info();t.page===t.pages-1&&(e.currentPage=t.page,e.getData(e.nextRowFrom,e.nextRowTo)),0===t.start&&(t.start=1),e.internalControl.table.context[0].oLanguage.sInfo=t.recordsTotal+" registros carregados. Total de registros na base de dados: "+e.recordCount}),e.updateDataTableSelectAllCtrl=function(t){if(1!=!e.check){var a=t.table().node(),r=$('tbody input[type="checkbox"]',a),n=$('tbody input[type="checkbox"]:checked',a),o=$('thead input[name="select_all"]',a).get(0);0===n.length?(o.checked=!1,"indeterminate"in o&&(o.indeterminate=!1)):n.length===r.length?(o.checked=!0,"indeterminate"in o&&(o.indeterminate=!1)):(o.checked=!0,"indeterminate"in o&&(o.indeterminate=!0))}},$("#pxTable tbody").on("click",'input[type="checkbox"]',function(t){var a=$(this).closest("tr"),r=e.internalControl.table.row(a).data(),n=r.pxDataGridRowNumber,o=$.inArray(n,e.rowsSelected);this.checked&&-1===o?(e.rowsSelected.push(n),e.internalControl.selectedItems.push(r)):this.checked||-1===o||(e.rowsSelected.splice(o,1),e.internalControl.selectedItems.splice(o,1)),this.checked?a.addClass("selected"):a.removeClass("selected"),e.updateDataTableSelectAllCtrl(e.internalControl.table),e.$apply(function(){e.$eval(e.itemClick)}),t.stopPropagation()}),$("#pxTable").on("click","tbody td, thead th:first-child",function(e){$(this).parent().find('input[type="checkbox"]').trigger("click")}),$('#pxTable thead input[name="select_all"]').on("click",function(e){this.checked?$('#pxTable tbody input[type="checkbox"]:not(:checked)').trigger("click"):$('#pxTable tbody input[type="checkbox"]:checked').trigger("click"),e.stopPropagation()}),$("#pxTable").on("draw",function(){e.updateDataTableSelectAllCtrl(table)})},e.getData=function(a,l){e.internalControl.working=!0;var i=JSON.parse(e.fields);angular.forEach(i,function(e){if(e.filterObject={},angular.isDefined(e.filter)){var t="#"+e.filter,a=e.filter;if(angular.isDefined(angular.element($(t+"_pxComplete").get(0)).scope())&&(t+="_pxComplete",a="selectedItem"),angular.element($(t).get(0)).scope().hasOwnProperty(a)){var r=angular.element($(t).get(0)).scope()[a];if(!angular.isDefined(r))return;var o=e.field,l=r;angular.isDefined(e.filterOptions)&&(o=e.filterOptions.field,r?(l=r[e.filterOptions.selectedItem],angular.isDefined(l)||(l=r[e.filterOptions.selectedItem.toUpperCase()]),"%"===l&&(l=null)):l=null),null!==l&&""!==l?e.filterObject={field:o,value:l}:e.filterObject={}}else e.filterObject={};e.filterObject.value=n.filterOperator(e.filterObject.value,e.filterOperator)}});var s={};s.table=e.table,s.fields=angular.toJson(i),s.orderBy=e.orderBy,s.rows=e.rowsProcess,angular.isDefined(a)&&(s.rowFrom=a),angular.isDefined(l)&&(s.rowTo=l),0===a&&(e.reset(),requirejs(["datatables"],function(){$("#pxTable").DataTable().clear().draw()})),t({method:"POST",url:r.PX_PACKAGE+"system/components/px-data-grid/px-data-grid.cfc?method=getData",dataType:"json",params:s}).success(function(t){if(e.debug&&console.info("grid getData success",t),angular.isDefined(t.fault))alert("Ops! Ocorreu um erro inesperado.\nPor favor contate o administrador do sistema!");else if(t.qQuery.length>0){angular.forEach(t.qQuery,function(t){e.currentRecordCount++;var a={};a.pxDataGridRowNumber=e.currentRecordCount,angular.forEach(JSON.parse(e.fields),function(e){if(angular.isDefined(t[e.field])?a[e.field]=t[e.field]:a[e.field]=t[e.field.toUpperCase()],e.stringMask)switch(e.stringMask){case"cpf":a[e.field]=o.maskFormat(a[e.field],"###.###.###-##").result;break;case"cnpj":a[e.field]=o.maskFormat(a[e.field],"##.###.###/####-##").result;break;case"cep":a[e.field]=o.maskFormat(a[e.field],"#####-###").result;break;case"brPhone":11===a[e.field].length?a[e.field]=o.maskFormat(a[e.field],"(##) #####-####").result:a[e.field]=o.maskFormat(a[e.field],"(##) #####-####").result;break;default:a[e.field]=o.maskFormat(a[e.field],e.stringMask).result}if(e.moment,e.numeral)switch(e.numeral){case"currency":a[e.field]=numeral(a[e.field]).format("0,0.00");break;default:a[e.field]=numeral(a[e.field]).format(e.numeral)}}),$("#pxTable").DataTable().row.add(a).draw()}),e.recordCount=t.recordCount,e.nextRowFrom=t.rowFrom+e.rowsProcess,e.nextRowTo=t.rowTo+e.rowsProcess;var a=$("#pxTable").DataTable();a.page(e.currentPage).draw(!1);var r=a.page.info();0===r.start&&(r.start=1),$("#pxTable_info").html(r.recordsTotal+" registros carregados. Total de registros na base de dados: "+e.recordCount),e.demand?e.internalControl.working=!1:e.getData(e.nextRowFrom,e.nextRowTo)}else e.internalControl.working=!1}).error(function(e,t,a,r){alert("Ops! Ocorreu um erro inesperado.\nPor favor contate o administrador do sistema!")})},e.remove=function(){var t=JSON.parse(e.fields);pxDataGridService.remove(e.table,angular.toJson(t),angular.toJson(e.internalControl.selectedItems),function(t){if(t.success){e.internalControl.table.rows(".selected").remove().draw(!1);var a=e.internalControl.table.page.info();0===a.start&&(a.start=1),e.recordCount-=e.rowsSelected.length,$("#pxTable_info").html(a.recordsTotal+" registros carregados. Total de registros na base de dados: "+e.recordCount),e.internalControl.selectedItems=[],e.rowsSelected=[]}else alert("Ops! Ocorreu um erro inesperado.\nPor favor contate o administrador do sistema!")})}}e.directive("pxDataGrid",["pxConfig","pxDataGridService","pxUtil","pxMaskUtil","$timeout","$sce",function(e,a,r,n,o,l){return{restrict:"E",replace:!0,transclude:!1,templateUrl:e.PX_PACKAGE+"system/components/px-data-grid/px-data-grid.html",scope:{debug:"=pxDebug",lengthChange:"=pxLengthChange",lengthMenu:"=pxLengthMenu",ajaxUrl:"@pxAjaxUrl",table:"@pxTable",fields:"@pxFields",orderBy:"@pxOrderBy",columns:"@pxColumns",check:"=pxCheck",init:"&pxInit",itemClick:"&pxItemClick",dataInit:"=pxDataInit",rowsProcess:"=pxRowsProcess",demand:"=pxDemand",control:"="},link:function(e,t,a){e.rowsProcess=e.rowsProcess||100,angular.isDefined(e.demand)||(e.demand=!0),e.$watch("fields",function(t,a){""!==t&&(t=JSON.parse(t)),e.dataTable="",e.dataTable+="<thead>",e.aoColumns=[],e.columns="";var r=0,n={};angular.forEach(t,function(t){0===r&&e.check&&(e.columns+='<th class="text-left"><input name="select_all" value="1" type="checkbox"></th>',n={},n.mData="pxDataGridRowNumber",e.aoColumns.push(n)),e.columns+='<th class="text-left">'+t.title+"</th>",n={},n.mData=t.field,e.aoColumns.push(n),r++}),e.dataTable+=e.columns,e.dataTable+="</thead>",e.dataTable+="<tbody></tbody>",e.dataTable+="<tfoot>",e.dataTable+=e.columns,e.dataTable+="</tfoot>",e.dataTable=l.trustAsHtml(e.dataTable),e.pxTableReady=!0,e.internalControl=e.control||{},e.internalControl.working=!1,e.internalControl.getData=function(){e.getData(0,e.rowsProcess)},e.internalControl.remove=function(){e.remove()},e.internalControl.selectedItems=[],e.currentRecordCount=0}),o(e.init,0)},controller:t}}]),t.$inject=["$scope","$http","$timeout","pxConfig","pxUtil","pxMaskUtil"]});