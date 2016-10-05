<%@Page Language="C#" %>
<%@Import Namespace="SupplierListXml" %>

<!------------------ HTML page content --------------------->

<html>
<head>
<title>Supplier List : ArrayList from XML Disk File</title>
<!-- #include file="../global/style.inc" -->
</head>
<body>

<div class="heading">Supplier List : ArrayList from XML Disk File</div>

<div align="right" class="cite">
[<a href="../global/viewsource.aspx?compsrc=get-supplier-xml.cs">view page source</a>]<br />
[<a href="viewxml.aspx?doc=XmlGetSuppliersXmlString">view XML document</a>]
</div>

<asp:Label id="lblMessage" runat="server" />

<asp:DataGrid id="dgrSuppliers" runat="server">
<HeaderStyle BackColor="#c0c0c0"></HeaderStyle>
<AlternatingItemStyle BackColor="#eeeeee"></AlternatingItemStyle>
</asp:DataGrid>

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

  try {

    // create an instance of the data access component
    SupplierList objSupplierList = new SupplierList(strXMLPath, "");

    // call the method to return the data as an ArrayList and
    // bind it to the DataGrid server control
    dgrSuppliers.DataSource = objSupplierList.GetSuppliersArrayList("SupplierName");
    dgrSuppliers.DataBind();
  }
  catch (Exception objErr) {

     // there was an error and no data will be returned
     lblMessage.Text = "ERROR: No data returned. " + objErr.Message;
  }

}

</script>

<!---------------------------------------------------------->
