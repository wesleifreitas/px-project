<!--- <cfdump var="#CGI#"> <cfabort> --->
<cfif lCase(CGI.SERVER_NAME) EQ 'localhost' OR CGI.SERVER_NAME EQ '127.0.0.1'>
	<cfset location = "http://" & CGI.HTTP_HOST & "/px-project/src">
<cfelse>
	<cfset location = "http://" & CGI.HTTP_HOST>
</cfif>
<cflocation url="#location#" addtoken="no"/>