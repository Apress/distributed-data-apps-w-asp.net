<%@Page Language="VB"%>
<%@Import Namespace="OrderListData" %>
<%@Import Namespace="System.Data" %>

<script language="VB" runat="server">

'--------------------------------------------------------------

Sub Page_Load()

  Dim objDataSet As DataSet = GetDataSetFromServer()


  'set the Nested property of the relationship between the tables so the XML output
  'is in "nested" form (i.e. appropriate linked OrderLines nested within each Order)
  objDataSet.Relations(0).Nested = True

  Response.ContentType = "text/xml"
  Response.Write("<?xml version='1.0' ?>" & vbCrLf)

  'stream the contents of the DataSet to the output as a DiffGram
  objDataSet.WriteXml(Response.OutputStream, XmlWriteMode.DiffGram)

End Sub

'--------------------------------------------------------------

Function GetDataSetFromServer() As DataSet
'uses data access component to get DataSet containing matching order details

  Dim objDataSet As DataSet

  'get connection string from web.config
  Dim strConnect As String
  strConnect = ConfigurationSettings.AppSettings("NorthwindConnectString")

  Try

    'create an instance of the data access component
    Dim objOrderList As New OrderList(strConnect)

    'call the method to get the data as a DataSet
    objDataSet = objOrderList.GetOrdersByCustomerDataSet("%")

    'add column containing total value of each line in OrderLines table
    Dim objLinesTable As DataTable = objDataSet.Tables("OrderLines")
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

</script>
