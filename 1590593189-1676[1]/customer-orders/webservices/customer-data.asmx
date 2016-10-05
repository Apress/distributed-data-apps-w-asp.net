<%@WebService Language="VB" Class="CustomerOrders"%>

Imports OrderListData
Imports System
Imports System.Data
Imports System.Web
Imports System.Web.Services
Imports System.Configuration

<WebService(Description:="4923 Customer Orders Service", _
 Namespace:="http://www.daveandal.net/books/4923//webservices/4923/customer-orders" _
 )> Public Class CustomerOrders

'------------------------------------------------------------------

<WebMethod> Public Function GetCustomers(strCustID As String, strCustName As String) As DataSet
'uses data access component to get DataSet containing matching customer details

  Try

    'get connection string from web.config <appSettings> section
    Dim strConnect As String
    strConnect = ConfigurationSettings.AppSettings("NorthwindConnectString")

    'create an instance of the data access component
    Dim objOrderList As New OrderList(strConnect)

    'call the method to return the data as a DataSet
    Return objOrderList.GetCustomerByIdOrName(strCustID, strCustName)

  Catch objErr As Exception

    'there was an error so no data is returned
    Return Nothing

  End Try

End Function

'------------------------------------------------------------------

<WebMethod()> Public Function GetOrders(strCustID As String) As DataSet
'uses data access component to get DataSet containing matching order details

  Dim objDataSet As DataSet

  Try

    'get connection string from web.config <appSettings> section
    Dim strConnect As String
    strConnect = ConfigurationSettings.AppSettings("NorthwindConnectString")

    'create an instance of the data access component
    Dim objOrderList As New OrderList(strConnect)

    'call the method to get the data as a DataSet
    objDataSet = objOrderList.GetOrdersByCustomerDataSet(strCustID)

    'add column containing total value of each line in OrderLines table
    Dim objLinesTable As DataTable = objDataSet.Tables("OrderLines")
    Dim objColumn As DataColumn
    objColumn = objLinesTable.Columns.Add("LineTotal", System.Type.GetType("System.Double"))
    objColumn.Expression = "[Quantity] * ([UnitPrice] - ([UnitPrice] * [Discount]))"

    'set the Nested property of the relationship between the tables so the XML output
    'is in "nested" form (i.e. appropriate linked OrderLines nested within each Order)
    objDataSet.Relations(0).Nested = True

    'return the DataSet to the calling routine
    Return objDataSet

  Catch objErr As Exception

    'there was an error so no data is returned
    Return Nothing

  End Try

End Function

'------------------------------------------------------------------

End Class
