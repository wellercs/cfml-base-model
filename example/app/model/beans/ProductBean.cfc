component extends="model.beans.BaseBean" accessors="true" {

	public any function init() {
		variables.dependencies = "Utilities";
		super.init( argumentCollection = arguments );
		return this;
	}

	public numeric function getPromoPrice() {
		// do business logic here
		return 5.00;
	}

}
