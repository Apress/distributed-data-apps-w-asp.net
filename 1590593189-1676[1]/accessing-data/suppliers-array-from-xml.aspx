<%@Page Language="VB" %>
<%@Import Namespace="SupplierListXml" %>

<!------------------ HTML page content --------------------->

<html>
<head>
<title>Supplier List : Array from XML Disk File</title>
<!-- #include file="../global/style.inc" -->
</head>
<body>

<div class="heading">Supplier List : Array from XML Disk File</div>

<div align="right" class="cite">
[<a href="../global/viewsource.aspx?compsrc=get-supplier-xml.vb">view page source</a>]<br />
[<a href="viewxml.aspx?doc=XmlGetSuppliersXmlString">view XML document</a>]
</div>

<asp:Label id="lblMessage" runat="server" />

<!-- #include file="../global/foot.inc" -->
</body>
</html>

<!-------------- server-side script section ---------------->

<script language="VB" runat="server">

Sub Page_Load()

  'create physical path to XML file (in same folder as ASPX page)
  Dim strCurrentPath As String = Request.PhysicalPath
  Dim strPathOnly As String = Left(strCurrentPath, InStrRev(strCurrentPath, "\"))
  Dim strXMLPath As String = strPathOnly & "supplier-list.xml"

  'declare a varable to hold the array returned from the method
  Dim arrResult As Array

  Try

    'create an instance of the data access component
    Dim objSupplierList As New SupplierList(strXMLPath)

    'call the method to return the data as an Array
    arrResult = objSupplierList.GetSuppliersArray()

  Catch objErr As Exception

     'there was an error and no data will be returned
     lblMessage.Text = "ERROR: No data returned. " & objErr.Message

     Exit Sub   'and stop processing here

  End Try


  'iterate through array to display values returned
  'first get number of rows in the array
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
