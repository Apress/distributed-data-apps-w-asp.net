<%@Page Language="C#"%>
<%@Import Namespace="OrderListData" %>
<%@Import Namespace="System.Data" %>

<script Language="C#" runat="server">

// --------------------------------------------------------------

void Page_Load() {

  DataSet objDataSet = GetDataSetFromServer("", "");
  Response.ContentType = "text/xml";
  Response.Write("<?xml version='1.0' ?>");
  objDataSet.WriteXml(Response.OutputStream);

}

// --------------------------------------------------------------

DataSet GetDataSetFromServer(String strCustID, String strCustName) {
// uses data access component to get DataSet containing matching customer details

  // get connection string from web.config
  String strConnect = ConfigurationSettings.AppSettings["NorthwindConnectString"];

  try {

    // create an instance of the data access component
    OrderList objOrderList = new OrderList(strConnect);

    // call the method to return the data as a DataSet
    return objOrderList.GetCustomerByIdOrName(strCustID, strCustName);

  }
  catch (Exception objErr) {

    // there was an error so no data is returned
    return null;

  }
}

// --------------------------------------------------------------

</script>
