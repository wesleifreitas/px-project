define(['../../filters/module'], function(filters) {
	'use strict';

	// Filter dataGridRefresh
	// Retorna o class adequado para o botão atualizar de acordo com o processamento do dataGrid
	filters.filter('dataGridRefresh', [function() {
		return function(working) {
			// Verifica working da px-data-grid
			// Class no botão Atualizar (Listagem)
			if (working) {
				return 'fa fa-refresh fa-spin';
			} else {
				return 'fa fa-refresh';
			}
		}
	}]);

	return filters;
});