/**
 * Module pxGrid
 */
angular.module('pxGrid', ['ngSanitize'])
    .value('pxGridConfig', {

    })
    .directive('pxGrid', ['pxGridConfig', 'pxConfig', '$timeout', '$sce', function(pxGridConfig, pxConfig, $timeout, $sce) {
        return {
            restrict: 'E',
            replace: true,
            transclude: false,
            templateUrl: pxConfig.PX_PACKAGE + 'px/system/view/grid.html',
            scope: {
                debug: '@pxDebug',
                table: '@pxTable',
                fields: '@pxFields',
                orderBy: '@pxOrderBy',
                columns: '@pxColumns',
                init: '&pxInit',
                itemClick: '&pxItemClick',
                dataInit: '@pxDataInit',
                control: '='
            },
            link: function(scope, element, attrs) {

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

                    var i = 0;
                    var aoColumnsData = {};
                    angular.forEach(newValue, function(index) {

                        if (i == 0) {
                            scope.columns += '<th class="text-left"><input name="select_all" value="1" type="checkbox"></th>';

                            aoColumnsData = new Object();
                            aoColumnsData.mData = 'pxGridRowNumber';

                            scope.aoColumns.push(aoColumnsData);
                        }

                        scope.columns += '<th class="text-left">' + index.title + '</th>';

                        aoColumnsData = new Object();
                        aoColumnsData.mData = index.field;

                        scope.aoColumns.push(aoColumnsData);
                        i++;
                    });
                    scope.dataTable += scope.columns;

                    scope.dataTable += '</thead>';

                    scope.dataTable += '<tbody></tbody>';

                    scope.dataTable += '<tfoot>';
                    scope.dataTable += scope.columns;
                    scope.dataTable += '</tfoot>';

                    scope.dataTable = $sce.trustAsHtml(scope.dataTable);

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

                    // Armazena itens selecionados da listagem
                    scope.internalControl.selectedItems = [];

                    // Armazena número atual de linhas carregadas
                    scope.currentRecordCount = 0;

                    // Internal Control - End

                });

                // Chama evento px-init
                $timeout(scope.init, 0);

            },
            controller: function($scope, $element, $attrs, $http) {

                // Verifica se a grid a está preparada para receber os dados
                $scope.pxTableReady = false;

                // A página atual inicia-se em 0
                $scope.currentPage = 0;

                $scope.$watch('pxTableReady', function(newValue, oldValue) {

                    if (newValue == true) {
                        $timeout($scope.pxGridGetData, 0);
                    }
                });

                $scope.pxGridGetData = function() {

                    // Armazena linhas selecionadas (checkbox)
                    var rows_selected = [];
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
                        "bFilter": false,
                        "bLengthChange": false,
                        "lengthMenu": [20, 35, 45],
                        "bProcessing": true,
                        "aoColumns": $scope.aoColumns,
                        "destroy": true,
                        'columnDefs': [{
                            'targets': 0,
                            'searchable': false,
                            'orderable': false,
                            'className': 'dt-body-center',
                            'render': function(data, type, full, meta) {
                                return '<input type="checkbox">';
                            }
                        }],
                        "order": [1, 'asc'],
                        "rowCallback": function(row, data, dataIndex) {
                            // Linhda ID
                            var rowId = data.pxGridRowNumber;

                            // Se a linha ID está na lista de IDs de linha selecionados
                            if ($.inArray(rowId, rows_selected) !== -1) {
                                $(row).find('input[type="checkbox"]').prop('checked', true);
                                $(row).addClass('selected');
                            }
                        }
                    });

                    $scope.pxTableReady = false;

                    // Se a propriedade pxGetData for igual a true                
                    if ($scope.dataInit == 'true') {
                        // Recupera dados assim que a listagem é criada 
                        $scope.getData(0, $scope.rows);
                    }

                    var table = $('#pxTable').DataTable();

                    // Evento page.dt
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

                    // Atualizar dataTable (Selecionar tudo)
                    $scope.updateDataTableSelectAllCtrl = function(table) {
                        var $table = table.table().node();
                        var $chkbox_all = $('tbody input[type="checkbox"]', $table);
                        var $chkbox_checked = $('tbody input[type="checkbox"]:checked', $table);
                        var chkbox_select_all = $('thead input[name="select_all"]', $table).get(0);

                        // Se não possuir nenhum checkbox selecionado
                        if ($chkbox_checked.length === 0) {
                            chkbox_select_all.checked = false;
                            if ('indeterminate' in chkbox_select_all) {
                                chkbox_select_all.indeterminate = false;
                            }

                            // Se todos os checkboxes estiverem selecionados
                        } else if ($chkbox_checked.length === $chkbox_all.length) {
                            chkbox_select_all.checked = true;
                            if ('indeterminate' in chkbox_select_all) {
                                chkbox_select_all.indeterminate = false;
                            }

                            // Se possuir algum checkbox selecionado
                        } else {
                            chkbox_select_all.checked = true;
                            if ('indeterminate' in chkbox_select_all) {
                                chkbox_select_all.indeterminate = true;
                            }
                        }
                    }

                    // Evento click checkbox
                    $('#pxTable tbody').on('click', 'input[type="checkbox"]', function(e) {
                        var $row = $(this).closest('tr');

                        // Dados da linha
                        var data = table.row($row).data();

                        // ID da linha
                        var rowId = data.pxGridRowNumber;

                        // Se caixa de seleção está marcada e linha ID não está na lista de IDs de linha selecionados
                        var index = $.inArray(rowId, rows_selected);

                        // Se caixa de seleção está marcada e linha ID não está na lista de IDs de linha selecionados
                        if (this.checked && index === -1) {
                            rows_selected.push(rowId);

                            $scope.internalControl.selectedItems.push(data);

                            // Se caixa de seleção está marcada e linha ID não está na lista de IDs de linha selecionados
                        } else if (!this.checked && index !== -1) {
                            rows_selected.splice(index, 1);

                            $scope.internalControl.selectedItems.splice(index, 1);
                        }

                        if (this.checked) {
                            $row.addClass('selected');
                        } else {
                            $row.removeClass('selected');
                        }

                        // Atualizar dataTable (selecionar tudo)
                        $scope.updateDataTableSelectAllCtrl(table);

                        $scope.$apply(function() {
                            // Chama função definida em px-item-click
                            $scope.$eval($scope.itemClick);
                        });

                        e.stopPropagation();
                    });

                    // Evento click células
                    $('#pxTable').on('click', 'tbody td, thead th:first-child', function(e) {
                        $(this).parent().find('input[type="checkbox"]').trigger('click');
                    });

                    // Evento click (selecionar tudo)
                    $('#pxTable thead input[name="select_all"]').on('click', function(e) {
                        if (this.checked) {
                            $('#pxTable tbody input[type="checkbox"]:not(:checked)').trigger('click');
                        } else {
                            $('#pxTable tbody input[type="checkbox"]:checked').trigger('click');
                        }

                        e.stopPropagation();
                    });

                    // Evento draw
                    table.on('draw', function() {
                        // Atualizar dataTable (Selecionar tudo)
                        $scope.updateDataTableSelectAllCtrl(table);
                    });

                };

                /**
                 * Recupera dados para listagem
                 * @param  {number} rowFrom linha inicial
                 * @param  {number} rowTo   linha final
                 * @return {void}         
                 */
                $scope.getData = function(rowFrom, rowTo) {

                    var arrayFields = JSON.parse($scope.fields);

                    // Loop na configuração de campos
                    angular.forEach(arrayFields, function(index) {

                        // Valor do filtro
                        index.filterValue = '';

                        // Verifica se possui campo de filtro
                        // Caso possua campo de filtro será definido o 'filterValue'
                        // filterValue é igual ao valor do campo do filtro 
                        if (angular.isDefined(index.filter)) {

                            // Verifica seu o scope do elemento angular possui valor definido
                            if (angular.element($(index.filter.selector).get(0)).scope().hasOwnProperty(index.filter.selector.replace('#', ''))) {
                                // Se possuir o valor do filtro recebe o valor (ng-model)
                                index.filterValue = angular.element($(index.filter.selector).get(0)).scope()[index.filter.selector.replace('#', '')];
                            } else {
                                // Se não possuir um valor válido no ng-model o valor recebe vazio
                                index.filterValue = '';
                            }

                            // Verifica se o valor do filtro é um valor válido
                            if (angular.isDefined(index.filterValue) && index.filterValue != '') {

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
                    params.fields = angular.toJson(arrayFields);
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
                        // Zera contagem de linhas atuais
                        $scope.currentRecordCount = 0;
                        $('#pxTable').DataTable().clear().draw();
                    }


                    $http({
                        method: 'POST',
                        url: pxConfig.PX_PACKAGE + 'px/system/model/grid.cfc?method=getData',
                        dataType: 'json',
                        params: params
                    }).success(function(result) {

                        console.info('grid getData success', result);
                        //console.info('grid getData success JSON.stringify',JSON.stringify(result,null,"    "));

                        if (angular.isDefined(result.FAULT)) {
                            alert('Ops! Ocorreu um erro inesperado.\nPor favor contate o administrador do sistema!');
                        } else {

                            if (result.qQuery.length > 0) {

                                // Loop na query
                                angular.forEach(result.qQuery, function(index) {

                                    $scope.currentRecordCount++;

                                    // Dados
                                    var data = new Object();

                                    data['pxGridRowNumber'] = $scope.currentRecordCount;
                                    // Loop nas colunas da grid
                                    angular.forEach(JSON.parse($scope.fields), function(item) {

                                        // dDados por campo
                                        data[item.field] = index[item.field.toUpperCase()];
                                    });

                                    // Atualizar dados do dataTable
                                    $('#pxTable').DataTable().row.add(data).draw();

                                });

                                $scope.recordCount = result.recordCount;
                                $scope.nextRowFrom = result.rowFrom + $scope.rows;
                                $scope.nextRowTo = result.rowTo + $scope.rows;

                                //$scope.getData(result.rowFrom + $scope.rows, result.rowTo + $scope.rows);

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