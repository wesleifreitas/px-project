define(["../controllers/module"],function(e){"use strict";e.controller("LoginCtrl",["$timeout","pxCssLoader","$scope","$location","loginService","FlashService","$mdDialog",function(e,s,i,n,o,a,t){s.load();var r=this;r.formTitle="Login",r.loginMessage="",r.initController=function(){o.ClearCredentials()}(),r.login=function(){"default"===r.selection&&(r.dataLoading=!0,o.Login(r.username,r.password,function(e){if(r.loginMessage=e.message,e.success){if(1===e.qQuery[0].USU_MUDARSENHA)return r.dataLoading=!1,r.formTitle="Alteração de senha",r.selection="redefine",void(r.id=e.qQuery[0].USU_ID);o.SetCredentials(r.username,r.password,e),n.path("/home")}else a.Error(e.message),r.dataLoading=!1,$("#loginDiv").effect("shake",{direction:"left",distance:10,times:3})}))},r.redefine=function(){r.dataLoading=!0,o.Redefine(r.id,r.username,r.usu_senha,function(e){e.success?(o.SetCredentials(r.username,r.password,e),n.path("/")):(r.loginMessage=e.message,a.Error(e.message),r.dataLoading=!1,$("#loginDiv").effect("shake",{direction:"left",distance:10,times:3}))})},r.redefineForm=function(){String(r.password)!==String(r.usu_senha_atual)?i.loginForm.usu_senha_atual.$setValidity("confirm",!1):i.loginForm.usu_senha_atual.$setValidity("confirm",!0),String(r.usu_senha)===String(r.password)?i.loginForm.usu_senha.$setValidity("equal",!1):(i.loginForm.usu_senha.$setValidity("equal",!0),String(r.usu_senha)!==String(r.usu_senha_confirmar)?i.loginForm.usu_senha_confirmar.$setValidity("confirm",!1):i.loginForm.usu_senha_confirmar.$setValidity("confirm",!0))},r.recover=function(){r.dataLoading=!0,o.Recover(r.username,r.email,function(e){e.success?(alert("Foi enviado um e-mail para "+r.email+" com as instruções de recuperação de login"),r.showLogin()):(r.loginMessage=e.message,a.Error(e.message),r.dataLoading=!1,$("#loginDiv").effect("shake",{direction:"left",distance:10,times:3}))})},r.showRecover=function(){r.password="",r.loginMessage="",r.formTitle="Recuperar senha",r.selection="recover"},r.showLogin=function(){r.password="",r.email="",r.usu_senha_atual="",r.usu_senha="",r.usu_senha_confirmar="",r.loginMessage="",r.formTitle="Login",r.selection="default"},r.selection="default",r.showNewUser=function(){i.formTitle="Cadastro de usuário",i.formAction="insert",t.show({scope:i,preserveScope:!0,templateUrl:"custom/register/register-form.html",parent:angular.element(document.body),targetEvent:event,clickOutsideToClose:!0})}}])});