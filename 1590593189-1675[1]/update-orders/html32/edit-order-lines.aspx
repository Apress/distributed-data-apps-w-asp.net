<%@Page Language="C#" debug="true" %>
<%@Import Namespace="DDA4923OrderUpdate" %>
<%@Import Namespace="System.Data" %>

<!------------------ HTML page content --------------------->

<html>
<head>
<title>Edit Order Items</title>
<!-- #include file="../../global/style.inc" -->
</head>

<body link="#0000ff" alink="#0000ff" vlink="#0000ff">

<div class="heading">Edit Order Items</div>

<div align="right" class="cite">
[<a href="../../global/viewsource.aspx?compsrc=updateorders.cs" target="_blank">view page source</a>]
</div><hr />

<form runat="server">

<input id="customerid" type="hidden" runat="server" />
<input id="orderid" type="hidden" runat="server" />

<table border="0" cellpadding="10"><tr><td valign="top" bgcolor="#fffacd">

  <!-- label to display customer ID -->
  <asp:Label id="lblStatus" EnableViewState="false" runat="server" /><br />

  <!-- label to display order total value -->
  <asp:Label id="lblTotalValue" EnableViewState="false" runat="server" /><p />

  <!-- DataGrid control to display/edit order lines -->

  <asp:DataGrid id="dgrOrderLines" runat="server"
       CellPadding="5"
       GridLines="Vertical"
       SelectedItemStyle-BackColor="#ffe4e1"
       HeaderStyle-BackColor="#c0c0c0"
       ItemStyle-BackColor="#ffffff"
       AlternatingItemStyle-BackColor="#eeeeee"
       EditItemStyle-BackColor="#dcdcdc"
       HeaderStyle-HorizontalAlign="Center"
       DataKeyField="ProductID"
       OnItemCommand="DoItemCommand"
       OnEditCommand="DoItemEdit"
       OnUpdateCommand="DoItemUpdate"
       OnCancelCommand="DoItemCancel"
       AutoGenerateColumns="False">

    <Columns>

      <asp:TemplateColumn HeaderStyle-HorizontalAlign="center"
           ItemStyle-HorizontalAlign="center" HeaderText="<b>Qty</b>" >
        <ItemTemplate>
          <asp:Label id="lblQuantity" runat="server"
               Text='<%# DataBinder.Eval(Container.DataItem, "Quantity") %>' />
        </ItemTemplate>
        <EditItemTemplate>
          <asp:TextBox id="txtQuantity" Columns="2" MaxLength="4" runat="server"
               Text='<%# DataBinder.Eval(Container.DataItem, "Quantity") %>' />
        </EditItemTemplate>
      </asp:TemplateColumn>

      <asp:TemplateColumn HeaderText="<b>Product</b>"
           HeaderStyle-HorizontalAlign="center" ItemStyle-HorizontalAlign="left">
        <ItemTemplate>
          <asp:Label id="lblProductName" runat="server"
               Text='<%# DataBinder.Eval(Container.DataItem, "ProductName") %>' />
        </ItemTemplate>
      </asp:TemplateColumn>

      <asp:BoundColumn DataField="QtyPerUnit" HeaderText="<b>Packs</b>"
           HeaderStyle-HorizontalAlign="center" ItemStyle-HorizontalAlign="center"
           ReadOnly="True" />

      <asp:TemplateColumn HeaderText="<b>Each</b>"
           HeaderStyle-HorizontalAlign="center" ItemStyle-HorizontalAlign="right" >
        <ItemTemplate>
          $ <asp:Label id="lblUnitPrice" runat="server"
               Text='<%# DataBinder.Eval(Container.DataItem, "UnitPrice", "{0:N2}") %>'/>
        </ItemTemplate>
        <EditItemTemplate>
          <asp:TextBox id="txtUnitPrice" Columns="4" MaxLength="6" runat="server"
               Text='<%# DataBinder.Eval(Container.DataItem, "UnitPrice") %>' />
        </EditItemTemplate>
      </asp:TemplateColumn>

      <asp:TemplateColumn HeaderText="<b>Discount</b>"
           HeaderStyle-HorizontalAlign="center" ItemStyle-HorizontalAlign="right" >
        <ItemTemplate>
          <asp:Label id="lblDiscount" runat="server"
               Text='<%# DataBinder.Eval(Container.DataItem, "Discount", "{0:P}") %>'/>
        </ItemTemplate>
        <EditItemTemplate>
          <asp:TextBox id="txtDiscount" Columns="3" MaxLength="5" runat="server"
               Text='<%# (float) DataBinder.Eval(Container.DataItem, "Discount") * 100 %>' />
        </EditItemTemplate>
      </asp:TemplateColumn>

      <asp:BoundColumn HeaderText="<b>Total</b>"
           HeaderStyle-HorizontalAlign="center" ItemStyle-HorizontalAlign="right"
           DataField="LineTotal" DataFormatString="$ {0:N2}" ReadOnly="True" />

      <asp:EditCommandColumn EditText="Edit" CancelText="Cancel" UpdateText="Update" />

      <asp:TemplateColumn>
        <ItemTemplate>
          <asp:LinkButton Text="Delete" CommandName="Delete" runat="server" />
          <input id="hidQuantityWas" type="hidden" runat="server"
                 value='<%# DataBinder.Eval(Container.DataItem, "Quantity") %>' />
          <input id="hidUnitPriceWas" type="hidden" runat="server"
                 value='<%# DataBinder.Eval(Container.DataItem, "UnitPrice") %>' />
          <input id="hidDiscountWas" type="hidden" runat="server"
                 value='<%# DataBinder.Eval(Container.DataItem, "Discount") %>' />
        </ItemTemplate>
      </asp:TemplateColumn>

   </Columns>


  </asp:DataGrid><p />

  <div id="divAddNewLine" style="display:none" runat="server">
    Add Product to this Order:
    <asp:DropDownList id="lstAddProduct" runat="server" />
    <asp:Button OnClick="AddNewLine" Text="Add" runat="server" /><p />
  </div>

  <!-- label to display interactive messages -->
  <asp:Label id="lblMessage" EnableViewState="false" runat="server" />

