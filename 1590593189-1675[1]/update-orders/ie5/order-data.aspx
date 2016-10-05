<%@Page Language="C#"%>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="DataSetUpdate" %>

<script Language="C#" runat="server">

//--------------------------------------------------------------

void Page_Load() {

  DataSet objDataSet = new DataSet();

  switch (Request.QueryString["list"]) {
    case ("customers"): {
      objDataSet = GetOrdersDataSet(Request.QueryString["customerid"]);
      break;
    }
    case ("shippers"): {
      objDataSet = GetShippersDataSet();
      break;
    }
    case ("products"): {
      objDataSet = GetProductsDataSet();
      break;
    }
  }

  Response.ContentType = "text/xml";
  Response.Write("<?xml version='1.0' ?>\n");
  objDataSet.WriteXml(Response.OutputStream, XmlWriteMode.DiffGram);
}

//--------------------------------------------------------------

DataSet GetOrdersDataSet(String strCustID) {
// uses data access component to get DataSet containing matching order details

  DataSet objDataSet;

  // get connection string from web.config
  String strConnect = ConfigurationSettings.AppSettings["NorthwindConnectString"];

  try {

    // create an instance of the data access component
    UpdateDataSet objOrderUpdate = new UpdateDataSet(strConnect);

    // call component to get DataSet containing order details for customer
    objDataSet = objOrderUpdate.GetOrderDetails(strCustID);

    // add column containing total value of each line in OrderLines table
    DataTable objLinesTable = objDataSet.Tables["Order Details"];
    DataColumn objColumn = objLinesTable.Columns.Add("LineTotal", System.Type.GetType("System.Double"));
    objColumn.Expression = "[Quantity] * ([UnitPrice] - ([UnitPrice] * [Discount]))";

    // return the DataSet to the calling routine
    return objDataSet;
  }
  catch (Exception objErr) {
    // there was an error so no data is returned
    return null;
  }
}
//--------------------------------------------------------------

DataSet GetShippersDataSet() {
// uses data access component to get DataSet containing all shipper details

  // get connection string from web.config
  String strConnect = ConfigurationSettings.AppSettings["NorthwindConnectString"];

  try {

    // create an instance of the data access component
    UpdateDataSet objOrderUpdate = new UpdateDataSet(strConnect);

    // call component to get DataSet containing shipper details
    return objOrderUpdate.GetShippersDataSet();

  }
  catch (Exception objErr) {
    // there was an error so no data is returned
    return null;
  }
}
//--------------------------------------------------------------

DataSet GetProductsDataSet() {
// uses data access component to get DataSet containing all product details

  // get connection string from web.config
  String strConnect = ConfigurationSettings.AppSettings["NorthwindConnectString"];

  try {

    // create an instance of the data access component
    UpdateDataSet objOrderUpdate = new UpdateDataSet(strConnect);

    // call component to get DataSet containing product list
    return objOrderUpdate.GetProductsDataSet();

  }
  catch (Exception objErr) {
    // there was an error so no data is returned
    return null;
  }
}
//--------------------------------------------------------------

</script>
