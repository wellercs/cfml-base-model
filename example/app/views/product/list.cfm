<!--- This should go in an external stylesheet. --->
<style>
	#tblProducts {
		width: 100%;
	}

	#tblProducts th {
		background-color: #4CAF50;
		color: white;
		height: 50px;
	}

	#tblProducts th, td {
		border-bottom: 1px solid #ddd;
		padding: 15px;
		text-align: left;
	}

	#tblProducts tr:nth-child(even) {background-color: #f2f2f2;}

	#tblProducts tr:hover {background-color: yellow;}
</style>

<cfoutput>
	<div style="overflow-x:auto;">
		<table id="tblProducts">
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
				<cfloop condition="#rc.ProductBean.next()#">
					<tr>
						<td>#rc.ProductBean.get('label')#</td>
						<td>#rc.ProductBean.get('description')#</td>
						<td>#rc.ProductBean.get('dummy')#</td>
						<td>#dollarFormat(rc.ProductBean.get('retailPrice'))#</td>
						<td>#dollarFormat(rc.ProductBean.get('promoPrice'))#</td>				
					</tr>
				</cfloop>
			</tbody>
		</table>
	</div>
</cfoutput>