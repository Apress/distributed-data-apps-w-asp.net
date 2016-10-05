<%@Page Inherits="System.Web.UI.MobileControls.MobilePage" Language="C#" debug="true" %>
<%@Register TagPrefix="Mobile" Namespace="System.Web.UI.MobileControls" Assembly="System.Web.Mobile"%>
<%@Import Namespace="DDA4923OrderUpdate" %>
<%@Import Namespace="System.Data" %>

<mobile:Form id="frmSelectOrder" title="Select Order" StyleReference="styPage" OnActivate="SelectOrder_Activate" runat="server">
  <mobile:Label id="lblMsg1" StyleReference="styHeading" EnableViewState="False"
          runat="server">Edit Order:</mobile:Label><br /><br />
  <mobile:Label id="lblOrderMsg" Font-Bold="true" EnableViewState="False" runat="server" />
  <mobile:List id="lstOrders" StyleReference="styListAndLink"
          OnItemCommand="ShowEditOptions" runat="server" /><br />
  <mobile:Command id="cmdInsert" StyleReference="styListAndLink" runat="server"
          OnClick="InsertNewOrder" SoftKeyLabel="New" Text="Add New Order" />
  <mobile:Link NavigateUrl="../../customer-orders/mobile/default.aspx"
          StyleReference="styListAndLink" runat="server"
          SoftKeyLabel="Customer" Text="Select Customer" />
</mobile:Form>

<mobile:Form id="frmEditOptions" title="Edit Order" StyleReference="styPage" OnActivate="EditOptions_Activate" runat="server">
  <mobile:Label id="lblMsg2" StyleReference="styHeading" EnableViewState="False"
          runat="server">Edit Options:</mobile:Label><br /><br />
  <mobile:Label id="lblOrderID" Font-Bold="true" EnableViewState="False" runat="server" />
  <mobile:Link StyleReference="styListAndLink" runat="server"
          NavigateUrl="#frmEditAddress" SoftKeyLabel="Address" Text="Ship Address" />
  <mobile:Link StyleReference="styListAndLink" runat="server"
          NavigateUrl="#frmEditDetails" SoftKeyLabel="Shipping" Text="Ship Details" />
  <mobile:Link StyleReference="styListAndLink" runat="server"
          NavigateUrl="#frmSelectLine" SoftKeyLabel="Contents" Text="Order Contents" />
  <mobile:Command StyleReference="styListAndLink" runat="server"
          OnClick="DeleteOrder" SoftKeyLabel="Delete" Text="Delete Order" /><br />
  <mobile:Link StyleReference="styListAndLink" runat="server"
          NavigateUrl="#frmViewOrder" SoftKeyLabel="Summary" Text="View Summary" />
  <mobile:Link StyleReference="styListAndLink" runat="server"
          NavigateUrl="#frmSelectOrder" SoftKeyLabel="Orders" Text="Select Order" />
</mobile:Form>

<mobile:Form id="frmEditAddress" title="Edit Address" StyleReference="styPage" runat="server">
  <mobile:Label id="lblMsg3" StyleReference="styHeading" EnableViewState="False"
          runat="server">Ship Address:</mobile:Label><br /><br />
  <mobile:Label id="lblName" Text="Name:" EnableViewState="False" runat="server" />
  <mobile:TextBox id="txtName" Size="20" MaxLength="40" runat="server" />
  <mobile:Label id="lblAddress" Text="Address:" EnableViewState="False" runat="server" />
  <mobile:TextBox id="txtAddress" Size="20" MaxLength="60" runat="server" />
  <mobile:Label id="lblCity" Text="City:" EnableViewState="False" runat="server" />
  <mobile:TextBox id="txtCity" Size="20" MaxLength="15" runat="server" />
  <mobile:Label id="lblPostCode" Text="PostCode:" EnableViewState="False" runat="server" />
  <mobile:TextBox id="txtPostCode" Size="20" MaxLength="10" runat="server" />
  <mobile:Label id="lblCountry" Text="Country:" EnableViewState="False" runat="server" />
  <mobile:TextBox id="txtCountry" Size="20" MaxLength="15" runat="server" />
  <mobile:Command StyleReference="styListAndLink" runat="server"
          OnClick="UpdateAddress" SoftKeyLabel="Update" Text="Update" />
  <mobile:Link StyleReference="styListAndLink" runat="server"
          NavigateUrl="#frmEditOptions" SoftKeyLabel="Cancel" Text="Cancel" />
  <mobile:Label id="lblStatus3" EnableViewState="False" runat="server" />
</mobile:Form>

<mobile:Form id="frmEditDetails" title="Edit Details" StyleReference="styPage" runat="server">
  <mobile:Label id="lblMsg4" StyleReference="styHeading" EnableViewState="False"
          runat="server">Ship Details:</mobile:Label><br /><br />
  <mobile:Label id="lblOrdered" runat="server" />
  <mobile:Label id="lblRequired" Text="Required:" EnableViewState="False" runat="server" />
  <mobile:TextBox id="txtRequired" Size="10" MaxLength="10" runat="server" />
  <mobile:Label id="lblShipped" Text="Shipped:" EnableViewState="False" runat="server" />
  <mobile:TextBox id="txtShip" Size="10" MaxLength="10" runat="server" />
  <mobile:Label id="lblVia" Text="Via:" EnableViewState="False" runat="server" />
  <mobile:SelectionList id="lstVia" runat="server" />
  <mobile:Label id="lblFreight" Text="Freight: ($)" EnableViewState="False" runat="server" />
  <mobile:TextBox id="txtFreight" Size="5" MaxLength="6" runat="server" />
  <mobile:Command StyleReference="styListAndLink" runat="server"
          OnClick="CalculateFreight" SoftKeyLabel="Freight" Text="Set Freight" />
  <mobile:Command StyleReference="styListAndLink" runat="server"
          OnClick="UpdateDetails" SoftKeyLabel="Update" Text="Update" />
  <mobile:Link StyleReference="styListAndLink" runat="server"
          NavigateUrl="#frmEditOptions" SoftKeyLabel="Cancel" Text="Cancel" />
  <mobile:Label id="lblStatus4" EnableViewState="False" runat="server" />
