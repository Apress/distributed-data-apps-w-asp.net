<%@Page Language="C#"%>
<%@Import Namespace="OrderListData" %>
<%@Import Namespace="System.Data" %>

<script language="C#" runat="server">
//--------------------------------------------------------------

char TAB = (char)9;   // TAB character

void Page_Load(Object objSender, EventArgs objArgs) {

  // get values from query string
  String strType = Request.QueryString["type"];
  String strCustID = Request.QueryString["customerid"];

  // set content-type to return a tab-delimited text file
  Response.ContentType = "text/text";

  // call function to create output and write to response
  switch (strType)
  {
    case "customerlist":
      Response.Write(GetCustomerDataFromServer());
      break;
    case "orderlist":
      Response.Write(GetOrderDataFromServer(strCustID));
      break;
    case "orderdetail":
      Response.Write(GetDetailDataFromServer(strCustID));
      break;
  }
}
//--------------------------------------------------------------

public String GetCustomerDataFromServer() {
// uses data access component to get tab-delimited string
// containing a list of all the customers

  // get connection string from web.config
  String strConnect;
  strConnect = ConfigurationSettings.AppSettings["NorthwindConnectString"];

  DataSet objDataSet;

  try {

    // create an instance of the data access component
    OrderList objOrderList = new OrderList(strConnect);

    // call the method to get the data as a DataSet
    objDataSet = objOrderList.GetCustomerByIdOrName("", "");

    // iterate through each row in the table building the output
    String strResult = "CustomerID" + TAB + "CompanyName" + TAB
                     + "City" + TAB + "ViewOrderHref\n";
    DataTable objTable = objDataSet.Tables["Customers"];
    foreach(DataRow objRow in objTable.Rows){
      strResult += objRow["CustomerID"].ToString() + TAB
                + objRow["CompanyName"].ToString() + TAB
                + objRow["City"].ToString() + TAB
                + "view-orders.aspx?customerid="
                + objRow["CustomerID"].ToString() + "\n";
    }

    return strResult;
  }
  catch (Exception objErr) {

    // there was an error so no data is returned
    return "";

  }
}
//--------------------------------------------------------------

public String GetOrderDataFromServer(String strCustID) {
// uses data access component to get tab-delimited string
// containing a list of all orders for specified customer

  // get connection string from web.config
  String strConnect;
  strConnect = ConfigurationSettings.AppSettings["NorthwindConnectString"];

  DataSet objDataSet;

  try {

    // create an instance of the data access component
    OrderList objOrderList = new OrderList(strConnect);

    // call the method to get the data as a DataSet
    objDataSet = objOrderList.GetOrdersByCustomerDataSet(strCustID);


    // create the headings row for the output string
    String strResult = "OrderID" + TAB + "ShipName" + TAB
                     + "OrderAddress" + TAB + "OrderDate" + TAB +
                     "ShippedDate" + TAB + "CompanyName" + TAB
                     + "OrderDetailHref\n";

    // iterate through each row in the table building the output
    DataTable objTable = objDataSet.Tables["Orders"];
    foreach(DataRow objRow in objTable.Rows){

      // get values from columns as correct data types
      DateTime datOrderDate = (DateTime)objRow["OrderDate"];

      // create the result string for this row
      strResult += objRow["OrderID"].ToString() + TAB
                + objRow["ShipName"].ToString() + TAB
                + objRow["OrderAddress"].ToString() + TAB
                + datOrderDate.ToString("yyyy-MM-dd") + TAB;
      if (objRow["ShippedDate"] == DBNull.Value) {
        strResult += TAB;   // no "shipped date" value
      }
      else {
        DateTime datShippedDate = (DateTime)objRow["ShippedDate"];
        strResult += datShippedDate.ToString("yyyy-MM-dd") + TAB;
      }
      strResult += objRow["CompanyName"].ToString() + TAB
                + "javascript:ShowOrderDetail('"
                + objRow["OrderID"].ToString() + "')\n";
    }

    return strResult;
  }
  catch (Exception objErr) {

    // there was an error so no data is returned
    return "";

  }
}
//--------------------------------------------------------------

public String GetDetailDataFromServer(String strCustID) {
// uses data access component to get tab-delimited string
// containing a list of all order lines for specified customer

  // get connection string from web.config
  String strConnect;
  strConnect = ConfigurationSettings.AppSettings["NorthwindConnectString"];

  DataSet objDataSet;

  try {

    // create an instance of the data access component
    OrderList objOrderList = new OrderList(strConnect);

    // call the method to get the data as a DataSet
    objDataSet = objOrderList.GetOrdersByCustomerDataSet(strCustID);

    // create the headings row for the output string
    String strResult = "OrderID" + TAB + "ProductName" + TAB
                     + "QuantityPerUnit" + TAB + "UnitPrice" + TAB
                     + "Quantity" + TAB + "Discount" + TAB + "LineTotal\n";

    // iterate through each row in the table building the output
    DataTable objTable = objDataSet.Tables["OrderLines"];
    foreach(DataRow objRow in objTable.Rows){

      // get values from columns as correct data types
      decimal dPrice = (decimal)objRow["UnitPrice"];
      short iQty = (short)objRow["Quantity"];
      float fDiscount = (float)objRow["Discount"];

      // calculate total value of this order line
      decimal dTotal = iQty * (dPrice - (dPrice * (decimal)fDiscount));

      // create the result string for this row
      strResult += objRow["OrderID"].ToString() + TAB
                + objRow["ProductName"].ToString() + TAB
                + objRow["QuantityPerUnit"].ToString() + TAB
                + dPrice.ToString("N2") + TAB
                + iQty.ToString() + TAB
                + fDiscount.ToString("p") + TAB
                + dTotal.ToString("N2") + "\n";;
    }

    return strResult;
  }
  catch (Exception objErr) {

    // there was an error so no data is returned
    return "";

  }
}
//--------------------------------------------------------------
</script>