</td></tr></table>
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

  if (Page.IsPostBack == true) {

    // collect customer ID and Order ID from hidden controls
    strCustID = customerid.Value;
    strOrderID = orderid.Value;
  }
  else {

    strCustID = Request.QueryString["customerid"];
    strOrderID = Request.QueryString["orderid"];

    if (strOrderID == null || strCustID == null
    || strOrderID == "" || strCustID == "" )

      // display error message
      lblMessage.Text = "* ERROR: no Customer or Order ID provided. You must "
        + "<a href='../../customer-orders/html32/default.aspx'>"
        + "<b>select a customer and order</b></a> first.";

    else {

       // put customer ID and Order ID into hidden controls
       customerid.Value = strCustID;
       orderid.Value = strOrderID;

      // display all orders for this customer
      ShowOrderLines();
    }
  }
}
//--------------------------------------------------------------

void ShowOrderLines() {
// displays list of all order lines for this customer in DataGrid control

  // get Orders DataSet using  else {where in this page
  DataSet objDataSet = GetOrdersFromSessionOrServer(strCustID);

  // create sorted and filtered DataView from Order Details table
  DataView objLinesView = objDataSet.Tables["Order Details"].DefaultView;
  objLinesView.RowFilter = "OrderID = " + strOrderID;
  objLinesView.Sort = "ProductName";

  // diplay heading above DataList
  lblStatus.Text = "Details for Order ID: <b>" + strOrderID + "</b>";

  // see if any line is in "Edit mode"
  if (dgrOrderLines.EditItemIndex > -1) {

    // hide list of products and display "Help" message
    divAddNewLine.Style["display"] = "none";
    lblMessage.Text = "Edit the details of the selected order and click the "
                    + "<b>Update</b> link in the grid above to save the "
                    + "changes, or click<br /> the <b>Delete</b> link to "
                    + "permanently delete this item. Click the <b>Cancel</b> "
                    + "link to abandon any changes made to the<br /> "
                    + "item, or "
                    + "<a href='edit-orders.aspx?customerid=" + strCustID + "'>"
                    + "<b>select a different order</b></a>, or "
                    + "<a href='../../customer-orders/html32/default.aspx'>"
                    + "<b>select another customer</b></a>";
  }
  else {

    // show list of products and display "Help" message
    divAddNewLine.Style["display"] = "";    // show list of products
    lblMessage.Text = "Click the <b>Edit</b> link in the grid above to "
                    + "edit that order line,<br />or "
                    + "<a href='edit-orders.aspx?customerid=" + strCustID + "'>"
                    + "<b>select a different order</b></a>, or "
                    + "<a href='../../customer-orders/html32/default.aspx'>"
                    + "<b>select another customer</b></a>";

    // bind list of products to data source to fill in values
    lstAddProduct.DataSource = GetProductsFromSessionOrServer();
    lstAddProduct.DataMember = "Products";
    lstAddProduct.DataTextField = "ProductName";
    lstAddProduct.DataValueField = "ProductID";
    lstAddProduct.DataBind();

    // add extra row at top of list for "Select product ..."
    ListItem objItem = new ListItem ("Select product...", "-1");
    lstAddProduct.Items.Insert(0, objItem);
  }

  // see if there are any order detail lines on this order
  if (objLinesView.Count == 0) {

    // display "Help" message
    lblMessage.Text = "There are no lines on this order. Select a product from<br />"
                    + "the list above and click the <b>Add</b> button to add "
                    + "a line to<br />this order, or "
                    + "<a href='edit-orders.aspx?customerid=" + strCustID + "'>"
                    + "<b>select a different order</b></a>";

    dgrOrderLines.Visible = false;    // hide DataGrid control
  }
  else {

    // set DataSource and bind the DataGrid to show order lines
    dgrOrderLines.DataSource = objDataSet.Tables["Order Details"];
    dgrOrderLines.DataBind();

    dgrOrderLines.Visible = true;  // make DataGrid visible

    // show order Total Value by iterating rows in DataView
    Double dblTotal = 0;
    foreach (DataRowView objRow in objLinesView) {
      dblTotal += (Double) objRow["LineTotal"];
    }
    lblTotalValue.Text = "Total order value: <b>$ "
                       + dblTotal.ToString("N2") + "</b>";
  }
}
//--------------------------------------------------------------

