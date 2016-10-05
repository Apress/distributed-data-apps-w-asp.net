<%@Page Language="C#" EnableViewState="False"%>
<%@Import Namespace="OrderListData" %>
<%@Import Namespace="System.Data" %>

<!------------------ HTML page content --------------------->

<html>
<head>
<title>View Order List</title>
<!-- #include file="../../global/style.inc" -->
</head>

<body link="#0000ff" alink="#0000ff" vlink="#0000ff">

<div class="heading">View Order List</div>

<div align="right" class="cite">
[<a href="../../global/viewsource.aspx" target="_blank">view page source</a>]
</div><hr />

<form runat="server">
<table border="0" cellpadding="20"><tr><td valign="top" bgcolor="#fffacd">

  <!-- label to display customer ID -->
  <asp:Label id="lblStatus" runat="server" /><p />

  <!-- DataGrid control to display matching orders -->
  <asp:DataGrid id="dgrOrders" runat="server"
       AutoGenerateColumns="False"
       CellPadding="5"
       GridLines="Vertical"
       HeaderStyle-BackColor="#c0c0c0"
       ItemStyle-BackColor="#ffffff"
       AlternatingItemStyle-BackColor="#eeeeee">

    <Columns>

      <asp:TemplateColumn HeaderText="<b>Order ID</b>" ItemStyle-BackColor="#add8e6"
                          ItemStyle-HorizontalAlign="center">
        <ItemTemplate>
          <asp:hyperlink Text='<%# DataBinder.Eval(Container.DataItem, "OrderID")%>'
               NavigateUrl='<%# DataBinder.Eval(Container.DataItem, "OrderID",
               "order-detail.aspx?customerid=" + strCustID + "&orderid={0}") %>'
               Target="right" runat="server" />
        </ItemTemplate>
      </asp:TemplateColumn>

      <asp:BoundColumn HeaderText="<b>Order Date</b>" HeaderStyle-HorizontalAlign="center"
                       ItemStyle-HorizontalAlign="center"
                       DataField="OrderDate" DataFormatString="{0:d}" />

      <asp:BoundColumn HeaderText="<b>Shipped</b>" HeaderStyle-HorizontalAlign="center"
                       ItemStyle-HorizontalAlign="center"
                       DataField="ShippedDate" DataFormatString="{0:d}" />

    </Columns>

  </asp:DataGrid><p />

  <!-- label to display interactive messages -->
  <asp:Label id="lblMessage" runat="server" />

</td></tr></table>
</form>

</body>
</html>

<!-------------- server-side script section ---------------->

<script Language="C#" runat="server">

// page-level variable accessed from more than one routine
String strCustID = "";

//--------------------------------------------------------------

void Page_Load() {

  if (! Page.IsPostBack) {

    // get customer ID from query string
    strCustID = Request.QueryString["customerid"];
    if (strCustID == null || strCustID == "")

      // display error message
      lblMessage.Text = "* ERROR: no Customer ID provided.<br />"
        + "You must <a href='default.aspx' target='_top'><b>select"
        + " a customer</b></a> first.";
    else
      // display all orders for this customer
      ShowOrders();
  }
}
//--------------------------------------------------------------

void ShowOrders() {
// display list of all orders for this customer in DataGrid control

  // get DataSet using function elsewhere in this page
  DataSet objDataSet = GetDataSetFromSessionOrServer(strCustID);

  // remove any existing filter from table DefaultView
  // otherwise refreshing page in browser shows only one row
  objDataSet.Tables["Orders"].DefaultView.RowFilter = "";

  // check if ( any orders were found for this customer
  if (objDataSet.Tables["Orders"].Rows.Count > 0) {

    // diplay heading above DataGrid
    lblStatus.Text = "Orders for customer ID <b>'" + strCustID + "'</b>";

    // set DataSource, bind the DataGrid and display status message
    dgrOrders.DataSource = objDataSet.Tables["Orders"];
    dgrOrders.DataBind();
    lblMessage.Text = "Click an <b>Order ID</b> in the grid above to"
                    + "<br /> display details of that order or ";

    }
    else
      lblMessage.Text = "No orders found for this customer ...";

  lblMessage.Text += "<br /><a href='default.aspx' target='_top'>"
                  + "<b>select another customer</b></a>";
}
//--------------------------------------------------------------

DataSet GetDataSetFromSessionOrServer(String strCustID) {
// gets a DataSet containing all orders for this customer

  try {

    DataSet objDataSet;

    // try and get DataSet from user's Session
    objDataSet = (DataSet) Session["4923HTMLOrdersDataSet"];

    if (objDataSet == null) {   // not in Session

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
