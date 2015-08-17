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

			// Custom JS	
			/*
			Exemplo:

			var controllers = [{
				file: 'custom/cliente/cliente.controller.js'
			}, {
				file: 'custom/produto/cliente.service.js'
			}, {
				file: 'custom/produto/pedido.controller.js'
			}, {
				file: 'custom/pedido/pedido.service.js'
			}];
			*/
			var jsLoader = [{
				file: 'custom/exemplo/exemplo.controller.js'
			}, {
				file: 'custom/exemplo/exemplo.service.js'
			}];

			// Loop em jsLoader
			// Incluir java scripts
			$.each(jsLoader, function(i, item) {
				$("<script/>").attr('src', pxConfig.PX_PACKAGE + item.file).appendTo($('head'));
			});
		});
});