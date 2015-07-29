// Componente <px-grid>
// Exibe listagem de registros.
app.directive('pxGrid', ['$timeout', function(timer) {
    return {
        restrict: 'E',
        replace: true,
        transclude: false,
        templateUrl: pxProjectPackage() + 'px/system/view/grid.html',
        scope: {
            debug: '@pxDebug',
            table: '@pxTable',
            fields: '@pxFields',
            orderBy: '@pxOrderBy',
            columns: '@pxColumns',
            init: '&pxInit',
            dataInit: '@pxDataInit',
            control: '='
        },
        link: function(scope, element, attrs) {
            // Manipulação e Eventos DOM           

            scope.$watch('fields', function(newValue, oldValue) {

                // Transformar valor String para Array   
                if (newValue != '') {
                    newValue = JSON.parse(newValue);
                }

                scope.dataTable = ''
                scope.dataTable += '<thead>';

                // Campos para o dataTable (dados)
                scope.aoColumns = [];
                // Colunas para o <table>
                scope.columns = '';

                angular.forEach(newValue, function(index) {
                    scope.columns += '<th class="text-left">' + index.title + '</th>';

                    var aoColumnsData = new Object();
                    aoColumnsData.mData = index.field;

                    scope.aoColumns.push(aoColumnsData);
                });
                scope.dataTable += scope.columns;

                scope.dataTable += '</thead>';

                scope.dataTable += '<tbody></tbody>';

                scope.dataTable += '<tfoot>';
                scope.dataTable += scope.columns;
                scope.dataTable += '</tfoot>';

                // Quantidade de linhas por consulta
                scope.rows = 50;                
                scope.pxTableReady = true;

                // Internal Control - Start

                // How to call a method defined in an AngularJS directive?
                // http://stackoverflow.com/questions/16881478/how-to-call-a-method-defined-in-an-angularjs-directive
                scope.internalControl = scope.control || {};

                /**
                 * Recupera dados que são carregados na listagem
                 * @return {[type]} [description]
                 */
                scope.internalControl.getData = function() {

                    scope.getData(0, scope.rows);
                }

                // Internal Control - End

            });

            // Chama evento px-init
            timer(scope.init, 0);

        },
        controller: function($scope, $element, $attrs, $http) {

            // Verifica se a grid a está preparada para receber os dados
            $scope.pxTableReady = false;

            // A página atual começa em 0
            $scope.currentPage = 0;

            $scope.$watch('pxTableReady', function(newValue, oldValue) {

                if (newValue == true) {
                    timer($scope.pxGridGetData, 0);
                }
            });

            $scope.pxGridGetData = function() {

                $('#pxTable').dataTable({
                    "language": {
                        processing: "Processando...",
                        search: "Filtrar registros carregados",
                        lengthMenu: "Visualizar _MENU_ registros",
                        //info: "Monstrando de _START_ a _END_ no total de _TOTAL_ registros.",
                        infoEmpty: "Nenhum registro encontrado",
                        zeroRecords: "Nenhum registro encontrado",
                        emptyTable: "Nenhum registro encontrado.",
                        infoFiltered: "",
                        paginate: {
                            first: "Primeira",
                            previous: "« Anterior",
                            next: "Próxima »",
                            last: "Última"
                        }
                    },
                    "bFilter": false, //Disable search function
                    "bLengthChange": false,
                    "lengthMenu": [20, 35, 45],
                    "bProcessing": true,
                    //"sAjaxSource": "http://localhost:8500/px-research/research/dataTables/data/exemplo.json",
                    /*
                    "aoColumns": [{
                        "mData": "exe_id"
                    }, {
                        "mData": "exe_nome"
                    }, {
                        "mData": "exe_cpf"
                    }, {
                        "mData": "exe_data"
                    }]
                    */
                    "aoColumns": $scope.aoColumns,
                    "destroy": true,
                });

                $scope.pxTableReady = false;

                // Se a propriedade pxGetData for igual a true                
                if ($scope.dataInit == 'true') {
                    // Recupera dados assim que a listagem é criada 
                    $scope.getData(0, $scope.rows);
                }

                // Eventos do dataTable pxTable
                var table = $('#pxTable').DataTable();

                // https://datatables.net/reference/event/page
                $('#pxTable').on('page.dt', function() {

                    var info = table.page.info();

                    if (info.page == info.pages - 1) {

                        $scope.currentPage = info.page;
                        $scope.getData($scope.nextRowFrom, $scope.nextRowTo);
                    }

                    //$('#pxTable_length').hide();

                    //console.info('pxTable page.dt table.context',table.context[0]);
                    if (info.start == 0) {
                        info.start = 1;
                    }

                    //table.context[0].oLanguage.sInfo = 'Monstrando de ' + info.start + ' a ' + info.end + ' no total de ' + info.recordsTotal + ' registros carregados.' + '<br>Total de registros na base de dados: ' + $scope.recordCount;
                    table.context[0].oLanguage.sInfo = info.recordsTotal + ' registros carregados.' + ' Total de registros na base de dados: ' + $scope.recordCount;

                });

            };

            $scope.getData = function(rowFrom, rowTo) {

                // Verifica se $scope.fields é Array
                // Se não for tranforma utilizado JSON.parse
                if (!angular.isArray($scope.fields)) {
                    // Transformar valor String para Array   
                    $scope.fields = JSON.parse($scope.fields);
                }

                // Loop na configuração de campos
                angular.forEach($scope.fields, function(index) {

                    // Valor do filtro
                    index.filterValue = '';

                    // Verifica se possui campo de filtro
                    if (angular.isDefined(index.filter)) {
                        // Caso possua campo de filtro, é definido o 'filterValue'
                        // filterValue é igual ao valor do campo do filtro
                        index.filterValue = angular.element(index.filter.selector).val();
                        // Verifica se o valor do filtro é um valor válido
                        if (angular.isDefined(index.filterValue) && index.filterValue != '') {
                            console.info(index.filterValue, 'index.filterValueindex.filterValue');

                            // Regras de filtro por Operator
                            switch (index.filterOperator) {

                                case '%LIKE%':
                                case '%LIKE':
                                case 'LIKE%':
                                    // Valor do filtro recebe '%' o filterOperator possua '%'
                                    // Por exemplo:
                                    // Se filterOperator for igual a '%LIKE%' e valor do filtro for 'teste'
                                    // Neste caso 'LIKE' é substituido por 'teste' 
                                    // Portanto o valor final do filtro será  '%teste%'
                                    index.filterValue = index.filterOperator.toUpperCase().replace('LIKE', index.filterValue);
                                    break;

                                default:

                                    break;

                            }

                        }
                    }

                });

                var params = new Object();
                params.table = $scope.table;
                params.fields = angular.toJson($scope.fields);
                params.orderBy = $scope.orderBy;

                params.rows = $scope.rows;

                if (angular.isDefined(rowFrom)) {
                    params.rowFrom = rowFrom;
                }
                if (angular.isDefined(rowTo)) {
                    params.rowTo = rowTo;
                }

                // Se for a primeira linha significa que é uma nova consulta ao dados
                // Neste caso é feito um 'clear' na listagem
                if (rowFrom == 0) {
                    $('#pxTable').DataTable().clear().draw();
                }


                $http({
                    method: 'POST',
                    url: pxProjectPackage() + 'px/system/model/grid.cfc?method=getData',
                    params: params
                }).success(function(result) {

                    console.info('grid getData success', result);
                    //console.info('grid getData success JSON.stringify',JSON.stringify(result,null,"    "));

                    if (angular.isDefined(result.FAULT)) {
                        //alert('Ops! Ocorreu um erro inesperado.\nPor favor contate o administrador do sistema!');
                        console.error(result);
                    } else {

                        if (result.QQUERY.length > 0) {

                            // Loop na query
                            angular.forEach(result.QQUERY, function(index) {

                                // Dados
                                var data = new Object();

                                // Loop nas colunas da grid
                                angular.forEach($scope.fields, function(item) {

                                    // dDados por campo
                                    data[item.field] = index[item.field.toUpperCase()];
                                });

                                // Atualiza dados do dataTable
                                $('#pxTable').DataTable().row.add(data).draw();

                            });

                            $scope.recordCount = result.RECORDCOUNT;
                            $scope.nextRowFrom = result.ARGUMENTS.ROWFROM + $scope.rows;
                            $scope.nextRowTo = result.ARGUMENTS.ROWTO + $scope.rows;

                            //$scope.getData(result.ARGUMENTS.ROWFROM + $scope.rows, result.ARGUMENTS.ROWTO + $scope.rows);

                            var table = $('#pxTable').DataTable();
                            table.page($scope.currentPage).draw(false);

                            var info = table.page.info();
                            if (info.start == 0) {
                                info.start = 1;
                            }
                            //$('#pxTable_info').html('Monstrando de ' + info.start + ' a ' + info.end + ' no total de ' + info.recordsTotal + ' registros carregados.' + '<br>Total de registros na base de dados: ' + $scope.recordCount);
                            $('#pxTable_info').html(info.recordsTotal + ' registros carregados.' + ' Total de registros na base de dados: ' + $scope.recordCount);



                        }
                    }
                }).
                error(function(data, status, headers, config) {
                    // Erro
                    alert('Ops! Ocorreu um erro inesperado.\nPor favor contate o administrador do sistema!');
                });

            }
        }
    }
}]);