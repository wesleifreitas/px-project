<cfinclude template="../../utils/cf/px-util.cfm">

<cfprocessingDirective pageencoding="utf-8">
<cfset setEncoding("form","utf-8")> 

<cffunction
    name="getNavBar"
    access="remote"
    output="true"
    returntype="any"
    returnformat="JSON"
    hint="Retorna menu">
    
    <cfargument
        name="dsn"
        type="string"
        required="false"
        default="px_project_sql"
        hint="Data source name">

    <cfargument
        name="pro_id"
        type="string"
        required="false"
        default="0"
        hint="Identificação do projeto">

    <cfargument
        name="user"
        type="numeric"
        required="false"
        default="-1"
        hint="ID do usuário">

    <cfargument
        name="isMobile"
        type="boolean"
        required="false"
        default="false"
        hint="O acesso é feito por browser mobile?">

    <cfset response = structNew()>

    <cfset arguments.pro_id = decode(arguments.pro_id)>
    <cfif isArray(arguments.pro_id)>
        <cfset inPro_id = arrayToList(arguments.pro_id, ",")>
    <cfelse>
        <cfset inPro_id = arguments.pro_id>
    </cfif>

    <cfquery datasource="#arguments.dsn#" name="qUsuario">
        SELECT
            usu_nome
            ,per_id
            ,per_developer
            ,grupo_nome
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
                <cfif arguments.user GT -1 AND qUsuario.per_developer NEQ 1>
                    INNER JOIN dbo.acesso AS acesso
                    ON submenu.men_id = acesso.men_id
                </cfif> 
                WHERE 
                    pro_id      IN (#inPro_id#)
                AND menu.men_id = submenu.men_idPai 
                AND men_ativo   = 1
                AND men_sistema = 1
                <cfif arguments.user GT -1 AND qUsuario.per_developer NEQ 1>
                    AND acesso.per_id = <cfqueryparam cfsqltype="cf_sql_bigint" value="#qUsuario.per_id#">
                </cfif>
            ) AS count_submenu
            ,(
                SELECT 
                    COUNT(1) 
                FROM 
                    dbo.menu AS submenu 
                <cfif arguments.user GT -1 AND qUsuario.per_developer NEQ 1>
                    INNER JOIN dbo.acesso AS acesso
                    ON submenu.men_id = acesso.men_id
                </cfif>
                WHERE 
                    pro_id              IN (#inPro_id#)
                AND submenu.men_idPai   = menu.men_idPai
                AND men_ativo           = 1 
                AND men_sistema         = 1
                <cfif arguments.user GT -1 AND qUsuario.per_developer NEQ 1>
                    AND acesso.per_id = <cfqueryparam cfsqltype="cf_sql_bigint" value="#qUsuario.per_id#">
                </cfif>
            ) AS count_menu
        FROM
            dbo.menu AS menu

        <cfif arguments.user GT -1 AND qUsuario.per_developer NEQ 1>
            INNER JOIN dbo.acesso AS acesso
            ON menu.men_id = acesso.men_id
        </cfif>

        WHERE
            pro_id      IN (#inPro_id#)
        AND men_ativo   = <cfqueryparam cfsqltype="cf_sql_bit" value="1"/>
        AND men_sistema = <cfqueryparam cfsqltype="cf_sql_bit" value="1"/>
        <cfif arguments.user GT -1 AND qUsuario.per_developer NEQ 1>
            AND acesso.per_id = <cfqueryparam cfsqltype="cf_sql_bigint" value="#qUsuario.per_id#">
        </cfif>
        ORDER BY
            menu.men_idPai
            ,menu.men_ordem             
    </cfquery>
    
    <cfset cssFit = "px-fit">
    <!---
    <cfset toggle = '<div class="element place-right px-pointer" ng-click="toggleRight()">
                <a class="element-menu">
                    <span class="glyphicon glyphicon-option-vertical" aria-hidden="true"></span>
                </a>            
            </div>'>
    --->
    <cfset toggle = "">
    <cfif arguments.isMobile>
        <cfset cssFit = "px-fit-mobile">
        <cfset toggle = "">
    </cfif>

    <cfsavecontent variable = "pxMenu">
        
        <cfset getRecursiveNavBar(
            data = qMenu,
            cssFit = variables.cssFit) />

    </cfsavecontent>

    
   
    <!--- <cfwddx action="cfml2js" input="#pxMenu#" toplevelvariable="menuString"/> --->
    <cfset response['navBar'] = '<md-menu-bar>#variables.pxMenu#</md-menu-bar>'>
    <cfreturn response>

</cffunction>

<!--- Função desenvolvida baseada em:
http://www.bennadel.com/blog/1069-ask-ben-simple-recursion-example.htm --->
<cffunction
    name="getRecursiveNavBar"
    access="public"
    returntype="void"
    output="true"
    hint="Faz a saída dos menus filhos de um determinado menu pai">
 
    <!--- Define argumentos --->
    <cfargument
        name="data"
        type="query"
        required="true"
        hint="data dos menus"
        />
 
    <cfargument
        name="men_idPai"
        type="numeric"
        required="false"
        default="0"
        hint="ID do menu pai que o menu filho pertence"
        />

    <cfargument
        name="cssFit"
        type="string"
        required="false"
        default=""
        hint="CSS Fit"
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
        <!--- Loop nos menus filhos --->
        <cfloop from="1" to="#LOCAL.qMenu.RecordCount#" index="i">
            <!--- Possui submenu? --->
            <cfif LOCAL.qMenu.count_submenu[i] GT 0>
                <!--- Verificar é menu base --->
                <cfif LOCAL.qMenu.men_idPai[i] EQ 0>
                    <md-menu>
                        <button ng-click="$mdOpenMenu()">
                            #LOCAL.qMenu.men_nome[i]#
                        </button>
                        <md-menu-content>
                        <!---
                            Chamar função recursiva
                        --->
                        <cfset getRecursiveNavBar(
                            data = arguments.data,
                            men_idPai = LOCAL.qMenu.men_id[i],
                            cssFit = arguments.cssFit
                            ) />
                        </md-menu-content>
                    </md-menu>
                <cfelse>
                    <md-menu-item>
                        <md-menu>
                            <md-button ng-click="$mdOpenMenu()">
                                #LOCAL.qMenu.men_nome[i]#
                            </md-button>
                            <md-menu-content>
                            <!---
                                Chamar função recursiva
                            --->
                            <cfset getRecursiveNavBar(
                                data = arguments.data,
                                men_idPai = LOCAL.qMenu.men_id[i],
                                cssFit = arguments.cssFit
                                ) />
                            </md-menu-content>
                        </md-menu>
                    </md-menu-item>
                </cfif>
            <!--- Verificar se possui idPai --->
            <cfelseif LOCAL.qMenu.men_idPai[i] GT 0>
                <md-menu-item>
                    <md-button ng-click="showView('#LOCAL.qMenu.men_id[i]#')">
                        #LOCAL.qMenu.men_nome[i]#
                    </md-button>
                </md-menu-item>
            </cfif>
        </cfloop>
    </cfif>

    <cfreturn />
</cffunction>


<cffunction
    name="getView"
    access="remote"
    output="true"
    returntype="any"
    returnformat="JSON"
    hint="Retorna o componente que será apresentado para o usuário">
    
    <cfargument
        name="dsn"
        required="false"
        default="px_project_sql"
        hint="Data source name">

    <cfargument
        name="pathname"
        type="string"
        required="false"
        default=""
        hint="Pasta raíz do projeto">

    <cfargument 
        name="pxProjectPackage"
        type="string"
        required="false"
        default=""
        hint="Componentes px-project">

    <cfargument
        name="per_id"
        required="false"
        default="-1"
        hint="Código do perfil">


    <cfargument
        name="men_id"
        required="false"
        default="-1"
        hint="Código do componente">


    <cfquery name="qView" datasource="#arguments.dsn#">
        
        WITH pxProjectMenuRecursivo(men_id, men_nome, men_nivel, men_nomeCaminho, men_ordem, men_idPai, com_view, com_icon, com_px_lib)
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
                ,com_px_lib
            FROM 
                dbo.vw_menu 
            WHERE 
                (men_idPai IS NULL OR men_idPai = 0)
                                    
            UNION ALL
                                
            <!--- Parte recursiva --->
            SELECT 
                m.men_id
                ,m.men_nome
                ,c.men_nivel + 1 AS 'men_nivel',
                CAST((c.men_nomeCaminho + ' » ' + m.men_nome) AS VARCHAR(255)) 'men_nomeCaminho'
                ,m.men_ordem
                ,m.men_idPai
                ,m.com_view
                ,m.com_icon
                ,m.com_px_lib
            FROM 
                dbo.vw_menu m 
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
            ,com_px_lib
        FROM 
            pxProjectMenuRecursivo
        WHERE 
            men_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.men_id#">

    </cfquery>

    <cfif qView.com_px_lib EQ 1>
        <cfset qView.com_view = arguments.pxProjectPackage & qView.com_view>
    </cfif>

    <cfset result = structNew()> 
    
    <cfif fileExists(expandPath('/') & qView.com_view) OR fileExists(expandPath('/') & arguments.pathname & qView.com_view)>
        <cfset result['com_view_fault'] = ''> 
    <cfelse>        
        <cfset result['com_view_fault'] = expandPath('/') & qView.com_view> 
        <cfset qView.com_view  = pxProjectPackage & 'system/components/px-nav-bar/fault-view.html'> 
    </cfif>    
    
    <cfset result['arguments'] = arguments> 
    <cfset result['qView'] = QueryToArray(qView)>
    <cfset state = listToArray(qView.COM_VIEW, "/")>
    <cfset result['state'] = replace(state[arrayLen(state)], ".html", "")>
    
    <cfreturn result>

</cffunction>