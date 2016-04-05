component accessors="false"{

	BaseBean function init(){
		variables._resetBean( false );
		return this;
	}

	// STANDARD BEAN METHODS

	public any function get( string propertyName ) {
		if ( structKeyExists( this, "get" & arguments.propertyName ) ) {
			local.response = invoke(this, "get#arguments.propertyName#");
			return local.response;
		} else {
			return this._get( arguments.propertyName );
		}
	}

	public any function _get( string propertyName ) {
		if ( variables.isDirty && structKeyExists( variables.dirty, arguments.propertyName ) ) {
			return variables.dirty[ arguments.propertyName ];
		}
		else if ( structKeyExists( variables.data, arguments.propertyName ) ) {
			return variables.data[ arguments.propertyName ];
		}
		else {
			return;
		}
	}

	public boolean function has( string propertyName ) {
		if ( structKeyExists( this, "has" & arguments.propertyName ) ) {
			local.response = invoke(this, "has#arguments.propertyName#");
			return local.response;
		} else {
			return this._has( arguments.propertyName );
		}
	}

	public boolean function _has( string propertyName ) {
		return structKeyExists( variables.dirty, arguments.propertyName ) || structKeyExists( variables.data, arguments.propertyName );
	}

	public any function load( required string method, struct args = {} ) {
		variables._resetBean( true );
		variables.data = { };
		if ( structKeyExists(variables.svc, arguments.method) ) {
			local.dataToLoad = invoke(variables.svc, arguments.method, arguments.args);
		}
		else {
			local.dataToLoad = invoke(variables.dao, arguments.method, arguments.args);
		}
		structAppend( variables.data, local.dataToLoad );
		variables.loaded = true;
		return this;
	}

	public any function populate() {
		for ( var arg in arguments ) {
			this.set( arg, arguments[ arg ] );
		}
		return this;
	}

	public any function set( string propertyName, any value ) {
		if ( structKeyExists( this, "set" & arguments.propertyName ) ) {
			local.response = invoke(this, "set#arguments.propertyName#");
			return local.response;
		} else {
			return this._set( arguments.propertyName, arguments.value );
		}
	}

	public any function _set( string propertyName, any value ) {
		variables.dirty[ arguments.propertyName ] = arguments.value;
		variables.isDirty = true;
		variables.loaded = true;
		return this;
	}

	public struct function getData() {
		return { "data" = variables.data, "dirty" = variables.dirty };
	}

	public struct function getCleanData() {
		return variables.data;
	}

	public struct function getDirtyData() {
		return variables.dirty;
	}

	public boolean function isDirty() {
		return variables.isDirty;
	}

	public boolean function isLoaded() {
		return variables.loaded;
	}

	// IBO METHODS

	// IBO loop example: while ( bean.next() ) { bean.get("propertyName"); }

	// this turns me into an iterator:
	public any function attach( any resultSet ) {
		variables.resultSet = arguments.resultSet;
		variables.size = arrayLen( variables.resultSet );
		variables.index = 0;
		return this;
	}

	/**
	* @hint Returns the number of records/results.
	*/
	public numeric function count() {
		return variables.size;
	}

	/**
	* @hint Sets the IBO cursor to point to the current record/result.
	*/
	public void function getFromIndex() {
		variables._resetBean( true );
		variables.data = { };
		structAppend( variables.data, variables.resultSet[ variables.index ] );
		variables.loaded = true;
	}

	/**
	* @hint Resets the IBO cursor to point to the first record/result.
	*/
	public boolean function first() {
		if ( this.count() ) {
			variables.index = 1;
			this.getFromIndex();
			return true;			
		}
		else {
			return false;
		}
	}

	/**
	* @hint Determines if the IBO has more records/results.
	*/
	public boolean function hasMore() {
		return (variables.index LT variables.size);
	}

	/**
	* @hint Determines if the IBO is pointing to the first record/result.
	*/
	public boolean function isFirst() {
		return (variables.index EQ 1);
	}

	/**
	* @hint Determines if the IBO is pointing to the last record/result.
	*/
	public boolean function isLast() {
		return (variables.index EQ variables.size);
	}

	/**
	* @hint Increments the IBO cursor to point to the next record/result.
	*/
	public boolean function next() {
		if ( this.hasMore() ) {
			variables.index++;
			this.getFromIndex();
			return true;			
		}
		else {
			return false;
		}
	}

	/**
	* @hint Resets the IBO cursor.
	*/
	public void function reset() {
		variables.index = 0;
		variables._resetBean( false );
	}

	// PRIVATE METHODS
	
	private void function _cleanData() {
		variables.dirty = { };
		variables.isDirty = false;
	}
	
	private void function _resetBean( boolean loaded ) {
		variables.data = { };
		variables.loaded = arguments.loaded;
		variables._cleanData();
	}	

}