int GetGridIndexForProduct(int intProductID) {
// gets the index within the Datagrid for the product specified

  int intResult = -1;
  int intIndex;

  // check ProductID for each row in DataGrid"s DataKeys collection
  for (intIndex = 0; intIndex < dgrOrderLines.DataKeys.Count; intIndex++) {
    if ((int) dgrOrderLines.DataKeys[intIndex] == intProductID) {
      intResult = intIndex;
      break;
    }
  }
  return intResult;
}
//--------------------------------------------------------------

void AddNewLine(Object objSource, EventArgs objArgs) {
// runs when the "Add" (product) button below the grid is clicked

  String strMessage = String.Empty;   // to hold status message

  // get selected item index from "Add Product" drop-down list
  int intListIndex = lstAddProduct.SelectedIndex;

  // get selected product ID and product name
  int intProductID = int.Parse(lstAddProduct.Items[intListIndex].Value);
  String strProductName = lstAddProduct.Items[intListIndex].Text;

  if (intProductID < 0) {

    // user did not make a selection in the list
    lblStatus.Text = "*ERROR: You must select a product from the drop-down<br />"
                   + "list at the bottom of this page first, then click <b>Add</b>."
                   + "or <a href='edit-orders.aspx?customerid=" + strCustID + "'>"
                   + "<b>select a different order</b></a>";
    return;
  }

  try {

    // get connection string from web.config
    String strConnect = ConfigurationSettings.AppSettings["NorthwindConnectString"];

    // create an instance of the data access component
    UpdateOrders objOrderList = new UpdateOrders(strConnect);

    // convert OrderID string into an Integer
    int intOrderID = int.Parse(strOrderID);

    // call the method to add a new row to the Order Details table
    if (objOrderList.InsertNewOrderLine(intOrderID, intProductID) == true) {

      strMessage = "Added product '<b>" + strProductName + "</b>' to order";

      // remove any cached DataSet from the Session
      Session["4923HTMLOrdersDataSet"] = null;

      // to be able to find new row in DataGrid we have to bind it
      // to the data source first and then search for it in the grid
      ShowOrderLines();  // bind the data and display it

      // now use routine in this page to return index in DataGrid
      // for the item with the specified ProductID. This will be
      // displayed when grid is bound again before display
      dgrOrderLines.SelectedIndex = GetGridIndexForProduct(intProductID);
    }
    else {

      strMessage = "Failed to added product '<b>" + strProductName + "</b>' to order";
    }
    ShowOrderLines();  // bind the data and display it
  }
  catch (Exception objErr) {

    strMessage = "*ERROR: Could not add product to order. "
               + "if this product is<br />already on the order, "
               + "just increase the quantity for that line.";
  }
  lblStatus.Text = strMessage;   // display status message
}
//--------------------------------------------------------------

