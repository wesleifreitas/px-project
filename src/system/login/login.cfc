<cfinclude template="../utils/cf/px-util.cfm">

<cfprocessingDirective pageencoding="utf-8">
<cfset setEncoding("form","utf-8")>

<cffunction
	name = "login"
	access ="remote"
	output ="false"
	returntype ="Any"
	returnformat ="JSON">

	<cfargument
		name ="dsn"
		type ="string"
		required ="false"
		default ="px_project_sql"
		hint ="Data source name">

	<cfargument
		name ="username"
		type ="string"
		required ="false">

	<cfargument
		name ="password"
		type ="string"
		required ="false">

	<cfargument
		name ="algorithm"
		type ="string"
		required ="false"
		default ="SHA-512">

	<cfset result = structNew()>

	<cftry>
		<cfquery datasource="#arguments.dsn#" name="qQuery" result="queryResult">
			SELECT 
			  *			  
			FROM 
			  dbo.vw_usuario
			WHERE
				usu_login = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.username#">
			AND (usu_senha = <cfqueryparam cfsqltype="cf_sql_varchar" value="#hash(arguments.password,arguments.algorithm)#">
			OR usu_ativo IN (0,2)) -- Usuário inativo, bloqueado
		</cfquery>	

		<!-- <cfset result["arguments"] = arguments>
		<cfset result["qQuery"] = qQuery> -->

		<cfif qQuery.recordCount EQ 1>
			<cfset qQuery.usu_senha = '*'>
							
			<cfif qQuery.usu_ativo EQ 0>
				<cfset result["success"] = false>
				<cfset result["message"] = 'Este usuário está inativo'>
				<cfreturn result>	
			<cfelseif qQuery.usu_ativo EQ 2>
				<cfset result["success"] = false>
				<cfset result["message"] = 'Este usuário está bloqueado'>
				<cfreturn result>	
			<cfelseif qQuery.usu_recuperarSenha EQ 1>
				<cfif dateDiff("h", qQuery.usu_recuperarSenhaData, now()) GT 24>
					<cfset result["success"] = false>
					<cfset result["message"] = 'A senha temporária expirou!\nVocê pode gerar outra clicando no link "Esqueci minha senha"'>					
					<cfreturn result>
				</cfif>
			<cfelseif qQuery.usu_senhaExpira GT 0 AND qQuery.usu_senhaData NEQ "" AND dateDiff("d", qQuery.usu_senhaData, now()) GT qQuery.usu_senhaExpira>
				<cfset result["message"] = 'Sua senha expirou'>
				<cfquery datasource="#arguments.dsn#">
					UPDATE
						dbo.usuario
					SET
						usu_mudarSenha = <cfqueryparam cfsqltype="cf_sql_bit" value="1">
					WHERE
						usu_id = <cfqueryparam cfsqltype="cf_sql_bigint" value="#qQuery.usu_id#">
				</cfquery>

				<cfset qQuery.usu_mudarSenha = 1>				
			</cfif>		
		<cfelse>			
			<cfquery datasource="#arguments.dsn#" name="qLogin">
				SELECT
					usu_id
					,usu_tentativasLogin
					,ISNULL(usu_countTentativasLogin,0) AS usu_countTentativasLogin
				FROM
					dbo.usuario
				WHERE 
					usu_login = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.username#">
			</cfquery>

			<cfif qLogin.usu_tentativasLogin GT 0>							
				<cfquery datasource="#arguments.dsn#">				
					UPDATE 
						dbo.usuario 
					SET 
						<cfif qLogin.usu_countTentativasLogin GT qLogin.usu_tentativasLogin>
							usu_countTentativasLogin = <cfqueryparam cfsqltype="cf_sql_integer" value="0">
							,usu_ativo = <cfqueryparam cfsqltype="cf_sql_integer" value="2">
						<cfelse>
							usu_countTentativasLogin = <cfqueryparam cfsqltype="cf_sql_integer" value="#qLogin.usu_countTentativasLogin+1#">
						</cfif>
						
					WHERE 
						usu_id = <cfqueryparam cfsqltype="cf_sql_bigint" value="#qLogin.usu_id#">
				</cfquery>
			</cfif>

			<cfset result["success"] = false>
			<cfset result["message"] = 'Usuário e/ou senha incorreto(s)'>	

			<cfreturn result>
		</cfif>


		<cfif qQuery.usu_senhaData EQ "">
			<cfquery datasource="#arguments.dsn#">
				UPDATE
					dbo.usuario
				SET
					usu_senhaData = GETDATE()
				WHERE
					usu_id = <cfqueryparam cfsqltype="cf_sql_bigint" value="#qQuery.usu_id#">
			</cfquery>
		</cfif>

		<cfquery datasource="#arguments.dsn#">
			UPDATE
				dbo.usuario
			SET
				usu_countTentativasLogin = <cfqueryparam cfsqltype="cf_sql_integer" value="0">
				,usu_ultimoAcesso = GETDATE()
			WHERE
				usu_id = <cfqueryparam cfsqltype="cf_sql_bigint" value="#qQuery.usu_id#">
		</cfquery>

		<cflock timeout="20" throwontimeout="No" type="EXCLUSIVE" scope="SESSION">
			<cfset SESSION.userId = qQuery.usu_id>
			<cfset SESSION.userName = arguments.username>
			<cfset SESSION.password = hash(arguments.password,arguments.algorithm)>
			<cfset SESSION.authenticated = true>
			<cfset SESSION.loggedIn = true>
		</cflock>
			
		<cfset result["success"] = true>		
		<!--- <cfset result["message"] = "Olá, " & qQuery.usu_nome>	--->
		<cfset result["qQuery"] = QueryToArray(qQuery)>
					
		<cfreturn result>

		<cfcatch>
			<cfset result["success"] = false>
			<cfset result["message"] = 'Erro ao se comunicar com o servidor'>
			<cfset result["cfcatch"] = cfcatch>
			<cfreturn result>
		</cfcatch>
	</cftry>
