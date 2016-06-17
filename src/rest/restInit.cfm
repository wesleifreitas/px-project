<cftry>
	<cfset path = getDirectoryFromPath(getCurrentTemplatePath())>
	<cfset restInitApplication(path & '..\system',"px-project")>	
	<cfcatch type="any">
	    <cfdump var="#cfcatch#">
	    <cfabort>
	</cfcatch>
</cftry>