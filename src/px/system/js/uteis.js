/**
 * Armanzena URL de cada script a ser carregado por ordem.
 * @type {Array}
 */
var scripts = ['/px-project/src/px/custom/js/custom.js'];

(function($) {
    jQuery.fn.extend({
        carregarScripts: function(scripts) {
            var chain = $.Deferred();
            chain.resolve();
            scripts.forEach(function(script, index, array) {
                chain = chain.then(function() {
                    return $.getScript(script, function(data, status) {
                        //console.info('Status: ' + status + ' - ' + script);
                    });
                });
            });
            chain.then(function() {
                //console.info('uteis.js: Carregamento de scripts completo.');
            });
            return chain.promise();
        }
    });
})(jQuery);


$(document).carregarScripts(scripts)
    .then(function() {
        angular.element(document).ready(function() {
            angular.bootstrap($('#angularContainer'), ['pxProjectApp']);
        });
    });


/**
 * [carregarScripts description]
 * @param  {Function} callback [description]
 * @return {[type]}            [description]
 */
/*
function carregarScripts(callback) {
	
    if (scripts == null || scripts.length == 0) {
        callback();
        return;
    }
    var script = scripts[0];
    scripts = scripts.slice(1);
    
    // http://api.jquery.com/jquery.getscript/
    $.getScript(script, function() { carregarScripts(callback); });
}

carregarScripts(function(){ iniciarProcessamento(); });
*/
/**
 * [iniciarProcessamento description]
 * @param  {Function} callback [description]
 * @return {[type]}            [description]
 */
/*
function iniciarProcessamento(callback) {
	
	console.log("px-project-scripts: ok")
}

console.log("px/system/js/uteis.js: ok");
*/