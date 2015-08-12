<cfinclude template="../../lib/pxUtil.cfm">

<cfprocessingDirective pageencoding="utf-8">
<cfset setEncoding("form","utf-8")> 

<cffunction 
	name         ="getData" 
	access       ="remote" 
	output       ="false" 
	returntype   ="Any" 
	returnformat ="JSON">

	<cfargument 
		name     ="dsn"		
		type     ="string"
		required ="false"	
		default  ="px_project_sql"	
		hint     ="Data source name">


	<cfargument 
		name     ="usuario" 	
		type     ="numeric"
		required ="false"
		default  ="0"	
		hint     ="ID do usuário">


	<cfargument 
		name     ="rows" 	
		type     ="numeric"
		required ="false"
		default  ="250"	
		hint     ="Número de linhas por select">

	<cfargument 
		name     ="rowFrom" 	
		type     ="numeric"
		required ="false"
		default  ="0"	
		hint     ="Linha inicial do select">

	<cfargument 
		name     ="rowTo" 	
		type     ="numeric"
		required ="false"
		default  ="250"	
		hint     ="Linha final do select">

	<cfargument 
		name     ="table" 	
		type	 ="string"
		required ="false"
		default  =""	
		hint     ="Tabela do banco de dados">

	<cfargument 
		name     ="fields" 	
		type	 ="any"
		required ="false"
		default  ="250"	
		hint     ="Campos do px-grid">


	<cfargument 
		name     ="orderBy" 	
		type	 ="string"
		required ="false"
		default  =""	
		hint     ="Campo ORDER BY da instrução SQL">
	
	<cfset result = structNew()>
	<cftry>

		<cfset arguments.fields = decode(arguments.fields)>

		<cfset listFields = "">
		<cfloop array="#arguments.fields#" index="i">
			
			<cfset listFields = listFields&i.field&",">
			
		</cfloop>

		<cfif arguments.orderBy EQ "">
			<cfset arguments.orderBy = arguments.fields[1].field>
		</cfif>

		<cftransaction>
					
			<cfquery name="qRecordCount" datasource="#arguments.dsn#">
				SELECT
					COUNT(1) as count
				FROM
					#arguments.table#

				WHERE 1=1	
				<cfloop array="#arguments.fields#" index="i">
					
					<cfif isDefined("i.filterValue") AND i.filterValue NEQ "">
						AND #i.field# #replace(i.filterOperator,"%","","all")# <cfqueryparam cfsqltype="#getSqltype(i.type)#" value="#i.filterValue#">
					</cfif>
							
				</cfloop>

			</cfquery>
			
			<cfquery name="qQuery" datasource="#arguments.dsn#">
			
				WITH pagination AS
				(
					SELECT 
						#listFields#
						ROW_NUMBER() OVER (ORDER BY #arguments.orderBy#) AS RowNumber
					FROM 
						#arguments.table#
					WHERE 
						1 = 1	
					<cfloop array="#arguments.fields#" index="i">
					
						<cfif isDefined("i.filterValue") AND i.filterValue NEQ "">
							AND #i.field# #replace(i.filterOperator,"%","","all")# <cfqueryparam cfsqltype="#getSqltype(i.type)#" value="#i.filterValue#">
						</cfif>
								
					</cfloop>
				)
				
				SELECT 
					#listFields# 
					RowNumber
				FROM	
					pagination
				WHERE	
					RowNumber BETWEEN #arguments.rowFrom+1# AND #arguments.rowTo#
				ORDER BY 
					RowNumber ASC

			</cfquery>

		</cftransaction>

		<cfcatch>
			<cfset result['fault'] 	= cfcatch>
			<cfset result['arguments'] = arguments>
			<cfreturn result>
		</cfcatch>

	</cftry>


	<cfset result['listFields']     = listFields>
	<cfset result['arguments']   = arguments>
	<cfset result['rowFrom']     = arguments.rowFrom>
	<cfset result['rowTo']       = arguments.rowTo>
	<cfset result['qQuery']      = QueryToArray(qQuery)>
	<cfset result['recordCount'] = qRecordCount.count>

	<cfreturn result>

</cffunction>

<cffunction 
	name         ="getSqltype" 
	access       ="private" 
	output       ="false" 
	returntype   ="String"
	>

	<cfargument 
		name     ="type" 	
		type	 ="string"
		required ="false"
		default  =""	
		hint     ="Tipo do campo">

	<cfscript>

		switch(arguments.type){
			case 'int':
				'cf_sql_integer';
			break;

			case 'string':
				'cf_sql_varchar';
			break;

			case 'varchar':
				'cf_sql_varchar';
			break;
		
			default:
				'cf_sql_varchar';
			break;
		}


	</cfscript>

</cffunction>