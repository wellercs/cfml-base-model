component extends="BaseBean" accessors="false"{

	ProductBean function init(){
		super.init();
		//variables.dao = new ProductDAO(); // normally the dependency objects (in this case the DAO) would be injected by a DI engine
		return this;
	}

	public numeric function getPromoPrice() {
		// do business logic here
		return 5.00;
	}

}
