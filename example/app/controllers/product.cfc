component accessors="true" {

	property DataMapper;
	property ProductService;

	function init( fw ) {
		variables.fw = fw;
		return this;
	}

	function list( struct rc ) {
		rc.ProductBean = variables.DataMapper.createIterator( name = "ProductBean", data = variables.ProductService.getProducts() );	
	}

}