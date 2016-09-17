<cftry>
	<cfset path = getDirectoryFromPath(getCurrentTemplatePath())>
	<cfset restInitApplication(path, "px-project")>	
	<cfcatch type="any">
	    <cfdump var="#cfcatch#">
	    <cfabort>
	</cfcatch>
</cftry>