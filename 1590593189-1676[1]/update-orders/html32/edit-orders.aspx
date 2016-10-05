<%@Page Language="VB" %>
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
[<a href="../../global/viewsource.aspx?compsrc=updateorders.vb" target="_blank">view page source</a>]
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
      Order No: <b><%# Container.DataItem("OrderID") %></b> &nbsp;
      Ordered: <%# DataBinder.Eval(Container.DataItem, _
                                  "OrderDate", "{0:d}") %> &nbsp;
      Required: <%# DataBinder.Eval(Container.DataItem, _
                                  "RequiredDate", "{0:d}") %> &nbsp;
      Ship: <%# DataBinder.Eval(Container.DataItem, _
                                  "ShippedDate", "{0:d}") %>
      via <%# Container.DataItem("ShipperName") %>
      ($<%# DataBinder.Eval(Container.DataItem, "Freight", "{0:F2}") %>)<br />
      <asp:Button CommandName="Edit" Text="Edit" runat="server" />
      Shipping address: <%# Container.DataItem("ShipName") %>,
      <%# Container.DataItem("ShipAddress") %>,
      <%# Container.DataItem("ShipCity") %>,
      <%# Container.DataItem("ShipPostalCode") %>,
      <%# Container.DataItem("ShipCountry") %>
    </ItemTemplate>

    <EditItemTemplate>
      Order No: <b><asp:Label id="lblOrderID" runat="server"
          Text='<%# Container.DataItem("OrderID") %>' /></b>&nbsp;
      Ordered: <%# DataBinder.Eval(Container.DataItem, _
                                  "OrderDate", "{0:d}") %>&nbsp;
      Required: <asp:TextBox id="txtRequired" size="11"
          MaxLength="10" runat="server"
          Text='<%# DataBinder.Eval(Container.DataItem, _
                                   "RequiredDate", "{0:d}") %>' />&nbsp;
      Ship: <asp:TextBox id="txtShipped" size="11"
          MaxLength="10" runat="server"
          Text='<%# DataBinder.Eval(Container.DataItem, _
                                   "ShippedDate", "{0:d}") %>' />&nbsp;
      Freight: $<asp:TextBox id="txtFreight" size="5"
          MaxLength="6" runat="server"
          Text='<%# DataBinder.Eval(Container.DataItem, _
                                   "Freight", "{0:F2}") %>' />
      <asp:Button id="cmdSetFreight" CommandName="SetFreight"
          Text="Set" runat="server" /><br />
      Name: <asp:TextBox id="txtShipName" size="40"
          MaxLength="40" runat="server"
          Text='<%# Container.DataItem("ShipName") %>' />&nbsp;&nbsp;
      Address: <asp:TextBox id="txtAddress" size="59"
          MaxLength="60" runat="server"
          Text='<%# Container.DataItem("ShipAddress") %>' /><br />&nbsp;
      City: <asp:TextBox id="txtCity" size="17"
          MaxLength="15" runat="server"
          Text='<%# Container.DataItem("ShipCity") %>' />&nbsp;&nbsp;
      Postal Code: <asp:TextBox id="txtPostalCode" size="11"
          MaxLength="10" runat="server"
          Text='<%# Container.DataItem("ShipPostalCode") %>' />&nbsp;
      Country: <asp:TextBox id="txtCountry" size="16"
          MaxLength="15" runat="server"
          Text='<%# Container.DataItem("ShipCountry") %>' />&nbsp;&nbsp;
      via: <asp:DropDownList id="lstShipper" runat="server" />
        <div align="right">
          <asp:Button CommandName="Update" Text="Update" runat="server" />
          <asp:Button CommandName="Delete" Text="Delete" runat="server" />
          <asp:Button CommandName="Cancel" Text="Cancel" runat="server" />
          <asp:Button id="cmdEditItems" CommandName="EditItems"
               Text="Edit Items" Visible="False" runat="server" />
        </div>
      <input id="hidRequiredWas" type="hidden" runat="server"
             value='<%# DataBinder.Eval(Container.DataItem, _
                                       "RequiredDate", "{0:d}") %>' />
      <input id="hidShippedWas" type="hidden" runat="server"
             value='<%# DataBinder.Eval(Container.DataItem, _
                                       "ShippedDate", "{0:d}") %>' />
      <input id="hidShipNameWas" type="hidden" runat="server"
             value='<%# Container.DataItem("ShipName") %>' />
      <input id="hidAddressWas" type="hidden" runat="server"
             value='<%# Container.DataItem("ShipAddress") %>' />
      <input id="hidCityWas" type="hidden" runat="server"
             value='<%# Container.DataItem("ShipCity") %>' />
      <input id="hidPostalCodeWas" type="hidden" runat="server"
             value='<%# Container.DataItem("ShipPostalCode") %>' />
      <input id="hidCountryWas" type="hidden" runat="server"
             value='<%# Container.DataItem("ShipCountry") %>' />
      <input id="hidFreightWas" type="hidden" runat="server"
             value='<%# DataBinder.Eval(Container.DataItem, _
                                       "Freight", "{0:F2}") %>' />
      <input id="hidShipViaWas" type="hidden" runat="server"
             value='<%# Container.DataItem("ShipVia") %>' />
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

