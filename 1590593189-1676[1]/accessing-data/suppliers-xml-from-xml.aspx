<%@Page Language="VB" %>
<%@Import Namespace="SupplierListXml" %>

<!------------------ HTML page content --------------------->

<html>
<head>
<title>Supplier List : Validated XML Document from XML Disk File</title>
<!-- #include file="../global/style.inc" -->
</head>
<body>

<div class="heading">Supplier List : Validated XML Document from XML Disk File</div>

<div align="right" class="cite">
[<a href="../global/viewsource.aspx?compsrc=get-supplier-xml.vb">view page source</a>]<br />
[<a href="viewxml.aspx?doc=XmlGetSuppliersXmlString">view XML document</a>]<br />
[<a href="viewxml.aspx?doc=XmlGetSuppliersDSSchema">view XSD schema</a>]<br />
[<a href="viewxml.aspx?doc=GetSuppliersXmlStyle">view XSLT sylesheet</a>]
</div><br />

<asp:Label id="lblMessage" runat="server" />
<asp:Xml id="xmlResult" runat="server" /><br />

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

    'call the method to return the data as an Xml String and
    'assign it to the Xml Server Control
    xmlResult.DocumentContent = objSupplierList.GetSuppliersXmlString()

    'specify path to XSLT stylesheet that transforms XML for display
    xmlResult.TransformSource = "supplier-list-style.xsl"

  Catch objErr As Exception

    'there was an error and no data will be returned
    lblMessage.Text = "ERROR: No data returned. " & objErr.Message

  End Try

End Sub

</script>

<!---------------------------------------------------------->
