app.controller('exemploCtrl', ['exemploService', 'pxConfig', '$scope', '$element', '$attrs', function(exemploService, pxConfig, $scope, $element, $attrs, $rootScope) {

    // Variáveis gerais - Start

    // Define as opções de status
    $scope.dataStatus = {
        // array, opções do select com opção "Todos"
        optionsAll: exemploService.status(true),
        // array, opções do select sem opção "Todos"
        options: exemploService.status(false),
    };

    // default de options para o filtro filtroStatus
    $scope.filtroStatus = exemploService.status(true)[0];

    // Configuração do filtro filtroComplete
    $scope.filtroComplete = {
        fields: [{
            title: '',
            labelField: true,
            field: 'exe_nome',
            search: true,
            type: 'string',
            filterOperator: '%LIKE%'
        }, {
            title: 'CPF: ',
            descriptionField: true,
            field: 'exe_cpf',
        }]
    };

    // Variáveis gerais - End

    // Listagem - Start

    /**
     * Controle da listagem
     * Note que a propriedade 'control' da directive px-data-grid é igual a 'gridControl'
     * Exemplo: <px-data-grid control="gridControl">
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
         * @type {object}
         */
        $scope.gridConfig = {
            fields: [{
                pk: true,
                title: 'id',
                field: 'exe_id',
                type: 'int',
                filter: angular.element($('#filtroId')),
                filterOperator: '='
            }, {
                title: 'Status',
                field: 'exe_ativo_label',
                type: 'bit',
                filter: angular.element($('#filtroStatus')),
                filterOperator: '=',
                filterOptions: {
                    field: 'exe_ativo',
                    selectedItem: 'id'
                }
            }, {
                title: 'Nome',
                field: 'exe_nome',
                type: 'string',
                filter: angular.element($('#filtroNome')),
                filterOperator: '%LIKE%'
            }, {
                title: 'CPF',
                field: 'exe_cpf',
                type: 'int',
                filter: angular.element($('#filtroCPF')),
                filterOperator: '='
            }, {
                title: 'Telefone',
                field: 'exe_telefone',
                type: 'string',
                filter: angular.element($('#filtroTelefone')),
                filterOperator: '='
            }, {
                title: 'Valor',
                field: 'exe_valor',
                type: 'decimal',
                filter: angular.element($('#filtroValor')),
                filterOperator: '='
            }, {
                title: 'Data',
                field: 'exe_data',
                type: 'datetime'
            }],
        };
    };

    /**
     * Chama função da listagem que carrega os dados
     * @return {void}
     */
    $scope.getData = function() {
        //Recuperar dados que são carregados na listagem
        $scope.gridControl.getData();
    };

    // Listagem - End

    /**
     * Variável de controle de visualição do Filtro Avançado
     * @type {Boolean}
     */
    $scope.expand = false;
    /**
     * Responsável por realizar o efeito de expandir o Filtro Avançado
     * @return {void}
     */
    $scope.showFilter = function() {

        $header = $('#headerSearch');
        $content = $header.next();
        $content.slideToggle(500, function() {});
        $scope.filterExpand = !$scope.filterExpand;
        $header.blur();
    };
}]);