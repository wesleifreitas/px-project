<cfinclude template="../../lib/pxUtil.cfm">

<cfprocessingDirective pageencoding="utf-8">
<cfset setEncoding("form","utf-8")> 

<cffunction 
	name         ="login" 
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
		name     ="username" 
		type     ="string"	
		required ="false">

	<cfargument 
		name     ="password" 	
		type     ="string"		
		required ="false">

	<cfset result = structNew()>

	<cfscript>

		myQuery = QueryNew("nome, username, password, cpf", "VarChar, VarChar, VarChar, BigInt");

		if ( arguments.username == "px-project" && arguments.password == "atopng"){

			newRow = QueryAddRow(MyQuery, 1);

			temp = QuerySetCell(myQuery, "nome", "px-project", 1);
			temp = QuerySetCell(myQuery, "username", arguments.username, 1);
			temp = QuerySetCell(myQuery, "password", '*', 1);
			temp = QuerySetCell(myQuery, "cpf", 11111111111, 1);

		}

		result.arguments = arguments;

		if (MyQuery.recordCount EQ 1){
			result.success = true;
			result.message = '';
		} else {
			result.success = false;
			result.message = 'Login inválido';
		}
		result.query = QueryToArray(MyQuery);

		return result;

	</cfscript>

</cffunction>