</mobile:Form>

<mobile:Form id="frmSelectLine" title="Order Lines" StyleReference="styPage" OnActivate="SelectLine_Activate" runat="server">
  <mobile:Label id="lblMsg5" StyleReference="styHeading" EnableViewState="False"
          runat="server">Select Order Line:</mobile:Label><br /><br />
  <mobile:Label id="lblStatus5" EnableViewState="False" Font-Bold="true" runat="server" />
  <mobile:List id="lstOrderLines" StyleReference="styListAndLink"
          OnItemCommand="OrderLineListSelect" runat="server" /><br />
  <mobile:Link StyleReference="styListAndLink" runat="server"
          NavigateUrl="#frmSelectProduct" SoftKeyLabel="Add" Text="Add Product" />
  <mobile:Link StyleReference="styListAndLink" runat="server"
          NavigateUrl="#frmEditOptions" SoftKeyLabel="Cancel" Text="Cancel" />
</mobile:Form>

<mobile:Form id="frmEditLine" title="Edit Line" StyleReference="styPage" runat="server">
  <mobile:Label id="lblMsg6" StyleReference="styHeading" EnableViewState="False"
          runat="server">Edit Order Line:</mobile:Label><br /><br />
  <mobile:Label id="lblProduct" Font-Bold="true" runat="server" />
  <mobile:Label id="lblQuantity" EnableViewState="False" runat="server">Quantity:</mobile:Label>
  <mobile:TextBox id="txtQuantity" Size="4" MaxLength="4" runat="server" />
  <mobile:Label id="lblUnitPrice" EnableViewState="False" runat="server">Price Each($):</mobile:Label>
  <mobile:TextBox id="txtUnitPrice" Size="4" MaxLength="6" runat="server" />
  <mobile:Label id="lblDiscount" EnableViewState="False" runat="server">Discount(%):</mobile:Label>
  <mobile:TextBox id="txtDiscount" Size="4" MaxLength="5" runat="server" />
  <mobile:Label id="lblLineTotal" EnableViewState="False" runat="server" />
  <mobile:Command styleReference="styListAndLink" runat="server"
          OnClick="UpdateOrderLine" SoftKeyLabel="Update" Text="Update" />
  <mobile:Command StyleReference="styListAndLink" runat="server"
          OnClick="DeleteOrderLine" SoftKeyLabel="Delete" Text="Delete" />
  <mobile:Link StyleReference="styListAndLink" runat="server"
          NavigateUrl="#frmSelectLine" SoftKeyLabel="Cancel" Text="Cancel" />
  <mobile:Label id="lblStatus6" EnableViewState="False" runat="server" />
</mobile:Form>

<mobile:Form id="frmViewOrder" title="Order Summary" StyleReference="styPage" OnActivate="ViewOrder_Activate" runat="server">
  <mobile:Label id="lblMsg7" StyleReference="styHeading" EnableViewState="False"
          runat="server">Order Summary:</mobile:Label><br /><br />
  <mobile:Label id="lblViewOrderNo" Font-Bold="true" EnableViewState="False" runat="server" />
  <mobile:Label id="lblViewNameAddress" EnableViewState="False" runat="server" />
  <mobile:Label id="lblViewOrdered" EnableViewState="False" runat="server" />
  <mobile:Label id="lblViewRequired" EnableViewState="False" runat="server" />
  <mobile:Label id="lblViewShipped" EnableViewState="False" runat="server" />
  <mobile:Label id="lblViewVia" EnableViewState="False" runat="server" />
  <mobile:Label id="lblViewFreight" EnableViewState="False" runat="server" />
  <mobile:List id="lstLinesSummary" EnableViewState="False" styleReference="styListAndLink" runat="server" /><br />
  <mobile:Link StyleReference="styListAndLink" runat="server"
          NavigateUrl="#frmEditOptions" SoftKeyLabel="Edit" Text="Edit Order" />
  <mobile:Link StyleReference="styListAndLink" runat="server"
          NavigateUrl="#frmSelectOrder" SoftKeyLabel="Orders" Text="Select Order" />
</mobile:Form>

<mobile:Form id="frmSelectProduct" title="Select Product" StyleReference="styPage" OnActivate="SelectAddProduct_Activate" runat="server">
  <mobile:Label id="lblMsg8" StyleReference="styHeading" EnableViewState="False"
          runat="server">Select Product:</mobile:Label><br /><br />
  <mobile:SelectionList id="lstProducts" runat="server" />
  <mobile:Command StyleReference="styListAndLink" runat="server"
          OnClick="AddOrderLine" SoftKeyLabel="Add" Text="Add" />
  <mobile:Link StyleReference="styListAndLink" runat="server"
          NavigateUrl="#frmEditOptions" SoftKeyLabel="Cancel" Text="Cancel" />
</mobile:Form>

