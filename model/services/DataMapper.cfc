component accessors="true" {

	property beanFactory;

	public DataMapper function init() {
		variables.beanCoreMapping = "model.beans";
		variables.beanMapping = "app.model.beans";
		variables.beanPath = expandPath( "/" & replace( variables.beanMapping, ".", "/", "all" ) );
		variables.beanCache = { };
		variables.cfcExists = { };
		return this;
	}

	// supports any factory that uses getBean()
	// public void function setBeanFactory( any factory ) {
	// 	variables.beanFactory = arguments.factory;
	// }
	
	public any function create( string name ) {
		local.daoName = replaceNoCase(arguments.name, "Bean", "DAO", "one");
		local.serviceName = replaceNoCase(arguments.name, "Bean", "Service", "one");

		// TODO: use missingBean()
		if ( variables.beanFactory.containsBean( local.daoName ) ) {
			local.DataAccessObject = variables.beanFactory.getBean( local.daoName );
		} else {
			local.DataAccessObject = variables.beanFactory.getBean( "BaseDAO" );
		}

		// TODO: use missingBean()
		if ( variables.beanFactory.containsBean( local.serviceName ) ) {
			local.ServiceObject = variables.beanFactory.getBean( local.serviceName );
		} else {
			local.ServiceObject = variables.beanFactory.getBean( "BaseService" );
		}

		if ( !structKeyExists( variables.cfcExists, arguments.name ) ) {
			// just in case we're passed a dotted name, look for a bean in a subfolder:
			local.beanFilePath = variables.beanPath & "/" & replace( arguments.name, ".", "/", "all" ) & ".cfc";
			variables.cfcExists[ arguments.name ] = fileExists( local.beanFilePath );
		}
		
		if ( variables.cfcExists[ arguments.name ] ) {
			return new "#variables.beanMapping#.#arguments.name#"( name = arguments.name, dao = local.DataAccessObject, datamapper = this, svc = local.ServiceObject );
		} else {
			return new "#variables.beanCoreMapping#.BaseBean"( name = arguments.name, dao = local.DataAccessObject, datamapper = this, svc = local.ServiceObject );
		}
	}	
	
	public any function createIterator( string name, any data = [] ) {
		local.bean = this.create( arguments.name );
		local.bean.attach( arguments.data );
		return local.bean;
	}

	public void function injectBean( string beanName, struct scope ) {
        if ( !structKeyExists( variables.beanCache, arguments.beanName ) ) {
		    variables.beanCache[ arguments.beanName ] = variables.beanFactory.getBean( arguments.beanName );
        }
		arguments.scope[ arguments.beanName ] = variables.beanCache[ arguments.beanName ];
	}

    public any function queryToResultSet( query q ) {
        // return array of structs instead
        var rows = [ ];
        for  ( var row in q ) {
            rows.append( row );
        }
        return rows;
    }

}