void DoItemEdit(Object objSource, DataGridCommandEventArgs objArgs) {
// runs when the "Edit" link in the DataGrid is clicked
// switches DataList into "Edit" mode to show edit controls

  // set the EditItemIndex property of the list to this item's index
  dgrOrderLines.EditItemIndex = objArgs.Item.ItemIndex;

  // set the SelectedIndex property to "unselect" all rows
  dgrOrderLines.SelectedIndex = -1;

  ShowOrderLines();  // bind the data and display it
}
//--------------------------------------------------------------

void DoItemCommand(Object objSource, DataGridCommandEventArgs objArgs) {
// runs when any Command button/link in the DataGrid is clicked

  // see if it was the "Delete" link that was clicked
  if (objArgs.CommandName == "Delete") DoItemDelete(objSource, objArgs);
}
//--------------------------------------------------------------

void DoItemUpdate(Object objSource, DataGridCommandEventArgs objArgs) {
// runs when the "Update" link in the DataGrid is clicked
// pushes update to the selected order line back into database

  String strMessage = String.Empty;   // to hold status message

  // get ProductID for current row from the DataGrid's DataKeys collection
  int intProductID = (int) dgrOrderLines.DataKeys[objArgs.Item.ItemIndex];

  // convert current OrderID string into an Integer
  int intOrderID = int.Parse(strOrderID);

  // get product name from current row in DataGrid
  Label objLabel = (Label) objArgs.Item.FindControl("lblProductName");
  String strProductName = objLabel.Text;

  // get the current (updated) values from the visible controls in the DataGrid
  TextBox objTextBox = (TextBox) objArgs.Item.FindControl("txtQuantity");
  String strQuantity = objTextBox.Text;
  objTextBox = (TextBox) objArgs.Item.FindControl("txtUnitPrice");
  String strUnitPrice = objTextBox.Text;
  objTextBox = (TextBox) objArgs.Item.FindControl("txtDiscount");
  String strDiscount = objTextBox.Text;

  // get the original values from the hidden-type controls in the DataGrid
  HtmlInputHidden objHidden = (HtmlInputHidden) objArgs.Item.FindControl("hidQuantityWas");
  String strQuantityWas = objHidden.Value;
  objHidden = (HtmlInputHidden) objArgs.Item.FindControl("hidUnitPriceWas");
  String strUnitPriceWas = objHidden.Value;
  objHidden = (HtmlInputHidden) objArgs.Item.FindControl("hidDiscountWas");
  String strDiscountWas = objHidden.Value;

  // declare variables to hold converted data types
  int intQuantity, intQuantityWas;
  float dblUnitPrice, dblUnitPriceWas;
  float dblDiscount, dblDiscountWas;

  try {

    // convert String values into correct data types
    intQuantity = int.Parse(strQuantity);
    intQuantityWas = int.Parse(strQuantityWas);
    dblUnitPrice = float.Parse(strUnitPrice);
    dblUnitPriceWas = float.Parse(strUnitPriceWas);
    dblDiscount = float.Parse(strDiscount) / 100;
    dblDiscountWas = float.Parse(strDiscountWas);
  }
  catch (Exception objErr) {
    lblStatus.Text = "* ERROR: Incorrect value entered.<br />" + objErr.Message;
    return;
  }

  // get connection string from web.config
  String strConnect = ConfigurationSettings.AppSettings["NorthwindConnectString"];

  // create an instance of the data access component
  UpdateOrders objOrderList = new UpdateOrders(strConnect);

  try {

    int intRows;

    // call  within this page to perform the update
    intRows = objOrderList.SingleOrderLineUpdate(intOrderID,
              intProductID, dblUnitPrice, intQuantity, dblDiscount,
              dblUnitPriceWas, intQuantityWas, dblDiscountWas);

    // see if we got one row updated
    if (intRows == 1)
      strMessage = "Updated order for '<b>" + strProductName + "</b>'";
    else
      strMessage = "* ERROR: Could not update order for '<b>"
                 + strProductName + "</b>'<br />There were "
                 + intRows.ToString() + " database row(s) updated.<br />"
                 + "Error may be due to changes being made to "
                 + "the data concurrently by other users.";
  }
  catch (Exception objErr) {
    strMessage = "* ERROR: Failed to Update Order Line.<br />" + objErr.Message;
  }

  // set SelectedIndex of grid to current EditItemIndex to indicate
  // updated row, and set EditItemIndex to -1 to switch off Edit mode
  dgrOrderLines.SelectedIndex = dgrOrderLines.EditItemIndex;
  dgrOrderLines.EditItemIndex = -1;

  // remove any cached DataSet from the Session
  Session["4923HTMLOrdersDataSet"] = null;

  // re-bind the data to display selected row
  ShowOrderLines();
  lblStatus.Text = strMessage;
}
//--------------------------------------------------------------