<mobile:Form id="frmHidden" runat="server">
  <mobile:Label id="hidCustID" runat="server" />
  <mobile:Label id="hidOrderID" runat="server" />
  <mobile:Label id="hidName" runat="server" />
  <mobile:Label id="hidAddress" runat="server" />
  <mobile:Label id="hidCity" runat="server" />
  <mobile:Label id="hidPostCode" runat="server" />
  <mobile:Label id="hidCountry" runat="server" />
  <mobile:Label id="hidRequired" runat="server" />
  <mobile:Label id="hidShip" runat="server" />
  <mobile:Label id="hidVia" runat="server" />
  <mobile:Label id="hidFreight" runat="server" />
  <mobile:Label id="hidShipperName" runat="server" />
  <mobile:Label id="hidProductID" runat="server" />
  <mobile:Label id="hidQuantity" runat="server" />
  <mobile:Label id="hidUnitPrice" runat="server" />
  <mobile:Label id="hidDiscount" runat="server" />
</mobile:Form>

<mobile:Stylesheet runat="server">

   <Style name="styPage">
      <DeviceSpecific>
         <Choice Filter="IsHTML32">
            <HeaderTemplate>
              <body bgcolor="#ffffacd" style="font-family:Tahoma, Arial, sans-serif; font-size:10pt">
              <font face="Tahoma,Arial,sans-serif (" size="2">
            </HeaderTemplate>
            <FooterTemplate>
              <br /><hr /></font>
              <font face="Tahoma,Arial,sans-serif" size="1">
              <div style="font-family:Tahoma, Arial, sans-serif; font-size:8pt">
              &copy;2003 <a href="http://www.daveandal.com/">
              Dave And Al</a><br /><a target="_top"
              href="http://www.daveandal.com/Books/Book_Details.asp?isbn=1861004923">ASP.NET Distributed Data Applications</a>
              <br /><br />[<a href="../../global/viewsource.aspx?compsrc=updateorders.cs" target="_blank">view page source</a>]</div>
              </font></body>
            </FooterTemplate>
         </Choice>
      </DeviceSpecific>
   </Style>

   <Style name="styHeading">
      <DeviceSpecific>
         <Choice Filter="IsHTML32" Font-Name="Tahoma,Arial,sans-serif" ForeColor="blue" Font-Size="large" Font-Bold="true" />
      </DeviceSpecific>
   </Style>

   <Style name="styListAndLink">
      <DeviceSpecific>
         <Choice Filter="IsHTML32" Font-Name="Tahoma,Arial,sans-serif" ForeColor="black" Font-Size="small" />
      </DeviceSpecific>
   </Style>

</mobile:Stylesheet>

<%//-------------- server-side script section ----------------%>

<script Language="C#" runat="server">

// page-level variables accessed from more than one routine
String strCustID = "";
String strOrderID = "";

//--------------------------------------------------------------
//       event handlers for forms and controls
//--------------------------------------------------------------

void Page_Load() {
// runs when page is first loaded

  if (Page.IsPostBack == true) {

    // collect customer and order IDs from Label controls
    // in "hidden" form frmHidden which is never displayed
    strCustID = hidCustID.Text;
    strOrderID = hidOrderID.Text;
  }
  else {  // loading for the first time

    // destroy any existing DataSet in Session
    Session["4923MobileOrdersDataSet"] = null;

    strCustID = Request.QueryString["customerid"];
    if (strCustID == null || strCustID == "") {

      // display error message
      lblMsg1.Text = "* ERROR: no Customer ID provided";
      cmdInsert.Visible = false;
    }
    else {

       // put customer and order IDs into "hidden" controls
       hidCustID.Text = strCustID;
       hidOrderID.Text = strOrderID;
    }
  }
}
//------------------------------------------------------------

void SelectOrder_Activate(Object objSender, EventArgs objArgs) {
// runs when frmSelectOrder is activated and before it's displayed

  // display list of orders for current customer
  ShowOrders();
}
//------------------------------------------------------------

void EditOptions_Activate(Object objSender, EventArgs objArgs) {
// runs when frmEditOptions is activated and before it"s displayed

  // display order ID
  lblOrderID.Text = "Order ID: " + strOrderID;
}
//------------------------------------------------------------

void ViewOrder_Activate(Object objSender, EventArgs objArgs) {
// runs when frmViewOrder is activated and before it's displayed

  // copy values from "hidden" controls
  lblViewOrderNo.Text = "Order ID: " + strOrderID;
  lblViewNameAddress.Text = hidName.Text + ", " + hidAddress.Text + ", "
      + hidCity.Text + ", " + hidPostCode.Text + ", " + hidCountry.Text;
  lblViewOrdered.Text = lblOrdered.Text;
  lblViewRequired.Text = "Required: " + hidRequired.Text;
  lblViewShipped.Text = "Shipped: " + hidShip.Text;
  lblViewVia.Text = "via: " + hidShipperName.Text;
  lblViewFreight.Text = "Freight: $" + hidFreight.Text;

  // get Orders DataSet using function elsewhere in this page
  DataSet objDataSet = GetOrdersFromSessionOrServer(strCustID);

  // get a DataView for the Order Details table
  DataView objLinesView = objDataSet.Tables["Order Details"].DefaultView;

  // apply filter to DataView to show lines for this order only
  objLinesView.RowFilter = "OrderID=" + strOrderID;

  // set DataSource and bind the List control
  lstLinesSummary.DataSource = objLinesView;
  lstLinesSummary.DataTextField = "DisplayCol";
  lstLinesSummary.DataValueField = "OrderID";
  lstLinesSummary.DataBind();
}
//------------------------------------------------------------

