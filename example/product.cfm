<!--- This would normally go in a controller in an MVC application, but this is just a quick example. --->
<cfscript>
	ProductBean = new ProductBean();
	ProductBean.load();
</cfscript>

<!--- This would go in an external stylesheet. --->
<style>
	table {
		width: 100%;
	}

	th {
		background-color: #4CAF50;
		color: white;
		height: 50px;
	}

	th, td {
		border-bottom: 1px solid #ddd;
		padding: 15px;
		text-align: left;
	}

	tr:nth-child(even) {background-color: #f2f2f2;}

	tr:hover {background-color: yellow;}
</style>

<!--- This would go in a view in an MVC application. --->
<cfoutput>
	<div style="overflow-x:auto;">
		<table>
			<thead>
				<tr>
					<th>Label</th>
					<th>Description</th>
					<th>Invalid Property</th>
					<th>Regular Price</th>
					<th>Promo Price</th>
				</tr>
			</thead>
			<tbody>
				<cfloop condition="#ProductBean.next()#">
					<tr>
						<td>#ProductBean.get('label')#</td>
						<td>#ProductBean.get('description')#</td>
						<td>#ProductBean.get('dummy')#</td>
						<td>#dollarFormat(ProductBean.get('retailPrice'))#</td>
						<td>#dollarFormat(ProductBean.get('promoPrice'))#</td>				
					</tr>
				</cfloop>
			</tbody>
		</table>
	</div>
</cfoutput>