<%@Page Language="VB"%>
<%@Import Namespace="OrderListData" %>
<%@Import Namespace="System.Data" %>

<script language="VB" runat="server">

'--------------------------------------------------------------

Sub Page_Load()

  Dim objDataSet As DataSet = GetDataSetFromServer("", "")
  Response.ContentType = "text/xml"
  Response.Write("<?xml version='1.0' ?>")
  objDataSet.WriteXml(Response.OutputStream)

End Sub

'--------------------------------------------------------------

Function GetDataSetFromServer(strCustID As String, strCustName As String) As DataSet
'uses data access component to get DataSet containing matching customer details

  'get connection string from web.config
  Dim strConnect As String
  strConnect = ConfigurationSettings.AppSettings("NorthwindConnectString")

  Try

    'create an instance of the data access component
    Dim objOrderList As New OrderList(strConnect)

    'call the method to return the data as a DataSet
    Return objOrderList.GetCustomerByIdOrName(strCustID, strCustName)

  Catch objErr As Exception

    'there was an error so no data is returned

  End Try

End Function

'--------------------------------------------------------------

</script>