</cffunction>

<cffunction
	name = "loggedIn"
	access ="remote"
	output ="false"
	returntype ="Any"
	returnformat ="JSON">

	<cfscript>
		var response = structNew();

		if (StructKeyExists(SESSION, "loggedIn") AND SESSION.loggedIn) {
			response["loggedIn"] = true;
		} else {
			response["loggedIn"] = false;
		}

		return response;
	</cfscript>

</cffunction>

<cffunction
	name = "logout"
	access ="remote"
	output ="false"
	returntype ="Any"
	returnformat ="JSON">

	<cfset StructDelete(SESSION, "loggedIn")>
	<cfreturn {"logout": true}>

</cffunction>

<cffunction
	name = "redefine"
	access ="remote"
	output ="false"
	returntype ="Any"
	returnformat ="JSON">

	<cfargument
		name ="dsn"
		type ="string"
		required ="false"
		default ="px_project_sql"
		hint ="Data source name">

	<cfargument
		name ="id"
		type="numeric"
		required ="false">

	<cfargument
		name ="username"
		type ="string"
		required ="false">

	<cfargument
		name ="password"
		type ="string"
		required ="false">

	<cfargument
		name ="algorithm"
		type ="string"
		required ="false"
		default ="SHA-512">		

	<cfset result = structNew()>

	<cftry>
		<cfquery datasource="#arguments.dsn#" name="qQuery" result="queryResult">
			UPDATE
				dbo.usuario	 
			SET
				usu_senha = <cfqueryparam cfsqltype="cf_sql_varchar" value="#hash(arguments.password,arguments.algorithm)#">			  
				,usu_mudarSenha = <cfqueryparam cfsqltype="cf_sql_bit" value="0">
				,usu_recuperarSenha = <cfqueryparam cfsqltype="cf_sql_bit" value="0">
				,usu_senhaData = GETDATE()
			WHERE
				usu_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.id#">
		</cfquery>	
							
		<cfreturn login( dsn = arguments.dsn,
			username = arguments.username,
			password = arguments.password)/>

		<cfcatch>
			<cfset result["success"] = false>
			<cfset result["message"] = 'Erro ao redefinir senha'>
			<cfset result["cfcatch"] = cfcatch>

			<cfreturn result>
		</cfcatch>

	</cftry>

