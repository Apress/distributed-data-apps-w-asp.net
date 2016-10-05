<%@Page Language="C#" %>
<%@Import Namespace="SupplierListDB" %>
<%@Import Namespace="System.Xml" %>

<script language="C#" runat="server">

void Page_Load() {

  Response.ContentType = "text/xml";

  try {

    // call the appropriate method that returns XML
    // or write stylesheet to Response directly
    switch(Request.QueryString["doc"]) {

      case "GetSuppliersSqlXml": {
        String strConnect = ConfigurationSettings.AppSettings["NorthwindSqlClientConnectString"];
        SupplierList objSupplierList = new SupplierList(strConnect);
        Response.Write(objSupplierList.GetSuppliersSqlXml());
        break;
      }
      case "GetSuppliersSqlXmlStyle": {
        Response.WriteFile("supplier-sqlxml-style.xsl");
        break;
      }
      case "GetSuppliersXml": {
        String strConnect = ConfigurationSettings.AppSettings["NorthwindConnectString"];
        SupplierList objSupplierList = new SupplierList(strConnect);
        Response.Write(objSupplierList.GetSuppliersXml(false));
        break;
      }
      case "XmlGetSuppliersXmlString": {
        Response.WriteFile("supplier-list.xml");
        break;
      }
      case "GetSuppliersXmlStyle": {
        Response.WriteFile("supplier-list-style.xsl");
        break;
      }
      case "GetSuppliersXmlDoc": {
        String strConnect = ConfigurationSettings.AppSettings["NorthwindConnectString"];
        SupplierList objSupplierList = new SupplierList(strConnect);
        XmlDocument objDoc = objSupplierList.GetSuppliersXmlDocument();
        Response.Write(objDoc.OuterXml);
        break;
      }
      case "GetSuppliersXmlDocStyle": {
        Response.WriteFile("supplier-list-style.xsl");
        break;
      }
      case "XmlGetSuppliersDSDoc": {
        Response.WriteFile("supplier-list.xml");
        break;
      }
      case "XmlGetSuppliersDSSchema": {
        Response.WriteFile("supplier-list.xsd");
        break;
      }
    }

  }
  catch (Exception objErr) {
  }
}
</script>
