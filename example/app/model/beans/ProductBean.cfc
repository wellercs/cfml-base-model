component extends="model.beans.BaseBean" accessors="false" {

	public ProductBean function init() {
		super.init();
		return this;
	}

	public numeric function getPromoPrice() {
		// do business logic here
		return 5.00;
	}

}
