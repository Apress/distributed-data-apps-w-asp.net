<%@Page Inherits="System.Web.UI.MobileControls.MobilePage" Language="VB" %>
<%@Register TagPrefix="Mobile" Namespace="System.Web.UI.MobileControls" Assembly="System.Web.Mobile"%>
<%@Import Namespace="DDA4923OrderUpdate" %>
<%@Import Namespace="System.Data" %>

<%'----------- visible panels content ----------------------%>

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

<%'----------- stylesheets for panels ----------------------%>

<mobile:Stylesheet runat="server">

   <Style name="styPage">
      <DeviceSpecific>
         <Choice Filter="IsHTML32">
            <HeaderTemplate>
              <body bgcolor="#ffffacd" style="font-family:Tahoma, Arial, sans-serif; font-size:10pt">
              <font face="Tahoma,Arial,sans-serif" size="2">
            </HeaderTemplate>
            <FooterTemplate>
              <br /><hr /></font>
              <font face="Tahoma,Arial,sans-serif" size="1">
              <div style="font-family:Tahoma, Arial, sans-serif; font-size:8pt">
              &copy;2003 <a href="http://www.daveandal.com/">
              Dave And Al</a><br /><a target="_top"
              href="http://www.daveandal.net/books/4923">ASP.NET Distributed Data Applications</a>
              <br /><br />[<a href="../../global/viewsource.aspx">view page source</a>]</div>
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

<%'-------------- server-side script section ----------------%>

<script language="VB" runat="server">

'page-level variables accessed from more than one routine
Dim strCustID As String = ""
Dim strOrderID As String = ""

'--------------------------------------------------------------
'       event handlers for forms and controls
'--------------------------------------------------------------

Sub Page_Load()
'runs when page is first loaded

  If Page.IsPostBack Then

    'collect customer and order IDs from Label controls
    'in "hidden" form frmHidden which is never displayed
    strCustID = hidCustID.Text
    strOrderID = hidOrderID.Text

  Else   'loading for the first time

    'destroy any existing DataSet in Session
    Session("4923MobileOrdersDataSet") = Nothing

    strCustID = Request.QueryString("customerid")
    If (strCustID Is Nothing) Or (strCustID = "")

      'display error message
      lblMsg1.Text = "* ERROR: no Customer ID provided"
      cmdInsert.Visible = False

    Else

       'put customer and order IDs into "hidden" controls
       hidCustID.Text = strCustID
       hidOrderID.Text = strOrderID

    End If

  End If

End Sub

'------------------------------------------------------------

Sub SelectOrder_Activate(objSender As Object, objArgs As EventArgs)
'runs when frmSelectOrder is activated and before it's displayed

  'display list of orders for current customer
  ShowOrders()

End Sub

'------------------------------------------------------------

Sub EditOptions_Activate(objSender As Object, objArgs As EventArgs)
'runs when frmEditOptions is activated and before it's displayed

  'display order ID
  lblOrderID.Text = "Order ID: " & strOrderID

End Sub

'------------------------------------------------------------

Sub ViewOrder_Activate(objSender As Object, objArgs As EventArgs)
'runs when frmViewOrder is activated and before it's displayed

  'copy values from "hidden" controls
  lblViewOrderNo.Text = "Order ID: " & strOrderID
  lblViewNameAddress.Text = hidName.Text & ", " & hidAddress.Text _
                  & ", " & hidCity.Text & ", " & hidPostCode.Text _
                  & ", " & hidCountry.Text
  lblViewOrdered.Text = lblOrdered.Text
  lblViewRequired.Text = "Required: " & hidRequired.Text
  lblViewShipped.Text = "Shipped: " & hidShip.Text
  lblViewVia.Text = "via: " & hidShipperName.Text
  lblViewFreight.Text = "Freight: $" & hidFreight.Text

  'get Orders DataSet using function elsewhere in this page
  Dim objDataSet As DataSet = GetOrdersFromSessionOrServer(strCustID)

  'get a DataView for the Order Details table
  Dim objLinesView As DataView = objDataSet.Tables("Order Details").DefaultView

  'apply filter to DataView to show lines for this order only
  objLinesView.RowFilter = "OrderID=" & strOrderID

  'set DataSource and bind the List control
  lstLinesSummary.DataSource = objLinesView
  lstLinesSummary.DataTextField = "DisplayCol"
  lstLinesSummary.DataValueField = "OrderID"
  lstLinesSummary.DataBind()

