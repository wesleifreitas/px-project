$(function() {
	/**
	 * Module pxConfig
	 * Configurações do sistema
	 */
	angular.module('pxConfig', [])
		.constant('pxConfig', {
			PX_PACKAGE: '', // Pacote Phoenix Project
			EXTERNAL_COMPONENTS: 'bower_components/', // Componentes externos
			PROJECT_NAME: 'Phoenix Project', // Nome do projedto
			PROJECT_SRC: 'px-project/src/' // Source do projedto
		})
		.config(function(pxConfig) {

			// Custom Controllers	
			/*
			Exemplo:
			
			var controllers = [{
				file: 'custom/cliente/cliente.controller.js'
			}, {
				file: 'custom/produto/produto.controller.js'
			}, {
				file: 'custom/pedido/pedido.controller.js'
			}];
			*/
			var controllers = [{
				file: 'custom/controller/exemploCtrl.js'
			}];

			// Loop em controllers
			// Incluir custom controllers
			$.each(controllers, function(i, item) {
				$("<script/>").attr('src', pxConfig.PX_PACKAGE + item.file).appendTo($('head'));
			});
		});
});