<%@Page Language="C#" %>
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
[<a href="../global/viewsource.aspx?compsrc=get-supplier-xml.cs">view page source</a>]<br />
[<a href="viewxml.aspx?doc=XmlGetSuppliersXmlString">view XML document</a>]
</div>

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

  // declare a varable to hold the array returned from the method
  String[,] arrResult;

  try {

    // create an instance of the data access component
    SupplierList objSupplierList = new SupplierList(strXMLPath, "");

    // call the method to return the data as an Array
    arrResult = objSupplierList.GetSuppliersArray();
  }
  catch (Exception objErr) {

     // there was an error and no data will be returned
     lblMessage.Text = "ERROR: No data returned. " + objErr.Message;
     return;   // and stop processing here
  }


  // iterate through array to display values returned
  // first get number of rows in the array
  int intLastRowIndex = arrResult.GetLength(1) - 1;

  String strResult = "";   // to hold results for display
  int intRow;              // to hold column iterator

  for (intRow = 0; intRow <= intLastRowIndex; intRow++) {
    strResult += "<b>" + arrResult[0, intRow] + "</b><br />"
              + "* Address: " + arrResult[1, intRow] + "<br />"
              + "* Contact: " + arrResult[2, intRow] + "<p />";
  }

  lblMessage.Text = strResult;  // assign result string to Label control

}

</script>

<!---------------------------------------------------------->
