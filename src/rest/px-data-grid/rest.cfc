<cfcomponent rest="true" restPath="/system/px-data-grid">  

    <cffunction name="dataGridGetData" 
    	access="remote" 
    	returnType="any" 
    	httpMethod="POST" 
    	restPath="/getData"
    	hint="">

        <cfargument name="body" type="String">

        <!---
        <cfdocument format="PDF" filename="rest-debug.pdf">                	
        	<cfdump var="#DeserializeJSON(arguments.body)#">
        </cfdocument>
        --->
        <cftry>
	        <cfset body = DeserializeJSON(arguments.body)>

	        <cfinvoke component="px-data-grid"
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
    	restPath="/removeData"
    	hint="">

        <cfargument name="body" type="String">

        <!---
        <cfdocument format="PDF" filename="rest-debug.pdf">                	
        	<cfdump var="#DeserializeJSON(arguments.body)#">
        </cfdocument>
        --->
        <cftry>
	        <cfset body = DeserializeJSON(arguments.body)>

	        <cfinvoke component="px-data-grid"
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
 
</cfcomponent>
