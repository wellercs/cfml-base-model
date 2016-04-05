component extends="BaseBean" accessors="false"{

	ProductBean function init(){
		super.init();
		return this;
	}

	public numeric function getPromoPrice() {
		// do business logic here
		return 5.00;
	}

	public any function load() {
		// call DAO or Service via super.load()
		var data = [
			{ "label"="Product A", "description"="sample product A", "retailPrice"=11.95 },
			{ "label"="Product B", "description"="sample product B", "retailPrice"=22.95 },
			{ "label"="Product C", "description"="sample product C", "retailPrice"=33.95 },
			{ "label"="Product D", "description"="sample product D", "retailPrice"=44.95 },
			{ "label"="Product E", "description"="sample product E", "retailPrice"=55.95 },
		];

		attach(data);
	}

}
