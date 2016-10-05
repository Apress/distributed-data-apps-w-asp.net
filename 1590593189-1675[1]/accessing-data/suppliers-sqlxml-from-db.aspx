<%@Page Language="C#" %>
<%@Import Namespace="SupplierListDB" %>

<!------------------ HTML page content --------------------->

<html>
<head>
<title>Supplier List : SQL-XML from Relational Database</title>
<!-- #include file="../global/style.inc" -->
</head>
<body>

<div class="heading">Supplier List : SQL-XML from Relational Database</div>

<div align="right" class="cite">
[<a href="../global/viewsource.aspx?compsrc=get-supplier-data.cs">view page source</a>]<br />
[<a href="viewxml.aspx?doc=GetSuppliersSqlXml">view XML document</a>]<br />
[<a href="viewxml.aspx?doc=GetSuppliersSqlXmlStyle">view XSLT sylesheet</a>]
</div><br />

<asp:Label id="lblMessage" runat="server" />

<asp:Xml id="xmlResult" runat="server" />

<!-- #include file="../global/foot.inc" -->
</body>
</html>

<!-------------- server-side script section ---------------->

<script Language="C#" runat="server">

void Page_Load() {

  // get connection string from connect-strings.ascx user control
  String strConnect = ConfigurationSettings.AppSettings["NorthwindSqlClientConnectString"];

  try {

    // create an instance of the data access component
    SupplierList objSupplierList = new SupplierList(strConnect);

    // call the method to return the data as ax XML document string
    // and assign it to the Xml server control for display
    xmlResult.DocumentContent = objSupplierList.GetSuppliersSqlXml();

    // specify the XSLT stylesheet to use to transform the XML
    xmlResult.TransformSource = "supplier-sqlxml-style.xsl";
  }
  catch (Exception objErr) {

    // there was an error and no data will be returned
    lblMessage.Text = "ERROR: No data returned. " + objErr.Message;
  }
}
</script>

<!---------------------------------------------------------->
