<cfcomponent rest="true" restPath="/system">  
	<!--- 
	px-data-grid - START
	--->    
    <cffunction name="dataGridGetData" 
    	access="remote" 
    	returnType="any" 
    	httpMethod="POST" 
    	restPath="/px-data-grid/getData"
    	hint="">

        <cfargument name="body" type="String">

        <!---
        <cfdocument format="PDF" filename="rest-debug.pdf">                	
        	<cfdump var="#DeserializeJSON(arguments.body)#">
        </cfdocument>
        --->
        <cftry>
	        <cfset body = DeserializeJSON(arguments.body)>

	        <cfinvoke component="px-project.system.components.px-data-grid.px-data-grid"
	        	method="getData"
				dsn="#body.dsn#"
				user="#body.user#"
				rows="#body.rows#"
				rowFrom="#body.rowFrom#"
				rowTo="#body.rowTo#"
				schema="#body.schema#"
				table="#body.table#"
				fields="#body.fields#"
				orderBy="#body.orderBy#"
				group="#body.group#"
				groupItem="#body.groupItem#"
				groupLabel="#body.groupLabel#"
				where="#body.where#"
	        	returnvariable="response">
	        
	        <cfreturn SerializeJSON(response)>

	    	<cfcatch>
	    		<cfset response = structNew()>
	    		<cfset response["source"] = "rest.cfc">
	    		<cfset response["cfcatch"] = cfcatch>
	    		<cfreturn SerializeJSON(cfcatch)>
	    	</cfcatch>
	    </cftry>
    </cffunction>

   <cffunction name="dataGridRemoveData" 
    	access="remote" 
    	returnType="any" 
    	httpMethod="POST" 
    	restPath="/px-data-grid/removeData"
    	hint="">

        <cfargument name="body" type="String">

        <!---
        <cfdocument format="PDF" filename="rest-debug.pdf">                	
        	<cfdump var="#DeserializeJSON(arguments.body)#">
        </cfdocument>
        --->
        <cftry>
	        <cfset body = DeserializeJSON(arguments.body)>

	        <cfinvoke component="px-project.system.components.px-data-grid.px-data-grid"
	        	method="removeData"
				dsn="#body.dsn#"
				user="#body.user#"
				schema="#body.schema#"
				table="#body.table#"
				fields="#body.fields#"
				selectedItems="#body.selectedItems#"
	        	returnvariable="response">
	        
	        <cfreturn SerializeJSON(response)>

	        <cfcatch>
	    		<cfset response = structNew()>
	    		<cfset response["source"] = "rest.cfc">
	    		<cfset response["cfcatch"] = cfcatch>
	    		<cfreturn SerializeJSON(cfcatch)>
	    	</cfcatch>
	    </cftry>
    </cffunction>
    <!--- 
	px-data-grid - END
	---> 

	<!--- 
	px-from - START
	---> 
	<cffunction name="formGetData" 
    	access="remote" 
    	returnType="any" 
    	httpMethod="POST" 
    	restPath="/px-form/getData"
    	hint="">

        <cfargument name="body" type="String">

        <!---
        <cfdocument format="PDF" filename="rest-debug.pdf">                	
        	<cfdump var="#DeserializeJSON(arguments.body)#">
        </cfdocument>
        --->
        <cftry>
	        <cfset body = DeserializeJSON(arguments.body)>

	        <cfinvoke component="px-project.system.components.px-form.px-form"
	        	method="select"
				dsn="#body.dsn#"
				<!--- user="#body.user#" --->
				<!--- schema="#body.schema#" --->
				table="#body.table#"
				fields="#body.fields#"				
	        	returnvariable="response">
	        
	        <cfreturn SerializeJSON(response)>

	        <cfcatch>
	    		<cfset response = structNew()>
	    		<cfset response["source"] = "rest.cfc">
	    		<cfset response["cfcatch"] = cfcatch>
	    		<cfreturn SerializeJSON(cfcatch)>
	    	</cfcatch>
	    </cftry>
    </cffunction>

    <cffunction name="formInsertUpdate" 
    	access="remote" 
    	returnType="any" 
    	httpMethod="POST" 
    	restPath="/px-form/insertUpdate"
    	hint="">

        <cfargument name="body" type="String">

        <!---
        <cfdocument format="PDF" filename="rest-debug.pdf">                	
        	<cfdump var="#DeserializeJSON(arguments.body)#">
        </cfdocument>
        --->
        <cftry>
	        <cfset body = DeserializeJSON(arguments.body)>

	        <cfinvoke component="px-project.system.components.px-form.px-form"
	        	method="insertUpdate"
				dsn="#body.dsn#"
				<!--- user="#body.user#" --->
				action="#body.action#"
				<!--- schema="#body.schema#" --->
				table="#body.table#"
				fields="#body.fields#"
				oldForm="#body.oldForm#"
	        	returnvariable="response">
	        
	        <cfreturn SerializeJSON(response)>

	        <cfcatch>
	    		<cfset response = structNew()>
	    		<cfset response["source"] = "rest.cfc">
	    		<cfset response["cfcatch"] = cfcatch>
	    		<cfreturn SerializeJSON(cfcatch)>
	    	</cfcatch>
	    </cftry>
    </cffunction>
	<!--- 
	px-from - END
	---> 
</cfcomponent>