void SelectLine_Activate(Object objSender, EventArgs objArgs) {
// runs when frmSelectLine is activated and before it's displayed

  // get Orders DataSet using function elsewhere in this page
  DataSet objDataSet = GetOrdersFromSessionOrServer(strCustID);

  // get a DataView for the Order Details table
  DataView objLinesView = objDataSet.Tables["Order Details"].DefaultView;

  // apply filter to DataView to show lines for this order only
  objLinesView.RowFilter = "OrderID=" + strOrderID;
  objLinesView.Sort = "ProductName";

  // set DataSource and bind the List control
  lstOrderLines.DataSource = objLinesView;
  lstOrderLines.DataTextField = "ProductName";
  lstOrderLines.DataValueField = "ProductID";
  lstOrderLines.DataBind();

  lblStatus5.Text = "Order ID: " + strOrderID;
}
//--------------------------------------------------------------

void SelectAddProduct_Activate(Object objSender, EventArgs objArgs) {
// runs when frmSelectProduct is activated and before it's displayed
// get list of products from server and fill SelectionList in this form

  // bind list of products to data source to fill in values
  lstProducts.DataSource = GetProductsFromSessionOrServer();
  lstProducts.DataMember = "Products";
  lstProducts.DataTextField = "ProductName";
  lstProducts.DataValueField = "ProductID";
  lstProducts.DataBind();
}
//------------------------------------------------------------

void ShowEditOptions(Object objSender, ListCommandEventArgs objArgs) {
// runs when an order is selected in frmSelectOrder
// inserts Order ID into Label and dislays edit options
// also puts order details into controls in other forms on page

  // get selected Order ID
  strOrderID = objArgs.ListItem.Value;

  // save in "hidden" control in frmHidden for use later
  hidOrderID.Text = strOrderID;

  // fill other form controls with order details
  PopulateOrderDetails(strOrderID);

  // and show this form
  ActiveForm = frmEditOptions;
}
//------------------------------------------------------------

void OrderLineListSelect(Object objSender, ListCommandEventArgs objArgs) {
// runs when a line on the order is clicked in frmSelectLine

  int intOrderID = int.Parse(objArgs.ListItem.Value);
  // fill other form controls with order details
  PopulateOrderLine(intOrderID);

  // display Edit Order Line form
  ActiveForm = frmEditLine;
}
//------------------------------------------------------------

void CalculateFreight(Object objSender, EventArgs objArgs) {
// runs when Calculate Freight command in frmEditDetails is clicked
// update value of Freight column in database and display update

  // get connection string from web.config
  String strConnect = ConfigurationSettings.AppSettings["NorthwindConnectString"];

  // create an instance of the data access component
  UpdateOrders objOrderList = new UpdateOrders(strConnect);

  int intOrderID = int.Parse(strOrderID);

  // call routine in data access component to calculate/update
  // freight cost in Orders table
  if (objOrderList.SetFreightCost(intOrderID) == true)
    lblStatus4.Text = "Freight cost recalculated";
  else
    lblStatus4.Text = "* ERROR: Could not calculate freight cost";

  // remove any cached DataSet from Session and update list
  Session["4923MobileOrdersDataSet"] = null;

  // fill other form controls with order details
  PopulateOrderDetails(strOrderID);
}
//------------------------------------------------------------

void InsertNewOrder(Object objSender, EventArgs objArgs) {
// runs when the Add New Order link in frmSelectOrder is clicked

  // remove any cached DataSet from the Session so that updates
  // are displayed when the page is loaded next time
  Session["4923MobileOrdersDataSet"] = null;

  // get connection string from web.config
  String strConnect = ConfigurationSettings.AppSettings["NorthwindConnectString"];

  // create an instance of the data access component
  UpdateOrders objOrderList = new UpdateOrders(strConnect);

  try {

    int intNewOrderID;

    // call the method to return the data as a DataSet
    intNewOrderID = objOrderList.InsertNewOrder(strCustID);

    strOrderID = intNewOrderID.ToString();

    // display status message and return True
    lblOrderID.Text = "Inserted new order ID: " + strOrderID;

    // save order ID in "hidden" control
    hidOrderID.Text = strOrderID;

    // fill other form controls with order details
    PopulateOrderDetails(strOrderID);

    // display frmEditOptions
    ActiveForm = frmEditOptions;
  }
  catch (Exception objErr) {

    // display error message and return False
    lblOrderMsg.Text = "* ERROR: Cannot insert new order.";
  }
}
//------------------------------------------------------------

void AddOrderLine(Object objSender, EventArgs objArgs) {
// runs when Add product link in frmSelectProduct is clicked
// add product selected in list to order and show in edit mode

  // get selected item index from "Add Product" drop-down list
  int intListIndex = lstProducts.SelectedIndex;

  // get selected product ID from the list
  int intProductID = int.Parse(lstProducts.Items[intListIndex].Value);

  try {

    // get connection string from web.config
    String strConnect = ConfigurationSettings.AppSettings["NorthwindConnectString"];

    // create an instance of the data access component
    UpdateOrders objOrderList = new UpdateOrders(strConnect);

    // convert OrderID string into an Integer
    int intOrderID = int.Parse(strOrderID);

    // call the method to add a new row to the Order Details table
    if (objOrderList.InsertNewOrderLine(intOrderID, intProductID) == true) {

      // remove any cached DataSet from the Session
      Session["4923MobileOrdersDataSet"] = null;

      // fill other form controls with order details
      PopulateOrderLine(intProductID);

      // display Edit Order Line form
      ActiveForm = frmEditLine;
    }
    else {

      lblStatus5.Text = "Failed to add product to order";

      // show form to select order line
      ActiveForm = frmSelectLine;
    }
  }
  catch (Exception objErr) {

      lblStatus5.Text = "*ERROR adding product line. Product may already exist on order";

      // show form to select order line
      ActiveForm = frmSelectLine;
  }
}
//------------------------------------------------------------

