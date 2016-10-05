<%@WebService Language="VB" Class="RemotingOrders"%>

Imports System
Imports System.Data
Imports System.Data.OleDb
Imports System.Xml
Imports System.Web
Imports System.Web.Services
Imports System.Configuration
Imports UpdateDataSet

<WebService(Description:="4923 Remoting Orders Service", _
 Namespace:="http://www.wrox.com/webservices/4923/remoting")> _
Public Class RemotingOrders

	'------------------------------------------------------------------
	' uses data access component to get DataSet containing matching order details

	<WebMethod> _
	Public Function Orders(strCustID As String) As DataSet


		Dim objDataSet As DataSet

		Try

			' get connection string from web.config <appSettings> section
			Dim strConnect As String = ConfigurationSettings.AppSettings("NorthwindConnectString")

			' create an instance of the data access component
			Dim objOrderUpdate As New Wrox4923DataSetUpdate.UpdateDataSet(strConnect)

			' call component to get DataSet containing order details for customer
			objDataSet = objOrderUpdate.GetOrderDetails(strCustID)

			' add column containing total value of each line in OrderLines table
			Dim objLinesTable As DataTable = objDataSet.Tables("Order Details")
			Dim objColumn As DataColumn = objLinesTable.Columns.Add("LineTotal", System.Type.GetType("System.Double"))
			objColumn.Expression = "[Quantity] * ([UnitPrice] - ([UnitPrice] * [Discount]))"

			' set the Nested property of the relationship between the tables so they
			' are appropriately linked (OrderLines nested within each Order)
			objDataSet.Relations(0).Nested = True

			' add autoincrement details, so the dataset handles
			' new values correctly. Using 0 & -1 ensures that new order IDs
			' don't clash with existing ones. The database will generate correct IDs
			' during update, and these are flushed back to the dataset
			With objDataSet.Tables("Orders").Columns("OrderID")
				.AutoIncrement = True
				.AutoIncrementStep = -1
				.AutoIncrementSeed = 0
				.AllowDBNull = False
				.Unique = True
			End With


			' return the DataSet to the calling routine
			Return objDataSet

		Catch objErr As Exception

			' there was an error so no data is returned

		End Try

	End Function

	'--------------------------------------------------------------
	' uses data access component to get DataSet containing all shipper details
	' and all product details
	' This allows us to ship one dataset containing all of the look up information

	<WebMethod> _
	Public Function Lookups() As DataSet

		Try

			' get connection string from web.config <appSettings> section
			Dim strConnect As String = ConfigurationSettings.AppSettings("NorthwindConnectString")

			' create an instance of the data access component
			Dim objOrderUpdate As New Wrox4923DataSetUpdate.UpdateDataSet(strConnect)

			' call component to get DataSet containing shipper details
			Dim dsLookups As DataSet = objOrderUpdate.GetShippersDataSet()

			' now add more data for other lookups
			dsLookups.Merge (objOrderUpdate.GetProductsDataSet())


			Return dsLookups

		Catch objErr As Exception

			' there was an error so no data is returned
			Return Nothing

		End Try

	End Function


	'--------------------------------------------------------------
	' uses data access component to get DataSet containing all shipper details

	<WebMethod> _
	Public Function UpdateOrders(ByVal strCustID As String, ByVal objDataSet As DataSet) As DataSet

		' kludge required to get correct RowState values in DataSet
		objDataSet = objDataSet.GetChanges()


		' get connection string from web.config <appSettings> section
		Dim strConnect As String = ConfigurationSettings.AppSettings("NorthwindConnectString")

		' create an instance of the data access component
		Dim objOrderUpdate As New Wrox4923DataSetUpdate.UpdateDataSet(strConnect)

		' call function to do updates and return error rows only
		Return objOrderUpdate.UpdateAllOrderDetails(strCustID, objDataSet)

		'Return objDataSet

	End Function
	
		
End Class

