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
            init: '&pxInit'
        },
        link: function(scope, element, attrs) {
            // Manipulação e Eventos DOM           

            scope.$watch('fields', function(newValue, oldValue) {

                console.info('link: fields has changed', newValue); // valor atual.
                console.info(oldValue + ' -> ' + newValue);

                scope.dataTable = ''
                scope.dataTable += '<thead>';

                // Campos para o dataTable (dados)
                scope.aoColumns = [];
                // Colunas para o <table>
                scope.columns = '';

                angular.forEach(newValue, function(index) {
                    scope.columns += '<th class="text-left>' + index.title + '</th>';

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
                //scope.dataTable += '</table>';

                console.log(scope.dataTable);
                console.log($('pxTable'));
                console.info('aoColumns', scope.aoColumns);

                // Quantidade de linhas por consulta
                scope.rows = 50;
                /*
                scope.aoColumns = [{
                    "mData": "exe_id"
                }, {
                    "mData": "exe_nome"
                }, {
                    "mData": "exe_cpf"
                }, {
                    "mData": "exe_data"
                }];
                */
                scope.pxTableReady = true;

            });

            timer(scope.init, 0); // Chama a função px-init

        },
        controller: function($scope, $element, $attrs, $http) {

            // Verifica se a grid a está preparada para receber os dados
            $scope.pxTableReady = false;

            // A página atual começa em 0
            $scope.currentPage = 0;

            $scope.$watch('pxTableReady', function(newValue, oldValue) {

                console.info('link: pxTableReady has changed', newValue); // valor atual.
                console.info(oldValue + ' -> ' + newValue);

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
                    "lengthMenu": [10, 25, 45],
                    "bProcessing": true,
                    //"sAjaxSource": "px-project research/dataTables/data/exemplo.json",
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
                    "aoColumns": $scope.aoColumns
                });

                $scope.pxTableReady = false;

                $scope.getData(0, $scope.rows);


                // Eventos do dataTable pxTable
                var table = $('#pxTable').DataTable();

                // https://datatables.net/reference/event/page
                $('#pxTable').on('page.dt', function() {

                    var info = table.page.info();
                    console.info('pxTable on page.dt', info);

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

                $http({
                    method: 'POST',
                    url: pxProjectPackage() + 'px/system/model/grid.cfc?method=getData',
                    params: params
                }).success(function(result) {

                    //console.info('grid getData success', result);

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

                            var table = $('#pxTable').DataTable()
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