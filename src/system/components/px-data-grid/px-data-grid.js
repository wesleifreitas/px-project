define(['../../directives/module'], function(directives) {
    'use strict';

    directives.directive('pxDataGrid', ['pxConfig', 'pxArrayUtil', 'pxUtil', '$timeout', '$sce', '$rootScope', function(pxConfig, pxArrayUtil, pxUtil, $timeout, $sce, $rootScope) {
        return {
            restrict: 'E',
            replace: true,
            transclude: false,
            templateUrl: pxConfig.PX_PACKAGE + 'system/components/px-data-grid/px-data-grid.html',
            scope: {
                debug: '=pxDebug',
                config: '@pxConfig',
                id: '@id',
                lengthChange: '=pxLengthChange',
                lengthMenu: '=pxLengthMenu',
                ajaxUrl: '@pxAjaxUrl',
                schema: '@pxSchema',
                table: '@pxTable',
                fields: '@pxFields',
                orderBy: '@pxOrderBy',
                group: '@pxGroup',
                groupItem: '@pxGroupItem',
                groupLabel: '@pxGroupLabel',
                where: '@pxWhere',
                columns: '@pxColumns',
                check: '=pxCheck',
                edit: '=pxEdit',
                init: '&pxInit',
                itemClick: '&pxItemClick',
                itemEdit: '&pxItemEdit',
                dataInit: '=pxDataInit',
                rowsProcess: '@pxRowsProcess',
                demand: '@pxDemand',
                control: '=pxControl'
            },
            link: function(scope, element, attrs) {

                if (!angular.isDefined(scope.id) || scope.id === '') {
                    console.warn('pxDataGrid: Existe um px-data-grid sem id, isto pode causar sérios problemas em seu código!');
                }

                // ID do DataTable
                scope.id = scope.id || 'pxTable';

                // Quantidade de linhas por consulta
                scope.rowsProcess = parseInt(scope.rowsProcess) || 100;


                // Consulta por demanda?
                if (!angular.isDefined(scope.demand)) {
                    scope.demand = true;
                } else {
                    scope.demand = (scope.demand === "true");
                }

                // Group
                if (!angular.isDefined(scope.group)) {
                    scope.group = pxConfig.GROUP;
                } else {
                    scope.group = (scope.group === "true");
                }
              
                scope.$watch('config', function(newValue, oldValue) {
                    // Transformar valor String para Array
                    if (newValue !== '') {
                        newValue = JSON.parse(newValue);
                        //console.info(scope.id + ' - new config:', newValue)
                    } else {
                        return;
                    }
                    scope.fields = newValue.fields;

                    scope.dataTable = '';
                    scope.dataTable += '<thead>';

                    // Campos para o dataTable (dados)
                    scope.aoColumns = [];

                    // Colunas para o <table>
                    scope.columns = '';
                                    
                    scope.schema = newValue.schema || 'dbo';
                    scope.table = newValue.table;
                    scope.view = newValue.view;
                    scope.orderBy = newValue.orderBy;
                    scope.where = newValue.where;

                    // Configuração Group
                    scope.group = scope.group || pxConfig.GROUP;
                    if (angular.isDefined(newValue.group)) {
                        scope.group = newValue.group;
                    }
                    if (angular.isDefined(newValue.groupItem)) {
                        scope.groupItem = newValue.groupItem;
                    }
                    if (angular.isDefined(newValue.groupLabel)) {
                        scope.groupLabel = newValue.groupLabel;
                    }

                    if (scope.group === true) {
                        if (pxConfig.GROUP_ITEM_SUFFIX === '') {
                            scope.groupItem = scope.groupItem || pxConfig.GROUP_ITEM;
                        } else if (!angular.isDefined(scope.groupItem)) {
                            scope.groupItem = scope.groupItem || scope.table + '_' + pxConfig.GROUP_ITEM_SUFFIX;
                            for (var i = 0; i < pxConfig.GROUP_REPLACE.length; i++) {
                                scope.groupItem = scope.groupItem.replace(pxConfig.GROUP_REPLACE[i], '');
                            };
                        }
                        if (pxConfig.GROUP_LABEL_SUFFIX === '') {
                            scope.groupLabel = scope.groupLabel || pxConfig.GROUP_LABEL;
                        } else if (!angular.isDefined(scope.groupLabel)) {
                            scope.groupLabel = scope.groupLabel || pxConfig.GROUP_TABLE + '_' + pxConfig.GROUP_LABEL_SUFFIX;
                            for (var i = 0; i < pxConfig.GROUP_REPLACE.length; i++) {
                                scope.groupLabel = scope.groupLabel.replace(pxConfig.GROUP_REPLACE[i], '');
                            };
                        }
                    }

                    if (scope.group && pxArrayUtil.getIndexByProperty(scope.fields, 'field', scope.groupLabel) === -1 && $rootScope.globals.currentUser.per_developer === 1) {
                        if (pxConfig.GROUP_ITEM === '') {
                            scope.fields.push({
                                title: 'Grupo',
                                field: scope.groupLabel,
                                type: 'string',
                                filter: scope.id,
                                filterOperator: '=',
                                filterOptions: {
                                    field: scope.groupItem,
                                    selectedItem: pxConfig.GROUP_TABLE + '_' + pxConfig.GROUP_ITEM_SUFFIX
                                },
                                filterGroup: true
                            });
                        } else {
                            scope.fields.push({
                                title: 'Grupo',
                                field: scope.groupLabel,
                                type: 'string',
                                filter: scope.id,
                                filterOperator: '=',
                                filterOptions: {
                                    field: scope.groupItem,
                                    selectedItem: pxConfig.GROUP_ITEM
                                },
                                filterGroup: true
                            });
                        }
                    }

                    var i = 0;
                    var aoColumnsData = {};
                    var columnDefs = 0;
                    scope.columnDefs = [];

                    angular.forEach(scope.fields, function(index) {

                        // Checkbox  - Start
                        if (i === 0 && scope.check === true) {
                            scope.columns += '<th class="text-left" width="1%"><input name="select_all" value="1" type="checkbox"></th>';

                            aoColumnsData = {};
                            aoColumnsData.mData = 'pxDataGridRowNumber';

                            scope.aoColumns.push(aoColumnsData);

                            scope.columnDefs.push({
                                "targets": columnDefs,
                                "searchable": false,
                                "orderable": false,
                                "className": "dt-body-center",
                                "render": function(data, type, full, meta) {
                                    return "<input type='checkbox'>";
                                }
                            });
                            columnDefs++;
                        }
                        i++;
                        // Checkbox  - End

                        // Edit - Start                        
                        if (i === 1 && scope.edit === true) {
                            scope.columns += '<th class="text-center" width="1%"><i class=""></i></th>';

                            aoColumnsData = {};
                            aoColumnsData.mData = 'edit';

                            scope.aoColumns.push(aoColumnsData);

                            scope.columnDefs.push({
                                "targets": columnDefs,
                                "searchable": false,
                                "orderable": false,
                                "className": "dt-body-center",
                                "render": function(data, type, full, meta) {
                                    return "<i class='fa fa-pencil'>";
                                    //return "<i class='fa fa-pencil'> <b>Editar</b>";
                                }
                            });
                            columnDefs++;
                        }
                        // Edit - End

                        // Verificar se o campo é visível
                        if (index.visible === false) {
                            scope.columnDefs.push({
                                "targets": columnDefs,
                                "visible": false
                            });
                        }
                        columnDefs++;

                        scope.columns += '<th class="text-left">' + index.title + '</th>';

                        aoColumnsData = {};
                        aoColumnsData.mData = index.field;

                        scope.aoColumns.push(aoColumnsData);
                        i++;
                    });
                    scope.dataTable += scope.columns;

                    scope.dataTable += '</thead>';

                    scope.dataTable += '<tbody></tbody>';

                    scope.dataTable += '<tfoot>';
                    scope.dataTable += scope.columns.replace('<th class="text-left" width="1px"><input name="select_all" value="1" type="checkbox"></th>', '<th class="text-left"></th>');
                    scope.dataTable += '</tfoot>';

                    scope.dataTable = $sce.trustAsHtml(scope.dataTable);

                    // Data Grid pronta para consulta
                    scope.pxTableReady = true;
                });

                // Internal Control - Start

                // How to call a method defined in an AngularJS directive?
                // http://stackoverflow.com/questions/16881478/how-to-call-a-method-defined-in-an-angularjs-directive
                scope.internalControl = scope.control || {};

                // A listagem está processamento?
                scope.internalControl.working = false;

                /**
                 * Recuperar dados que são carregados na listagem
                 * @return {void}
                 */
                scope.internalControl.getData = function() {
                    $timeout(function() {
                        scope.getData(0, scope.rowsProcess);
                    }, 0)
                };

                /**
                 * Adicionar linha de registro
                 * @param {object} value valor que será inserido na listagem
                 */
                scope.internalControl.addDataRow = function(value) {
                    scope.addDataRow(value);
                };

                /**
                 * Atualizar linha de registro
                 * @param {object} value valor que será inserido na listagem
                 */
                scope.internalControl.updateDataRow = function(value) {
                    scope.updateDataRow(value);
                };

                /**
                 * Remover linha
                 * @param {object} value objeto linha do DataTable
                 */
                scope.internalControl.removeRow = function(value) {
                    scope.removeRow(value);
                };

                /**
                 * Limpar dados
                 * @param {object} value objeto linha do DataTable
                 */
                scope.internalControl.clearData = function(value) {
                    scope.clearData(value);
                };

                /**
                 * Remover itens (selecionados) da listagem
                 * @return {void}
                 */
                scope.internalControl.remove = function() {
                    scope.remove();
                };

                // Armazena itens selecionados da listagem
                scope.internalControl.selectedItems = [];

                // Armazena número atual de linhas carregadas
                scope.currentRecordCount = 0;

                // Internal Control - End


                // Chama evento px-init
                $timeout(scope.init, 0);

            },
            controller: pxDataGridCtrl
        };
    }]);

    pxDataGridCtrl.$inject = ['pxConfig', 'pxUtil', 'pxArrayUtil', 'pxMaskUtil', 'pxStringUtil', 'pxDataGridService', '$scope', '$http', '$timeout'];

    function pxDataGridCtrl(pxConfig, pxUtil, pxArrayUtil, pxMaskUtil, pxStringUtil, pxDataGridService, $scope, $http, $timeout) {

        // Verifica se a grid a está preparada para receber os dados
        $scope.pxTableReady = false;

        // A página atual inicia-se em 0
        $scope.currentPage = 0;

        $scope.$watch('pxTableReady', function(newValue, oldValue) {

            if (newValue === true) {
                $timeout($scope.pxDataGridGetData, 0);
            }
        });

        $scope.reset = function() {
            // A página atual inicia-se em 0
            $scope.currentPage = 0;

            // Zera contagem de linhas atuais
            $scope.currentRecordCount = 0;

            // Armazena itens selecionados da listagem
            $scope.internalControl.selectedItems = [];

            // Armazena linhas selecionados da listagem
            $scope.internalControl.rowsSelected = [];

            // Nenhuma linha selecionada
            $scope.rowsSelected = [];

            // Se exitir a opção selecionar tudo de listagem
            if (angular.isDefined($scope.internalControl.checkAll)) {
                // Resetar checkbox
                $scope.internalControl.checkAll.checked = false;
                $scope.internalControl.checkAll.indeterminate = false;
            }

        };

        $scope.pxDataGridGetData = function() {
            // Armazena linhas selecionadas (checkbox)
            $scope.rowsSelected = [];

            // sDom - Start
            // http://legacy.datatables.net/usage/options#sDom
            var sDom = '';
            sDom += 'l'; // Length changing
            //sDom += 'f';  // Filtering input
            sDom += 't'; // The table!
            sDom += 'i'; // Information
            sDom += 'p'; // Pagination
            sDom += 'r'; // pRocessing
            // sDom - End

            // Configuração do dataTable
            // Features: http://legacy.datatables.net/usage/features
            var dataTableConfig = {};
            // Ajax Url
            if ($scope.ajaxUrl) {
                dataTableConfig.ajax = {
                    "url": $scope.ajaxUrl,
                    "dataSrc": ""
                }
            }
            // Tradução                       
            // https://datatables.net/reference/option/language
            dataTableConfig.language = {
                    processing: "Processando...",
                    search: "Filtrar registros carregados",
                    lengthMenu: "Visualizar _MENU_ registros",
                    info: "Monstrando de _START_ a _END_ no total de _TOTAL_ registros.",
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
                }
                // Acesso via mobile browser
            if (pxUtil.isMobile()) {
                dataTableConfig.pagingType = "simple";
                dataTableConfig.pageLength = 8;
            }
            dataTableConfig.bFilter = true;
            dataTableConfig.bLengthChange = $scope.lengthChange;
            dataTableConfig.lengthMenu = $scope.lengthMenu; //[20, 35, 45];
            dataTableConfig.sDom = sDom;
            dataTableConfig.bProcessing = true;
            dataTableConfig.aoColumns = $scope.aoColumns;
            dataTableConfig.destroy = true;

            dataTableConfig.columnDefs = $scope.columnDefs;

            dataTableConfig.order = []; //default order
            dataTableConfig.rowCallback = function(row, data, dataIndex) {
                // Linhda ID
                var rowId = data.pxDataGridRowNumber;

                // Se a linha ID está na lista de IDs de linha selecionados
                if ($.inArray(rowId, $scope.rowsSelected) !== -1) {
                    $(row).find('input[type="checkbox"]').prop('checked', true);
                    $(row).addClass('selected');
                }
            };

            requirejs(["dataTables"], function() {
                // Inicializa dataTable
                $('#' + $scope.id + '_pxDataTable').dataTable(
                    dataTableConfig
                );
            });

            $scope.pxTableReady = false;

            // Se a propriedade pxGetData for true
            if ($scope.dataInit === true) {
                // Recupera dados assim que a listagem é criada
                $scope.getData(0, $scope.rowsProcess);
            }

            requirejs(["dataTables"], function() {
                var table = $('#' + $scope.id + '_pxDataTable').DataTable();
                $scope.internalControl.table = $('#' + $scope.id + '_pxDataTable').DataTable();
            });

            // Evento page.dt
            // https://datatables.net/reference/event/page
            $('#' + $scope.id + '_pxDataTable').on('page.dt', function() {

                var info = $scope.internalControl.table.page.info();

                if (info.page === info.pages - 1) {

                    $scope.currentPage = info.page;
                    $scope.getData($scope.nextRowFrom, $scope.nextRowTo);
                }

                //$('#'+$scope.id+'_pxDataTable_length').hide();
                //console.info('pxTable page.dt table.context',table.context[0]);
                if (info.start === 0) {
                    info.start = 1;
                }

                //table.context[0].oLanguage.sInfo = 'Monstrando de ' + info.start + ' a ' + info.end + ' no total de ' + info.recordsTotal + ' registros carregados.' + '<br>Total de registros na base de dados: ' + $scope.recordCount;
                $scope.internalControl.table.context[0].oLanguage.sInfo = info.recordsTotal + ' registros carregados.' + ' Total de registros na base de dados: ' + $scope.recordCount;
            });

            // Atualizar dataTable (Selecionar tudo)
            $scope.updateDataTableSelectAllCtrl = function(table) {
                // Verifica se o dataTable possui coluna de checkbox
                if (!$scope.check == true)
                    return;

                var $table = table.table().node();
                var $chkbox_all = $('tbody input[type="checkbox"]', $table);
                var $chkbox_checked = $('tbody input[type="checkbox"]:checked', $table);
                var chkbox_select_all = $('thead input[name="select_all"]', $table).get(0);
                $scope.internalControl.checkAll = chkbox_select_all;

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
            };

            // Evento click edit
            $('#' + $scope.id + '_pxDataTable tbody').on('click', 'i[class="fa fa-pencil"]', function(e) {

                var $row = $(this).closest('tr');
                $scope.internalControl.updatedRow = $row;
                var data = $scope.internalControl.table.row($row).data();

                var itemEdit = {} //angular.copy(JSON.parse($scope.fields))

                angular.forEach($scope.fields, function(index) {
                    itemEdit[index.field] = data.edit[index.field]
                });

                var itemEditEvent = {
                    itemClick: data,
                    itemEdit: itemEdit
                }

                $scope.itemEdit({
                    event: itemEditEvent
                });
            });

            // Evento click checkbox
            $('#' + $scope.id + '_pxDataTable tbody').on('click', 'input[type="checkbox"]', function(e) {
                var $row = $(this).closest('tr');

                // Dados da linha
                var data = $scope.internalControl.table.row($row).data();

                // ID da linha
                var rowId = data.pxDataGridRowNumber;

                // Se caixa de seleção está marcada e linha ID não está na lista de IDs de linha selecionados
                var index = $.inArray(rowId, $scope.rowsSelected);

                // Se caixa de seleção está marcada e linha ID não está na lista de IDs de linha selecionados
                if (this.checked && index === -1) {
                    $scope.rowsSelected.push(rowId);

                    $scope.internalControl.selectedItems.push(data);

                    // Se caixa de seleção está marcada e linha ID não está na lista de IDs de linha selecionados
                } else if (!this.checked && index !== -1) {
                    $scope.rowsSelected.splice(index, 1);

                    $scope.internalControl.selectedItems.splice(index, 1);
                }

                if (this.checked) {
                    $row.addClass('selected');
                } else {
                    $row.removeClass('selected');
                }

                // Atualizar dataTable (selecionar tudo)
                $scope.updateDataTableSelectAllCtrl($scope.internalControl.table);

                e.stopPropagation();
            });

            // Evento click células
            $('#' + $scope.id + '_pxDataTable').on('click', 'tbody td, thead th:first-child', function(e) {

                // Evento Item Click - Start
                var $row = $(this).closest('tr');
                // Dados da linha
                var data = $scope.internalControl.table.row($row).data();
                var itemClickEvent = {
                    itemClick: data
                }

                $timeout(function() {
                    $scope.itemClick({
                        event: itemClickEvent
                    });
                }, 0);

                // Evento Item Click - End

                // Clicar no edit
                if (e.target.tagName === 'I') {
                    return;
                }
                $(this).parent().find('input[type="checkbox"]').trigger('click');
            });

            // Evento click (selecionar tudo)
            $('#' + $scope.id + '_pxDataTable thead input[name="select_all"]').on('click', function(e) {
                if (this.checked) {
                    $('#' + $scope.id + '_pxDataTable tbody input[type="checkbox"]:not(:checked)').trigger('click');
                } else {
                    $('#' + $scope.id + '_pxDataTable tbody input[type="checkbox"]:checked').trigger('click');
                }

                e.stopPropagation();
            });

            // Evento draw
            $('#' + $scope.id + '_pxDataTable').on('draw', function() {
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
            // Processamento getData iniciado
            $scope.internalControl.working = true;            

            var arrayFields = $scope.fields; //JSON.parse($scope.fields);            

            // Loop na configuração de campos
            angular.forEach(arrayFields, function(index) {
                // Valor do filtro
                index.filterObject = {};

                // Verifica se possui campo de filtro
                // Caso possua campo de filtro será definido o 'filterObject'
                // filterObject armazena dados do filtro que será realizado no campo
                if (angular.isDefined(index.filter)) {

                    var selectorName = '#' + index.filter;
                    var selectorValue = index.filter;

                    // Verifica se o filtro group
                    if (index.filterGroup) {
                        selectorName += '_groupSearch_inputSearch';
                        selectorValue = 'selectedItem';
                    }
                    // Verificar se o filtro é um px-complete
                    else if (angular.isDefined(angular.element($(selectorName + '_inputSearch').get(0)).scope())) {
                        selectorName += '_inputSearch';
                        selectorValue = 'selectedItem';
                    }

                    // Verifica seu o scope do elemento angular possui valor definido
                    if (angular.isDefined(angular.element($(selectorName).get(0)).scope()) && angular.element($(selectorName).get(0)).scope().hasOwnProperty(selectorValue)) {
                        // filtro
                        var filter = angular.element($(selectorName).get(0)).scope()[selectorValue];

                        // Se filtro for undefined, o filtro será considerado inválido
                        if (!angular.isDefined(filter)) {
                            return;
                        }

                        var tempField = index.field;
                        var tempValue = filter;

                        // Se possuir configuração avançada de fitro (filterOptions)
                        if (angular.isDefined(index.filterOptions)) {
                            tempField = index.filterOptions.field;
                            // value recebe o que foi configurado em index.filterOptions.selectedItem
                            // por exemplo se o filtro for um select, o ng-model pode ser um objeto {id: 1, name: 'teste'}
                            // neste caso é necessário definir qual chave do objeto representa o valor a ser filtrado
                            if (filter) {
                                tempValue = filter[index.filterOptions.selectedItem];
                                if (!angular.isDefined(tempValue)) {
                                    tempValue = filter[index.filterOptions.selectedItem.toUpperCase()];
                                }
                                if (tempValue === '%') {
                                    tempValue = null;
                                }
                            } else {
                                tempValue = null;
                            }
                        }

                        if (tempValue !== null && tempValue !== '') {
                            // Define o objeto de filtro do campo
                            // field é nome do campo que será filtro no banco de dados
                            // value é valor do campo, o qual será filtrado                        
                            index.filterObject = {
                                field: tempField,
                                value: tempValue
                            };
                        } else {
                            index.filterObject = {};
                        }
                    } else {
                        // Se não possuir um valor válido no ng-model o valor recebe vazio
                        index.filterObject = {};
                    }

                    // Armazena valor do filtro que será enviado ao back-end
                    index.filterObject.value = pxUtil.filterOperator(index.filterObject.value, index.filterOperator);

                }

            });
            
            // Parâmetros da consulta
            var params = {};

            params.schema = $scope.schema;
            if (angular.isDefined($scope.view) && $scope.view !== '') {
                params.table = $scope.view;
            } else {
                params.table = $scope.table;
            }
            params.fields = angular.toJson(arrayFields);
            params.orderBy = angular.toJson($scope.orderBy);

            params.rows = $scope.rowsProcess;

            if (angular.isDefined(rowFrom)) {
                params.rowFrom = rowFrom;
            }
            if (angular.isDefined(rowTo)) {
                params.rowTo = rowTo;
            }

            params.group = $scope.group;
            params.groupItem = $scope.groupItem;
            params.groupLabel = $scope.groupLabel;
            
            if ($scope.where) {
                $scope.where = pxUtil.setFilterObject($scope.where, false, pxConfig.GROUP_TABLE);
                params.where = angular.toJson($scope.where);
            }

            // Se for a primeira linha significa que é uma nova consulta ao dados
            // Neste caso é feito um 'clear' na listagem
            if (rowFrom === 0) {
                $scope.reset();

                requirejs(["dataTables"], function() {
                    $('#' + $scope.id + '_pxDataTable').DataTable().clear().draw();
                });
            }

            pxDataGridService.select(params, function(response) {
                if ($scope.debug) {
                    console.info('px-data-grid ' + $scope.id + ' getData', response);
                    //console.info('px-data-grid ' + $scope.id + ' getData JSON.stringify',JSON.stringify(response,null,"    "));
                }

                if (angular.isDefined(response.fault)) {
                    alert('Ops! Ocorreu um erro inesperado.\nPor favor contate o administrador do sistema!');
                } else {
                    // Verifica se a quantidade de registros é maior que 0
                    if (response.qQuery.length > 0) {
                        // Loop na query
                        angular.forEach(response.qQuery, function(index) {
                            $scope.addDataRow(index);
                        });

                        $scope.recordCount = response.recordCount;
                        $scope.nextRowFrom = response.rowFrom + $scope.rowsProcess;
                        $scope.nextRowTo = response.rowTo + $scope.rowsProcess;

                        var table = $scope.internalControl.table;
                        requirejs(["dataTables"], function() {
                            $('#' + $scope.id + '_pxDataTable').DataTable().page($scope.currentPage).draw(false);
                        });

                        requirejs(["dataTables"], function() {
                            var info = $('#' + $scope.id + '_pxDataTable').DataTable().page.info();
                            if (info.start === 0) {
                                info.start = 1;
                            }

                            //$('#'+$scope.id+'_pxDataTable_info').html('Monstrando de ' + info.start + ' a ' + info.end + ' no total de ' + info.recordsTotal + ' registros carregados.' + '<br>Total de registros na base de dados: ' + $scope.recordCount);                           
                            $('#' + $scope.id + '_pxDataTable_info').html(info.recordsTotal + ' registros carregados.' + ' Total de registros na base de dados: ' + $scope.recordCount);
                        });
                        // Verifica $scope.demand
                        // false: não continua a consulta até que o usuário navegue até a última página
                        // true: continua consulta até carregar todos os registros
                        if ($scope.demand) {
                            // A listagem está processo?
                            $scope.internalControl.working = false;
                        } else {
                            // Continuar a consulta
                            $scope.getData($scope.nextRowFrom, $scope.nextRowTo);
                        }
                    } else {
                        // A listagem está processo?
                        $scope.internalControl.working = false;
                    }
                }
            });
        };


        $scope.updateDataRow = function updateDataRow(value) {
            var data = $scope.internalControl.table.row($scope.internalControl.updatedRow).data();
            angular.forEach($scope.fields, function(item) {
                if (angular.isDefined(data[item.field]) && angular.isDefined(value[item.field])) {
                    if (!angular.isDefined(item.stringMask)) {
                        data[item.field] = value[item.field];
                    } else {
                        if (angular.isDefined(item.pad)) {
                            data[item.field] = pxMaskUtil.maskFormat(pxStringUtil.pad(item.pad, value[item.field], true), item.stringMask).result;
                        } else {
                            data[item.field] = pxMaskUtil.maskFormat(value[item.field], item.stringMask).result;
                        }

                    }
                }
            });
            $scope.internalControl.table
                .row($scope.internalControl.updatedRow)
                .data(data)
                .draw();
        }

        $scope.addDataRow = function addDataRow(value) {
            // Somar currentRecordCount
            $scope.currentRecordCount++;

            // Dados
            var data = {};

            data.pxDataGridRowNumber = $scope.currentRecordCount;
            data.edit = {}; //$scope.currentRecordCount;

            // Loop nas colunas da grid
            angular.forEach($scope.fields, function(item) {

                if (!angular.isDefined(value[item.field])) {
                    // Dados por campo
                    data[item.field] = value[item.field.toUpperCase()];
                } else {
                    // Dados por campo
                    data[item.field] = value[item.field];
                }

                if (!angular.isDefined(data[item.field])) {
                    data[item.field] = '';
                }

                data.edit[item.field] = angular.copy(data[item.field]);

                // Se possuir máscara
                // https://github.com/the-darc/string-mask
                if (item.stringMask) {
                    switch (item.stringMask) {
                        case 'cpf':
                            item.stringMask = '###.###.###-##';
                            //item.pad = '00000000000';
                            break;
                        case 'cnpj':
                            item.stringMask = '##.###.###/####-##';
                            //item.pad = '00000000000000';
                            break;
                        case 'cep':
                            item.stringMask = '#####-###';
                            //item.pad = '00000000';
                            break;
                        case 'brPhone':
                            if (data[item.field].length === 11) {
                                item.stringMask = '(##) #####-####';
                            } else {
                                item.stringMask = '(##) #####-####';
                            }
                            break;
                        default:
                            break;
                    }
                    if (angular.isDefined(item.pad)) {
                        data[item.field] = pxMaskUtil.maskFormat(pxStringUtil.pad(item.pad, data[item.field], true), item.stringMask).result;
                    } else {
                        data[item.field] = pxMaskUtil.maskFormat(data[item.field], item.stringMask).result;
                    }
                }

                // Se possuir moment
                // http://momentjs.com/
                if (item.moment) {
                    // Verificar se o valor é do tipo date
                    if (angular.isDate(data[item.field])) {
                        require(['moment'], function(moment) {
                            data[item.field] = moment(Date.parse(data[item.field])).format(item.moment);
                        });
                    } else {
                        // Senão considerar numérico (YYYYMMDD)
                        require(['moment'], function(moment) {
                            data[item.field] = moment(Date.parse(new Date(String(data[item.field]).substr(0, 4), String(data[item.field]).substr(4, 2) - 1, String(data[item.field]).substr(6, 2)))).format(item.moment);
                        });
                    }
                }

                // Se possuir numeral
                // http://numeraljs.com/
                if (item.numeral) {
                    switch (item.numeral) {
                        case 'currency':
                            data[item.field] = numeral(data[item.field]).format('0,0.00');
                            break;
                        default:
                            data[item.field] = numeral(data[item.field]).format(item.numeral);
                            break;
                    }
                }
            });

            // Atualizar dados do dataTable                                        
            requirejs(["dataTables"], function() {
                $('#' + $scope.id + '_pxDataTable').DataTable().row.add(data).draw();
            });
        }

        /**
         * Remover linha
         * @return {void}
         */
        $scope.removeRow = function removeRow(value) {
            $scope.internalControl.table.rows(value).remove().draw();
        }

        /**
         * Limpar dados
         * @return {void}
         */
        $scope.clearData = function clearData(value) {
            // Verificar a listagem foi iniciada para que assim possa apagar o dados
            if ($scope.pxTableReady) {
                requirejs(["dataTables"], function() {
                    $('#' + $scope.id + '_pxDataTable').DataTable().clear().draw();
                });
            }
        }

        /**
         * Remover itens da listagem
         * @return {void}
         */
        $scope.remove = function remove() {
            var arrayFields = $scope.fields; //JSON.parse($scope.fields);

            var objConfig = JSON.parse($scope.config);
            var table = objConfig.table;
            if (!angular.isDefined(table)) {
                table = $scope.table;
            }

            var params = {};
            params.schema = $scope.schema;
            params.table = table;
            params.fields = angular.toJson(arrayFields);
            params.selectedItems = angular.toJson($scope.internalControl.selectedItems);

            pxDataGridService.remove(params, function(response) {
                if ($scope.debug) {
                    console.info('pxDataGrid remove: ', response);
                }
                if (response.success) {
                    $scope.internalControl.table.rows('.selected').remove().draw(false);

                    // rotina duplicada :( - START
                    var info = $scope.internalControl.table.page.info();
                    if (info.start === 0) {
                        info.start = 1;
                    }

                    $scope.recordCount -= $scope.rowsSelected.length;

                    $('#' + $scope.id + '_pxDataTable_info').html(info.recordsTotal + ' registros carregados.' + ' Total de registros na base de dados: ' + $scope.recordCount);
                    // rotina duplicada :( - END

                    $scope.internalControl.selectedItems = [];
                    $scope.rowsSelected = [];
                } else {
                    alert('Ops! Ocorreu um erro inesperado.\nPor favor contate o administrador do sistema!');
                }
            });
        };
    }
});