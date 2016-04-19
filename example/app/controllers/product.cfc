component accessors="true" {

	property DataMapper;
	property ProductService;

	function init( fw ) {
		variables.fw = fw;
		return this;
	}

	function list( struct rc ) {
		// rc.ProductBean = variables.DataMapper.create( name = "ProductBean" );
		// rc.ProductBean.load(3157150);
		// writedump(rc.ProductBean.getData());
		// abort;

		// rc.ProductBean = variables.DataMapper.create( name = "ProductBean" );
		// rc.ProductBean.loadByKeys( values = [ 9, 12, "" ] );
		// writedump(rc.ProductBean.getData());
		// abort;

		// rc.data = variables.DataMapper.findByKeys( name = "ProductBean", args = { values = [ 9, 12, "" ] }, format = "arrayOfStructs" );
		// writedump(rc.data);
		// abort;

		// rc.ProductBean = variables.DataMapper.findByKeys( name = "ProductBean", args = { values = [ 9, 12, "" ] }, format = "iterator" );
		// writedump(rc.ProductBean.getData());
		// writedump(rc.ProductBean.getResultSet());
		// abort;

		// rc.ProductBean = variables.DataMapper.createIterator( name = "ProductBean", method = "getProductsByType", args = { values = [ 9, 12, "" ] } );
		// writedump(rc.ProductBean.getData());
		// writedump(rc.ProductBean.getResultSet());
		// abort;

		// rc.ProductBean = variables.DataMapper.createIterator( name = "ProductBean", data = variables.ProductService.getProducts() );

		// rc.ProductBean = variables.DataMapper.createIterator( name = "ProductBean", method = "getProducts" );
	}

}