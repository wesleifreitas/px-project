<cfcomponent rest="true" restPath="/system/px-form">  

	<cffunction name="formGetData" 
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

	        <cfinvoke component="px-form"
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
    	restPath="/insertUpdate"
    	hint="">

        <cfargument name="body" type="String">

        <!---
        <cfdocument format="PDF" filename="rest-debug.pdf">                	
        	<cfdump var="#DeserializeJSON(arguments.body)#">
        </cfdocument>
        --->
        <cftry>
	        <cfset body = DeserializeJSON(arguments.body)>

	        <cfinvoke component="px-form"
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
	
</cfcomponent>