<script language="VB" runat="server">

'page-level variable accessed from more than one routine
Dim strCustID As String = ""

'--------------------------------------------------------------

Sub Page_Load()

  If Page.IsPostBack Then

    'collect customer ID from hidden control
    strCustID = customerid.Value

  Else

    strCustID = Request.QueryString("customerid")
    If (strCustID Is Nothing) Or (strCustID = "") Then

      'display error message
      lblMessage.Text = "* ERROR: no Customer ID provided. You must " _
        & "<a href='../../customer-orders/html32/default.aspx'>" _
        & "<b>select a customer</b></a> first."

    Else

       'put customer ID into hidden control
       customerid.Value = strCustID

      'display all orders for this customer
      ShowOrders()

      'diplay heading above DataList
      lblStatus.Text = "Orders for customer ID <b>'" & strCustID & "'</b>"

    End If

  End If

End Sub

'--------------------------------------------------------------

Sub ShowOrders()
'displays list of all orders for this customer in DataGrid control

  'get Orders DataSet using function elsewhere in this page
  Dim objDataSet As DataSet = GetOrdersFromSessionOrServer(strCustID)

  'remove filter appied by "Edit Order Lines" page
  Dim objLinesView As DataView = objDataSet.Tables("Order Details").DefaultView
  objLinesView.RowFilter = ""

  'set DataSource, bind the DataList and display status message
  lstOrders.DataSource = objDataSet.Tables("Orders")
  lstOrders.DataBind()

  If lstOrders.EditItemIndex > -1 Then

    lblMessage.Text = "Edit the details of the selected order and click the " _
                    & "<b>Update</b> button in the list above to save the " _
                    & "changes, or click<br /> the <b>Delete</b> button to " _
                    & "permanently delete this order. Click the <b>Cancel</b> " _
                    & "button to abandon any changes made to the<br /> " _
                    & "order. To edit the detail lines for un-shipped orders " _
                    & "click the <b>Edit Items</b> button, or " _
                    & "<a href='../../customer-orders/html32/default.aspx'>" _
                    & "<b>select another customer</b></a>"

  Else

    lblMessage.Text = "Click the <b>Edit</b> button in the list above to " _
                    & "edit details of that order, or " _
                    & "<a href='../../customer-orders/html32/default.aspx'>" _
                    & "<b>select another customer</b></a>"
  End If

End Sub

'--------------------------------------------------------------

