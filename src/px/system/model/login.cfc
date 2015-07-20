<cfinclude template="../../lib/pxUtil.cfm">

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
		name     ="usuario" 
		type     ="string"	
		required ="false">

	<cfargument 
		name     ="senha" 	
		type     ="string"		
		required ="false">


	<!--- <cfreturn arguments> --->

	<cfscript>

		myQuery = QueryNew("nome, usuario, senha, cpf", "VarChar, VarChar, VarChar, BigInt");

		if ( arguments.usuario == "px-project" && arguments.senha == "atopng"){

			newRow = QueryAddRow(MyQuery, 1);

			temp = QuerySetCell(myQuery, "nome", "px-project", 1);
			temp = QuerySetCell(myQuery, "usuario", arguments.usuario, 1);
			temp = QuerySetCell(myQuery, "senha", '*', 1);
			temp = QuerySetCell(myQuery, "cpf", 11111111111, 1);

		}

		return QueryToArray(myQuery);

	</cfscript>

</cffunction>