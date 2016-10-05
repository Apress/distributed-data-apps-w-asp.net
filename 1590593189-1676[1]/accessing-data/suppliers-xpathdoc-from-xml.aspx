<%@Page Language="VB"%>
<%@Import Namespace="SupplierListXml" %>
<%@Import Namespace="System.Xml" %>
<%@Import Namespace="System.Xml.XPath" %>

<!------------------ HTML page content --------------------->

<html>
<head>
<title>Supplier List : XPathDocument Object from XML Disk File</title>
<!-- #include file="../global/style.inc" -->
</head>
<body>

<div class="heading">Supplier List : XPathDocument Object from XML Disk File</div>

<div align="right" class="cite">
[<a href="../global/viewsource.aspx?compsrc=get-supplier-xml.vb">view page source</a>]<br />
[<a href="viewxml.aspx?doc=XmlGetSuppliersXmlString">view XML document</a>]<br />
[<a href="viewxml.aspx?doc=XmlGetSuppliersDSSchema">view XSD schema</a>]
</div><br />

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
  Dim strSchemaPath As String = strPathOnly & "supplier-list.xsd"

  'declare a variable to hold an XPathDocument object
  Dim objXPDoc As XPathDocument

  Try

    'create an instance of the data access component
    Dim objSupplierList As New SupplierList(strXMLPath, strSchemaPath)

    'call the method to return the data as an XPathDocument
    objXPDoc = objSupplierList.GetSuppliersXPathDocument()

  Catch objErr As Exception

    'there was an error and no data will be returned
    lblMessage.Text = "ERROR: No data returned. " & objErr.Message

  End Try

  'create an XPathNavigator object against the XPathDocument
  Dim objXPNav As XPathNavigator = objXPDoc.CreateNavigator()

  'declare variable to hold an XPathNodeIterator object
  Dim objXPIter As XPathNodeIterator

  'move to document element
  objXPNav.MoveToFirstChild()

  'select all the SupplierName nodes of the document node into an
  'XPathNodeIterator object using an XPath expression
  objXPIter = objXPNav.Select("descendant::SupplierName")

  Dim strResult As String   'to hold results for display

  'iterate through the element nodes in the XPathNodeIterator
  'collection adding their values to the output string
  While objXPIter.MoveNext()
    strResult += objXPIter.Current.Value & "<br />"
  End While

  lblMessage.Text = strResult

End Sub

</script>

<!---------------------------------------------------------->