void UpdateAddress(Object objSender, EventArgs objArgs) {
// runs when Update link in frmEditAddress is clicked

  // variable to hold status message from function
  String strStatus = String.Empty;

  if (UpdateOrderRow(ref strStatus) == true) {

    // display "Edit Options" form and message
    ActiveForm = frmEditOptions;
    lblOrderID.Text = "Updated Address";
  }
  else
    lblStatus3.Text = strStatus;
}
//------------------------------------------------------------

void UpdateDetails(Object objSender, EventArgs objArgs) {
// runs when Update link in frmEditDetails is clicked

  // variable to hold status message from function
  String strStatus = String.Empty;

  if (UpdateOrderRow(ref strStatus) == true) {

    // display "Edit Options" form and message
    ActiveForm = frmEditOptions;
    lblOrderID.Text = "Updated Details";
  }
  else
    lblStatus4.Text = strStatus;
}
//------------------------------------------------------------

void UpdateOrderLine(Object objSender, EventArgs objArgs) {
// runs when Update link in frmEditLine is clicked

  // get ProductID for current row from "hidden" control
  String strProductID = hidProductID.Text;
  int intProductID = int.Parse(strProductID);

  // convert current OrderID string into an Integer
  int intOrderID = int.Parse(strOrderID);

  // get the current (updated) values from the visible controls in the DataGrid
  String strQuantity = txtQuantity.Text;
  String strUnitPrice = txtUnitPrice.Text;
  String strDiscount = txtDiscount.Text;

  // get the original values from the "hidden" controls in frmHidden
  String strQuantityWas = hidQuantity.Text;
  String strUnitPriceWas = hidUnitPrice.Text;
  String strDiscountWas = hidDiscount.Text;

  // declare variables to hold converted data types
  int intQuantity, intQuantityWas;
  Double dblUnitPrice, dblUnitPriceWas, dblDiscount, dblDiscountWas;

  try {

    // convert String values into correct data types
    intQuantity = int.Parse(strQuantity);
    intQuantityWas = int.Parse(strQuantityWas);
    dblUnitPrice = Double.Parse(strUnitPrice);
    dblUnitPriceWas = Double.Parse(strUnitPriceWas);
    dblDiscount = Double.Parse(strDiscount) / 100;
    dblDiscountWas = Double.Parse(strDiscountWas);
  }
  catch (Exception objErr) {

    lblStatus6.Text = objErr.Message;
    return;
  }

  // destroy any existing DataSet in Session
  Session["4923MobileOrdersDataSet"] = null;

  // get connection string from web.config
  String strConnect = ConfigurationSettings.AppSettings["NorthwindConnectString"];

  // create an instance of the data access component
  UpdateOrders objOrderList = new UpdateOrders(strConnect);

  try {

    int intRows;

    // call function within this page to perform the update
    intRows = objOrderList.SingleOrderLineUpdate(intOrderID,
              intProductID, dblUnitPrice, intQuantity, dblDiscount,
              dblUnitPriceWas, intQuantityWas, dblDiscountWas);

    // see if we got one row updated
    if (intRows == 1) {

      // fill other form controls with order details
      PopulateOrderLine(intProductID);

      // display "Select Order Lines" form and message
      ActiveForm = frmSelectLine;
      lblStatus5.Text = "Updated " + lblProduct.Text;
    }
    else
      lblStatus6.Text = "* ERROR: Could not update order. May be due to changes made by other users";
  }
  catch (Exception objErr) {
    lblStatus6.Text = "* ERROR: Failed to update order";
  }
}
//------------------------------------------------------------

void DeleteOrder(Object objSender, EventArgs objArgs) {
// runs when Delete link in frmEditOptions is clicked

  // get OrderID as an Integer
  int intOrderID = int.Parse(strOrderID);

  // get the original values from the "hidden" controls in frmHidden
  String strRequiredWas = hidRequired.Text;
  String strShippedWas = hidShip.Text;
  String strFreightWas = hidFreight.Text;
  String strShipNameWas = hidName.Text;
  String strAddressWas = hidAddress.Text;
  String strCityWas = hidCity.Text;
  String strPostalCodeWas = hidPostCode.Text;
  String strCountryWas = hidCountry.Text;
  String strShipViaWas = hidVia.Text;

  // declare variables to hold converted data types
  Double dblFreightWas;
  int intShipViaWas;
  Object datRequiredWas = null, datShippedWas = null;

  try {

    // convert String values into correct data types
    // leave Date vales as Null (Nothing) to delete them
    dblFreightWas = Double.Parse(strFreightWas);
    intShipViaWas = int.Parse(strShipViaWas);
    if (strRequiredWas.Length > 0)
      datRequiredWas = DateTime.Parse(strRequiredWas);
    if (strShippedWas.Length > 0)
      datShippedWas = DateTime.Parse(strShippedWas);
  }
  catch (Exception objErr) {
    lblOrderMsg.Text = objErr.Message;
    return;
  }

  // destroy any existing DataSet in Session
  Session["4923MobileOrdersDataSet"] = null;

  // get connection string from web.config
  String strConnect = ConfigurationSettings.AppSettings["NorthwindConnectString"];

  // create an instance of the data access component
  UpdateOrders objOrderList = new UpdateOrders(strConnect);

  try {

    int intRows;

    // call function in data access component to delete the row
    intRows = objOrderList.SingleRowOrderDelete(intOrderID, datRequiredWas,
              datShippedWas, dblFreightWas, strShipNameWas, strAddressWas,
              strCityWas, strPostalCodeWas, strCountryWas, intShipViaWas);

    // see if we got one row deleted
    if (intRows == 1) {

      // display "Select Order" form and message
      ActiveForm = frmSelectOrder;
      lblOrderMsg.Text = "Deleted order " + strOrderID;
    }
    else
      lblOrderMsg.Text = "* ERROR: Could not delete order. May be due to changes made by other users";
  }
  catch (Exception objErr) {
    lblOrderMsg.Text = "* ERROR: Failed to Delete Order";
  }
}
//------------------------------------------------------------