void DoItemDelete(Object objSource, DataGridCommandEventArgs objArgs) {
// runs when the "Delete" link in the DataGrid is clicked
// deletes the selected order line from the database

  String strMessage = String.Empty;   // to hold status message

  // set Edit and Selected Index of grid to -1 to ensure no rows
  // are in "selected" or "edit mode" after deleting this row
  dgrOrderLines.EditItemIndex = -1;
  dgrOrderLines.SelectedIndex = -1;

  // get ProductID for current row from the DataGrid"s DataKeys collection
  int intProductID = (int) dgrOrderLines.DataKeys[objArgs.Item.ItemIndex];

  // convert current OrderID string into an Integer
  int intOrderID = int.Parse(strOrderID);

  // get product name from current row in DataGrid
  Label objLabel = (Label) objArgs.Item.FindControl("lblProductName");
  String strProductName = objLabel.Text;

  // get the original values from the hidden-type controls in the DataGrid
  HtmlInputHidden objHidden = (HtmlInputHidden) objArgs.Item.FindControl("hidQuantityWas");
  String strQuantityWas = objHidden.Value;
  objHidden = (HtmlInputHidden) objArgs.Item.FindControl("hidUnitPriceWas");
  String strUnitPriceWas = objHidden.Value;
  objHidden = (HtmlInputHidden) objArgs.Item.FindControl("hidDiscountWas");
  String strDiscountWas = objHidden.Value;

  // declare variables to hold converted data types
  int intQuantityWas = int.Parse(strQuantityWas);
  float dblUnitPriceWas = float.Parse(strUnitPriceWas);
  float dblDiscountWas = float.Parse(strDiscountWas);

  // get connection string from web.config
  String strConnect = ConfigurationSettings.AppSettings["NorthwindConnectString"];

  // create an instance of the data access component
  UpdateOrders objOrderList = new UpdateOrders(strConnect);

  try {

    int intRows;

    // call  in data access component to delete the row
    intRows = objOrderList.SingleOrderLineDelete(intOrderID,
            intProductID, dblUnitPriceWas, intQuantityWas, dblDiscountWas);

    // see if we got one row deleted
    if (intRows == 1)
      strMessage = "Deleted order for '<b>" + strProductName + "'</b>";
    else
      strMessage = "* ERROR: Could not delete product '<b>"
                 + strProductName + "</b>'<br />There were "
                 + intRows.ToString() + " database row(s) deleted.<br />"
                 + "Error may be due to changes being made to "
                 + "the data concurrently by other users.";
  }
  catch (Exception objErr) {
    strMessage = "* ERROR: Failed to Delete Order Line.<br />" + objErr.Message;
  }

  // remove any cached DataSet from the Session so that updates
  // are displayed when the page is loaded next time
  Session["4923HTMLOrdersDataSet"] = null;
  ShowOrderLines();  // bind the data and display it
  lblStatus.Text = strMessage;
}
//--------------------------------------------------------------

