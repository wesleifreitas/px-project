<cfinclude template="../../lib/pxUtil.cfm">

<cfprocessingDirective pageencoding="utf-8">
<cfset setEncoding("form","utf-8")> 

<cffunction 
    name         ="getNavBar" 
    access       ="remote"  
    output       ="true" 
    returntype   ="any" 
    returnformat ="JSON" 
    hint         ="Retorna px-project menu">
    
    <cfargument 
        name     ="dsn"     
        type     ="string"  
        required ="false"   
        default  ="px_project_sql"  
        hint     ="Data source name">

    <cfargument 
        name     ="per_id"  
        type     ="numeric"  
        required ="false"   
        default  ="-1"          
        hint     ="Código do perfil">

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
                    px.menu AS submenu 
                WHERE 
                    menu.men_id = submenu.men_idPai 
                AND men_ativo   = 1
                AND men_sistema = 1
            ) AS count_submenu
            ,(
                SELECT 
                    COUNT(1) 
                FROM 
                    px.menu AS submenu 
                WHERE 
                    submenu.men_idPai   = menu.men_idPai
                AND men_ativo           = 1 
                AND men_sistema         = 1
            ) AS count_menu
        FROM
            px.menu AS menu
        WHERE
            men_ativo   = <cfqueryparam cfsqltype="cf_sql_bit" value="1"/>
        AND men_sistema = <cfqueryparam cfsqltype="cf_sql_bit" value="1"/>
        ORDER BY
            menu.men_idPai
            ,menu.men_ordem 
    </cfquery>
    

    <cfsavecontent 
        variable = "pxMenu">
        

        <cfset getRecursiveNavBar(
            Dados = qMenu) />

    </cfsavecontent>

    
    <!--- <cfwddx action="cfml2js" input="#pxMenu#" toplevelvariable="menuString"/> --->

    <cfreturn pxMenu>

</cffunction>

<!--- Função desenvolvida baseada em:
http://www.bennadel.com/blog/1069-ask-ben-simple-recursion-example.htm --->
<cffunction
    name       ="getRecursiveNavBar"
    access     ="public"
    returntype ="void"
    output     ="true"
    hint       ="Faz a saída dos menus filhos de um determinado menu pai">
 
    <!--- Define argumentos. --->
    <cfargument
        name     ="Dados"
        type     ="query"
        required ="true"
        hint     ="Dados dos menus"
        />
 
    <cfargument
        name     ="men_idPai"
        type     ="numeric"
        required ="false"
        default  ="0"
        hint     ="ID do menu pai que o menu filho pertence"
        />
 
    <!--- Define o scope LOCAL. --->
    <cfset var LOCAL = StructNew() />
 
 
    <!--- Menus do menu pai. --->
    <cfquery name="LOCAL.qMenu" dbtype="query">
        SELECT
            men_id
            ,men_idPai
            ,men_nome
            ,men_ordem
            ,count_submenu
            ,count_menu
        FROM
            ARGUMENTS.Dados
        WHERE
            men_ativo    = <cfqueryparam cfsqltype="cf_sql_bit"     value="1"/>
        AND men_sistema  = <cfqueryparam cfsqltype="cf_sql_bit"     value="1"/>
        AND men_idPai    = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.men_idPai#"/>
        ORDER BY
            men_ordem ASC
    </cfquery>

    <!---     
        Verifica se existem algum menu filho.
    --->
    <cfif LOCAL.qMenu.RecordCount> 
      
        <!--- Loop nos menus filhos. --->
        <cfloop query="LOCAL.qMenu">

           <cfif LOCAL.qMenu.count_submenu GT 0>
              <li class="px-no-radius">

                <a class='dropdown-toggle px-no-radius px-pointer'>#LOCAL.qMenu.men_nome# </a>

                <ul class='dropdown-menu px-no-radius' data-role='dropdown'>

                <!---
                    Chama função recursiva.
                --->
                <cfset getRecursiveNavBar(
                    Dados = ARGUMENTS.Dados,
                    men_idPai = LOCAL.qMenu.men_id
                    ) />
            

            <cfelseif LOCAL.qMenu.men_idPai GT 0>

                <cfif LOCAL.qMenu.men_ordem EQ 1>
                    
                    <!---<ul class='dropdown-menu' data-role='dropdown'> --->

                </cfif>
                
                <li>
                    <a ng-click="showView('#LOCAL.qMenu.men_id#')">#LOCAL.qMenu.men_nome#</a>
                </li>
                 
            <cfelse>
                
                <li>
                    <a>#LOCAL.qMenu.men_nome#</a>
                </li>

            </cfif>                   
        
            <cfif (LOCAL.qMenu.men_ordem GTE LOCAL.qMenu.count_menu)>

                 </ul> </li>    

            </cfif>

        </cfloop>
        
    </cfif>

    <cfreturn />
