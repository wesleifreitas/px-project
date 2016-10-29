<cfinclude template="../../system/utils/cf/px-util.cfm">

<cfprocessingDirective pageencoding="utf-8">
<cfset setEncoding("form","utf-8")> 

<cffunction 
	name         ="insertUpdate" 
	access       ="public" 
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
			<!--- Verificar se pk existe --->
			<cfquery datasource="#arguments.dsn#" name="qUnique">
				SELECT 1 FROM #arguments.table#
				<cfset whereInit = 'WHERE'>
				<cfloop array="#arguments.fields#" index="i">
					<cfif isDefined("i.pk") AND i.pk AND i.insert>
						#whereInit# #i.field# = <cfqueryparam cfsqltype="#getSqlType(i.type)#" value="#i.valueObject.value#">
						<cfset whereInit = 'AND '>
					</cfif>
				</cfloop>
			</cfquery>

			<!---
			Verificar se whereInit é diferente que "WHERE" e qUnique (recordCount) > 0
			Obs.: Se whereInit for igual a "WHERE" siginifica que  não foi criada nenhuma condição
			neste caso deve desconsiderar a verificação UNIQUE
			--->
			<cfif whereInit NEQ "WHERE" AND qUnique.recordCount GT 0>
				<cfset result["error"] = true>
				<cfset result["unique"] = true>
				<cfset result["qUnique"] = QueryToArray(qUnique)>
				<cfset result["success"] = true>
				<cfreturn result>
			</cfif>

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
			<cfset updatePk = false>
			<!--- Verificar se pk existe --->
			<cfquery datasource="#arguments.dsn#" name="qUnique">
				SELECT TOP 1 1 FROM #arguments.table#
				<cfset whereInit = 'WHERE'>
				<cfloop array="#arguments.fields#" index="i">
					<cfif isDefined("i.pk") AND i.pk AND i.update>
						#whereInit# #i.field# = <cfqueryparam cfsqltype="#getSqlType(i.type)#" value="#i.valueObject.value#">
							<cfset whereInit = 'AND '>
						<cfif i.valueObject.value NEQ arguments.oldForm[i.field]>
							<cfset updatePk = true>
						</cfif>
					</cfif>
				</cfloop>
			</cfquery>

			<!---
			Verificar se whereInit é diferente que "WHERE", qUnique (recordCount) > 0 e se o valor da PK não é ela mesma
			Obs.: Se whereInit for igual a "WHERE" siginifica que  não foi criada nenhuma condição
			neste caso deve desconsiderar a verificação UNIQUE
			--->
			<cfif whereInit NEQ "WHERE" AND qUnique.recordCount GT 0 AND updatePk>
				<cfset result["action"] = 'unique'>
				<cfset result["unique"] = true>
				<cfset result["qUnique"] = QueryToArray(qUnique)>
				<cfset result["success"] = true>
				<cfreturn result>
			</cfif>

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
				if (isDefined("item.labelField") AND isDefined("item.labelField.field")) {
					if(isDefined("item.labelField.value")){
						data[item.labelField.field] = item.labelField.value;
					}else{
						data[item.labelField.field] = null;
					}
				}
			}
		</cfscript>
						
		<cfset result["success"] = true>
		<cfset result["action"] = arguments.action>
		<cfset result["queryResult"] = queryResult>
		<cfset result["data"] = data>
		
		<cfcatch>
			<cfif cfcatch.type NEQ "Database" AND isDefined("i")>
				<cfset result["i"] = i>
			</cfif>
			<cfset result["success"] = false>
			<cfset result["cfcatch"] = cfcatch>
		</cfcatch>

	</cftry>

	<cfreturn result>
</cffunction>

<cffunction 
	name         ="select" 
	access       ="public" 
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