End Sub

'------------------------------------------------------------

Sub SelectLine_Activate(objSender As Object, objArgs As EventArgs)
'runs when frmSelectLine is activated and before it's displayed

  'get Orders DataSet using function elsewhere in this page
  Dim objDataSet As DataSet = GetOrdersFromSessionOrServer(strCustID)

  'get a DataView for the Order Details table
  Dim objLinesView As DataView = objDataSet.Tables("Order Details").DefaultView

  'apply filter to DataView to show lines for this order only
  objLinesView.RowFilter = "OrderID=" & strOrderID
  objLinesView.Sort = "ProductName"

  'set DataSource and bind the List control
  lstOrderLines.DataSource = objLinesView
  lstOrderLines.DataTextField = "ProductName"
  lstOrderLines.DataValueField = "ProductID"
  lstOrderLines.DataBind()

  lblStatus5.Text = "Order ID: " & strOrderID

End Sub

'--------------------------------------------------------------

Sub SelectAddProduct_Activate(objSender As Object, objArgs As EventArgs)
'runs when frmSelectProduct is activated and before it's displayed
'get list of products from server and fill SelectionList in this form

  'bind list of products to data source to fill in values
  lstProducts.DataSource = GetProductsFromSessionOrServer()
  lstProducts.DataMember = "Products"
  lstProducts.DataTextField = "ProductName"
  lstProducts.DataValueField = "ProductID"
  lstProducts.DataBind()

End Sub

'------------------------------------------------------------

Sub ShowEditOptions(objSender As Object, objArgs As ListCommandEventArgs)
'runs when an order is selected in frmSelectOrder
'inserts Order ID into Label and dislays edit options
'also puts order details into controls in other forms on page

  'get selected Order ID
  strOrderID = objArgs.ListItem.Value

  'save in "hidden" control in frmHidden for use later
  hidOrderID.Text = strOrderID

  'fill other form controls with order details
  PopulateOrderDetails(strOrderID)

  'and show this form
  ActiveForm = frmEditOptions

End Sub

'------------------------------------------------------------

Sub OrderLineListSelect(objSender As Object, objArgs As ListCommandEventArgs)
'runs when a line on the order is clicked in frmSelectLine

  'fill other form controls with order details
  PopulateOrderLine(objArgs.ListItem.Value)

  'display Edit Order Line form
  ActiveForm = frmEditLine

End Sub

'------------------------------------------------------------

Sub CalculateFreight(objSender As Object, objArgs As EventArgs)
'runs when Calculate Freight command in frmEditDetails is clicked
'update value of Freight column in database and display update

  'get connection string from web.config
  Dim strConnect As String
  strConnect = ConfigurationSettings.AppSettings("NorthwindConnectString")

  'create an instance of the data access component
  Dim objOrderList As New DDA4923OrderUpdate.UpdateOrders(strConnect)

  Dim intOrderID = Integer.Parse(strOrderID)

  'call routine in data access component to calculate/update
  'freight cost in Orders table
  If objOrderList.SetFreightCost(intOrderID) Then
    lblStatus4.Text = "Freight cost recalculated"
  Else
    lblStatus4.Text = "* ERROR: Could not calculate freight cost"
  End If

  'remove any cached DataSet from Session and update list
  Session("4923MobileOrdersDataSet") = Nothing

  'fill other form controls with order details
  PopulateOrderDetails(strOrderID)

End Sub

'------------------------------------------------------------

Sub InsertNewOrder(objSender As Object, objArgs As EventArgs)
'runs when the Add New Order link in frmSelectOrder is clicked

  'remove any cached DataSet from the Session so that updates
  'are displayed when the page is loaded next time
  Session("4923MobileOrdersDataSet") = Nothing

  'get connection string from web.config
  Dim strConnect As String
  strConnect = ConfigurationSettings.AppSettings("NorthwindConnectString")

  'create an instance of the data access component
  Dim objOrderList As New DDA4923OrderUpdate.UpdateOrders(strConnect)

  Try

    Dim intNewOrderID As Integer

    'call the method to return the data as a DataSet
    intNewOrderID = objOrderList.InsertNewOrder(strCustID)

    strOrderID = intNewOrderID.ToString()

    'display status message and return True
    lblOrderID.Text = "Inserted new order ID: " _
                   & strOrderID

    'save order ID in "hidden" control
    hidOrderID.Text = strOrderID

    'fill other form controls with order details
    PopulateOrderDetails(strOrderID)

    'display frmEditOptions
    ActiveForm = frmEditOptions

  Catch objErr As Exception

    'display error message and return False
    lblOrderMsg.Text = "* ERROR: Cannot insert new order."

  End Try

