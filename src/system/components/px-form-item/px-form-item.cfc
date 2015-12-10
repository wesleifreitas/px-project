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

	<cfargument 
		name     ="where" 	
		type	 ="string"
		required ="false"
		default  =""	
		hint     ="Condição da instrução SQL">
	
	<cfset result = structNew()>
	<cftry>

		<cfset arguments.fields = decode(arguments.fields)>
		
		<cfif arguments.where NEQ "">
			<cfset arguments.where = decode(arguments.where)>
		<cfelse>
			<cfset arguments.where = arrayNew(1)>
		</cfif>

		<cfset listFields = "">
		<cfloop array="#arguments.fields#" index="i">
			
			<cfset listFields = listFields&i.field&",">
			
		</cfloop>

		<cfif arguments.orderBy EQ "">
			<cfset arguments.orderBy = arguments.fields[1].field>
		</cfif>

		<!--- http://www.bennadel.com/blog/867-ask-ben-protecting-database-table-names-in-coldfusion-cfquery.htm --->

		<cftransaction>						
			<cfquery name="qQuery" result="qResult" datasource="#arguments.dsn#">			
				SELECT 
					TOP #arguments.rows#
					#listFields#
					ROW_NUMBER() OVER (ORDER BY #arguments.orderBy#) AS row_number
				FROM 
					#arguments.table#
				<cfset whereInit = 'WHERE ('>
				<cfloop array="#arguments.fields#" index="i">					
					<cfif isDefined("i.filterObject.field")>
						#whereInit# #i.filterObject.field# #replace(i.filterOperator,"%","","all")# <cfqueryparam cfsqltype="#getSqlType(i.type)#" value="#i.filterObject.value#">
						<cfset whereInit = 'OR '>
					</cfif>
				</cfloop>
				<cfif whereInit NEQ "WHERE (">
					)
					<cfset whereInit = "AND ">	
				</cfif>
				<cfloop array="#arguments.where#" index="i">
					<cfif isDefined("i.filterObject.field")>
						<cfif i.filterOperator EQ "IN">
							<cfif i.filterObject.value EQ "">
								<cfcontinue>
							</cfif>
							<cfset inStart= "(">
							<cfset inEnd= ")">
						<cfelse>							
							<cfset inStart= "">
							<cfset inEnd= "">
						</cfif>
						#whereInit# #i.field# #replace(i.filterOperator,"%","","all")# #inStart#<cfqueryparam cfsqltype="#getSqlType(i.type)#" value="#i.filterObject.value#" list="#i.filterList#">#inEnd#
							<cfset whereInit = 'AND '>	
					</cfif>
				</cfloop>
			</cfquery>
		</cftransaction>

		<cfcatch>
			<cfset result["fault"] 	= cfcatch>
			<cfset result["arguments"] = arguments>
			<cfreturn result>
		</cfcatch>

	</cftry>

	<cfset result["listFields"] = listFields>
	<cfset result["arguments"] = arguments>
	<cfset result["qQuery"] = QueryToArray(qQuery)>
	<cfset result["qResult"] = qResult>

	<cfreturn result>

</cffunction>