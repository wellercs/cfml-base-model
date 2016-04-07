component accessors="true" {

	property ProductService;

	function init( fw ) {
		variables.fw = fw;
	}

	function list( struct rc ) {
		writedump(variables.ProductService); abort;

		//local.user = datamapper.create( "user" ).load( userid );
		//local.things = datamapper.createIterator( name = "thing", sql "select * from thing where some set of conditions" );		
	}

}