End Sub

'------------------------------------------------------------

Sub AddOrderLine(objSender As Object, objArgs As EventArgs)
'runs when Add product link in frmSelectProduct is clicked
'add product selected in list to order and show in edit mode

  'get selected item index from "Add Product" drop-down list
  Dim intListIndex As Integer = lstProducts.SelectedIndex

  'get selected product ID from the list
  Dim intProductID As Integer = CType(lstProducts.Items(intListIndex).Value, Integer)

  Try

    'get connection string from web.config
    Dim strConnect As String
    strConnect = ConfigurationSettings.AppSettings("NorthwindConnectString")

    'create an instance of the data access component
    Dim objOrderList As New DDA4923OrderUpdate.UpdateOrders(strConnect)

    'convert OrderID string into an Integer
    Dim intOrderID As Integer = CType(strOrderID, Integer)

    'call the method to add a new row to the Order Details table
    If objOrderList.InsertNewOrderLine(intOrderID, intProductID) = True Then

      'remove any cached DataSet from the Session
      Session("4923MobileOrdersDataSet") = Nothing

      'fill other form controls with order details
      PopulateOrderLine(intProductID)

      'display Edit Order Line form
      ActiveForm = frmEditLine

    Else

      lblStatus5.Text = "Failed to add product to order"

      'show form to select order line
      ActiveForm = frmSelectLine

    End If

  Catch objErr As Exception

      lblStatus5.Text = "*ERROR adding product line. Product may already exist on order"

      'show form to select order line
      ActiveForm = frmSelectLine

  End Try

End Sub

'------------------------------------------------------------

Sub UpdateAddress(objSender As Object, objArgs As EventArgs)
'runs when Update link in frmEditAddress is clicked

  'variable to hold status message from function
  Dim strStatus As String

  If UpdateOrderRow(strStatus) = True Then

    'display "Edit Options" form and message
    ActiveForm = frmEditOptions
    lblOrderID.Text = "Updated Address"

  Else

    lblStatus3.Text = strStatus

  End If

End Sub

'------------------------------------------------------------

Sub UpdateDetails(objSender As Object, objArgs As EventArgs)
'runs when Update link in frmEditDetails is clicked

  'variable to hold status message from function
  Dim strStatus As String

  If UpdateOrderRow(strStatus) = True Then

    'display "Edit Options" form and message
    ActiveForm = frmEditOptions
    lblOrderID.Text = "Updated Details"

  Else

    lblStatus4.Text = strStatus

  End If

End Sub

'------------------------------------------------------------

