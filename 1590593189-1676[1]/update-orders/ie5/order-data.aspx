<%@Page Language="VB"%>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="DataSetUpdate" %>

<script language="VB" runat="server">

'--------------------------------------------------------------

Sub Page_Load()

  Dim objDataSet As DataSet

  Select Case Request.QueryString("list")
    Case "customers"
       objDataSet = GetOrdersDataSet(Request.QueryString("customerid"))
    Case "shippers"
       objDataSet = GetShippersDataSet()
    Case "products"
       objDataSet = GetProductsDataSet()
  End Select

  Response.ContentType = "text/xml"
  Response.Write("<?xml version='1.0' ?>")
  objDataSet.WriteXml(Response.OutputStream, XmlWriteMode.DiffGram)

End Sub

'--------------------------------------------------------------

Function GetOrdersDataSet(strCustID As String) As DataSet
'uses data access component to get DataSet containing matching order details

  Dim objDataSet As DataSet

  'get connection string from web.config
  Dim strConnect As String
  strConnect = ConfigurationSettings.AppSettings("NorthwindConnectString")

  Try

    'create an instance of the data access component
    Dim objOrderUpdate As New UpdateDataSet(strConnect)

    'call component to get DataSet containing order details for customer
    objDataSet = objOrderUpdate.GetOrderDetails(strCustID)

    'add column containing total value of each line in OrderLines table
    Dim objLinesTable As DataTable = objDataSet.Tables("Order Details")
    Dim objColumn As DataColumn
    objColumn = objLinesTable.Columns.Add("LineTotal", System.Type.GetType("System.Double"))
    objColumn.Expression = "[Quantity] * ([UnitPrice] - ([UnitPrice] * [Discount]))"

    'return the DataSet to the calling routine
    Return objDataSet

  Catch objErr As Exception

    'there was an error so no data is returned

  End Try

End Function

'--------------------------------------------------------------

Function GetShippersDataSet() As DataSet
'uses data access component to get DataSet containing all shipper details

  'get connection string from web.config
  Dim strConnect As String
  strConnect = ConfigurationSettings.AppSettings("NorthwindConnectString")

  Try

    'create an instance of the data access component
    Dim objOrderUpdate As New UpdateDataSet(strConnect)

    'call component to get DataSet containing shipper details
    Return objOrderUpdate.GetShippersDataSet()

  Catch objErr As Exception

    'there was an error so no data is returned
    Return Nothing

  End Try

End Function

'--------------------------------------------------------------

Function GetProductsDataSet() As DataSet
'uses data access component to get DataSet containing all product details

  'get connection string from web.config
  Dim strConnect As String
  strConnect = ConfigurationSettings.AppSettings("NorthwindConnectString")

  Try

    'create an instance of the data access component
    Dim objOrderUpdate As New UpdateDataSet(strConnect)

    'call component to get DataSet containing product list
    Return objOrderUpdate.GetProductsDataSet()

  Catch objErr As Exception

    'there was an error so no data is returned
    Return Nothing

  End Try

End Function

'--------------------------------------------------------------

</script>