Sub SetRowVariations(objSender As Object, objArgs As DataListItemEventArgs)
'sets value of DropDownList in each row to current Shipper name
'and displays the "Edit Items" button if it's an un-shipped order

  'see what type of row caused the event
  Dim objItemType As ListItemType = CType(objArgs.Item.ItemType, ListItemType)

  'only set the row variations for an EditItem row, which occurs only
  'once for each page load, and contains the EditItemTemplate content
  If objItemType = ListItemType.EditItem Then

    'get a reference to the ShippedDate TextBox control in this row
    Dim objTextBox As TextBox = CType(objArgs.Item.FindControl("txtShipped"), TextBox)

    'get a reference to the "Edit Items" Button control in this row
    Dim objButton As Button = CType(objArgs.Item.FindControl("cmdEditItems"), Button)

    'business rule: can only edit lines on order if not yet shipped
    objButton.Visible = False
    If objTextBox.Text.Length = 0 Then
      objButton.Visible = True   'no ship date specified
    Else
      Try
        'see if ship date is in the future
        Dim datShip As DateTime = DateTime.Parse(objTextBox.Text)
        If DateTime.Compare(DateTime.Now(), datShip) < 0 Then
          objButton.Visible = True
        End If
      Catch
      End Try
    End If

    'get a reference to the asp:DropDownList control in this row
    Dim objList As DropDownList = CType(objArgs.Item.FindControl("lstShipper"), DropDownList)

    Try

      'get Shippers DataSet using function elsewhere in this page
      Dim objShipDataSet As DataSet = GetShippersFromSessionOrServer()

      objList.DataSource = objShipDataSet
      objList.DataTextField = "ShipperName"
      objList.DataValueField = "ShipperID"
      objList.DataBind()

      'objArgs.Item.DataItem returns the data for this row of items
      Dim objRowVals As DataRowView = CType(objArgs.Item.DataItem, DataRowView)

      'get the Shipping Company ID of the item in the DataRowView
      Dim intShipperID As Integer = objRowVals("ShipVia")

      Dim objItem As ListItem
      For Each objItem In objList.Items
        If objItem.Value = intShipperID Then
          objItem.Selected = True
        End If
      Next

    Catch objErr As Exception

      lblMessage.Text = "* ERROR: Shipper details not located. " & objErr.Message
      objList.SelectedIndex = 0

    End Try

  End If

End Sub

'--------------------------------------------------------------

Sub DoItemEdit(objSource As Object, objArgs As DataListCommandEventArgs)
'runs when the EditCommand button in the Datalist is clicked
'switches DataList into "Edit" mode to show edit controls

  'reset any Selected row
  lstOrders.SelectedIndex = -1

  'set the EditItemIndex property of the list to this item's index
  lstOrders.EditItemIndex = objArgs.Item.ItemIndex

  lblStatus.Text = "Orders for customer ID <b>'" & strCustID & "'</b>"
  ShowOrders()  'bind the data and display it

End Sub

'--------------------------------------------------------------

Sub DoItemCommand(objSource As Object, objArgs As DataListCommandEventArgs)
'runs when any Command button in the Datalist is clicked

  'see if was the "Edit Items" button that was clicked
  If objArgs.CommandName = "EditItems" Then

    'get a reference to the Order ID Label control
    Dim objOrderIDCtrl As Label
    objOrderIDCtrl = CType(objArgs.Item.FindControl("lblOrderID"), Label)

    'create Query String for edit-order-lines page
    Dim strQuery As String = "?customerid=" & strCustID _
                           & "&orderid=" & objOrderIDCtrl.Text

    'open page for editing detail lines for this order
    Response.Clear()
    Response.Redirect("edit-order-lines.aspx" & strQuery)
    Response.End

  End If

  'see if was the "New Order" button that was clicked
  If objArgs.CommandName = "NewOrder" Then

    'reset any Selected row
    lstOrders.SelectedIndex = -1

    'create variable for ByRef function parameter
    Dim intOrderID As Integer = -1

    'call function to insert a new Order row in database for the
    'current customer. Sets OrderID and returns True/False
    If InsertNewOrder(intOrderID) = True Then

      'show this row ready for editing
      lstOrders.EditItemIndex = 0
      ShowOrders()

    End If

  End If

  'see if was the "Set Freight" button that was clicked
  If objArgs.CommandName = "SetFreight" Then

    'get a reference to and value of OrderID Label control
    Dim objOrderIDCtrl As Label
    objOrderIDCtrl = CType(objArgs.Item.FindControl("lblOrderID"), Label)
    Dim intOrderID As Integer = Integer.Parse(objOrderIDCtrl.Text)

    'get connection string from web.config
    Dim strConnect As String
    strConnect = ConfigurationSettings.AppSettings("NorthwindConnectString")

    'create an instance of the data access component
    Dim objOrderList As New UpdateOrders(strConnect)

    'call routine in data access component to calculate/update
    'freight cost in Orders table and display message
    If objOrderList.SetFreightCost(intOrderID) Then
      lblStatus.Text = "Freight cost recalculated for Order ID: <b>" _
                     & intOrderID.ToString() & "</b>"
    Else
      lblStatus.Text = "* ERROR: Could not calculate freight cost."
    End If

    'remove any cached DataSet from Session and update list
    Session("4923HTMLOrdersDataSet") = Nothing
    ShowOrders()

  End If