Sub UpdateOrderLine(objSender As Object, objArgs As EventArgs)
'runs when Update link in frmEditLine is clicked

  'get ProductID for current row from "hidden" control
  Dim strProductID As String = hidProductID.Text
  Dim intProductID As Integer = Integer.Parse(strProductID)

  'convert current OrderID string into an Integer
  Dim intOrderID As Integer = Integer.Parse(strOrderID)

  'get the current (updated) values from the visible controls in the DataGrid
  Dim strQuantity As String = txtQuantity.Text
  Dim strUnitPrice As String = txtUnitPrice.Text
  Dim strDiscount As String = txtDiscount.Text

  'get the original values from the "hidden" controls in frmHidden
  Dim strQuantityWas As String = hidQuantity.Text
  Dim strUnitPriceWas As String = hidUnitPrice.Text
  Dim strDiscountWas As String = hidDiscount.Text

  'declare variables to hold converted data types
  Dim intQuantity, intQuantityWas As Integer
  Dim dblUnitPrice, dblUnitPriceWas As Double
  Dim dblDiscount, dblDiscountWas As Double

  Try

    'convert String values into correct data types
    intQuantity = Integer.Parse(strQuantity)
    intQuantityWas = Integer.Parse(strQuantityWas)
    dblUnitPrice = Double.Parse(strUnitPrice)
    dblUnitPriceWas = Double.Parse(strUnitPriceWas)
    dblDiscount = Double.Parse(strDiscount) / 100
    dblDiscountWas = Double.Parse(strDiscountWas)

  Catch objErr As Exception

    lblStatus6.Text = objErr.Message
    Exit Sub

  End Try

  'destroy any existing DataSet in Session
  Session("4923MobileOrdersDataSet") = Nothing

  'get connection string from web.config
  Dim strConnect As String
  strConnect = ConfigurationSettings.AppSettings("NorthwindConnectString")

  'create an instance of the data access component
  Dim objOrderList As New DDA4923OrderUpdate.UpdateOrders(strConnect)

  Try

    Dim intRows As Integer

    'call function within this page to perform the update
    intRows = objOrderList.SingleOrderLineUpdate(intOrderID, _
              intProductID, dblUnitPrice, intQuantity, dblDiscount, _
              dblUnitPriceWas, intQuantityWas, dblDiscountWas)

    'see if we got one row updated
    If intRows = 1 Then

      'fill other form controls with order details
      PopulateOrderLine(intProductID)

      'display "Select Order Lines" form and message
      ActiveForm = frmSelectLine
      lblStatus5.Text = "Updated " & lblProduct.Text

    Else

      lblStatus6.Text = "* ERROR: Could not update order. May be due to changes made by other users"

    End If

  Catch objErr As Exception

    lblStatus6.Text = "* ERROR: Failed to update order"

  End Try

End Sub

'------------------------------------------------------------

Sub DeleteOrder(objSender As Object, objArgs As EventArgs)
'runs when Delete link in frmEditOptions is clicked

  'get OrderID as an Integer
  Dim intOrderID As Integer = Integer.Parse(strOrderID)

  'get the original values from the "hidden" controls in frmHidden
  Dim strRequiredWas As String = hidRequired.Text
  Dim strShippedWas As String = hidShip.Text
  Dim strFreightWas As String = hidFreight.Text
  Dim strShipNameWas As String = hidName.Text
  Dim strAddressWas As String = hidAddress.Text
  Dim strCityWas As String = hidCity.Text
  Dim strPostalCodeWas As String = hidPostCode.Text
  Dim strCountryWas As String = hidCountry.Text
  Dim strShipViaWas As String = hidVia.Text

  'declare variables to hold converted data types
  Dim dblFreightWas As Double
  Dim intShipViaWas As Integer
  Dim datRequiredWas, datShippedWas As DateTime

  Try

    'convert String values into correct data types
    'leave Date vales as Null (Nothing) to delete them
    dblFreightWas = Double.Parse(strFreightWas)
    intShipViaWas = Integer.Parse(strShipViaWas)
    If strRequiredWas.Length > 0 Then
      datRequiredWas = DateTime.Parse(strRequiredWas)
    End If
    If strShippedWas.Length > 0 Then
      datShippedWas = DateTime.Parse(strShippedWas)
    End If

  Catch objErr As Exception

    lblOrderMsg.Text = objErr.Message
    Exit Sub

  End Try

  'destroy any existing DataSet in Session
  Session("4923MobileOrdersDataSet") = Nothing

  'get connection string from web.config
  Dim strConnect As String
  strConnect = ConfigurationSettings.AppSettings("NorthwindConnectString")

  'create an instance of the data access component
  Dim objOrderList As New DDA4923OrderUpdate.UpdateOrders(strConnect)

  Try

    Dim intRows As Integer

    'call function in data access component to delete the row
    intRows = objOrderList.SingleRowOrderDelete(intOrderID, datRequiredWas, _
              datShippedWas, dblFreightWas, strShipNameWas, strAddressWas, _
              strCityWas, strPostalCodeWas, strCountryWas, intShipViaWas)

    'see if we got one row deleted
    If intRows = 1 Then

      'display "Select Order" form and message
      ActiveForm = frmSelectOrder
      lblOrderMsg.Text = "Deleted order " & strOrderID

    Else

      lblOrderMsg.Text = "* ERROR: Could not delete order. May be due to changes made by other users"

    End If

  Catch objErr As Exception

    lblOrderMsg.Text = "* ERROR: Failed to Delete Order"

  End Try