</cffunction>

<cffunction
	name = "recover"
	access ="remote"
	output ="false"
	returntype ="Any"
	returnformat ="JSON">

	<cfargument
		name ="dsn"
		type ="string"
		required ="false"
		default ="px_project_sql"
		hint ="Data source name">

	<cfargument
		name ="username"
		type ="string"
		required ="false">

	<cfargument
		name ="email"
		type ="string"
		required ="false">

	<cfargument
		name ="algorithm"
		type ="string"
		required ="false"
		default ="SHA-512">

	<cfset result = structNew()>

	<cftry>
		<cfquery datasource="#arguments.dsn#" name="qQuery" result="queryResult">
			SELECT 
			  *
			FROM 
			  dbo.usuario
			WHERE
				usu_login = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.username#">
			AND (usu_email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.email#">
			OR usu_ativo IN (0,2)) -- Usuário inativo, bloqueado)
		</cfquery>	

		<cfif qQuery.recordCount EQ 1>

			<cfif qQuery.usu_ativo NEQ 1>
				<cfset result["success"] = false>

				<cfswitch expression="#qQuery.usu_ativo#">
					<cfcase value="0">
						<cfset result["message"] = 'Este usuário está inativo'>			
					</cfcase>
					<cfcase value="2">
						<cfset result["message"] = 'Este usuário está bloqueado'>			
					</cfcase>
					<cfdefaultcase>
						<cfset result["message"] = ''>			
					</cfdefaultcase>
				</cfswitch>

				<cfreturn result>					
			</cfif>

			<cfset newPassword = randPassword()>

			<cfquery datasource="#arguments.dsn#">
				UPDATE 
				  dbo.usuario  
				SET 
				  usu_senha 		= <cfqueryparam cfsqltype="cf_sql_varchar" value="#hash(variables.newPassword,arguments.algorithm)#">,
				  usu_recuperarSenha = <cfqueryparam cfsqltype="cf_sql_bit" value="1">,
				  usu_recuperarSenhaData = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#">,
				  usu_mudarSenha = <cfqueryparam cfsqltype="cf_sql_bit" value="1">
				WHERE 
				  usu_id = <cfqueryparam cfsqltype="cf_sql_bigint" value="#qQuery.usu_id#">;
			</cfquery>

			<cfset cfg_smtp_server 	= "">
			<cfset cfg_smtp_username 	= "">
			<cfset cfg_smtp_password 	= "">
			<cfset cfg_smtp_port 		= 25>
			
			<cfmail from="#variables.cfg_smtp_username#"
					type="html"
					to="#arguments.email#"					
					subject="[Phoenix Project] Recuperação de Senha"
			    	server="#variables.cfg_smtp_server#"
			    	username="#variables.cfg_smtp_username#" 
					password="#variables.cfg_smtp_password#"
					port="#variables.cfg_smtp_port#"		
					>

				<strong>Este é um e-mail automático, por favor não responda.</strong>	
				<br /><br />
				Prezado(a) #qQuery.usu_nome#,
				<br /><br />
				Foi realizada uma solicitação de recuperação de senha para o login #qQuery.usu_login#.
				<br /><br />
				Por favor acesse o sistema utilizando a senha temporária que está disponibilizada ao <strong>final deste e-mail</strong>.
				<br /><br />
				Ao acessar o sistema com a senha temporária, será solicitado o registro de uma nova senha.
				<br /><br />
				Obs: A senha temporária é válida por 24 Horas.
				<br /><br />												
				<br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
				<br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
				<br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
				<br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
				<cfoutput>
					#variables.newPassword#
				</cfoutput>	

			</cfmail>		

			<cfset result["success"] = true>	
			<cfset result["message"] = ''>
			<!--- <cfset result["newPassword"] = newPassword> --->			
		<cfelse>
			<cfset result["success"] = false>	
			<cfset result["message"] = 'Usuário e/ou e-mail incorreto(s)'>
		</cfif>
				
		<cfset result["qQuery"] = QueryToArray(qQuery)>
					
		<cfreturn result>

		<cfcatch>
			<cfset result["success"] = false>
			<cfset result["message"] = 'Erro ao se comunicar com o servidor'>
			<cfset result["cfcatch"] = cfcatch>
			<cfreturn result>
		</cfcatch>
	</cftry>