void DeleteOrderLine(Object objSender, EventArgs objArgs) {
// runs when Delete link in frmEditLine is clicked

  // get ProductID for current row from "hidden" control
  String strProductID = hidProductID.Text;
  int intProductID = int.Parse(strProductID);

  // convert current OrderID string into an Integer
  int intOrderID = int.Parse(strOrderID);

  // get the original values from the "hidden" controls in frmHidden
  String strQuantityWas = hidQuantity.Text;
  String strUnitPriceWas = hidUnitPrice.Text;
  String strDiscountWas = hidDiscount.Text;

  // declare variables to hold converted data types
  int intQuantityWas = int.Parse(strQuantityWas);
  Double dblUnitPriceWas = Double.Parse(strUnitPriceWas);
  Double dblDiscountWas = Double.Parse(strDiscountWas);

  // remove any cached DataSet from the Session so that updates
  // are displayed when the page is loaded next time
  Session["4923MobileOrdersDataSet"] = null;

  // get connection string from web.config
  String strConnect = ConfigurationSettings.AppSettings["NorthwindConnectString"];

  // create an instance of the data access component
  UpdateOrders objOrderList = new UpdateOrders(strConnect);

  try {

    int intRows;

    // call function in data access component to delete the row
    intRows = objOrderList.SingleOrderLineDelete(intOrderID,
                intProductID, dblUnitPriceWas, intQuantityWas,
                dblDiscountWas);

    // see if we got one row deleted
    if (intRows == 1) {

      // display "Select Order Lines" form and message
      ActiveForm = frmSelectLine;
      lblStatus5.Text = "Deleted " + lblProduct.Text;
    }
    else
      lblStatus6.Text = "* ERROR: Could not delete product. May be due to changes made by other users";
  }
  catch (Exception objErr) {
      lblStatus6.Text = "* ERROR: Failed to delete product";
  }
}
//--------------------------------------------------------------
//        functions and routines used in the code above
//--------------------------------------------------------------

void ShowOrders() {
// displays list of all orders for this customer in List control

  // get Orders DataSet using function elsewhere in this page
  DataSet objDataSet = GetOrdersFromSessionOrServer(strCustID);

  if (objDataSet == null) {

    lblOrderMsg.Text = "* ERROR - cannot access database";
    cmdInsert.Visible = false;
  }
  else {

    // display current customer ID
    lblOrderMsg.Text = "Customer '" + strCustID + "'";

    // get a DataView for the Orders table
    DataView objLinesView = objDataSet.Tables["Orders"].DefaultView;

    // remove any filter from DataView
    objLinesView.RowFilter = "";
    objLinesView.Sort = "OrderID";

    // set DataSource and bind the List control
    lstOrders.DataSource = objLinesView;
    lstOrders.DataTextField = "DisplayCol";
    lstOrders.DataValueField = "OrderID";
    lstOrders.DataBind();
  }
}
//------------------------------------------------------------

