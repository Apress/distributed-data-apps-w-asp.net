<%@Page Language="VB" %>
<%@Import Namespace="SupplierListDB" %>

<!------------------ HTML page content --------------------->

<html>
<head>
<title>Supplier List : Array from Relational Database</title>
<!-- #include file="../global/style.inc" -->
</head>
<body>

<div class="heading">Supplier List : Array from Relational Database</div>

<div align="right" class="cite">
[<a href="../global/viewsource.aspx?compsrc=get-supplier-data.vb">view page source</a>]
</div><br />

<asp:Label id="lblMessage" runat="server" />

<!-- #include file="../global/foot.inc" -->
</body>
</html>

<!-------------- server-side script section ---------------->

<script language="VB" runat="server">

Sub Page_Load()

  'get connection string from web.config
  Dim strConnect As String
  strConnect = ConfigurationSettings.AppSettings("NorthwindConnectString")

  'declare a varable to hold the array returned from the method
  Dim arrResult As Array

  Try

    'create an instance of the data access component
    Dim objSupplierList As New SupplierList(strConnect)

    'call the method to return the data as an Array and
    'specify we only want a maximum of 10 items
    arrResult = objSupplierList.GetSuppliersArray(10)

  Catch objErr As Exception

     'there was an error and no data will be returned
     lblMessage.Text = "ERROR: No data returned. " & objErr.Message

     Exit Sub   'and stop processing here

  End Try

  'iterate through array to display values returned
  'get number of rows in the array, may be less than maximum specified
  Dim intLastRowIndex As Integer = arrResult.GetLength(1) - 1

  Dim strResult As String = ""   'to hold results for display
  Dim intRow As Integer          'to hold column iterator

  For intRow = 0 To intLastRowIndex
    strResult += "<b>" & arrResult(0, intRow) & "</b><br />"
    strResult += "* Address: " & arrResult(1, intRow) & "<br />"
    strResult += "* Contact: " & arrResult(2, intRow) & "<p />"
  Next

  lblMessage.Text = strResult  'assign result string to Label control

End Sub

</script>

<!---------------------------------------------------------->
