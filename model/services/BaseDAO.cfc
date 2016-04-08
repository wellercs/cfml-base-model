component accessors="true" {

	/* TODO
		delete
		save
	*/

	property beanFactory;
	property datamapper;
	property orm;

	public BaseDAO function init() {
		return this;
	}

	public struct function getByID( string name, any id ) {
		local.result = retrieveData( name = arguments.name, fn = getFunctionCalledName(), values = [ arguments.id ] );
		if ( arrayLen(local.result) ) {
			return local.result[1];
		}
		return {};
	}

	public any function findByKeys( string name, struct args, string format = "arrayOfStructs", array orderBy = [] ) {
		return retrieveData( name = arguments.name, fn = getFunctionCalledName(), values = arguments.args.values );
	}

	private any function retrieveData( required string name, required string fn, array values = [] ) {
		local.useNOSQL = false;
		local.results = "";
		local.stem = replaceNoCase(arguments.name, "Bean", "", "one");

		if ( structKeyExists(variables.orm, local.stem) AND structKeyExists(variables.orm[local.stem], arguments.fn) ) {
			if ( structKeyExists(variables.orm[local.stem][arguments.fn], "NOSQL") ) {
				local.nosqlConfig = variables.orm[local.stem][arguments.fn]["NOSQL"];
				local.nosqlObject = variables.beanFactory.getBean( local.nosqlConfig.mapping );
				local.useNOSQL = true;
				for ( local.key_match in reMatchNoCase( "{[0-9]}", local.nosqlConfig.options.key ) ) {
					local.value_index = reReplace( local.key_match, "{||}", "", "all" );
					local.nosqlConfig.options.key = replace( local.nosqlConfig.options.key, "{#local.value_index#}", arguments.values[local.value_index], "all" );
				}
			}

			if ( local.useNOSQL ) {
				local.results = local.nosqlObject.get( argumentCollection = local.nosqlConfig.options );
			}

			if ( structKeyExists(variables.orm[local.stem][arguments.fn], "MSSQL") AND isValid("string", local.results) AND NOT len(trim(local.results)) ) {
				structAppend( arguments, variables.orm[local.stem][arguments.fn]["MSSQL"], false );
				local.results = executeProcedure( argumentCollection = arguments );
				if ( local.useNOSQL ) {
					local.nosqlPutArgs = {};
					structAppend( local.nosqlPutArgs, local.nosqlConfig.options, false );
					local.nosqlPutArgs.value = local.results;
					local.nosqlObject.put( argumentCollection = local.nosqlPutArgs );
				}
			}
		}

		return local.results;
	}

	private any function executeProcedure( required string sp, struct options = {}, array params = [], array values = [] ) {
		var results = "";
		var sproc = new StoredProc(procedure=arguments.sp, datasource=arguments.options.datasource);
		var ix = 0;
		var vlu = "";
		for ( var param in arguments.params ) {
			ix++;
			vlu = arguments.values[ix];
			sproc.addParam( cfsqltype="cf_sql_#lcase(param.dataType)#", type=param.paramType, value=vlu, null=!len(trim(vlu)) );
		}
		sproc.addProcResult(name="results");
		results = sproc.execute().getProcResultSets().results;
		return datamapper.queryToResultSet( results );
	}

}
