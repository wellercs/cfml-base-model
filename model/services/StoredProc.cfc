<cfcomponent displayname="StoredProc" hint="A Lucee replacement for CFSCRIPT stored proc differences in syntax">
	
	<cffunction name="init" output="false" access="public" hint="">
		
		<cfset local.details = {}>
		<cfloop list="#structKeyList(arguments)#" index="local.x">
			<cfif NOT listFindNoCase("procedure,datasource",local.x)>
				<cfset local.details[local.x] = arguments[local.x]>
			</cfif>
		</cfloop>

		<cfset this.proc = {
			procedure	= arguments.procedure,
			datasource	= arguments.datasource,
			details		= local.details,
			params		= ArrayNew(1),
			results		= ArrayNew(1)
		}>
		<cfreturn this>
	</cffunction>
	
	<cffunction name="addParam" output="false" returntype="void" access="public" hint="replacement for the cfprocparam tag">
		<!--- Add param to the proc details --->
		<cfset ArrayAppend(this.proc.params,arguments)>
	</cffunction>
	
	<cffunction name="addProcResult" output="false" returntype="void" access="public" hint="replacement for the cfprocresult tag">
		<!--- Add param to the proc reults --->
		<cfset ArrayAppend(this.proc.results,arguments)>
	</cffunction>
	
	<cffunction name="execute" output="false" returntype="StoredProcReturn" access="public" hint="Executes the stored proc in tag form and returns a standard result">
		<!--- There should be no arguments --->
		
		<!--- Setup the return object --->
		<cfset local.StoredProcReturn = CreateObject("component","StoredProcReturn")>

		<!--- Execute the proc --->
		<cfstoredproc attributeCollection="#this.proc.details#" procedure="#this.proc.procedure#" datasource="#this.proc.datasource#">
			<!--- Params --->
			<cfloop from="1" to="#arrayLen(this.proc.params)#" index="local.i">
				<cfprocparam attributeCollection="#this.proc.params[local.i]#">
			</cfloop>
			<!--- Results --->
			<cfloop from="1" to="#arrayLen(this.proc.results)#" index="local.i">
				<cfprocresult  attributeCollection="#this.proc.results[local.i]#">
			</cfloop>
		</cfstoredproc>

		<!--- Get the out vars --->
		<cfloop from="1" to="#arrayLen(this.proc.params)#" index="local.i">
			<cfset local.param = this.proc.params[local.i]>
			<cfif structKeyExists(local.param,"type")>
				<cfif local.param.type IS "out" OR local.param.type IS "inout">
					<cfset local.StoredProcReturn.addProcOutput(name=local.param.variable,value=evaluate(local.param.variable))>
				</cfif>
			</cfif>
		</cfloop>
		
		<!--- Get the results and push them into the result object --->
		<cfloop from="1" to="#arrayLen(this.proc.results)#" index="local.i">
			<cfset local.StoredProcReturn.addProcResults(name=this.proc.results[local.i].name,result=evaluate(this.proc.results[local.i].name))>
		</cfloop>
		<cfreturn local.StoredProcReturn/>
	</cffunction>

</cfcomponent>