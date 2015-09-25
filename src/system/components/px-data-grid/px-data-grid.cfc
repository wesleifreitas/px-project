<cfinclude template="../../utils/cf/px-util.cfm">

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
		type	 ="string"
		required ="false"
		default  =""	
		hint     ="Campos do px-data-grid">

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
				<cfset whereInit = 'WHERE'>
				<cfloop array="#arguments.fields#" index="i">					
					<cfif isDefined("i.filterObject.field")>
						#whereInit# #i.filterObject.field# #replace(i.filterOperator,"%","","all")# <cfqueryparam cfsqltype="#getSqlType(i.type)#" value="#i.filterObject.value#">
						<cfset whereInit = 'AND '>
					</cfif>							
				</cfloop>
			</cfquery>
			
			<cfquery name="qQuery" datasource="#arguments.dsn#">			
				WITH pagination AS
				(
					SELECT 
						-- TOP 1
						#listFields#
						ROW_NUMBER() OVER (ORDER BY #arguments.orderBy#) AS row_number
					FROM 
						#arguments.table#
					<cfset whereInit = 'WHERE'>
					<cfloop array="#arguments.fields#" index="i">						
						<cfif isDefined("i.filterObject.field")>
							#whereInit# #i.filterObject.field# #replace(i.filterOperator,"%","","all")# <cfqueryparam cfsqltype="#getSqlType(i.type)#" value="#i.filterObject.value#">
							<cfset whereInit = 'AND '>
						</cfif>							
					</cfloop>
				)
				
				SELECT 
					#listFields# 
					row_number
				FROM	
					pagination
				WHERE	
					row_number BETWEEN #arguments.rowFrom+1# AND #arguments.rowTo#
				ORDER BY 
					row_number ASC
			</cfquery>
		</cftransaction>

		<cfcatch>
			<cfset result['fault'] 	= cfcatch>
			<cfset result['arguments'] = arguments>
			<cfreturn result>
		</cfcatch>

	</cftry>

	<cfset result['listFields']  = listFields>
	<cfset result['arguments']   = arguments>
	<cfset result['rowFrom']     = arguments.rowFrom>
	<cfset result['rowTo']       = arguments.rowTo>
	<cfset result['qQuery']      = QueryToArray(qQuery)>
	<cfset result['recordCount'] = qRecordCount.count>

	<cfreturn result>

</cffunction>

<cffunction 
	name         ="removeData" 
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
		name     ="table" 	
		type	 ="string"
		required ="false"
		default  =""	
		hint     ="Tabela do banco de dados">

	<cfargument 
		name     ="fields" 	
		type	 ="string"
		required ="false"
		default  =""	
		hint     ="Campos do px-data-grid">

	<cfargument 
		name     ="selectedItems" 	
		type	 ="string"
		required ="false"
		default  =""	
		hint     ="Itens selecionados">

	<cfset result = structNew()>
	<cfset result['arguments']  = arguments>

	<cftry>	
		<cfset arguments.fields 		= decode(arguments.fields)>
		<cfset arguments.selectedItems 	= decode(arguments.selectedItems)>

		<!--- Utilize apenas para testes --->
		<!--- <cfset dump = arrayNew(1)> --->
		<cfloop array="#arguments.selectedItems#" index="i">	
			<cfquery name="qRemove" datasource="#arguments.dsn#">
				<!---
				-- Utilize a instrução abaixo (SELECT) para testes
				-- Para verificar quais registros estão sendos removidos por exemplo
				-- Note que no final do loop existe uma variável (dump) para tal ação
				SELECT						
					*
				FROM
					#arguments.table#	
				--->
				DELETE FROM #arguments.table#

				<!--- Constroi condição da instrução DELETE (SQL)--->
				<cfset whereInit = 'WHERE'>
				<cfloop array="#arguments.fields#" index="j">		
					<cfif isDefined("j.field") AND isDefined("j.pk") AND j.pk>						
						#whereInit# #j.field# = <cfqueryparam cfsqltype="#getSqlType(j.type)#" value="#i[j.field]#">
						<cfset whereInit = 'AND '>	
					</cfif>																			
				</cfloop>		
			</cfquery>			
			<!--- <cfset arrayAppend(dump, qRemove)> --->		
		</cfloop>
		
		<!--- Utilize apenas para testes --->
		<!--- <cfset result['dump'] = dump>	--->	
		<cfset result['success']  	= true>
		
		<cfcatch>
			<cfset result['success']  = false>
			<cfset result['cfcatch']  = cfcatch>
		</cfcatch>

	</cftry>

	<cfreturn result>
</cffunction>