</cffunction>

<!--- http://www.bennadel.com/blog/488-generating-random-passwords-in-coldfusion-based-on-sets-of-valid-characters.htm --->
<cffunction name="randPassword" access="private" returntype="String">
	
	<!---
    We have to start out be defining what the sets of valid
    character data are. While this might not look elegant,
    notice that it gives a LOT of power over what the sets
    are without writing a whole lot of code or "condition"
    statements.
	--->

	<!--- Set up available lower case values. --->
	<cfset strLowerCaseAlpha = "abcdefghijklmnopqrstuvwxyz" />

	<!---
	    Set up available upper case values. In this instance, we
	    want the upper case to correspond to the lower case, so
	    we are leveraging that character set.
	--->
	<cfset strUpperCaseAlpha = UCase( strLowerCaseAlpha ) />

	<!--- Set up available numbers. --->
	<cfset strNumbers = "0123456789" />

	<!--- Set up additional valid password chars. --->
	<cfset strOtherChars = "~!@##$%^&*" />

	<!---
	    When selecting random value, we want to be able to easily
	    choose from the entire set. To this effect, we are going
	    to concatenate all the previous valid character sets.
	--->
	<cfset strAllValidChars = (
	    strLowerCaseAlpha &
	    strUpperCaseAlpha &
	    strNumbers &
	    strOtherChars
	    ) />


	<!---
	    Create an array to contain the password ( think of a
	    string as an array of character).
	--->
	<cfset arrPassword = ArrayNew( 1 ) />


	<!---
	    When creating a password, there are certain rules that we
	    need to follow (as deemed by the business logic). That is,
	    the password must:
	    - must be exactly 8 characters in length
	    - must have at least 1 number
	    - must have at least 1 uppercase letter
	    - must have at least 1 lower case letter
	--->


	<!--- Select the random number from our number set. --->
	<cfset arrPassword[ 1 ] = Mid(
	    strNumbers,
	    RandRange( 1, Len( strNumbers ) ),
	    1
	    ) />

	<!--- Select the random letter from our lower case set. --->
	<cfset arrPassword[ 2 ] = Mid(
	    strLowerCaseAlpha,
	    RandRange( 1, Len( strLowerCaseAlpha ) ),
	    1
	    ) />

	<!--- Select the random letter from our upper case set. --->
	<cfset arrPassword[ 3 ] = Mid(
	    strUpperCaseAlpha,
	    RandRange( 1, Len( strUpperCaseAlpha ) ),
	    1
	    ) />


	<!---
	    ASSERT: At this time, we have satisfied the character
	    requirements of the password, but NOT the length
	    requirement. In order to do that, we must add more
	    random characters to make up a proper length.
	--->


	<!--- Create rest of the password. --->
	<cfloop
	    index="intChar"
	    from="#(ArrayLen( arrPassword ) + 1)#"
	    to="8"
	    step="1">

	    <!---
	        Pick random value. For this character, we can choose
	        from the entire set of valid characters.
	    --->
	    <cfset arrPassword[ intChar ] = Mid(
	        strAllValidChars,
	        RandRange( 1, Len( strAllValidChars ) ),
	        1
	        ) />

	</cfloop>


	<!---
	    Now, we have an array that has the proper number of
	    characters and fits the business rules. But, we don't
	    always want the first three characters to be of the
	    same order (by type). Therefore, let's use the Java
	    Collections utility class to shuffle this array into
	    a "random" order.
	    If you are not comfortable using the Java class, you
	    can create your own shuffle algorithm.
	--->
	<cfset CreateObject( "java", "java.util.Collections" ).Shuffle(
	    arrPassword
	    ) />


	<!---
	    We now have a randomly shuffled array. Now, we just need
	    to join all the characters into a single string. We can
	    do this by converting the array to a list and then just
	    providing no delimiters (empty string delimiter).
	--->
	<cfset strPassword = ArrayToList(
	    arrPassword,
	    ""
	    ) />

	<cfreturn replaceList(strPassword, "^,~", "@,$")>

</cffunction>