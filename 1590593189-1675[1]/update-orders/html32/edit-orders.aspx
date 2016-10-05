<%@Page Language="C#" debug="true" %>
<%@Import Namespace="DDA4923OrderUpdate" %>
<%@Import Namespace="System.Data" %>

<!------------------ HTML page content --------------------->

<html>
<head>
<title>Edit Customer Orders</title>
<!-- #include file="../../global/style.inc" -->
</head>

<body link="#0000ff" alink="#0000ff" vlink="#0000ff">

<div class="heading">Edit Customer Orders</div>

<div align="right" class="cite">
[<a href="../../global/viewsource.aspx?compsrc=updateorders.cs" target="_blank">view page source</a>]
</div><hr />

<form runat="server">

<!-- hidden control to hold customer id -->
<input id="customerid" type="hidden" runat="server" />

<table border="0" cellpadding="10"><tr><td valign="top" bgcolor="#fffacd">

  <!-- label to display customer ID -->
  <asp:Label id="lblStatus" runat="server" EnableViewState="false" /><p />

  <!-- DataList control to display/edit matching orders -->
  <asp:DataList id="lstOrders" runat="server"
       HeaderStyle-BackColor="#c0c0c0"
       ItemStyle-BackColor="#ffffff"
       SelectedItemStyle-BackColor="#ffe4e1"
       EditItemStyle-BackColor="#dcdcdc"
       FooterStyle-HorizontalAlign="Right"
       DataKeyField="OrderID"
       CellPadding="3"
       CellSpacing="3"
       OnItemCommand="DoItemCommand"
       OnEditCommand="DoItemEdit"
       OnUpdateCommand="DoItemUpdate"
       OnDeleteCommand="DoItemDelete"
       OnCancelCommand="DoItemCancel"
       OnItemDataBound="SetRowVariations">

    <ItemTemplate>
      Order No: <b><%# DataBinder.Eval(Container.DataItem, "OrderID") %></b> &nbsp;
      Ordered: <%# DataBinder.Eval(Container.DataItem, "OrderDate", "{0:d}") %> &nbsp;
      Required: <%# DataBinder.Eval(Container.DataItem, "RequiredDate", "{0:d}") %> &nbsp;
      Ship: <%# DataBinder.Eval(Container.DataItem, "ShippedDate", "{0:d}") %>
      via <%# DataBinder.Eval(Container.DataItem, "ShipperName") %>
      ($<%# DataBinder.Eval(Container.DataItem, "Freight", "{0:F2}") %>)<br />
      <asp:Button CommandName="Edit" Text="Edit" runat="server" />
      Shipping address: <%# DataBinder.Eval(Container.DataItem, "ShipName") %>,
      <%# DataBinder.Eval(Container.DataItem, "ShipAddress") %>,
      <%# DataBinder.Eval(Container.DataItem, "ShipCity") %>,
      <%# DataBinder.Eval(Container.DataItem, "ShipPostalCode") %>,
      <%# DataBinder.Eval(Container.DataItem, "ShipCountry") %>
    </ItemTemplate>

    <EditItemTemplate>
      Order No: <b><asp:Label id="lblOrderID" runat="server"
          Text='<%# DataBinder.Eval(Container.DataItem, "OrderID") %>' /></b>&nbsp;
      Ordered: <%# DataBinder.Eval(Container.DataItem, "OrderDate", "{0:d}") %>&nbsp;
      Required: <asp:TextBox id="txtRequired" size="11" MaxLength="10" runat="server"
          Text='<%# DataBinder.Eval(Container.DataItem, "RequiredDate", "{0:d}") %>' />&nbsp;
      Ship: <asp:TextBox id="txtShipped" size="11" MaxLength="10" runat="server"
          Text='<%# DataBinder.Eval(Container.DataItem, "ShippedDate", "{0:d}") %>' />&nbsp;
      Freight: $<asp:TextBox id="txtFreight" size="5" MaxLength="6" runat="server"
          Text='<%# DataBinder.Eval(Container.DataItem, "Freight", "{0:F2}") %>' />
      <asp:Button id="cmdSetFreight" CommandName="SetFreight" Text="Set" runat="server" /><br />
      Name: <asp:TextBox id="txtShipName" size="40" MaxLength="40" runat="server"
          Text='<%# DataBinder.Eval(Container.DataItem, "ShipName") %>' />&nbsp;&nbsp;
      Address: <asp:TextBox id="txtAddress" size="59" MaxLength="60" runat="server"
          Text='<%# DataBinder.Eval(Container.DataItem, "ShipAddress") %>' /><br />&nbsp;
      City: <asp:TextBox id="txtCity" size="17" MaxLength="15" runat="server"
          Text='<%# DataBinder.Eval(Container.DataItem, "ShipCity") %>' />&nbsp;&nbsp;
      Postal Code: <asp:TextBox id="txtPostalCode" size="11" MaxLength="10" runat="server"
          Text='<%# DataBinder.Eval(Container.DataItem, "ShipPostalCode") %>' />&nbsp;
      Country: <asp:TextBox id="txtCountry" size="16" MaxLength="15" runat="server"
          Text='<%# DataBinder.Eval(Container.DataItem, "ShipCountry") %>' />&nbsp;&nbsp;
      via: <asp:DropDownList id="lstShipper" runat="server" />
        <div align="right">
          <asp:Button CommandName="Update" Text="Update" runat="server" />
          <asp:Button CommandName="Delete" Text="Delete" runat="server" />
          <asp:Button CommandName="Cancel" Text="Cancel" runat="server" />
          <asp:Button id="cmdEditItems" CommandName="EditItems"
               Text="Edit Items" Visible="False" runat="server" />
        </div>
      <input id="hidRequiredWas" type="hidden" runat="server"
             value='<%# DataBinder.Eval(Container.DataItem, "RequiredDate", "{0:d}") %>' />
      <input id="hidShippedWas" type="hidden" runat="server"
             value='<%# DataBinder.Eval(Container.DataItem, "ShippedDate", "{0:d}") %>' />
      <input id="hidShipNameWas" type="hidden" runat="server"
             value='<%# DataBinder.Eval(Container.DataItem, "ShipName") %>' />
      <input id="hidAddressWas" type="hidden" runat="server"
             value='<%# DataBinder.Eval(Container.DataItem, "ShipAddress") %>' />
      <input id="hidCityWas" type="hidden" runat="server"
             value='<%# DataBinder.Eval(Container.DataItem, "ShipCity") %>' />
      <input id="hidPostalCodeWas" type="hidden" runat="server"
             value='<%# DataBinder.Eval(Container.DataItem, "ShipPostalCode") %>' />
      <input id="hidCountryWas" type="hidden" runat="server"
             value='<%# DataBinder.Eval(Container.DataItem, "ShipCountry") %>' />
      <input id="hidFreightWas" type="hidden" runat="server"
             value='<%# DataBinder.Eval(Container.DataItem, "Freight", "{0:F2}") %>' />
      <input id="hidShipViaWas" type="hidden" runat="server"
             value='<%# DataBinder.Eval(Container.DataItem, "ShipVia") %>' />
    </EditItemTemplate>

    <FooterTemplate>
      <asp:Button CommandName="NewOrder" Text="New Order" runat="server" />
    </FooterTemplate>

  </asp:DataList><p />

  <!-- label to display interactive messages -->
  <asp:Label id="lblMessage" runat="server" EnableViewState="false" />

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

  if (Page.IsPostBack == true)

    // collect customer ID from hidden control
    strCustID = customerid.Value;

  else {

    strCustID = Request.QueryString["customerid"];
    if (strCustID == null || strCustID == "")

      // display error message
      lblMessage.Text = "* ERROR: no Customer ID provided. You must "
        + "<a href='../../customer-orders/html32/default.aspx'>"
        + "<b>select a customer</b></a> first.";

    else {

       // put customer ID into hidden control
       customerid.Value = strCustID;

      // display all orders for this customer
      ShowOrders();

      // diplay heading above DataList
      lblStatus.Text = "Orders for customer ID <b>'" + strCustID + "'</b>";
    }
  }
}
//--------------------------------------------------------------