End Sub

'------------------------------------------------------------

Sub DeleteOrderLine(objSender As Object, objArgs As EventArgs)
'runs when Delete link in frmEditLine is clicked

  'get ProductID for current row from "hidden" control
  Dim strProductID As String = hidProductID.Text
  Dim intProductID As Integer = Integer.Parse(strProductID)

  'convert current OrderID string into an Integer
  Dim intOrderID As Integer = CType(strOrderID, Integer)

  'get the original values from the "hidden" controls in frmHidden
  Dim strQuantityWas As String = hidQuantity.Text
  Dim strUnitPriceWas As String = hidUnitPrice.Text
  Dim strDiscountWas As String = hidDiscount.Text

  'declare variables to hold converted data types
  Dim intQuantityWas As Integer = Integer.Parse(strQuantityWas)
  Dim dblUnitPriceWas As Double = Double.Parse(strUnitPriceWas)
  Dim dblDiscountWas As Double = Double.Parse(strDiscountWas)

  'remove any cached DataSet from the Session so that updates
  'are displayed when the page is loaded next time
  Session("4923MobileOrdersDataSet") = Nothing

  'get connection string from web.config
  Dim strConnect As String
  strConnect = ConfigurationSettings.AppSettings("NorthwindConnectString")

  'create an instance of the data access component
  Dim objOrderList As New DDA4923OrderUpdate.UpdateOrders(strConnect)

  Try

    Dim intRows As Integer

    'call function in data access component to delete the row
    intRows = objOrderList.SingleOrderLineDelete(intOrderID, _
                intProductID, dblUnitPriceWas, intQuantityWas, _
                dblDiscountWas)

    'see if we got one row deleted
    If intRows = 1 Then

      'display "Select Order Lines" form and message
      ActiveForm = frmSelectLine
      lblStatus5.Text = "Deleted " & lblProduct.Text

    Else

      lblStatus6.Text = "* ERROR: Could not delete product. May be due to changes made by other users"

    End If

  Catch objErr As Exception

      lblStatus6.Text = "* ERROR: Failed to delete product"

  End Try

End Sub

'--------------------------------------------------------------
'        functions and routines used in the code above
'--------------------------------------------------------------

Sub ShowOrders()
'displays list of all orders for this customer in List control


  'get Orders DataSet using function elsewhere in this page
  Dim objDataSet As DataSet = GetOrdersFromSessionOrServer(strCustID)

  If objDataSet Is Nothing Then

    lblOrderMsg.Text = "* ERROR - cannot access database"
    cmdInsert.Visible = False

  Else

    'display current customer ID
    lblOrderMsg.Text = "Customer '" & strCustID & "'"

    'get a DataView for the Orders table
    Dim objLinesView As DataView = objDataSet.Tables("Orders").DefaultView

    'remove any filter from DataView
    objLinesView.RowFilter = ""
    objLinesView.Sort = "OrderID"

    'set DataSource and bind the List control
    lstOrders.DataSource = objLinesView
    lstOrders.DataTextField = "DisplayCol"
    lstOrders.DataValueField = "OrderID"
    lstOrders.DataBind()

  End If

End Sub

'------------------------------------------------------------