End Sub

'--------------------------------------------------------------

Sub DoItemUpdate(objSource As Object, objArgs As DataListCommandEventArgs)
'runs when the "Update" button in the DataList is clicked
'pushes update to the selected order back into the database

  'get OrderID for current row from the DataList's DataKeys collection
  Dim intUpdateID As Integer = lstOrders.DataKeys(objArgs.Item.ItemIndex)

  'get the current (updated) values from the visible controls in the DataList
  Dim strRequired As String = CType(objArgs.Item.FindControl("txtRequired"), TextBox).Text
  Dim strShipped As String = CType(objArgs.Item.FindControl("txtShipped"), TextBox).Text
  Dim strFreight As String = CType(objArgs.Item.FindControl("txtFreight"), TextBox).Text
  Dim strShipName As String = CType(objArgs.Item.FindControl("txtShipName"), TextBox).Text
  Dim strAddress As String = CType(objArgs.Item.FindControl("txtAddress"), TextBox).Text
  Dim strCity As String = CType(objArgs.Item.FindControl("txtCity"), TextBox).Text
  Dim strPostalCode As String = CType(objArgs.Item.FindControl("txtPostalCode"), TextBox).Text
  Dim strCountry As String = CType(objArgs.Item.FindControl("txtCountry"), TextBox).Text
  Dim objList As DropDownList = CType(objArgs.Item.FindControl("lstShipper"), DropDownList)
  Dim strShipVia As String = objList.Items(objList.SelectedIndex).Value

  'get the original values from the hidden-type controls in the DataList
  Dim strRequiredWas As String = CType(objArgs.Item.FindControl("hidRequiredWas"), HtmlInputHidden).Value
  Dim strShippedWas As String = CType(objArgs.Item.FindControl("hidShippedWas"), HtmlInputHidden).Value
  Dim strFreightWas As String = CType(objArgs.Item.FindControl("hidFreightWas"), HtmlInputHidden).Value
  Dim strShipNameWas As String = CType(objArgs.Item.FindControl("hidShipNameWas"), HtmlInputHidden).Value
  Dim strAddressWas As String = CType(objArgs.Item.FindControl("hidAddressWas"), HtmlInputHidden).Value
  Dim strCityWas As String = CType(objArgs.Item.FindControl("hidCityWas"), HtmlInputHidden).Value
  Dim strPostalCodeWas As String = CType(objArgs.Item.FindControl("hidPostalCodeWas"), HtmlInputHidden).Value
  Dim strCountryWas As String = CType(objArgs.Item.FindControl("hidCountryWas"), HtmlInputHidden).Value
  Dim strShipViaWas As String = CType(objArgs.Item.FindControl("hidShipViaWas"), HtmlInputHidden).Value

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

    lblStatus.Text = "* ERROR: Incorrect value entered.<br />" _
                     & objErr.Message
    Exit Sub

  End Try

  'get connection string from web.config
  Dim strConnect As String
  strConnect = ConfigurationSettings.AppSettings("NorthwindConnectString")

  'create an instance of the data access component
  Dim objOrderList As New UpdateOrders(strConnect)

  Try

    Dim intRows As Integer

    'call function within this page to perform the update
    intRows = objOrderList.SingleRowOrderUpdate(intUpdateID, datRequired, _
              datShipped, dblFreight, strShipName, strAddress, strCity, _
              strPostalCode, strCountry, intShipVia, datRequiredWas, _
              datShippedWas, dblFreightWas, strShipNameWas, strAddressWas, _
              strCityWas, strPostalCodeWas, strCountryWas, intShipViaWas)

    'see if we got one row updated
    If intRows = 1 Then
      lblStatus.Text = "Updated Order ID: <b>" & intUpdateID.ToString() & "</b>"
    Else
      lblStatus.Text = "* ERROR: Could not update Order ID: <b>" _
                     & intUpdateID.ToString() & "</b><br />There were " _
                     & intRows.ToString() & " database row(s) updated.<br />" _
                     & "Error may be due to changes being made to " _
                     & "the data concurrently by other users."
    End If

  Catch objErr As Exception

    lblStatus.Text = "* ERROR: Failed to Update Order.<br />" _
                   & objErr.Message

  End Try

  'remove any cached DataSet from the Session
  Session("4923HTMLOrdersDataSet") = Nothing

  'set EditItemIndex property of grid to -1 to switch out of Edit mode
  lstOrders.EditItemIndex = -1

  'set SelectedIndex to indicate row that was updated
  lstOrders.SelectedIndex = objArgs.Item.ItemIndex
  ShowOrders()  'bind the data and display it