void ShowOrders() {
// displays list of all orders for this customer in DataGrid control

  // get Orders DataSet using  elsewhere in this page
  DataSet objDataSet = GetOrdersFromSessionOrServer(strCustID);

  // remove filter appied by "Edit Order Lines" page
  DataView objLinesView = objDataSet.Tables["Order Details"].DefaultView;
  objLinesView.RowFilter = "";

  // set DataSource, bind the DataList and display status message
  lstOrders.DataSource = objDataSet.Tables["Orders"];
  lstOrders.DataBind();

  if (lstOrders.EditItemIndex > -1)

    lblMessage.Text = "Edit the details of the selected order and click the "
                    + "<b>Update</b> button in the list above to save the "
                    + "changes, or click<br /> the <b>Delete</b> button to "
                    + "permanently delete this order. Click the <b>Cancel</b> "
                    + "button to abandon any changes made to the<br /> "
                    + "order. To edit the detail lines for un-shipped orders "
                    + "click the <b>Edit Items</b> button, or "
                    + "<a href='../../customer-orders/html32/default.aspx'>"
                    + "<b>select another customer</b></a>";

  else

    lblMessage.Text = "Click the <b>Edit</b> button in the list above to "
                    + "edit details of that order, or "
                    + "<a href='../../customer-orders/html32/default.aspx'>"
                    + "<b>select another customer</b></a>";
}
//--------------------------------------------------------------

