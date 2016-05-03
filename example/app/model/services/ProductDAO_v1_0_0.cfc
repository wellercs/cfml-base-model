component extends="model.services.BaseDAO" accessors="true" {

	public any function init() {
		super.init( argumentCollection = arguments );
		return this;
	}

	public array function getProducts() {
		return [
			{ "label"="Product A", "description"="sample product A", "retailPrice"=11.95 },
			{ "label"="Product B", "description"="sample product B", "retailPrice"=22.95 },
			{ "label"="Product C", "description"="sample product C", "retailPrice"=33.95 }
		];
	}

}