Sub PopulateOrderDetails(strOrderID)
'gets values for selected order from DataSet and fills in the
'visible and hidden controls on the page with these values

  'get Orders DataSet using function elsewhere in this page
  Dim objDataSet As DataSet = GetOrdersFromSessionOrServer(strCustID)

  'get a DataView for the Orders table
  Dim objLinesView As DataView = objDataSet.Tables("Orders").DefaultView

  'specify sort order for Find method to use
  objLinesView.Sort = "OrderID"

  'find row for this order using OrderID
  Dim intRowIndex As Integer = objLinesView.Find(strOrderID)

  'put values into visible controls on this form
  txtName.Text = objLinesView(intRowIndex)("ShipName")
  txtAddress.Text = objLinesView(intRowIndex)("ShipAddress")
  txtCity.Text = objLinesView(intRowIndex)("ShipCity")
  txtPostCode.Text = objLinesView(intRowIndex)("ShipPostalCode")
  txtCountry.Text = objLinesView(intRowIndex)("ShipCountry")
  Dim datOrdered As DateTime = objLinesView(intRowIndex)("OrderDate")
  lblOrdered.Text = "Ordered: " & datOrdered.ToString("d")
  If objLinesView(intRowIndex)("RequiredDate") Is DBNull.Value Then
    txtRequired.Text = ""
  Else
    Dim datRequired As DateTime = objLinesView(intRowIndex)("RequiredDate")
    txtRequired.Text = datRequired.ToString("d")
  End If
  If objLinesView(intRowIndex)("ShippedDate") Is DBNull.Value Then
    txtShip.Text = ""
  Else
    Dim datShipped As DateTime = objLinesView(intRowIndex)("ShippedDate")
    txtShip.Text = datShipped.ToString("d")
  End If
  Dim dblFreight As Double = objLinesView(intRowIndex)("Freight")
  txtFreight.Text = dblFreight.ToString("N2")

  'bind shippers list to DataSet returned by function elsewhere in page
  lstVia.DataSource = GetShippersFromSessionOrServer()
  lstVia.DataTextField = "ShipperName"
  lstVia.DataValueField = "ShipperID"
  lstVia.DataBind()

  'get Shipper ID for this order from DataView
  Dim intShipperID As Integer = objLinesView(intRowIndex)("ShipVia")

  'select current shipper for this order in list
  Dim objItem As MobileListItem
  For Each objItem In lstVia.Items
    If objItem.Value = intShipperID Then
      objItem.Selected = True
    End If
  Next

  'put same values into hidden controls in frmHidden
  'to be used as original values when updating
  hidName.Text = txtName.Text
  hidAddress.Text = txtAddress.Text
  hidCity.Text = txtCity.Text
  hidPostCode.Text = txtPostCode.Text
  hidCountry.Text = txtCountry.Text
  hidRequired.Text = txtRequired.Text
  hidShip.Text = txtShip.Text
  hidVia.Text = intShipperID.ToString()
  hidShipperName.Text = objLinesView(intRowIndex)("ShipperName")
  hidFreight.Text = txtFreight.Text

End Sub

'------------------------------------------------------------

Sub PopulateOrderLine(intProductID As Integer)
'gets values for selected order line from DataSet and fills in the
'visible and hidden controls on the page with these values

  'get Orders DataSet using function elsewhere in this page
  Dim objDataSet As DataSet = GetOrdersFromSessionOrServer(strCustID)

  'get a DataView for the Order Details table
  Dim objLinesView As DataView = objDataSet.Tables("Order Details").DefaultView

  'remove any filter from DataView
  objLinesView.RowFilter = ""

  'specify sort order for Find method to use
  objLinesView.Sort = "ProductID"

  'find row for this order using OrderID
  Dim intRowIndex As Integer = objLinesView.Find(intProductID)

  'put values from row into controls on frmEditLine
  lblProduct.Text = objLinesView(intRowIndex)("ProductName")
  txtQuantity.Text = objLinesView(intRowIndex)("Quantity")
  Dim dblUnitPrice As Double = objLinesView(intRowIndex)("UnitPrice")
  txtUnitPrice.Text = dblUnitPrice.ToString("N2")
  Dim dblUnitDiscount As Double = objLinesView(intRowIndex)("Discount")
  dblUnitDiscount *= 100
  txtDiscount.Text = dblUnitDiscount.ToString("N2")
  Dim dblTotalValue As Double = objLinesView(intRowIndex)("LineTotal")
  lblLineTotal.Text = "Line Total: $" & dblTotalValue.ToString("N2")

  'copy original values into "hidden" form labels
  hidProductID.Text = objLinesView(intRowIndex)("ProductID")
  hidQuantity.Text = txtQuantity.Text
  hidUnitPrice.Text = txtUnitPrice.Text
  hidDiscount.Text = objLinesView(intRowIndex)("Discount")

End Sub

'------------------------------------------------------------

