component extends="model.services.BaseService" accessors="true" {

	property ProductDAO;

	public any function init() {
		super.init( argumentCollection = arguments );
		return this;
	}

	public array function getProducts() {
		return variables.ProductDAO.getProducts();
	}

}
