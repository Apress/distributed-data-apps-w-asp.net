<%@Page Language="VB" %>
<%@Import Namespace="SupplierListXml" %>

<!------------------ HTML page content --------------------->

<html>
<head>
<title>Supplier List : DataSet from XML Disk File</title>
<!-- #include file="../global/style.inc" -->
</head>
<body>

<div class="heading">Supplier List : DataSet from XML Disk File</div>

<div align="right" class="cite">
[<a href="../global/viewsource.aspx?compsrc=get-supplier-xml.vb">view page source</a>]]<br />
[<a href="viewxml.aspx?doc=XmlGetSuppliersDSDoc">view XML document</a>]<br />
[<a href="viewxml.aspx?doc=XmlGetSuppliersDSSchema">view XSD schema</a>]
</div><br />

<asp:Label id="lblMessage" runat="server" />

<asp:DataGrid id="dgrSuppliers" runat="server">
<HeaderStyle BackColor="#c0c0c0"></HeaderStyle>
<AlternatingItemStyle BackColor="#eeeeee"></AlternatingItemStyle>
</asp:DataGrid>

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
  Dim strSchemaPath As String = strPathOnly & "supplier-list.xsd"

  Try

    'create an instance of the data access component
    Dim objSupplierList As New SupplierList(strXMLPath, strSchemaPath)

    'call the method to return the data as a DataSet and
    'assign it to the DataGrid server control for display
    dgrSuppliers.DataSource = objSupplierList.GetSuppliersDataSet()

  Catch objErr As Exception

    'there was an error and no data will be returned
    lblMessage.Text = "ERROR: No data returned. " & objErr.Message

  End Try

  If Not dgrSuppliers.DataSource Is Nothing Then

    'set data member and bind the data to display it
    dgrSuppliers.DataMember = "Suppliers"
    dgrSuppliers.DataBind()

  End If

End Sub

</script>

<!---------------------------------------------------------->
