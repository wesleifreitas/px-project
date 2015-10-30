<cfinclude template="../../utils/cf/px-util.cfm">

<cfprocessingDirective pageencoding="utf-8">
<cfset setEncoding("form","utf-8")> 

<cffunction 
	name         ="insert" 
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
		name     ="pk" 	
		type	 ="string"
		required ="false"
		default  =""	
		hint     ="Chave">

	<cfargument 
		name     ="fields" 	
		type	 ="string"
		required ="false"
		default  =""	
		hint     ="Campos do px-data-grid">

	<cfset result = structNew()>
	<cfset result['arguments']  = arguments>
	
	<cftry>	
		<cfset arguments.pk 	= decode(arguments.pk)>
		<cfset arguments.fields = decode(arguments.fields)>		
		
		<cfset comma = "">
		<cfquery name="qResult" datasource="#arguments.dsn#">
			INSERT INTO
				#arguments.table#
			(
				<cfloop array="#arguments.fields#" index="i">
					#comma# #i.field#
					<cfset comma = ",">
				</cfloop>		
			)
			<cfset comma = "">
			VALUES 
			(
				<cfloop array="#arguments.fields#" index="i">
					#comma# <cfqueryparam cfsqltype="#getSqlType(i.type)#" value="#i.valueObject.value#">
					<cfset comma = ",">
				</cfloop>
			)			
		</cfquery>			
						
		<cfset result['success']  	= true>
		
		<cfcatch>
			<cfset result['success']  = false>
			<cfset result['cfcatch']  = cfcatch>
		</cfcatch>

	</cftry>

	<cfreturn result>
</cffunction>