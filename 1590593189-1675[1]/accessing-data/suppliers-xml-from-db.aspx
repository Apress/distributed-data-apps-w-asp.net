<%@Page Language="C#" %>
<%@Import Namespace="SupplierListDB" %>

<!------------------ HTML page content --------------------->

<html>
<head>
<title>Supplier List : XML Document from Relational Database</title>
<!-- #include file="../global/style.inc" -->
</head>
<body>

<div class="heading">Supplier List : XML Document from Relational Database</div>

<div align="right" class="cite">
[<a href="../global/viewsource.aspx?compsrc=get-supplier-data.cs">view page source</a>]<br />
[<a href="viewxml.aspx?doc=GetSuppliersXml">view XML document</a>]<br />
[<a href="viewxml.aspx?doc=GetSuppliersXmlStyle">view XSLT sylesheet</a>]
</div><br />

<asp:Label id="lblMessage" runat="server" />
<asp:Xml id="xmlResult" runat="server" /><br />

<!-- #include file="../global/foot.inc" -->
</body>
</html>

<!-------------- server-side script section ---------------->

<script Language="C#" runat="server">

void Page_Load() {

  // get connection string from web.config
  String strConnect = ConfigurationSettings.AppSettings["NorthwindConnectString"];

  try {

    // create an instance of the data access component
    SupplierList objSupplierList = new SupplierList(strConnect);

    // call the method to return the data as an Xml String and
    // specify false as no schema required
    // assign it to the Xml Server Control
    xmlResult.DocumentContent = objSupplierList.GetSuppliersXml(false);

    // specify path to XSLT stylesheet that transforms XML for display
    xmlResult.TransformSource = "supplier-list-style.xsl";
  }
  catch (Exception objErr) {

    // there was an error and no data will be returned
    lblMessage.Text = "ERROR: No data returned. " + objErr.Message;
  }
}
</script>

<!---------------------------------------------------------->
