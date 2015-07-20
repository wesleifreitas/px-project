<cfscript>
	This.rootPxProject 	= "px-project";	
</cfscript>

<cfapplication	
	clientmanagement	= "yes"
	clientstorage		= "cookie"
	sessionmanagement	= "yes"
	sessiontimeout		= "#CreateTimeSpan(0,5,0,0)#"
	loginstorage		= "cookie"
	setclientcookies	= "yes"
	setdomaincookies	= "yes"
	>

<!--- 
<cfdump var="#session#">
<cfabort> 
--->