void SetRowVariations(Object objSender, DataListItemEventArgs objArgs) {
// sets value of DropDownList in each row to current Shipper name
// and displays the "Edit Items" button if it's an un-shipped order

  // see what type of row caused the event
  ListItemType objItemType = (ListItemType) objArgs.Item.ItemType;

  // only set the row variations for an EditItem row, which occurs only
  // once for each page load, and contains the EditItemTemplate content
  if (objItemType == ListItemType.EditItem) {

    // get a reference to the ShippedDate TextBox control in this row
    TextBox objTextBox = (TextBox) objArgs.Item.FindControl("txtShipped");

    // get a reference to the "Edit Items" Button control in this row
    Button objButton = (Button) objArgs.Item.FindControl("cmdEditItems");

    // business rule: can only edit lines on order if not yet shipped
    objButton.Visible = false;
    if (objTextBox.Text.Length == 0)
      objButton.Visible = true;   // no ship date specified
    else {
      try {
        // see if ship date is in the future
        DateTime datShip = DateTime.Parse(objTextBox.Text);
        if (DateTime.Compare(DateTime.Now, datShip) < 0)
          objButton.Visible = true;
      }
      catch (Exception objError) {
      }
    }

    // get a reference to the asp:DropDownList control in this row
    DropDownList objList = (DropDownList) objArgs.Item.FindControl("lstShipper");

    try {

      // get Shippers DataSet using  else {where in this page
      DataSet objShipDataSet = GetShippersFromSessionOrServer();

      objList.DataSource = objShipDataSet;
      objList.DataTextField = "ShipperName";
      objList.DataValueField = "ShipperID";
      objList.DataBind();

      // objArgs.Item.DataItem returns the data for this row of items
      DataRowView objRowVals = (DataRowView) objArgs.Item.DataItem;

      // get the Shipping Company ID of the item in the DataRowView
      String strShipperID = objRowVals["ShipVia"].ToString();

      foreach (ListItem objItem in objList.Items) {
        if (objItem.Value == strShipperID) objItem.Selected = true;
      }
    }
    catch (Exception objErr) {

      lblMessage.Text = "* ERROR: Shipper details not located. " + objErr.Message;
      objList.SelectedIndex = 0;
    }
  }
}
//--------------------------------------------------------------

void DoItemEdit(Object objSource, DataListCommandEventArgs objArgs) {
// runs when the EditCommand button in the Datalist is clicked
// switches DataList into "Edit" mode to show edit controls

  // reset any Selected row
  lstOrders.SelectedIndex = -1;

  // set the EditItemIndex property of the list to this item's index
  lstOrders.EditItemIndex = objArgs.Item.ItemIndex;

  lblStatus.Text = "Orders for customer ID <b>'" + strCustID + "'</b>";
  ShowOrders();  // bind the data and display it
}
//--------------------------------------------------------------