End Sub

'--------------------------------------------------------------

Sub DoItemDelete(objSource As Object, objArgs As DataListCommandEventArgs)
'runs when the "Delete" button in the Datalist is clicked
'deletes the selected order from the database

  'get OrderID for current row from the DataList's DataKeys collection
  Dim intDeleteID As Integer = lstOrders.DataKeys(objArgs.Item.ItemIndex)

  'get the original values from the hidden-type controls in the DataList
  Dim strRequiredWas As String = CType(objArgs.Item.FindControl("hidRequiredWas"), HtmlInputHidden).Value
  Dim strShippedWas As String = CType(objArgs.Item.FindControl("hidShippedWas"), HtmlInputHidden).Value
  Dim strFreightWas As String = CType(objArgs.Item.FindControl("hidFreightWas"), HtmlInputHidden).Value
  Dim strShipNameWas As String = CType(objArgs.Item.FindControl("hidShipNameWas"), HtmlInputHidden).Value
  Dim strAddressWas As String = CType(objArgs.Item.FindControl("hidAddressWas"), HtmlInputHidden).Value
  Dim strCityWas As String = CType(objArgs.Item.FindControl("hidCityWas"), HtmlInputHidden).Value
  Dim strPostalCodeWas As String = CType(objArgs.Item.FindControl("hidPostalCodeWas"), HtmlInputHidden).Value
  Dim strCountryWas As String = CType(objArgs.Item.FindControl("hidCountryWas"), HtmlInputHidden).Value
  Dim strShipViaWas As String = CType(objArgs.Item.FindControl("hidShipViaWas"), HtmlInputHidden).Value

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

    lblStatus.Text = "* ERROR: Incorrect value entered.<br />" _
                     & objErr.Message
    Exit Sub

  End Try

  'get connection string from web.config
  Dim strConnect As String
  strConnect = ConfigurationSettings.AppSettings("NorthwindConnectString")

  'create an instance of the data access component
  Dim objOrderList As New UpdateOrders(strConnect)

  Try

    Dim intRows As Integer

    'call function in data access component to delete the row
    intRows = objOrderList.SingleRowOrderDelete(intDeleteID, datRequiredWas, _
              datShippedWas, dblFreightWas, strShipNameWas, strAddressWas, _
              strCityWas, strPostalCodeWas, strCountryWas, intShipViaWas)

    'see if we got one row deleted
    If intRows = 1 Then

      lblStatus.Text = "Deleted Order ID: <b>" & intDeleteID.ToString() & "</b>"

    Else

      lblStatus.Text = "* ERROR: Could not delete Order ID: <b>" _
                     & intDeleteID.ToString() & "</b><br />There were " _
                     & intRows.ToString() & " database row(s) deleted.<br />" _
                     & "Error may be due to changes being made to " _
                     & "the data concurrently by other users."

      'set SelectedIndex to indicate row that was not deleted
      lstOrders.SelectedIndex = objArgs.Item.ItemIndex

    End If

  Catch objErr As Exception

    lblStatus.Text = "* ERROR: Failed to Delete Order.<br />" _
                   & objErr.Message

  End Try

  'remove any cached DataSet from the Session
  Session("4923HTMLOrdersDataSet") = Nothing

  'set EditItemIndex property of grid to -1 to switch out of Edit mode
  lstOrders.EditItemIndex = -1
  ShowOrders()  'bind the data and display it

