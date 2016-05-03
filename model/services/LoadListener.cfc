component {

	public LoadListener function init() {
		return this;
	}

	public any function onLoad( beanFactory ) {
		beanFactory.addBean( "beanVersions", {
			"Product" = "1.1.0"
		} );

		for ( var beanStem in beanFactory.getBean("beanVersions") ) {
			for ( var beanType in ["Service","DAO"] ) {
				try {
					var beanName = beanStem & beanType;
					var beanVersion = beanFactory.getBean( "beanVersions" )[ beanStem ];
					versionedBeanName = beanName & "_v" & replace( beanVersion, ".", "_", "all" );
					beanFactory.addAlias( beanName, versionedBeanName );
				} catch ( any e ) {
					// ignore error
				}
			}
		}

		beanFactory.addBean( "orm", {
	        product = {
	            getByID = {
	                MSSQL = {
	                    sp = "pr_product_sel",
	                    params = [
	                        {
	                            paramName = "id",
	                            paramType = "in",
	                            dataType = "integer"
	                        }
	                    ],
	                    options = {
	                        datasource = "mydsn"
	                    }
	                },
	                _NOSQL_ = {
	                    mapping = "redis",
	                    options = {
	                        bucket = "enterprise",
	                        key = "product:{1}",
	                        expiration = 60
	                    }
	                }
	            },
	            findByKeys = {
	                MSSQL = {
	                    sp = "pr_product_by_type_lst",
	                    params = [
	                        {
	                            paramName = "store_group_id",
	                            paramType = "in",
	                            dataType = "integer"
	                        },
	                        {
	                            paramName = "product_type_id",
	                            paramType = "in",
	                            dataType = "integer"
	                        },
	                        {
	                            paramName = "label",
	                            paramType = "in",
	                            dataType = "varchar"
	                        }
	                    ],
	                    options = {
	                        datasource = "mydsn"
	                    }
	                }
	            },
	            getProductsByType = {
	                MSSQL = {
	                    sp = "pr_product_by_type_lst",
	                    params = [
	                        {
	                            paramName = "store_group_id",
	                            paramType = "in",
	                            dataType = "integer"
	                        },
	                        {
	                            paramName = "product_type_id",
	                            paramType = "in",
	                            dataType = "integer"
	                        },
	                        {
	                            paramName = "label",
	                            paramType = "in",
	                            dataType = "varchar"
	                        }
	                    ],
	                    options = {
	                        datasource = "mydsn"
	                    }
	                }
	            }
	        }
		} );	    
	}

}