void DoItemCommand(Object objSource, DataListCommandEventArgs objArgs) {
// runs when any Command button in the Datalist is clicked

  // see if it was the "Edit Items" button that was clicked
  if (objArgs.CommandName == "EditItems") {

    // get a reference to the Order ID Label control
    Label objOrderIDCtrl = (Label) objArgs.Item.FindControl("lblOrderID");

    // create Query String for edit-order-lines page
    String strQuery = "?customerid=" + strCustID + "&orderid=" + objOrderIDCtrl.Text;

    // open page for editing detail lines for this order
    Response.Clear();
    Response.Redirect("edit-order-lines.aspx" + strQuery);
    Response.End();
  }

  // see if it was the "New Order" button that was clicked
  if (objArgs.CommandName == "NewOrder") {

    // reset any Selected row
    lstOrders.SelectedIndex = -1;

    // create variable for ByRef  parameter
    int intOrderID = -1;

    // call  to insert a new Order row in database for the
    // current customer. Sets OrderID and returns True/False
    if (InsertNewOrder(ref intOrderID) == true) {

      // show this row ready for editing
      lstOrders.EditItemIndex = 0;
      ShowOrders();
    }
  }

  // see if it was the "Set Freight" button that was clicked
  if (objArgs.CommandName == "SetFreight") {

    // get a reference to and value of OrderID Label control
    Label objOrderIDCtrl = (Label) objArgs.Item.FindControl("lblOrderID");
    int intOrderID = int.Parse(objOrderIDCtrl.Text);

    // get connection string from web.config
    String strConnect = ConfigurationSettings.AppSettings["NorthwindConnectString"];

    // create an instance of the data access component
    UpdateOrders objOrderList = new UpdateOrders(strConnect);

    // call routine in data access component to calculate/update
    // freight cost in Orders table and display message
    if (objOrderList.SetFreightCost(intOrderID) == true)
      lblStatus.Text = "Freight cost recalculated for Order ID: <b>"
                     + intOrderID.ToString() + "</b>";
    else
      lblStatus.Text = "* ERROR: Could not calculate freight cost.";

    // remove any cached DataSet from Session and update list
    Session["4923HTMLOrdersDataSet"] = null;
    ShowOrders();
  }
}
//--------------------------------------------------------------

void DoItemUpdate(Object objSource, DataListCommandEventArgs objArgs) {
// runs when the "Update" button in the DataList is clicked
// pushes update to the selected order back into the database

  // get OrderID for current row from the DataList's DataKeys collection
  int intUpdateID = (int) lstOrders.DataKeys[objArgs.Item.ItemIndex];

  // get the current (updated) values from the visible controls in the DataList
  TextBox objTextBox = (TextBox) objArgs.Item.FindControl("txtRequired");
  String strRequired = objTextBox.Text;
  objTextBox = (TextBox) objArgs.Item.FindControl("txtShipped");
  String strShipped = objTextBox.Text;
  objTextBox = (TextBox) objArgs.Item.FindControl("txtFreight");
  String strFreight = objTextBox.Text;
  objTextBox = (TextBox) objArgs.Item.FindControl("txtShipName");
  String strShipName = objTextBox.Text;
  objTextBox = (TextBox) objArgs.Item.FindControl("txtAddress");
  String strAddress = objTextBox.Text;
  objTextBox = (TextBox) objArgs.Item.FindControl("txtCity");
  String strCity = objTextBox.Text;
  objTextBox = (TextBox) objArgs.Item.FindControl("txtPostalCode");
  String strPostalCode = objTextBox.Text;
  objTextBox = (TextBox) objArgs.Item.FindControl("txtCountry");
  String strCountry = objTextBox.Text;
  DropDownList objList = (DropDownList) objArgs.Item.FindControl("lstShipper");
  String strShipVia = objList.Items[objList.SelectedIndex].Value;

  // get the original values from the hidden-type controls in the DataList
  HtmlInputHidden objHidden = (HtmlInputHidden) objArgs.Item.FindControl("hidRequiredWas");
  String strRequiredWas = objHidden.Value;
  objHidden = (HtmlInputHidden) objArgs.Item.FindControl("hidShippedWas");
  String strShippedWas = objHidden.Value;
  objHidden = (HtmlInputHidden) objArgs.Item.FindControl("hidFreightWas");
  String strFreightWas = objHidden.Value;
  objHidden = (HtmlInputHidden) objArgs.Item.FindControl("hidShipNameWas");
  String strShipNameWas = objHidden.Value;
  objHidden = (HtmlInputHidden) objArgs.Item.FindControl("hidAddressWas");
  String strAddressWas = objHidden.Value;
  objHidden = (HtmlInputHidden) objArgs.Item.FindControl("hidCityWas");
  String strCityWas = objHidden.Value;
  objHidden = (HtmlInputHidden) objArgs.Item.FindControl("hidPostalCodeWas");
  String strPostalCodeWas = objHidden.Value;
  objHidden = (HtmlInputHidden) objArgs.Item.FindControl("hidCountryWas");
  String strCountryWas = objHidden.Value;
  objHidden = (HtmlInputHidden) objArgs.Item.FindControl("hidShipViaWas");
  String strShipViaWas = objHidden.Value;

  // declare variables to hold converted data types
  Double dblFreight, dblFreightWas;
  int intShipVia, intShipViaWas;
  // dates have to be Object types as they may contain null
  Object datRequired = null, datRequiredWas = null;
  Object datShipped = null, datShippedWas = null;

  try {

    // convert String values into correct data types
    // leave Date vales as null to delete them
    dblFreight = Double.Parse(strFreight);
    intShipVia = int.Parse(strShipVia);
    dblFreightWas = Double.Parse(strFreightWas);
    intShipViaWas = int.Parse(strShipViaWas);
    if (strRequired.Length > 0) datRequired = DateTime.Parse(strRequired);
    if (strRequiredWas.Length > 0 ) datRequiredWas = DateTime.Parse(strRequiredWas);
    if (strShipped.Length > 0) datShipped = DateTime.Parse(strShipped);
    if (strShippedWas.Length > 0) datShippedWas = DateTime.Parse(strShippedWas);
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
    intRows = objOrderList.SingleRowOrderUpdate(intUpdateID, datRequired,
              datShipped, dblFreight, strShipName, strAddress, strCity,
              strPostalCode, strCountry, intShipVia, datRequiredWas,
              datShippedWas, dblFreightWas, strShipNameWas, strAddressWas,
              strCityWas, strPostalCodeWas, strCountryWas, intShipViaWas);

    // see if we got one row updated
    if (intRows == 1 )
      lblStatus.Text = "Updated Order ID: <b>" + intUpdateID.ToString() + "</b>";
    else
      lblStatus.Text = "* ERROR: Could not update Order ID: <b>"
                     + intUpdateID.ToString() + "</b><br />There were "
                     + intRows.ToString() + " database row(s) updated.<br />"
                     + "Error may be due to changes being made to "
                     + "the data concurrently by other users.";
  }
  catch (Exception objErr) {

    lblStatus.Text = "* ERROR: Failed to Update Order.<br />" + objErr.Message;
  }

  // remove any cached DataSet from the Session
  Session["4923HTMLOrdersDataSet"] = null;

  // set EditItemIndex property of grid to -1 to switch out of Edit mode
  lstOrders.EditItemIndex = -1;

  // set SelectedIndex to indicate row that was updated
  lstOrders.SelectedIndex = objArgs.Item.ItemIndex;
  ShowOrders();  // bind the data and display it
}
//--------------------------------------------------------------