End Sub

'--------------------------------------------------------------

Sub DoItemCancel(objSource As Object, objArgs As DataListCommandEventArgs)
'runs when the "Cancel" button in the Datalist is clicked

  'set EditItemIndex property of grid to -1 to switch out of Edit mode
  lstOrders.EditItemIndex = -1
  ShowOrders()  'bind the data and display it
  lblStatus.Text = "Changes to the order were abandoned."

End Sub

'--------------------------------------------------------------

Function InsertNewOrder(ByRef intOrderID As Integer) As Boolean

  'remove any cached DataSet from the Session so that updates
  'are displayed when the page is loaded next time
  Session("4923HTMLOrdersDataSet") = Nothing

  'get connection string from web.config
  Dim strConnect As String
  strConnect = ConfigurationSettings.AppSettings("NorthwindConnectString")

  'create an instance of the data access component
  Dim objOrderList As New UpdateOrders(strConnect)

  Try

    'call the method to return the data as a DataSet
    intOrderID = objOrderList.InsertNewOrder(strCustID)

    'display status message and return True
    lblStatus.Text = "Inserted new order ID: <b>" _
                   & intOrderID.ToString() & "</b>"
    Return True

  Catch objErr As Exception

    'display error message and return False
    lblStatus.Text = "* ERROR: Cannot insert new order.<br />" _
                   & objErr.Message
    Return False

  End Try

End Function

'--------------------------------------------------------------

Function GetOrdersFromSessionOrServer(strCustID As String) As DataSet
'gets a DataSet containing all orders for this customer

  Try

    Dim objDataSet As DataSet

    'try and get DataSet from user's Session
    objDataSet = CType(Session("4923HTMLOrdersDataSet"), DataSet)

    If objDataSet Is Nothing Then   'not in Session

      'get connection string from web.config
      Dim strConnect As String
      strConnect = ConfigurationSettings.AppSettings("NorthwindConnectString")

      'create an instance of the data access component
      Dim objOrderList As New UpdateOrders(strConnect)

      'call the method to return the data as a DataSet
      objDataSet = objOrderList.GetOrderDetails(strCustID)

      'add a column containing the total value of each line
      Dim objLinesTable As DataTable = objDataSet.Tables("Order Details")
      Dim objColumn As DataColumn
      objColumn = objLinesTable.Columns.Add("LineTotal", System.Type.GetType("System.Double"))
      objColumn.Expression = "[Quantity] * ([UnitPrice] - ([UnitPrice] * [Discount]))"

      'save DataSet in Session for next order inquiry
      Session("4923HTMLOrdersDataSet") = objDataSet

    End If

    Return objDataSet

  Catch objErr As Exception

    'there was an error and no data will be returned
    lblMessage.Text = "* ERROR: No data returned. " & objErr.Message

    Return Nothing

  End Try

End Function

'--------------------------------------------------------------

Function GetShippersFromSessionOrServer() As DataSet
'gets a DataSet containing the list of Shippers

  Try

    Dim objDataSet As DataSet

    'try and get DataSet from user's Session
    objDataSet = CType(Session("4923HTMLShippersDataSet"), DataSet)

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
      Session("4923HTMLShippersDataSet") = objDataSet

    End If

    Return objDataSet

  Catch

    Return Nothing

  End Try

End Function

</script>

<!---------------------------------------------------------->
