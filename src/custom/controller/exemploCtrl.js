// Este script deve ser carregado em 'px-config.js', verifique a variável 'controllers'
app.controller('exemploCtrl', function($scope, $element, $attrs, $rootScope) {

    //console.info('exemploCtrl carregado com sucesso.');

    /**
     * Controle da listagem
     * Note que a propriedade 'control' da directive px-grid é igual a 'gridControl'
     * Exemplo: <px-grid control="gridControl">
     * @type {Object}
     */
    $scope.gridControl = {};

    /**
     * Inicializa listagem
     * @return {[type]}   [description]
     */
    $scope.gridInit = function() {

        /**
         * Configurações da listagem
         * - fields: Colunas da listagem
         * @type {Object}
         */
        $scope.grid = {
            fields: [{
                title: 'id',
                field: 'exe_id',
                type: 'int',
                filter: angular.element($('#filtroId')),
                filterOperator: '='
            }, {
                title: 'Nome',
                field: 'exe_nome',
                type: 'varchar',
                filter: angular.element($('#filtroNome')),
                filterOperator: '%LIKE%'
            }, {
                title: 'CPF',
                field: 'exe_cpf',
                type: 'int',
                filter: angular.element($('#filtroCPF')),
                filterOperator: '='
            }, {
                title: 'Data',
                field: 'exe_data',
                type: 'varchar'
            }]
        };
    };

    /**
     * Chama função da listagem que carrega os dados
     * @return {[type]} [description]
     */
    $scope.getData = function() {

        console.info($rootScope.globals);
        /**
         * Recupera dados que são carregados na listagem
         */
        $scope.gridControl.getData();
    };

    /**
     * Váriavel de controle de visualição do Filtro Avançado
     * @type {Boolean}
     */
    $scope.expand = false;
    /**
     * Responsável por realizar o efeito de expandir o Filtro Avançado
     * @return {[type]} [description]
     */
    $scope.showFilter = function() {

        $header = $('#headerSearch');
        $content = $header.next();
        $content.slideToggle(500, function() {});
        $scope.filterExpand = !$scope.filterExpand;
        $header.blur();
    };
});