void PopulateOrderDetails(String strOrderID) {
// gets values for selected order from DataSet and fills in the
// visible and hidden controls on the page with these values

  // get Orders DataSet using function elsewhere in this page
  DataSet objDataSet = GetOrdersFromSessionOrServer(strCustID);

  // get a DataView for the Orders table
  DataView objLinesView = objDataSet.Tables["Orders"].DefaultView;

  // specify sort order for Find method to use
  objLinesView.Sort = "OrderID";

  // find row for this order using OrderID
  int intRowIndex = objLinesView.Find(strOrderID);

  // put values into visible controls on this form
  txtName.Text = objLinesView[intRowIndex]["ShipName"].ToString();
  txtAddress.Text = objLinesView[intRowIndex]["ShipAddress"].ToString();
  txtCity.Text = objLinesView[intRowIndex]["ShipCity"].ToString();
  txtPostCode.Text = objLinesView[intRowIndex]["ShipPostalCode"].ToString();
  txtCountry.Text = objLinesView[intRowIndex]["ShipCountry"].ToString();
  DateTime datOrdered = DateTime.Parse(objLinesView[intRowIndex]["OrderDate"].ToString());
  lblOrdered.Text = "Ordered: " + datOrdered.ToString("d");
  if (objLinesView[intRowIndex]["RequiredDate"] == DBNull.Value)
    txtRequired.Text = "";
  else {
    DateTime datRequired = DateTime.Parse(objLinesView[intRowIndex]["RequiredDate"].ToString());
    txtRequired.Text = datRequired.ToString("d");
  }
  if (objLinesView[intRowIndex]["ShippedDate"] == DBNull.Value)
    txtShip.Text = "";
  else {
    DateTime datShipped = DateTime.Parse(objLinesView[intRowIndex]["ShippedDate"].ToString());
    txtShip.Text = datShipped.ToString("d");
  }
  Double dblFreight = Double.Parse(objLinesView[intRowIndex]["Freight"].ToString());
  txtFreight.Text = dblFreight.ToString("N2");

  // bind shippers list to DataSet returned by function elsewhere in page
  lstVia.DataSource = GetShippersFromSessionOrServer();
  lstVia.DataTextField = "ShipperName";
  lstVia.DataValueField = "ShipperID";
  lstVia.DataBind();

  // get Shipper ID for this order from DataView
  int intShipperID = (int) objLinesView[intRowIndex]["ShipVia"];

  // select current shipper for this order in list
  foreach (MobileListItem objItem in lstVia.Items) {
    if (objItem.Value == intShipperID.ToString()) objItem.Selected = true;
  }

  // put same values into hidden controls in frmHidden
  // to be used as original values when updating
  hidName.Text = txtName.Text;
  hidAddress.Text = txtAddress.Text;
  hidCity.Text = txtCity.Text;
  hidPostCode.Text = txtPostCode.Text;
  hidCountry.Text = txtCountry.Text;
  hidRequired.Text = txtRequired.Text;
  hidShip.Text = txtShip.Text;
  hidVia.Text = intShipperID.ToString();
  hidShipperName.Text = objLinesView[intRowIndex]["ShipperName"].ToString();
  hidFreight.Text = txtFreight.Text;
}
//------------------------------------------------------------

void PopulateOrderLine(int intProductID) {
// gets values for selected order line from DataSet and fills in the
// visible and hidden controls on the page with these values

  // get Orders DataSet using function elsewhere in this page
  DataSet objDataSet = GetOrdersFromSessionOrServer(strCustID);

  // get a DataView for the Order Details table
  DataView objLinesView = objDataSet.Tables["Order Details"].DefaultView;

  // remove any filter from DataView
  objLinesView.RowFilter = "";

  // specify sort order for Find method to use
  objLinesView.Sort = "ProductID";

  // find row for this order using OrderID
  int intRowIndex = objLinesView.Find(intProductID);

  // put values from row into controls on frmEditLine
  lblProduct.Text = objLinesView[intRowIndex]["ProductName"].ToString();
  txtQuantity.Text = objLinesView[intRowIndex]["Quantity"].ToString();
  Double dblUnitPrice = Double.Parse(objLinesView[intRowIndex]["UnitPrice"].ToString());
  txtUnitPrice.Text = dblUnitPrice.ToString("N2");
  Double dblUnitDiscount = Double.Parse(objLinesView[intRowIndex]["Discount"].ToString());
  dblUnitDiscount *= 100;
  txtDiscount.Text = dblUnitDiscount.ToString("N2");
  Double dblTotalValue = Double.Parse(objLinesView[intRowIndex]["LineTotal"].ToString());
  lblLineTotal.Text = "Line Total: $" + dblTotalValue.ToString("N2");

  // copy original values into "hidden" form labels
  hidProductID.Text = objLinesView[intRowIndex]["ProductID"].ToString();
  hidQuantity.Text = txtQuantity.Text;
  hidUnitPrice.Text = txtUnitPrice.Text;
  hidDiscount.Text = objLinesView[intRowIndex]["Discount"].ToString();
}
//------------------------------------------------------------

Boolean UpdateOrderRow(ref String strStatus) {
// routine called to perform update to address and shipping details
// returns status or error message as a String and Boolean flag

  // get OrderID as an Integer
  int intOrderID = int.Parse(strOrderID);

  // get the current (updated) values from the visible controls
  String strRequired = txtRequired.Text;
  String strShipped = txtShip.Text;
  String strFreight = txtFreight.Text;
  String strShipName = txtName.Text;
  String strAddress = txtAddress.Text;
  String strCity = txtCity.Text;
  String strPostalCode = txtPostCode.Text;
  String strCountry = txtCountry.Text;
  String strShipVia = lstVia.Items[lstVia.SelectedIndex].Value;

  // get the original values from the "hidden" controls
  String strRequiredWas = hidRequired.Text;
  String strShippedWas = hidShip.Text;
  String strFreightWas = hidFreight.Text;
  String strShipNameWas = hidName.Text;
  String strAddressWas = hidAddress.Text;
  String strCityWas = hidCity.Text;
  String strPostalCodeWas = hidPostCode.Text;
  String strCountryWas = hidCountry.Text;
  String strShipViaWas = hidVia.Text;

  // declare variables to hold converted data types
  Double dblFreight, dblFreightWas;
  int intShipVia, intShipViaWas;
  Object datRequired = null, datRequiredWas = null;
  Object datShipped = null, datShippedWas = null;

  try {

    // convert String values into correct data types
    // leave Date vales as Null (Nothing) to delete them
    dblFreight = Double.Parse(strFreight);
    intShipVia = int.Parse(strShipVia);
    dblFreightWas = Double.Parse(strFreightWas);
    intShipViaWas = int.Parse(strShipViaWas);
    if (strRequired.Length > 0)
      datRequired = DateTime.Parse(strRequired);
    if (strRequiredWas.Length > 0)
      datRequiredWas = DateTime.Parse(strRequiredWas);
    if (strShipped.Length > 0)
      datShipped = DateTime.Parse(strShipped);
    if (strShippedWas.Length > 0)
      datShippedWas = DateTime.Parse(strShippedWas);
  }
  catch (Exception objErr) {
    strStatus = objErr.Message;
    return false;
  }

  // remove any cached DataSet from the Session
  Session["4923MobileOrdersDataSet"] = null;

  // get connection string from web.config
  String strConnect = ConfigurationSettings.AppSettings["NorthwindConnectString"];

  // create an instance of the data access component
  UpdateOrders objOrderList = new UpdateOrders(strConnect);

  try {

    int intRows;

    // call function within this page to perform the update
    intRows = objOrderList.SingleRowOrderUpdate(intOrderID, datRequired,
              datShipped, dblFreight, strShipName, strAddress, strCity,
              strPostalCode, strCountry, intShipVia, datRequiredWas,
              datShippedWas, dblFreightWas, strShipNameWas, strAddressWas,
              strCityWas, strPostalCodeWas, strCountryWas, intShipViaWas);

    // see if we got one row updated
    if (intRows == 1) {

     // fill other form controls with order details
     PopulateOrderDetails(strOrderID);
     return true;
    }
    else
      strStatus = "* ERROR: Could not update order. May be due to changes made by other users";
      return false;
  }
  catch (Exception objErr) {
    strStatus = "* ERROR: Failed to Update Order.";
    return false;
  }
}
//------------------------------------------------------------

