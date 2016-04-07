component extends="model.services.BaseService" accessors="true" {

	property ProductDAO;

	public ProductService function init() {
		super.init();
		return this;
	}

	public array function getProducts() {
		return variables.ProductDAO.getProducts();
	}

}