</cffunction>


<cffunction 
    name         ="getView"    
    access       ="remote"  
    output       ="true" 
    returntype   ="any" 
    returnformat ="JSON" 
    hint         ="Retorna o componente que será apresentado para o usuário">
    
    <cfargument 
        name     ="dsn"     
        required ="false"   
        default  ="px_project_sql"    
        hint     ="Data source name">

    <cfargument 
        name     ="pathname"     
        type     ="string"  
        required ="false"   
        default  =""    
        hint     ="Pasta raíz do projeto">

    <cfargument 
        name     ="pxProjectPackage"     
        type     ="string"  
        required ="false"   
        default  =""    
        hint     ="Componentes px-project">

    <cfargument 
        name     ="per_id"  
        required ="false"   
        default  ="-1"          
        hint     ="Código do perfil">


    <cfargument 
        name     ="com_id"  
        required ="false"   
        default  ="-1"          
        hint     ="Código do componente">


    <cfquery name="qComponente" datasource="#arguments.dsn#">
        
        WITH pxProjectMenuRecursivo(men_id, men_nome, men_nivel, men_nomeCaminho, men_ordem, men_idPai, com_view, com_icon)
        AS
        (
            SELECT 
                men_id
                ,men_nome
                ,1 AS 'men_nivel'
                ,CAST(men_nome AS VARCHAR(255)) AS 'men_nomeCaminho'
                ,men_ordem
                ,men_idPai
                ,com_view
                ,com_icon
            FROM 
                px.vw_menu 
            WHERE 
                (men_idPai IS NULL OR men_idPai = 0)
                                    
            UNION ALL
                                
            -- Parte recursiva.
            SELECT 
                m.men_id
                ,m.men_nome
                ,c.men_nivel + 1 AS 'men_nivel',
                CAST((c.men_nomeCaminho + ' » ' + m.men_nome) AS VARCHAR(255)) 'men_nomeCaminho'
                ,m.men_ordem
                ,m.men_idPai
                ,m.com_view
                ,m.com_icon
            FROM 
                px.vw_menu m 
            INNER JOIN 
                pxProjectMenuRecursivo c 
            ON 
                m.men_idPai = c.men_id
                             
        )
        SELECT 
            men_nivel
            ,men_nomeCaminho
            ,men_ordem
            ,men_idPai
            ,men_id
            ,com_view 
            ,com_icon
        FROM 
            pxProjectMenuRecursivo
        WHERE 
            men_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.com_id#">

    </cfquery>


    <cfset result               = structNew()> 

    <cfif not fileExists(expandPath('/') & arguments.pathname & qComponente.com_view)>        
        <cfset result['com_view_fault'] = qComponente.com_view> 
        <cfset qComponente.com_view  = pxProjectPackage & 'px/system/view/viewDoesNotExist.html'> 
    </cfif>
    
    <cfset result['arguments']     = arguments> 
    <cfset result['qComponente']   = QueryToArray(qComponente)> 
    
    <cfreturn result>

</cffunction>