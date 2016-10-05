<%@Page Language="C#" %>
<%@Import Namespace="System.Xml" %>
<%@Import Namespace="SupplierListXml" %>

<!------------------ HTML page content --------------------->

<html>
<head>
<title>Supplier List : XmlValidatingReader from XML Disk File</title>
<!-- #include file="../global/style.inc" -->
</head>
<body>

<div class="heading">Supplier List : XmlValidatingReader from XML Disk File</div>

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

  // declare variable to hold XmlValidatingReader object
  XmlValidatingReader objReader = null;

  try {

    // create an instance of the data access component
    SupplierList objSupplierList = new SupplierList(strXMLPath, strSchemaPath);

    // call the method to return the data as an XmlValidatingReader
    objReader = objSupplierList.GetSuppliersValidatingReader();

    // if we got a result, display the parsed content
    if (objReader != null) {
      lblMessage.Text = ParseXmlContent(objReader);
    }
  }
  catch (Exception objErr) {

    // there was an error and no data will be returned
    lblMessage.Text = "ERROR: No data returned. " + objErr.Message;
  }
  finally {

    objReader.Reader.Close();   // close the Reader to release file
  }
}


String ParseXmlContent(XmlValidatingReader objXMLReader) {

  // read or "pull" the nodes of the XML document
  String strNodeResult = "";
  XmlNodeType objNodeType;

  // read each node in turn - returns False if ( no more nodes to read
  while (objXMLReader.Read()) {

    // select on the type of the node (these are only some of the types)
    objNodeType = objXMLReader.NodeType;

    switch(objNodeType) {

      case XmlNodeType.XmlDeclaration: {
         // get the name and value
         strNodeResult += "XML Declaration: <b>" + objXMLReader.Name
                       + " " + objXMLReader.Value + "</b><br />";
         break;
      }
      case XmlNodeType.Element: {
         // just get the name, any value will be in next (#text) node
         strNodeResult += "Element: <b>" + objXMLReader.Name + "</b><br />";
         break;
      }
      case XmlNodeType.Text: {
         // just display the value, node name is "#text" in this case
         strNodeResult += "&nbsp; - Value: <b>" + objXMLReader.Value
                       + "</b><br />";
         break;
      }
    }

    // see if this node has any attributes
    if (objXMLReader.AttributeCount > 0) {

      // iterate through the attributes by moving to the next one
      // could use MoveToFirstAttribute but MoveToNextAttribute does
      // the same when the current node is an element-type node
      while (objXMLReader.MoveToNextAttribute()) {

        // get the attribute name and value
        strNodeResult += "&nbsp; - Attribute: <b>" + objXMLReader.Name
                       + "</b> &nbsp; Value: <b>" + objXMLReader.Value
                       + "</b><br />";
      }
    }
  }   // and read the next node

  // finished with the reader so close it
  objXMLReader.Close();

  // and retrun the resulting string
  return strNodeResult;

}

</script>

<!---------------------------------------------------------->
