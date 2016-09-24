define(["../controllers/module"],function(e){"use strict";function t(e,t,r,o,l,a,n){r.dataStatus={arrayStatusAll:n.status(!0),arrayStatus:n.status(!1)},r.expand=!1,r.showFilter=function(){var e=$("#headerSearch"),t=e.next();t.slideToggle(500,function(){}),r.filterExpand=!r.filterExpand,e.blur()},r.per_id_searchConfig={table:"dbo.perfil",fields:[{title:"",labelField:!0,field:"per_nome",search:!0,type:"varchar",filterOperator:"%LIKE%"},{title:"",field:"per_id"}]},r.grupo_searchConfig={table:"dbo.grupo",fields:[{title:"",labelField:!0,field:"grupo_nome",search:!0,type:"varchar",filterOperator:"%LIKE%"},{title:"",field:"grupo_id"}]},r.gridControl={},r.dgConfig={schema:"dbo",table:"usuario",view:"vw_usuario",fields:[{pk:!0,visible:!1,title:"ID",field:"usu_id",type:"int",identity:!0},{title:"Nome",field:"usu_nome",type:"varchar",filter:"filtro_usu_nome",filterOperator:"%LIKE%"},{title:"Login",field:"usu_login",type:"varchar",filter:"filtro_usu_login",filterOperator:"%LIKE%"},{title:"CPF",field:"usu_cpf",type:"int",stringMask:"###.###.###-##",filter:"filtro_usu_cpf",filterOperator:"="},{title:"Status",field:"usu_ativo_label",type:"bit",filter:"filtro_usu_ativo",filterOperator:"=",filterOptions:{field:"usu_ativo",selectedItem:"id"}},{title:"Último acesso",field:"usu_ultimoAcesso",type:"datetime",moment:"dddd - DD/MM/YYYY HH:mm:ss"}]},r.gridInit=function(){r.getData()},r.getData=function(){t.globals.currentUser.per_master||(r.dgConfig.where=[{field:"per_master",type:"bit",filterOperator:"<>",filterValue:"1"}]),r.gridControl.getData()},r.remove=function(){r.gridControl.remove()},r.formTitle="Formulário de Adicionar",r.setFormTitle=function(){"default"===r.formShow?"insert"===r.formAction?r.formTitle="Formulário de Adicionar":r.formTitle="Formulário de Editar":"perfil"===r.formShow?r.formTitle="Selecione um perfil":"grupo"===r.formShow&&(r.formTitle="Selecione um grupo")},r.add=function(t){r.formAction="insert",r.disabledSenha=!1,r.setFormTitle(),i.$inject=["$scope","$mdDialog","pxArrayUtil","usuarioService"],a.show({scope:r,preserveScope:!0,controller:i,templateUrl:e.PX_PACKAGE+"system/usuario/usuario-form.html",parent:angular.element(document.body),targetEvent:t,clickOutsideToClose:!1})},r.edit=function(t){r.formAction="update",r.formItemEdit=t.itemEdit,r.setFormTitle(),i.$inject=["$scope","$mdDialog","pxArrayUtil"],a.show({scope:r,preserveScope:!0,controller:i,templateUrl:e.PX_PACKAGE+"system/usuario/usuario-form.html",parent:angular.element(document.body),targetEvent:t,clickOutsideToClose:!1})}}function i(e,t,i,r){e.formControl={},e.per_id_searchControl={},e.grupo_searchControl={},e.per_id_searchClick=function(){e.formShow="perfil",e.setFormTitle()},e.grupo_searchClick=function(){e.formShow="grupo",e.setFormTitle()},e.formInit=function(){if(e.formShow="default",e.formClean(),e.formConfig={table:"dbo.usuario",view:"dbo.vw_usuario",fields:[{pk:!0,field:"usu_id",type:"int",identity:!0},{field:"grupo_id",fieldValueOptions:{selectedItem:"grupo_id"},type:"int",element:"grupo_id",insert:!1,update:!1},{field:"usu_ativo",labelField:"usu_ativo_label",fieldValueOptions:{selectedItem:"id",selectedLabel:"name"},type:"int",element:"usu_ativo"},{field:"per_id",fieldValueOptions:{selectedItem:"per_id"},type:"int",element:"per_id"},{field:"usu_login",type:"varchar",element:"usu_login"},{field:"usu_senha",type:"varchar",element:"usu_senha",hash:!0},{field:"usu_senha_confirmar",type:"varchar",element:"usu_senha_confirmar",select:!1,insert:!1,update:!1},{field:"usu_nome",type:"varchar",element:"usu_nome"},{field:"usu_email",type:"varchar",element:"usu_email"},{field:"usu_cpf",type:"varchar",element:"usu_cpf"},{field:"usu_senhaExpira",type:"int",element:"usu_senhaExpira"},{field:"usu_mudarSenha",type:"bit",element:"usu_mudarSenha"},{field:"usu_tentativasLogin",type:"int",element:"usu_tentativasLogin"}]},e.usu_ativo=e.dataStatus.arrayStatus,"update"==e.formAction){e.formControl.select(e.formItemEdit);var t=i.getIndexByProperty(e.formConfig.fields,"field","usu_senha");e.formConfig.fields[t].update=!1,e.disabledSenha=!0}},e.formInsert=function(){e.formControl.insert()},e.formUpdate=function(){e.formControl.update()},e.formCallback=function(i){"select"===i.action?(e.usu_senha="***************",e.usu_senha_confirmar="***************"):"insert"!=i.action||i.error?"update"!=i.action||i.error?alert("Ops! Ocorreu um erro inesperado.\nPor favor contate o administrador do sistema!"):(e.gridControl.updateDataRow(i.data),t.hide()):(e.gridControl.addDataRow(i.data),t.hide())},e.formCancel=function(){"default"===e.formShow?t.cancel():e.formShow="default"},e.formClean=function(){e.formControl.clean()},e.redefinirSenha=function(){e.usu_senha="",e.usu_senha_confirmar="";var t=i.getIndexByProperty(e.formConfig.fields,"field","usu_senha");e.formConfig.fields[t].update=!0,e.disabledSenha=!1},e.dgPerfilControl={},e.dgGrupoControl={},e.dgPerfilInit=function(){e.dgPerfilConfig={table:"dbo.perfil",view:"dbo.vw_perfil",fields:[{pk:!0,title:"ID",field:"per_id",type:"int",identity:!0},{title:"Nome",field:"per_nome",type:"varchar",filter:"filtro_per_nome",filterOperator:"%LIKE%"},{title:"Status",field:"per_ativo_label",type:"bit",filter:"filtro_per_ativo",filterOperator:"=",filterOptions:{field:"per_ativo",selectedItem:"id"}}]}},e.dgGrupoInit=function(){e.dgGrupoConfig={table:"dbo.grupo",fields:[{pk:!0,title:"Grupo",field:"grupo_id",type:"int",identity:!0},{title:"Nome",field:"grupo_nome",type:"varchar",filter:"filtro_grupo_nome",filterOperator:"%LIKE%"}]}},e.getDataPerfil=function(){e.dgPerfilControl.getData()},e.getDataGrupo=function(){e.dgGrupoControl.getData()},e.dgPerfilItemClick=function(t){console.info("dgPerfilItemClick",e.per_id_searchControl.getValue()),e.formShow="default",e.per_id_searchControl.setValue(t.itemClick),e.setFormTitle()},e.dgGrupoItemClick=function(t){e.formShow="default",e.grupo_searchControl.setValue(t.itemClick),e.setFormTitle()}}e.controller("usuarioCtrl",t),t.$inject=["pxConfig","$rootScope","$scope","$element","$attrs","$mdDialog","usuarioService"]});