<cfinclude template="../../utils/cf/px-util.cfm">

<cfprocessingDirective pageencoding="utf-8">
<cfset setEncoding("form","utf-8")> 

<cffunction 
	name         ="insertUpdate" 
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
		name     ="action"
		type	 ="string"
		required ="false"
		default  =""
		hint     ="Ação: insert | update">

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
		name     ="oldForm"
		type	 ="string"
		required ="false"
		default  =""
		hint     ="Dados do formulário sem nenhum alteração">

	<cfset result = structNew()>
	<cfset result["arguments"] = arguments>
	
	<cftry>
		<cfset arguments.fields = decode(arguments.fields)>
		<cfif arguments.oldForm NEQ "">
			<cfset arguments.oldForm = decode(arguments.oldForm)>
		<cfelse>
			<cfset arguments.oldForm = structNew()>
		</cfif>
		
		<cfset comma = "">
		<cfif arguments.action EQ "insert">
			<cfquery datasource="#arguments.dsn#" result="queryResult">
				INSERT INTO
					#arguments.table#
				(
					<cfloop array="#arguments.fields#" index="i">
						<cfif i.insert>
							#comma# #i.field#
							<cfset comma = ",">
						</cfif>
					</cfloop>
				)
				<cfset comma = "">
				VALUES 
				(
					<cfloop array="#arguments.fields#" index="i">
						<cfif i.insert>
							#comma# 
							<cfif isDefined("i.hash") AND i.hash>
								<cfqueryparam cfsqltype="#getSqlType(i.type)#" value="#hash(i.valueObject.value,i.algorithm)#">
							<cfelseif isDefined("i.valueObject.getDate") AND i.valueObject.getDate>
								GETDATE()
							<cfelse>
								<cfqueryparam cfsqltype="#getSqlType(i.type)#" value="#i.valueObject.value#">
							</cfif>
							<cfset comma = ",">
						</cfif>
					</cfloop>
				)
			</cfquery>
		<cfelse>
			<cfquery datasource="#arguments.dsn#" result="queryResult">
				UPDATE
					#arguments.table#
				SET
					<cfloop array="#arguments.fields#" index="i">
						<cfif i.update>
							#comma# #i.field# = 
							<cfif isDefined("i.hash") AND i.hash>
								<cfqueryparam cfsqltype="#getSqlType(i.type)#" value="#hash(i.valueObject.value,i.algorithm)#">
							<cfelseif isDefined("i.valueObject.getDate") AND i.valueObject.getDate>
								GETDATE()
							<cfelse>
								<cfqueryparam cfsqltype="#getSqlType(i.type)#" value="#i.valueObject.value#">
							</cfif>
							<cfset comma = ",">
						</cfif>
					</cfloop>

					<cfset whereInit = 'WHERE'>
					<cfloop array="#arguments.fields#" index="i">
						<cfif isDefined("i.pk") AND i.pk>
							#whereInit# #i.field# = <cfqueryparam cfsqltype="#getSqlType(i.type)#" value="#arguments.oldForm[i.field]#">
						<cfset whereInit = 'AND '>
						</cfif>
					</cfloop>
			</cfquery>
		</cfif>

		<cfscript>
			var data = structNew();
			
			for(item in arguments.fields) {
				if (isDefined("item.pk") AND item.pk AND isDefined("item.identity") AND item.identity) {
			   		if(StructKeyExists(arguments.oldForm, item.field)){
			   			data[item.field] = arguments.oldForm[item.field];
			   		} else if(arguments.action EQ "insert" AND isDefined("queryResult.IDENTITYCOL")) {
			   			data[item.field] = queryResult.IdentityCol;
			   		}
			   	}else if(isDefined("item.valueObject.value")) {
			   		data[item.field] = item.valueObject.value;
			   	}
				// labelField
				if (isDefined("item.labelField")) {
					data[item.labelField.field] = item.labelField.value;
				}
			}
		</cfscript>
						
		<cfset result["success"] = true>
		<cfset result["action"] = arguments.action>
		<cfset result["queryResult"] = queryResult>
		<cfset result["data"] = data>
		
		<cfcatch>
			<cfset result["success"] = false>
			<cfset result["cfcatch"] = cfcatch>
		</cfcatch>

	</cftry>

	<cfreturn result>
</cffunction>

<cffunction 
	name         ="select" 
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

	<cfset result = structNew()>
	<cfset result["arguments"] = arguments>
	
	<cftry>
		<cfset arguments.fields = decode(arguments.fields)>
		
		<cfset comma = "">
		<cfquery datasource="#arguments.dsn#" name="qQuery" result="queryResult">
			SELECT
				<cfloop array="#arguments.fields#" index="i">
					<cfif i.select>
						#comma# #i.field#
						<cfset comma = ",">
					</cfif>
				</cfloop>
			FROM
				#arguments.table#
			<cfset whereInit = 'WHERE'>
			<cfloop array="#arguments.fields#" index="i">
				<cfif isDefined("i.pk") AND i.pk>
					<cfif isDefined("i.valueObject.value")>
						#whereInit# #i.field# = <cfqueryparam cfsqltype="#getSqlType(i.type)#" value="#i.valueObject.value#">
						<cfset whereInit = 'AND '>
					<cfelse>
						<cfset result["success"] = false>
						<cfset result["message"] = "PK " & i.field & " com valor indefinido">
						<cfreturn result>
					</cfif>					
				</cfif>
			</cfloop>
		</cfquery>
		
						
		<cfset result["success"] = true>
		<cfset result["qQuery"] = QueryToArray(qQuery)>
		<cfset result["queryResult"] = queryResult>
				
		<cfcatch>
			<cfset result["success"] = false>
			<cfset result["cfcatch"] = cfcatch>
		</cfcatch>

	</cftry>

	<cfreturn result>
</cffunction>