void DoItemCancel(Object objSource, DataGridCommandEventArgs objArgs) {
// runs when the "Cancel" link in the Datalist is clicked

  // set EditItemIndex property of grid to -1 to switch out of Edit mode
  dgrOrderLines.EditItemIndex = -1;

  ShowOrderLines();  // bind the data and display it
  lblStatus.Text = "Changes to the order were abandoned.";
}
//--------------------------------------------------------------

DataSet GetOrdersFromSessionOrServer(String strCustID) {
// gets a DataSet containing all order details for this customer

  try {

    DataSet objDataSet = null;

    // try and get DataSet from user's Session
    objDataSet = (DataSet) Session["4923HTMLOrdersDataSet"];

    if (objDataSet == null) {   // not in Session

      // get connection string from web.config
      String strConnect = ConfigurationSettings.AppSettings["NorthwindConnectString"];

      // create an instance of the data access component
      UpdateOrders objOrderList = new UpdateOrders(strConnect);

      // call the method to return the data as a DataSet
      objDataSet = objOrderList.GetOrderDetails(strCustID);

      // add a column containing the total value of each line
      DataTable objLinesTable = objDataSet.Tables["Order Details"];
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
//--------------------------------------------------------------

DataSet GetProductsFromSessionOrServer() {
// gets a DataSet containing the list of Products

  try {

    DataSet objDataSet = null;

    // try and get DataSet from user"s Session
    objDataSet = (DataSet) Session["4923HTMLProductsDataSet"];

    if (objDataSet == null)  { // not in Session

      // get connection string from web.config
      String strConnect = ConfigurationSettings.AppSettings["NorthwindConnectString"];

      // create an instance of the data access component
      UpdateOrders objOrderList = new UpdateOrders(strConnect);

      // call the method to return the data as a DataSet
      objDataSet = objOrderList.GetProductsDataSet();

      // save DataSet in Session for next order inquiry
      Session["4923HTMLProductsDataSet"] = objDataSet;
    }
    return objDataSet;
  }
  catch (Exception objErr) {

    // there was an error and no data will be returned
    lblMessage.Text = "* ERROR: Cannot retrieve list of products.<br />" + objErr.Message;
    return null;
  }
}

</script>
<!---------------------------------------------------------->