DataSet GetOrdersFromSessionOrServer(String strCustID) {
// gets a DataSet containing all orders for this customer

  try {

    DataSet objDataSet = null;

    // try and get DataSet from user's Session
    objDataSet = (DataSet) Session["4923MobileOrdersDataSet"];

    if (objDataSet == null) {  // not in Session

      // get connection string from web.config
      String strConnect = ConfigurationSettings.AppSettings["NorthwindConnectString"];

      // create an instance of the data access component
      UpdateOrders objOrderList = new UpdateOrders(strConnect);

      // call the method to return the data as a DataSet
      objDataSet = objOrderList.GetOrderDetails(strCustID);

      // get a reference to the "Orders" table in the DataSet
      DataTable objTable = objDataSet.Tables["Orders"];

      // add a column containing the order ID and date as one string value
      DataColumn objColumn = objTable.Columns.Add("DisplayCol", System.Type.GetType("System.String"));

      // fill in this column for each row with "#{order number} - {order date}"
      DateTime objDate;
      foreach (DataRow objRow in objTable.Rows) {
        objDate = (DateTime) objRow["OrderDate"];
        objRow["DisplayCol"] = "#" + objRow["OrderID"].ToString() + " - " + objDate.ToString("d");
      }

      // get a reference to the "Order Details" table in the DataSet
      DataTable objLinesTable = objDataSet.Tables["Order Details"];

      // add a column containing the total value of each line
      objColumn = objLinesTable.Columns.Add("LineTotal", System.Type.GetType("System.Double"));
      objColumn.Expression = "[Quantity] * ([UnitPrice] - ([UnitPrice] * [Discount]))";

      // add a column containing the order details as one string value
      objColumn = objLinesTable.Columns.Add("DisplayCol", System.Type.GetType("System.String"));

      // fill in this column for each row as "qty x product (pack) @ price less discount = total"
      String strColValue;
      float fPrice, fDiscount;
      Double dblTotal;
      foreach (DataRow objRow in objLinesTable.Rows) {
        fPrice = float.Parse(objRow["UnitPrice"].ToString());
        strColValue = objRow["Quantity"].ToString() + " x " + objRow["ProductName"].ToString()
                    + " (" + objRow["QtyPerUnit"].ToString() + ") @ " + fPrice.ToString("$#0.00");
        fDiscount = (float) objRow["Discount"];
        if (fDiscount > 0)
          strColValue += " Less " + fDiscount.ToString("P");
        dblTotal = (Double) objRow["LineTotal"];
        objRow["DisplayCol"] = strColValue + " = " + dblTotal.ToString("$#0.00");
      }

      // save DataSet in Session for next order inquiry
      Session["4923MobileOrdersDataSet"] = objDataSet;
    }
    return objDataSet;
  }
  catch (Exception objError) {
    return null;
  }
}
//--------------------------------------------------------------

DataSet GetShippersFromSessionOrServer() {
// gets a DataSet containing the list of Shippers

  try {

    DataSet objDataSet = null;

    // try and get DataSet from user's Session
    objDataSet = (DataSet) Session["4923MobileShippersDataSet"];

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
      Session["4923MobileShippersDataSet"] = objDataSet;
    }
    return objDataSet;
  }
  catch {
    return null;
  }
}
//--------------------------------------------------------------

DataSet GetProductsFromSessionOrServer() {
// gets a DataSet containing the list of Products

  try {

    DataSet objDataSet = null;

    // try { and get DataSet from user's Session
    objDataSet = (DataSet) Session["4923MobileProductsDataSet"];

    if (objDataSet == null) {   // not in Session

      // get connection string from web.config
      String strConnect = ConfigurationSettings.AppSettings["NorthwindConnectString"];

      // create an instance of the data access component
      UpdateOrders objOrderList = new UpdateOrders(strConnect);

      // call the method to return the data as a DataSet
      objDataSet = objOrderList.GetProductsDataSet();

      // save DataSet in Session for next order inquiry
      Session["4923MobileProductsDataSet"] = objDataSet;
    }
    return objDataSet;
  }
  catch {
    return null;
  }
}

</script>

<!---------------------------------------------------------->
