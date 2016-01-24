<cfinclude template="../utils/cf/px-util.cfm">

<cffunction name="jsTreeMenu" access="remote" returntype="any" returnformat="JSON" output="true">

	<cfargument 
		name ="dsn"		
		type ="string"
		required ="false"	
		default ="px_project_sql"	
		hint ="Data source name">

	<cfargument 
		name     ="user"
		type	 ="numeric"
		required ="false"
		default  =""	
		hint     ="ID do usuário">

	<cfargument 
		name     ="id"
		type	 ="numeric"
		required ="false"
		default  ="0"	
		hint     ="ID do perfil">

	<cfargument 
        name     ="pro_id"  
        type     ="string"  
        required ="false"   
        default  ="0"          
        hint     ="Identificação do projeto">

	<cfset result = structNew()>

	<cftry>	
		<cfset inPro_id = 0>

		<cfquery datasource="#arguments.dsn#" name="qUsuario">
			SELECT
				per_id
				,per_developer
			FROM
				dbo.vw_usuario
			WHERE
				usu_id = <cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.user#">
		</cfquery>

		<cfquery datasource="#arguments.dsn#" name="qMenu">
		    SELECT
		        menu.men_ativo
		        ,menu.men_sistema
		        ,menu.men_id
		        ,menu.men_nome
		        ,menu.men_idPai
		        ,menu.men_ordem
		        ,(
		            SELECT 
		                COUNT(1) 
		            FROM 
		                dbo.menu AS submenu 
		            WHERE 
		                pro_id      IN (#inPro_id#)
		            AND menu.men_id = submenu.men_idPai 
		            AND men_ativo   = 1
		            AND men_sistema = 1
		        ) AS count_submenu
		        ,(
		            SELECT 
		                COUNT(1) 
		            FROM 
		                dbo.menu AS submenu 
		            WHERE 
		                pro_id              IN (#inPro_id#)
		            AND submenu.men_idPai   = menu.men_idPai
		            AND men_ativo           = 1 
		            AND men_sistema         = 1
		        ) AS count_menu
			 	,(
			      SELECT 
			          COUNT(1) 
			      FROM 
			          dbo.acesso AS acesso_check 
			      WHERE 
			          pro_id              IN (#inPro_id#)
			      AND acesso_check.men_id   = menu.men_id
			      AND men_ativo           = 1 
			      AND men_sistema         = 1
			      AND per_id = <cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.id#">
			  ) AS acesso_check_per_id
		    FROM
		        dbo.menu AS menu

		    <cfif qUsuario.per_developer NEQ 1>
			    LEFT OUTER JOIN dbo.acesso AS acesso
	  			ON menu.men_id = acesso.men_id
  			</cfif>

		    WHERE
		        pro_id      IN (#inPro_id#)
		    AND men_ativo   = <cfqueryparam cfsqltype="cf_sql_bit" value="1"/>
		    AND men_sistema = <cfqueryparam cfsqltype="cf_sql_bit" value="1"/>		 

		    <cfif qUsuario.per_developer NEQ 1>
			    AND acesso.per_id = <cfqueryparam cfsqltype="cf_sql_bigint" value="#qUsuario.per_id#">
  			</cfif>

		    ORDER BY
		        menu.men_idPai
		        ,menu.men_ordem             
		</cfquery>	

		<cfscript>
			var jstree = structNew();
			var plugins = arrayNew(1);
			var data = arrayNew(1);			

			arrayAppend(plugins, "wholerow");
			arrayAppend(plugins, "checkbox");		
		</cfscript>	

		<!--- <cfset dataTree = getRecursiveMenu(data = qMenu) /> --->

	    <cfsavecontent variable="dataTree"><cfset getRecursiveMenu(data = qMenu, per_id = arguments.id)></cfsavecontent>

	    <cfset dataTree = ConvertXmlToStruct(xmlParse(dataTree),structnew())>
   	   	
   	   		
   	   	<cfset result["qMenu"] = qMenu>
		<cfset result["dataTree"] = dataTree>
			
		<cfscript>
			/*
			var jstree = structNew();
			var plugins = arrayNew(1);
			var data = arrayNew(1);
			var dataObj = structNew();

			arrayAppend(plugins, "wholerow");
			arrayAppend(plugins, "checkbox");

			dataObj["text"] = "Teste";
			dataObj["children"] = [{"text": "Teste selected"},{"state":{"selected": true}}];

			arrayAppend(data, dataObj);
			*/
		
			jstree["plugins"] = plugins;
			jstree["core"]["themes"] = {"name": "proton", "responsive": true};
			jstree["core"]["data"] = dataTree.children;
		</cfscript>		
		
		<cfset result["success"] = true>		
		<cfset result["arguments"] = arguments>
		<cfset result["jstree"] = jstree>			  
			
		<cfreturn result>

		<cfcatch>
			<cfset result["success"] = false>
			<cfset result["cfcatch"] = cfcatch>
			<cfreturn result>
		</cfcatch>		
	</cftry>
</cffunction>

<cffunction
    name       ="getRecursiveMenu"
    access     ="public"
    returntype ="void"
    output     ="true"
    hint       ="Faz a saída dos menus filhos de um determinado menu pai">
 
    <!--- Define argumentos --->
	<cfargument 
		name ="dsn"		
		type ="string"
		required ="false"	
		default ="px_project_sql"	
		hint ="Data source name">

    <cfargument
        name     ="data"
        type     ="query"
        required ="true"
        hint     ="data dos menus"
        />

    <cfargument
        name     ="per_id"
        type     ="numeric"
        required ="false"
        default  ="0"
        hint     ="ID do perfil"
        />
 
    <cfargument
        name     ="men_idPai"
        type     ="numeric"
        required ="false"
        default  ="0"
        hint     ="ID do menu pai que o menu filho pertence"
        />
    
    <!--- Define o scope LOCAL --->
    <cfset var LOCAL = StructNew() />
 
    <!--- Menus do menu pai --->
    <cfquery name="LOCAL.qMenu" dbtype="query">
        SELECT
            men_id
            ,men_idPai
            ,men_nome
            ,men_ordem
            ,count_submenu
            ,count_menu
            ,acesso_check_per_id
        FROM
            arguments.data
        WHERE
            men_ativo    = <cfqueryparam cfsqltype="cf_sql_bit"     value="1"/>
        AND men_sistema  = <cfqueryparam cfsqltype="cf_sql_bit"     value="1"/>
        AND men_idPai    = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.men_idPai#"/>
        ORDER BY
            men_ordem ASC
    </cfquery>

    <!---     
        Verifica se existem algum menu filho
    --->
    <cfif LOCAL.qMenu.RecordCount>
    	<cfif LOCAL.qMenu.men_idPai EQ 0>
    		<cfoutput><root></cfoutput>
    	</cfif>  
        <!--- Loop nos menus filhos --->
        <cfloop query="LOCAL.qMenu">  

        	<cfquery datasource="#arguments.dsn#" name="qCheck">
        		SELECT
        			men_check
        		FROM
        			dbo.acesso
        		WHERE
        			per_id = <cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.per_id#">
        		AND men_id = <cfqueryparam cfsqltype="cf_sql_bigint" value="#LOCAL.qMenu.men_id#">
        	</cfquery>


        	<cfoutput><children><text>#LOCAL.qMenu.men_nome#</text><state><selected>#qCheck.men_check#</selected><opened>false</opened></state><id>#LOCAL.qMenu.men_id#</id></cfoutput>
            <!---
                Chama função recursiva
            --->
            <cfset getRecursiveMenu(
                data = arguments.data,
                per_id = arguments.per_id,
                men_idPai = LOCAL.qMenu.men_id
                )/>
            
            <cfoutput></children><children>null</children></cfoutput>
        </cfloop>
		<cfif LOCAL.qMenu.men_idPai EQ 0>
			<cfoutput></root></cfoutput>
		</cfif>

    </cfif>   

    <cfreturn />
</cffunction>

<cffunction 
	name         ="saveTreeMenu" 
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
		name     ="id" 	
		type	 ="numeric"
		required ="false"
		default  =""	
		hint     ="ID do perfil">

	<cfargument 
		name     ="data" 	
		type	 ="string"
		required ="false"
		default  =""	
		hint     ="jsTree data.selected">

	<cfset result = structNew()>
	<cfset result["arguments"] = arguments>
	
	<cftry>			
		<cfset arguments.data = decode(arguments.data)>		
		
		<!--- <cftransaction> --->
			<cfquery datasource="#arguments.dsn#" name="qQuery" result="queryResult">
				DELETE FROM
					dbo.acesso
				WHERE
					per_id = <cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.id#">
			</cfquery>
			<cfloop array="#arguments.data#" index="i">
				<cfquery datasource="#arguments.dsn#" result="queryResult">
					DELETE FROM
						dbo.acesso
					WHERE
						per_id = <cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.id#">
					AND men_id = <cfqueryparam cfsqltype="cf_sql_bigint" value="#i#">

					INSERT INTO
						dbo.acesso
					(
						per_id,
						men_id,
						men_check
					) 
					VALUES (
						<cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.id#">,
						<cfqueryparam cfsqltype="cf_sql_bigint" value="#i#">,
						<cfqueryparam cfsqltype="cf_sql_bit" value="1">
					);					
				</cfquery>

				<cfquery datasource="#arguments.dsn#" name="qParent">
					SELECT
						men_idPai
					FROM
						dbo.menu
					WHERE
						men_id = <cfqueryparam cfsqltype="cf_sql_bigint" value="#i#">
				</cfquery>

				<cfquery datasource="#arguments.dsn#" name="qParentAcesso">
					SELECT
						men_idPai
					FROM
						dbo.menu
					WHERE
						men_id = <cfqueryparam cfsqltype="cf_sql_bigint" value="#qParent.men_idPai#">
				</cfquery>

				<cfif qParent.recordCount GT 0 AND qParent.men_idPai GT 0>							
					<cfquery datasource="#arguments.dsn#">
						IF NOT EXISTS (	SELECT 
											per_id 
										FROM 
											dbo.acesso 
					                   	WHERE 
					                   		per_id = <cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.id#">
					                   	AND men_id = <cfqueryparam cfsqltype="cf_sql_bigint" value="#qParent.men_idPai#">)
						BEGIN
							INSERT INTO
								dbo.acesso
							(
								per_id,
								men_id,
								men_check
							) 
							VALUES (
								<cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.id#">,
								<cfqueryparam cfsqltype="cf_sql_bigint" value="#qParent.men_idPai#">,
								<cfqueryparam cfsqltype="cf_sql_bit" value="0">
							);
						END
					</cfquery>
				</cfif>
			</cfloop>
		<!--- </cftransaction> --->
							
		<cfset result["success"] = true>				
				
		<cfcatch>
			<cfset result["success"] = false>
			<cfset result["cfcatch"] = cfcatch>
			<cfreturn result>
		</cfcatch>

	</cftry>

	<cfreturn result>
</cffunction>