Function UpdateOrderRow(ByRef strStatus As String) As Boolean
'routine called to perform update to address and shipping details
'returns status or error message as a String and Boolean flag

  'get OrderID as an Integer
  Dim intOrderID As Integer = Integer.Parse(strOrderID)

  'get the current (updated) values from the visible controls
  Dim strRequired As String = txtRequired.Text
  Dim strShipped As String = txtShip.Text
  Dim strFreight As String = txtFreight.Text
  Dim strShipName As String = txtName.Text
  Dim strAddress As String = txtAddress.Text
  Dim strCity As String = txtCity.Text
  Dim strPostalCode As String = txtPostCode.Text
  Dim strCountry As String = txtCountry.Text
  Dim strShipVia As String = lstVia.Items(lstVia.SelectedIndex).Value

  'get the original values from the "hidden" controls
  Dim strRequiredWas As String = hidRequired.Text
  Dim strShippedWas As String = hidShip.Text
  Dim strFreightWas As String = hidFreight.Text
  Dim strShipNameWas As String = hidName.Text
  Dim strAddressWas As String = hidAddress.Text
  Dim strCityWas As String = hidCity.Text
  Dim strPostalCodeWas As String = hidPostCode.Text
  Dim strCountryWas As String = hidCountry.Text
  Dim strShipViaWas As String = hidVia.Text

  'declare variables to hold converted data types
  Dim dblFreight, dblFreightWas As Double
  Dim intShipVia, intShipViaWas As Integer
  Dim datRequired, datRequiredWas As DateTime
  Dim datShipped, datShippedWas As DateTime

  Try

    'convert String values into correct data types
    'leave Date vales as Null (Nothing) to delete them
    dblFreight = Double.Parse(strFreight)
    intShipVia = Integer.Parse(strShipVia)
    dblFreightWas = Double.Parse(strFreightWas)
    intShipViaWas = Integer.Parse(strShipViaWas)
    If strRequired.Length > 0 Then
      datRequired = DateTime.Parse(strRequired)
    End If
    If strRequiredWas.Length > 0 Then
      datRequiredWas = DateTime.Parse(strRequiredWas)
    End If
    If strShipped.Length > 0 Then
      datShipped = DateTime.Parse(strShipped)
    End If
    If strShippedWas.Length > 0 Then
      datShippedWas = DateTime.Parse(strShippedWas)
    End If

  Catch objErr As Exception

    strStatus = objErr.Message
    Return False

  End Try

  'remove any cached DataSet from the Session
  Session("4923MobileOrdersDataSet") = Nothing

  'get connection string from web.config
  Dim strConnect As String
  strConnect = ConfigurationSettings.AppSettings("NorthwindConnectString")

  'create an instance of the data access component
  Dim objOrderList As New DDA4923OrderUpdate.UpdateOrders(strConnect)

  Try

    Dim intRows As Integer

    'call function within this page to perform the update
    intRows = objOrderList.SingleRowOrderUpdate(intOrderID, datRequired, _
              datShipped, dblFreight, strShipName, strAddress, strCity, _
              strPostalCode, strCountry, intShipVia, datRequiredWas, _
              datShippedWas, dblFreightWas, strShipNameWas, strAddressWas, _
              strCityWas, strPostalCodeWas, strCountryWas, intShipViaWas)

    'see if we got one row updated
    If intRows = 1 Then

     'fill other form controls with order details
     PopulateOrderDetails(strOrderID)

     Return True

    Else

      Return "* ERROR: Could not update order. May be due to changes made by other users"

    End If

  Catch objErr As Exception

    strStatus = "* ERROR: Failed to Update Order."
    Return False

  End Try

End Function

'------------------------------------------------------------

