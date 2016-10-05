<%@Page Language="C#"%>
<%@Import Namespace="OrderListData" %>
<%@Import Namespace="System.Data" %>

<script language="C#" runat="server">

// --------------------------------------------------------------

void Page_Load() {

  DataSet objDataSet = GetDataSetFromServer(Request.QueryString["customerid"]);

  // set the Nested property of the relationship between the tables so the XML output
  // is in "nested" form (i.e. appropriate linked OrderLines nested within each Order)
  objDataSet.Relations[0].Nested = true;

  Response.ContentType = "text/xml";
  Response.Write("<?xml version='1.0' ?>\n");
  objDataSet.WriteXml(Response.OutputStream);

}

// --------------------------------------------------------------

DataSet GetDataSetFromServer(String strCustID) {
// uses data access component to get DataSet containing matching order details

  DataSet objDataSet;

  // get connection string from web.config
  String strConnect = ConfigurationSettings.AppSettings["NorthwindConnectString"];

  try {

    // create an instance of the data access component
    OrderList objOrderList = new OrderList(strConnect);

    // call the method to get the data as a DataSet
    objDataSet = objOrderList.GetOrdersByCustomerDataSet(strCustID);

    // add column containing total value of each line in OrderLines table
    DataTable objLinesTable = objDataSet.Tables["OrderLines"];
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

// --------------------------------------------------------------

</script>
