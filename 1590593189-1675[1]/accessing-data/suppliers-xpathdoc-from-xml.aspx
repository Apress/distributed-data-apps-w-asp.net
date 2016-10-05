<%@Page Language="C#"%>
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
[<a href="../global/viewsource.aspx?compsrc=get-supplier-xml.cs">view page source</a>]<br />
[<a href="viewxml.aspx?doc=XmlGetSuppliersXmlString">view XML document</a>]<br />
[<a href="viewxml.aspx?doc=XmlGetSuppliersDSSchema">view XSD schema</a>]
</div><br />

<asp:Label id="lblMessage" runat="server" />

<!-- #include file="../global/foot.inc" -->
</body>
</html>

<!-------------- server-side script section ---------------->

<script Language="C#" runat="server">

void Page_Load() {

  // create physical path to XML file (in same folder as ASPX page)
  String strCurrentPath  = Request.PhysicalPath;
  String strPathOnly = strCurrentPath.Substring(0, strCurrentPath.LastIndexOf ("\\") + 1);
  String strXMLPath = strPathOnly + "supplier-list.xml";
  String strSchemaPath = strPathOnly + "supplier-list.xsd";

  // declare a variable to hold an XPathDocument object
  XPathDocument objXPDoc = null;

  try {

    // create an instance of the data access component
    SupplierList objSupplierList = new SupplierList(strXMLPath, strSchemaPath);

    // call the method to return the data as an XPathDocument
    objXPDoc = objSupplierList.GetSuppliersXPathDocument();

  }
  catch (Exception objErr) {

    // there was an error and no data will be returned
    lblMessage.Text = "ERROR: No data returned. " + objErr.Message;

  }

  // create an XPathNavigator object against the XPathDocument
  XPathNavigator objXPNav = objXPDoc.CreateNavigator();

  // declare variable to hold an XPathNodeIterator object
  XPathNodeIterator objXPIter;

  // move to document element
  objXPNav.MoveToFirstChild();

  // select all the SupplierName nodes of the document node into an
  // XPathNodeIterator object using an XPath expression
  objXPIter = objXPNav.Select("descendant::SupplierName");

  String strResult = String.Empty;   // to hold results for display

  // iterate through the element nodes in the XPathNodeIterator
  // collection adding their values to the output string
  while (objXPIter.MoveNext()) {
    strResult += objXPIter.Current.Value + "<br />";
  }

  lblMessage.Text = strResult;

}

</script>

<!---------------------------------------------------------->