void DoItemDelete(Object objSource, DataListCommandEventArgs objArgs) {
// runs when the "Delete" button in the Datalist is clicked
// deletes the selected order from the database

  // get OrderID for current row from the DataList"s DataKeys collection
  int intDeleteID = (int) lstOrders.DataKeys[objArgs.Item.ItemIndex];

  // get the original values from the hidden-type controls in the DataList
  HtmlInputHidden objHidden = (HtmlInputHidden) objArgs.Item.FindControl("hidRequiredWas");
  String strRequiredWas = objHidden.Value;
  objHidden = (HtmlInputHidden) objArgs.Item.FindControl("hidShippedWas");
  String strShippedWas = objHidden.Value;
  objHidden = (HtmlInputHidden) objArgs.Item.FindControl("hidFreightWas");
  String strFreightWas = objHidden.Value;
  objHidden = (HtmlInputHidden) objArgs.Item.FindControl("hidShipNameWas");
  String strShipNameWas = objHidden.Value;
  objHidden = (HtmlInputHidden) objArgs.Item.FindControl("hidAddressWas");
  String strAddressWas = objHidden.Value;
  objHidden = (HtmlInputHidden) objArgs.Item.FindControl("hidCityWas");
  String strCityWas = objHidden.Value;
  objHidden = (HtmlInputHidden) objArgs.Item.FindControl("hidPostalCodeWas");
  String strPostalCodeWas = objHidden.Value;
  objHidden = (HtmlInputHidden) objArgs.Item.FindControl("hidCountryWas");
  String strCountryWas = objHidden.Value;
  objHidden = (HtmlInputHidden) objArgs.Item.FindControl("hidShipViaWas");
  String strShipViaWas = objHidden.Value;

  // declare variables to hold converted data types
  Double dblFreightWas;
  int intShipViaWas;
  // dates have to be Object types as they may contain null
  Object datRequiredWas = null, datShippedWas = null;

  try {

    // convert String values into correct data types
    // leave Date vales as Null (Nothing) to delete them
    dblFreightWas = Double.Parse(strFreightWas);
    intShipViaWas = int.Parse(strShipViaWas);
    if (strRequiredWas.Length > 0 ) datRequiredWas = DateTime.Parse(strRequiredWas);
    if (strShippedWas.Length > 0) datShippedWas = DateTime.Parse(strShippedWas);
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

    // call  in data access component to delete the row
    intRows = objOrderList.SingleRowOrderDelete(intDeleteID, datRequiredWas,
              datShippedWas, dblFreightWas, strShipNameWas, strAddressWas,
              strCityWas, strPostalCodeWas, strCountryWas, intShipViaWas);

    // see if ( we got one row deleted
    if (intRows == 1)

      lblStatus.Text = "Deleted Order ID: <b>" + intDeleteID.ToString() + "</b>";

    else {

      lblStatus.Text = "* ERROR: Could not delete Order ID: <b>"
                     + intDeleteID.ToString() + "</b><br />There were "
                     + intRows.ToString() + " database row(s) deleted.<br />"
                     + "Error may be due to changes being made to "
                     + "the data concurrently by other users.";

      // set SelectedIndex to indicate row that was not deleted
      lstOrders.SelectedIndex = objArgs.Item.ItemIndex;
    }
  }
  catch (Exception objErr) {

    lblStatus.Text = "* ERROR: Failed to Delete Order.<br />" + objErr.Message;
  }

  // remove any cached DataSet from the Session
  Session["4923HTMLOrdersDataSet"] = null;

  // set EditItemIndex property of grid to -1 to switch out of Edit mode
  lstOrders.EditItemIndex = -1;
  ShowOrders();  // bind the data and display it;
}
//--------------------------------------------------------------