Function GetOrdersFromSessionOrServer(strCustID As String) As DataSet
'gets a DataSet containing all orders for this customer

  Try

    Dim objDataSet As DataSet

    'try and get DataSet from user's Session
    objDataSet = CType(Session("4923MobileOrdersDataSet"), DataSet)

    If objDataSet Is Nothing Then   'not in Session

      'get connection string from web.config
      Dim strConnect As String
      strConnect = ConfigurationSettings.AppSettings("NorthwindConnectString")

      'create an instance of the data access component
      Dim objOrderList As New UpdateOrders(strConnect)

      'call the method to return the data as a DataSet
      objDataSet = objOrderList.GetOrderDetails(strCustID)

      'get a reference to the "Orders" table in the DataSet
      Dim objTable As DataTable = objDataSet.Tables("Orders")

      'add a column containing the order ID and date as one string value
      Dim objColumn As DataColumn
      objColumn = objTable.Columns.Add("DisplayCol", System.Type.GetType("System.String"))

      'fill in this column for each row with "#{order number} - {order date}"
      Dim objRow As DataRow
      Dim objDate As DateTime
      For Each objRow In objTable.Rows
        objDate = objRow("OrderDate")
        objRow("DisplayCol") = "#" & objRow("OrderID") & " - " & objDate.ToString("d")
      Next

      'get a reference to the "Order Details" table in the DataSet
      Dim objLinesTable As DataTable = objDataSet.Tables("Order Details")

      'add a column containing the total value of each line
      objColumn = objLinesTable.Columns.Add("LineTotal", System.Type.GetType("System.Double"))
      objColumn.Expression = "[Quantity] * ([UnitPrice] - ([UnitPrice] * [Discount]))"

      'add a column containing the order details as one string value
      objColumn = objLinesTable.Columns.Add("DisplayCol", System.Type.GetType("System.String"))

      'fill in this column for each row as "qty x product (pack) @ price less discount = total"
      Dim strColValue As String
      For Each objRow In objLinesTable.Rows
        Dim dblThisPrice as Double = objRow("UnitPrice")
        strColValue = objRow("Quantity").ToString & " x " & objRow("ProductName") _
                    & " (" & objRow("QtyPerUnit") & ") @ " & dblThisPrice.ToString("$#0.00")
        If objRow("Discount") > 0 Then
          dblThisPrice = objRow("Discount")
          strColValue &= " Less " & dblThisPrice.ToString("P")
        End If
        dblThisPrice = objRow("LineTotal")
        objRow("DisplayCol") = strColValue & " = " & dblThisPrice.ToString("$#0.00")
      Next

      'save DataSet in Session for next order inquiry
      Session("4923MobileOrdersDataSet") = objDataSet

    End If

    Return objDataSet

  Catch

    Return Nothing

  End Try

End Function

'--------------------------------------------------------------

Function GetShippersFromSessionOrServer() As DataSet
'gets a DataSet containing the list of Shippers

  Try

    Dim objDataSet As DataSet

    'try and get DataSet from user's Session
    objDataSet = CType(Session("4923MobileShippersDataSet"), DataSet)

    If objDataSet Is Nothing Then   'not in Session

      'get connection string from web.config
      Dim strConnect As String
      strConnect = ConfigurationSettings.AppSettings("NorthwindConnectString")

      'create an instance of the data access component
      Dim objOrderList As New UpdateOrders(strConnect)

      'call the method to return the data as a DataSet
      objDataSet = objOrderList.GetShippersDataSet()

      'get a reference to the Shippers table
      Dim objTable As DataTable = objDataSet.Tables("Shippers")

      'create a new DataRow object for the table
      Dim objDataRow As DataRow = objTable.NewRow()

      'fill in values and insert into Rows collection of table
      objDataRow("ShipperID") = "0"
      objDataRow("ShipperName") = "{not specified}"
      objTable.Rows.InsertAt(objDataRow, 0)

      'save DataSet in Session for next order inquiry
      Session("4923MobileShippersDataSet") = objDataSet

    End If

    Return objDataSet

  Catch

    Return Nothing

  End Try

End Function

'--------------------------------------------------------------

Function GetProductsFromSessionOrServer() As DataSet
'gets a DataSet containing the list of Products

  Try

    Dim objDataSet As DataSet

    'try and get DataSet from user's Session
    objDataSet = CType(Session("4923MobileProductsDataSet"), DataSet)

    If objDataSet Is Nothing Then   'not in Session

      'get connection string from web.config
      Dim strConnect As String
      strConnect = ConfigurationSettings.AppSettings("NorthwindConnectString")

      'create an instance of the data access component
      Dim objOrderList As New UpdateOrders(strConnect)

      'call the method to return the data as a DataSet
      objDataSet = objOrderList.GetProductsDataSet()

      'save DataSet in Session for next order inquiry
      Session("4923MobileProductsDataSet") = objDataSet

    End If

    Return objDataSet

  Catch

    Return Nothing

  End Try

End Function

</script>

<!---------------------------------------------------------->
