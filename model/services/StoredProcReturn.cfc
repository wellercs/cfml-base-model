<cfcomponent displayname="StoredProcReturn" hint="The result from the execute command of CFSCRIPT stored proc call">
	
	<cfset this.results = {}>
	<cfset this.output = {}>
	
	<cffunction name="addProcResults">
		<cfargument name="name" type="string" required="true">
		<cfargument name="result" type="any" required="true">
		<cfset this.results[arguments.name] = arguments.result> 
	</cffunction>
	
	<cffunction name="getProcResultSets" output="false" returntype="struct">
		<cfreturn this.results>
	</cffunction>


	<cffunction name="getProcOutVariables" output="false" returntype="struct">
		<cfreturn this.output>
	</cffunction>

	<cffunction name="addProcOutput">
		<cfargument name="name" type="string" required="true">
		<cfargument name="value" type="any" required="true">
		<cfset this.output[arguments.name] = arguments.value> 
	</cffunction>
	
</cfcomponent>