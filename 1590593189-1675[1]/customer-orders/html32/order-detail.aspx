<%@Page Language="C#" EnableViewState="False"%>
<%@Import Namespace="OrderListData" %>
<%@Import Namespace="System.Data" %>

<!------------------ HTML page content --------------------->

<html>
<head>
<title>View Order Details</title>
<!-- #include file="../../global/style.inc" -->
</head>
<body link="#0000ff" alink="#0000ff" vlink="#0000ff">

<div class="heading">View Order Details</div>

<div align="right" class="cite">
[<a href="../../global/viewsource.aspx" target="_blank">view page source</a>]
</div><hr />

<form runat="server">

  <!-- label to display order details -->
  <asp:Label id="lblMessage" runat="server" /><p />

  <!-- DataGrid control to display order lines -->
  <asp:DataGrid id="dgrOrders" runat="server"
       AutoGenerateColumns="False"
       CellPadding="5"
       GridLines="Vertical"
       HeaderStyle-BackColor="#c0c0c0"
       AlternatingItemStyle-BackColor="#eeeeee">

    <Columns>
      <asp:BoundColumn HeaderText="<b>Qty</b>" HeaderStyle-HorizontalAlign="center"
                       ItemStyle-HorizontalAlign="center" DataField="Quantity" />
      <asp:BoundColumn HeaderText="<b>Product</b>" HeaderStyle-HorizontalAlign="center"
                       DataField="ProductName" />
      <asp:BoundColumn HeaderText="<b>Packs</b>" HeaderStyle-HorizontalAlign="center"
                       DataField="QuantityPerUnit" />
      <asp:BoundColumn HeaderText="<b>Each</b>" HeaderStyle-HorizontalAlign="center"
                       ItemStyle-HorizontalAlign="right"
                       DataField="UnitPrice" DataFormatString="${0:N2}" />
      <asp:BoundColumn HeaderText="<b>Discount</b>" HeaderStyle-HorizontalAlign="center"
                       ItemStyle-HorizontalAlign="right"
                       DataField="Discount" DataFormatString="{0:P}" />
      <asp:BoundColumn HeaderText="<b>Total</b>" HeaderStyle-HorizontalAlign="center"
                       ItemStyle-HorizontalAlign="right"
                       DataField="LineTotal" DataFormatString="${0:N2}" />
   </Columns>

  </asp:DataGrid><p />

  <!-- label to display order total -->
  <asp:Label id="lblTotal" runat="server" /><p />

</form>

</body>
</html>

<!-------------- server-side script section ---------------->

<script Language="C#" runat="server">

// page-level variables accessed from more than one routine
String strCustID = "";
String strOrderID = "";

//--------------------------------------------------------------

void Page_Load() {

  if (! Page.IsPostBack ) {

    strCustID = Request.QueryString["customerid"];
    strOrderID = Request.QueryString["orderid"];
    if (strOrderID == "" || strCustID == ""
        || strOrderID == null || strCustID == null)

      // display help message
      lblMessage.Text = "Select an order from the first column "
        + "in the list shown on the left to display the order details.";
    else

      // display order details for this order
      ShowOrderLines();
  }
}
//--------------------------------------------------------------

void ShowOrderLines() {
// display all the order line details for this order in DataGrid control

  // get DataSet using function elsewhere in this page
  DataSet objDataSet = GetDataSetFromSessionOrServer(strCustID);

  // create filtered DataView from Orders table in DataSet
  DataView objOrderView = objDataSet.Tables["Orders"].DefaultView;
  objOrderView.RowFilter = "OrderID = " + strOrderID;

  // create filtered DataView from LinesTable table
  DataView objLinesView = objDataSet.Tables["OrderLines"].DefaultView;
  objLinesView.RowFilter = "OrderID = " + strOrderID;

  // calculate total value of order
  Double dblTotal = 0;
  foreach (DataRowView objDataRowView in objLinesView) {
    dblTotal += (Double)objDataRowView["LineTotal"];
  }

  // check that there are some matching order lines
  if (objLinesView.Count > 0) {

    // display the shipping details in Message Label
    DateTime datThisDate = (DateTime)objOrderView[0]["OrderDate"];
    String strMessage = "Order ID: <b>" + strOrderID + "</b>"
      + " &nbsp; Customer Name: <b>" + objOrderView[0]["ShipName"].ToString() + "</b><br />"
      + "Delivery Address: " + objOrderView[0]["OrderAddress"].ToString() + "<br />"
      + "Ordered: " + datThisDate.ToString("d") + " &nbsp; ";
    if (objOrderView[0]["ShippedDate"] == DBNull.Value)
      strMessage += "Awaiting shipping";
    else {
      datThisDate = (DateTime)objOrderView[0]["ShippedDate"];
      strMessage += "Shipped: " + datThisDate.ToString("d");
    }
    strMessage += "via " + objOrderView[0]["CompanyName"].ToString();
    lblMessage.Text = strMessage;

    // set DataSource and bind the DataGrid
    dgrOrders.DataSource = objLinesView;
    dgrOrders.DataBind();

    // display the total value of the order
    lblTotal.Text = "Total order value: <b>" + dblTotal.ToString("$#,##0.00") + "</b>";

    // set DataSource and bind the List control
    dgrOrders.DataSource = objLinesView;
    dgrOrders.DataBind();
  }
  else
    lblMessage.Text = "No order lines found for this order...";
}
//--------------------------------------------------------------

DataSet GetDataSetFromSessionOrServer(String strCustID) {
// gets a DataSet containing all orders for this customer

  try {

    DataSet objDataSet;

    // try and get DataSet from user's Session
    objDataSet = (DataSet)Session["4923HTMLOrdersDataSet"];

    if (objDataSet == null) {  // not in Session

      // get connection string from web.config
      String strConnect = ConfigurationSettings.AppSettings["NorthwindConnectString"];

      // create an instance of the data access component
      OrderList objOrderList = new OrderList(strConnect);

      // call the method to return the data as a DataSet
      objDataSet = objOrderList.GetOrdersByCustomerDataSet(strCustID);

      // add a column containing the total value of each line
      DataTable objLinesTable = objDataSet.Tables["OrderLines"];
      DataColumn objColumn = objLinesTable.Columns.Add("LineTotal", System.Type.GetType("System.Double"));
      objColumn.Expression = "[Quantity] * ([UnitPrice] - ([UnitPrice] * [Discount]))";

      // save DataSet in Session for next order inquiry
      Session["4923HTMLOrdersDataSet"] = objDataSet;
    }
    return objDataSet;
  }
  catch (Exception objErr) {

    // there was an error and no data will be returned
    lblMessage.Text = "* ERROR: No data returned. " + objErr.Message;
    return null;
  }
}

</script>

<!---------------------------------------------------------->
