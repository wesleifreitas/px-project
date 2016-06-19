define(['angular'], function(ng) {
	'use strict';

	// Package Phoenix Project
	var PX_PACKAGE = '';
	// Caminho de componentes ColdFusion (Phoenix Project)
	// Ex.: 'my-project.src'
	var PX_CFC_PATH = 'px-project.src' + PX_PACKAGE.replace(/\/|\\/g, ".");

	var config = ng.module('pxConfig', [])
		.constant('pxConfig', {
			PX_PACKAGE: PX_PACKAGE, // Package Phoenix Project
			PX_CFC_PATH: PX_CFC_PATH,
			LIB: 'lib/', // Componentes externos
			PROJECT_ID: 0, // Identificação do projeto (table: px.project)
			PROJECT_NAME: 'Phoenix Project', // Nome do projeto
			PROJECT_SRC: 'px-project/src/', // Source do projeto
			PROJECT_CSS: [PX_PACKAGE + 'system/login/login.css','styles.css'], // Arquivos .css
			PROJECT_DSN: 'px_project_sql', // Data Source Name (CF)
			LOCALE: 'pt-BR', // Locale
			LOGIN_REQUIRED: true, // Login obrigatório?
			GROUP: true, // Agrupar dados?
			GROUP_TABLE: 'grupo', // Tabela Group
			GROUP_ITEM_SUFFIX: '', // Sufixo do campo GROUP_ITEM
			GROUP_LABEL_SUFFIX: '', // Sufixo do campo GROUP_LABEL
			GROUP_REPLACE: [], // Substituir no nome do campo GROUP
			GROUP_ITEM:'grupo_id', // Idetificador de GROUP (Utilizar quando GROUP_ITEM_SUFFIX === '')
			GROUP_LABEL:'grupo_nome' // Label do GROUP (Utilizar quando GROUP_LABEL_SUFFIX === '')
		});
		
	return config;
});