component {

	public DataMapper function init() {
		// variables.beanMapping = "model.beans";
		variables.beanMapping = "app.model.beans";
		variables.beanPath = expandPath( "/" & replace( variables.beanMapping, ".", "/", "all" ) );
		variables.beanCache = { };
		variables.cfcExists = { };
		return this;
	}

	// supports any factory that uses getBean()
	public void function setBeanFactory( any factory ) {
		variables.beanFactory = arguments.factory;
	}
	
	public any function create( string name ) {
		if ( !structKeyExists( variables.cfcExists, arguments.name ) ) {
			// just in case we're passed a dotted name, look for a bean in a subfolder:
			local.filePath = variables.beanPath & "/" & replace( arguments.name, ".", "/", "all" ) & ".cfc";
			variables.cfcExists[ arguments.name ] = fileExists( local.filePath );
		}
		if ( variables.cfcExists[ arguments.name ] ) {
			return new "#variables.beanMapping#.#arguments.name#"( arguments.name, this );
		} else {
			return new "#variables.beanMapping#.BaseBean"( arguments.name, this );
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