void DoItemCancel(Object objSource, DataListCommandEventArgs objArgs) {
// runs when the "Cancel" button in the Datalist is clicked

  // set EditItemIndex property of grid to -1 to switch out of Edit mode
  lstOrders.EditItemIndex = -1;
  ShowOrders();  // bind the data and display it
  lblStatus.Text = "Changes to the order were abandoned.";
}
//--------------------------------------------------------------

Boolean InsertNewOrder(ref int intOrderID) {

 // remove any cached DataSet from the Session so that updates
  // are displayed when the page is loaded next time
  Session["4923HTMLOrdersDataSet"] = null;

  // get connection string from web.config
  String strConnect = ConfigurationSettings.AppSettings["NorthwindConnectString"];

  // create an instance of the data access component
  UpdateOrders objOrderList = new UpdateOrders(strConnect);

  try {

    // call the method to return the data as a DataSet
    intOrderID = objOrderList.InsertNewOrder(strCustID);

    // display status message and return True
    lblStatus.Text = "Inserted new order ID: <b>"
                   + intOrderID.ToString() + "</b>";
    return true;
  }
  catch (Exception objErr) {

    // display error message and return False
    lblStatus.Text = "* ERROR: Cannot insert new order.<br />" + objErr.Message;
    return false;
  }
}
//--------------------------------------------------------------

DataSet GetOrdersFromSessionOrServer(String strCustID) {
// gets a DataSet containing all orders for this customer

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

DataSet GetShippersFromSessionOrServer() {
// gets a DataSet containing the list of Shippers

  try {

    DataSet objDataSet = null;

    // try and get DataSet from user's Session
    objDataSet = (DataSet) Session["4923HTMLShippersDataSet"];

    if (objDataSet == null) {   // not in Session

      // get connection string from web.config
      String strConnect = ConfigurationSettings.AppSettings["NorthwindConnectString"];

      // create an instance of the data access component
      UpdateOrders objOrderList = new UpdateOrders(strConnect);

      // call the method to return the data as a DataSet
      objDataSet = objOrderList.GetShippersDataSet();

      // get a reference to the Shippers table
      DataTable objTable = objDataSet.Tables["Shippers"];

      // create a new DataRow object for the table
      DataRow objDataRow = objTable.NewRow();

      // fill in values and insert into Rows collection of table
      objDataRow["ShipperID"] = "0";
      objDataRow["ShipperName"] = "{not specified}";
      objTable.Rows.InsertAt(objDataRow, 0);

      // save DataSet in Session for next order inquiry
      Session["4923HTMLShippersDataSet"] = objDataSet;
    }
    return objDataSet;
  }
  catch {

    return null;
  }
}

</script>

<!---------------------------------------------------------->
