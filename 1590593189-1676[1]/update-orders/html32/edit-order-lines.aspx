<%@Page Language="VB" %>
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
[<a href="../../global/viewsource.aspx?compsrc=updateorders.vb" target="_blank">view page source</a>]
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
               Text='<%# Container.DataItem("Quantity") %>' />
        </ItemTemplate>
        <EditItemTemplate>
          <asp:TextBox id="txtQuantity" Columns="2" MaxLength="4" runat="server"
               Text='<%# Container.DataItem("Quantity") %>' />
        </EditItemTemplate>
      </asp:TemplateColumn>

      <asp:TemplateColumn HeaderText="<b>Product</b>"
           HeaderStyle-HorizontalAlign="center" ItemStyle-HorizontalAlign="left">
        <ItemTemplate>
          <asp:Label id="lblProductName" runat="server"
               Text='<%# Container.DataItem("ProductName") %>'/>
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
               Text='<%# Container.DataItem("UnitPrice") %>' />
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
               Text='<%# Container.DataItem("Discount") * 100 %>' />
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
               value='<%# Container.DataItem("Quantity") %>' />
          <input id="hidUnitPriceWas" type="hidden" runat="server"
                 value='<%# Container.DataItem("UnitPrice") %>' />
          <input id="hidDiscountWas" type="hidden" runat="server"
                 value='<%# Container.DataItem("Discount") %>' />
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

<script language="VB" runat="server">

'page-level variables accessed from more than one routine
Dim strCustID As String = ""
Dim strOrderID As String = ""

'--------------------------------------------------------------

Sub Page_Load()

  If Page.IsPostBack Then

    'collect customer ID and Order ID from hidden controls
    strCustID = customerid.Value
    strOrderID = orderid.Value

  Else

    strCustID = Request.QueryString("customerid")
    strOrderID = Request.QueryString("orderid")

    If (strOrderID Is Nothing) Or (strOrderID = "") _
    Or (strCustID Is Nothing) Or (strCustID = "") Then

      'display error message
      lblMessage.Text = "* ERROR: no Customer or Order ID provided. You must " _
        & "<a href='../../customer-orders/html32/default.aspx'>" _
        & "<b>select a customer and order</b></a> first."

    Else

       'put customer ID and Order ID into hidden controls
       customerid.Value = strCustID
       orderid.Value = strOrderID

      'display all orders for this customer
      ShowOrderlines()

    End If

  End If

End Sub

'--------------------------------------------------------------

Sub ShowOrderLines()
'displays list of all order lines for this customer in DataGrid control

  'get Orders DataSet using function elsewhere in this page
  Dim objDataSet As DataSet = GetOrdersFromSessionOrServer(strCustID)

  'create sorted and filtered DataView from Order Details table
  Dim objLinesView As DataView = objDataSet.Tables("Order Details").DefaultView
  objLinesView.RowFilter = "OrderID = " & strOrderID
  objLinesView.Sort = "ProductName"

  'diplay heading above DataList
  lblStatus.Text = "Details for Order ID: <b>" & strOrderID & "</b>"

  'see if a line is in "Edit mode"
  If dgrOrderLines.EditItemIndex > -1 Then

    'hide list of products and display "Help" message
    divAddNewLine.Style("display") = "none"
    lblMessage.Text = "Edit the details of the selected order and click the " _
                    & "<b>Update</b> link in the grid above to save the " _
                    & "changes, or click<br /> the <b>Delete</b> link to " _
                    & "permanently delete this item. Click the <b>Cancel</b> " _
                    & "link to abandon any changes made to the<br /> " _
                    & "item, or " _
                    & "<a href='edit-orders.aspx?customerid=" & strCustID & "'>" _
                    & "<b>select a different order</b></a>, or " _
                    & "<a href='../../customer-orders/html32/default.aspx'>" _
                    & "<b>select another customer</b></a>"

  Else

    'show list of products and display "Help" message
    divAddNewLine.Style("display") = ""    'show list of products
    lblMessage.Text = "Click the <b>Edit</b> link in the grid above to " _
                    & "edit that order line,<br />or " _
                    & "<a href='edit-orders.aspx?customerid=" & strCustID & "'>" _
                    & "<b>select a different order</b></a>, or " _
                    & "<a href='../../customer-orders/html32/default.aspx'>" _
                    & "<b>select another customer</b></a>"

    'bind list of products to data source to fill in values
    lstAddProduct.DataSource = GetProductsFromSessionOrServer()
    lstAddProduct.DataMember = "Products"
    lstAddProduct.DataTextField = "ProductName"
    lstAddProduct.DataValueField = "ProductID"
    lstAddProduct.DataBind()

    'add extra row at top of list for "Select product ..."
    Dim objItem As New ListItem ("Select product...", "-1")
    lstAddProduct.Items.Insert(0, objItem)


  End If

  'see if there are any order detail lines on this order
  If objLinesView.Count = 0 Then

    'display "Help" message
    lblMessage.Text = "There are no lines on this order. Select a product from<br />" _
                    & "the list above and click the <b>Add</b> button to add " _
                    & "a line to<br />this order, or " _
                    & "<a href='edit-orders.aspx?customerid=" & strCustID & "'>" _
                    & "<b>select a different order</b></a>"

    dgrOrderLines.Visible = False    'hide DataGrid control

  Else

    'set DataSource and bind the DataGrid to show order lines
    dgrOrderLines.DataSource = objDataSet.Tables("Order Details")
    dgrOrderLines.DataBind()

    dgrOrderLines.Visible = True  'make DataGrid visible

    'show order Total Value by iterating rows in DataView
    Dim dblTotal As Double = 0
    Dim objRow As DataRowView
    For Each objRow In objLinesView
      dblTotal += objRow("LineTotal")
    Next
    lblTotalValue.Text = "Total order value: <b>$ " _
                       & dblTotal.ToString("N2") & "</b>"
  End If

End Sub

'--------------------------------------------------------------

Function GetGridIndexForProduct(ByVal intProductID As Integer) As Integer
'gets the index within the Datagrid for the product specified

  Dim intResult As Integer = -1
  Dim intIndex As Integer

  'check ProductID for each row in DataGrid's DataKeys collection
  For intIndex = 0 To dgrOrderLines.DataKeys.Count - 1

    If dgrOrderLines.DataKeys(intIndex) = intProductID Then
      intResult = intIndex
      Exit For
    End If

  Next

  Return intResult

End Function

'--------------------------------------------------------------

Sub AddNewLine(objSource As Object, objArgs As EventArgs)
'runs when the "Add" (product) button below the grid is clicked

  Dim strMessage As String   'to hold status message

  'get selected item index from "Add Product" drop-down list
  Dim intListIndex As Integer = lstAddProduct.SelectedIndex

  'get selected product ID and product name
  Dim intProductID As Integer = CType(lstAddProduct.Items(intListIndex).Value, Integer)
  Dim strProductName As String = lstAddProduct.Items(intListIndex).Text

  If intProductID < 0 Then

    'user did not make a selection in the list
    lblStatus.Text = "*ERROR: You must select a product from the drop-down<br />" _
                   & "list at the bottom of this page first, then click <b>Add</b>."

    lblMessage.Text = "or <a href='edit-orders.aspx?customerid=" & strCustID & "'>" _
                    & "<b>select a different order</b></a>"
    Exit Sub

  End If

  Try

    'get connection string from web.config
    Dim strConnect As String
    strConnect = ConfigurationSettings.AppSettings("NorthwindConnectString")

    'create an instance of the data access component
    Dim objOrderList As New UpdateOrders(strConnect)

    'convert OrderID string into an Integer
    Dim intOrderID As Integer = CType(strOrderID, Integer)

    'call the method to add a new row to the Order Details table
    If objOrderList.InsertNewOrderLine(intOrderID, intProductID) = True Then

      strMessage = "Added product '<b>" & strProductName _
                 & "</b>' to order"

      'remove any cached DataSet from the Session
      Session("4923HTMLOrdersDataSet") = Nothing

      'to be able to find new row in DataGrid we have to bind it
      'to the data source first and then search for it in the grid
      ShowOrderLines()  'bind the data and display it

      'function in this page can then return index in DataGrid
      'for the item with the specified ProductID. This will be
      'displayed when grid is bound again before display
      dgrOrderLines.SelectedIndex = GetGridIndexForProduct(intProductID)

    Else

      strMessage = "Failed to added product '<b>" & strProductName _
                     & "</b>' to order"
    End If

    ShowOrderLines()  'bind the data and display it

  Catch objErr As Exception

    strMessage = "*ERROR: Could not add product to order. " _
               & "If this product is<br />already on the order, " _
               & "just increase the quantity for that line."
  End Try

  lblStatus.Text = strMessage   'display status message

End Sub

'--------------------------------------------------------------

Sub DoItemEdit(objSource As Object, objArgs As DataGridCommandEventArgs)
'runs when the "Edit" link in the DataGrid is clicked
'switches DataList into "Edit" mode to show edit controls

  'set the EditItemIndex property of the list to this item's index
  dgrOrderLines.EditItemIndex = objArgs.Item.ItemIndex

  'set the SelectedIndex property to "unselect" all rows
  dgrOrderLines.SelectedIndex = -1

  ShowOrderLines()  'bind the data and display it

End Sub

'--------------------------------------------------------------

Sub DoItemCommand(objSource As Object, objArgs As DataGridCommandEventArgs)
'runs when any Command button/link in the DataGrid is clicked

  'see if was the "Delete" link that was clicked
  If objArgs.CommandName = "Delete" Then
    DoItemDelete(objSource, objArgs)
  End If

End Sub

'--------------------------------------------------------------

Sub DoItemUpdate(objSource As Object, objArgs As DataGridCommandEventArgs)
'runs when the "Update" link in the DataGrid is clicked
'pushes update to the selected order line back into database

  Dim strMessage As String   'to hold status message

  'get ProductID for current row from the DataGrid's DataKeys collection
  Dim intProductID As Integer = dgrOrderLines.DataKeys(objArgs.Item.ItemIndex)

  'convert current OrderID string into an Integer
  Dim intOrderID As Integer = CType(strOrderID, Integer)

  'get product name from current row in DataGrid
  Dim strProductName As String = CType(objArgs.Item.FindControl("lblProductName"), Label).Text

  'get the current (updated) values from the visible controls in the DataGrid
  Dim strQuantity As String = CType(objArgs.Item.FindControl("txtQuantity"), TextBox).Text
  Dim strUnitPrice As String = CType(objArgs.Item.FindControl("txtUnitPrice"), TextBox).Text
  Dim strDiscount As String = CType(objArgs.Item.FindControl("txtDiscount"), TextBox).Text

  'get the original values from the hidden-type controls in the DataGrid
  Dim strQuantityWas As String = CType(objArgs.Item.FindControl("hidQuantityWas"), HtmlInputHidden).Value
  Dim strUnitPriceWas As String = CType(objArgs.Item.FindControl("hidUnitPriceWas"), HtmlInputHidden).Value
  Dim strDiscountWas As String = CType(objArgs.Item.FindControl("hidDiscountWas"), HtmlInputHidden).Value

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
    intRows = objOrderList.SingleOrderLineUpdate(intOrderID, _
              intProductID, dblUnitPrice, intQuantity, dblDiscount, _
              dblUnitPriceWas, intQuantityWas, dblDiscountWas)

    'see if we got one row updated
    If intRows = 1 Then
      strMessage = "Updated order for '<b>" & strProductName & "</b>'"
    Else
      strMessage = "* ERROR: Could not update order for '<b>" _
                 & strProductName & "</b>'<br />There were " _
                 & intRows.ToString() & " database row(s) updated.<br />" _
                 & "Error may be due to changes being made to " _
                 & "the data concurrently by other users."
    End If

  Catch objErr As Exception

    strMessage = "* ERROR: Failed to Update Order Line.<br />" _
               & objErr.Message

  End Try

  'set SelectedIndex of grid to current EditItemIndex to indicate
  'updated row, and set EditItemIndex to -1 to switch off Edit mode
  dgrOrderLines.SelectedIndex = dgrOrderLines.EditItemIndex
  dgrOrderLines.EditItemIndex = -1

  'remove any cached DataSet from the Session
  Session("4923HTMLOrdersDataSet") = Nothing

  're-bind the data to display selected row
  ShowOrderLines()

  lblStatus.Text = strMessage

End Sub

'--------------------------------------------------------------

Sub DoItemDelete(objSource As Object, objArgs As DataGridCommandEventArgs)
'runs when the "Delete" link in the DataGrid is clicked
'deletes the selected order line from the database

  Dim strMessage As String   'to hold status message

  'set Edit and Selected Index of grid to -1 to ensure no rows
  'are in "selected" or "edit mode" after deleting this row
  dgrOrderLines.EditItemIndex = -1
  dgrOrderLines.SelectedIndex = -1

  'get ProductID for current row from the DataGrid's DataKeys collection
  Dim intProductID As Integer = dgrOrderLines.DataKeys(objArgs.Item.ItemIndex)

  'convert current OrderID string into an Integer
  Dim intOrderID As Integer = CType(strOrderID, Integer)

  'get product name from current row in DataGrid
  Dim strProductName As String = CType(objArgs.Item.FindControl("lblProductName"), Label).Text


  'get the original values from the hidden-type controls in the DataGrid
  Dim strQuantityWas As String = CType(objArgs.Item.FindControl("hidQuantityWas"), HtmlInputHidden).Value
  Dim strUnitPriceWas As String = CType(objArgs.Item.FindControl("hidUnitPriceWas"), HtmlInputHidden).Value
  Dim strDiscountWas As String = CType(objArgs.Item.FindControl("hidDiscountWas"), HtmlInputHidden).Value

  'declare variables to hold converted data types
  Dim intQuantityWas As Integer = Integer.Parse(strQuantityWas)
  Dim dblUnitPriceWas As Double = Double.Parse(strUnitPriceWas)
  Dim dblDiscountWas As Double = Double.Parse(strDiscountWas)

  'get connection string from web.config
  Dim strConnect As String
  strConnect = ConfigurationSettings.AppSettings("NorthwindConnectString")

  'create an instance of the data access component
  Dim objOrderList As New UpdateOrders(strConnect)

  Try

    Dim intRows As Integer

    'call function in data access component to delete the row
    intRows = objOrderList.SingleOrderLineDelete(intOrderID, _
                intProductID, dblUnitPriceWas, intQuantityWas, _
                dblDiscountWas)

    'see if we got one row deleted
    If intRows = 1 Then

      strMessage = "Deleted order for '<b>" & strProductName & "'</b>"

    Else

      strMessage = "* ERROR: Could not delete product '<b>" _
                 & strProductName & "</b>'<br />There were " _
                 & intRows.ToString() & " database row(s) deleted.<br />" _
                 & "Error may be due to changes being made to " _
                 & "the data concurrently by other users."
    End If

  Catch objErr As Exception

    strMessage = "* ERROR: Failed to Delete Order Line.<br />" _
               & objErr.Message

  End Try

  'remove any cached DataSet from the Session so that updates
  'are displayed when the page is loaded next time
  Session("4923HTMLOrdersDataSet") = Nothing
  ShowOrderLines()  'bind the data and display it
  lblStatus.Text = strMessage

End Sub

'--------------------------------------------------------------

Sub DoItemCancel(objSource As Object, objArgs As DataGridCommandEventArgs)
'runs when the "Cancel" link in the Datalist is clicked

  'set EditItemIndex property of grid to -1 to switch out of Edit mode
  dgrOrderLines.EditItemIndex = -1

  ShowOrderLines()  'bind the data and display it
  lblStatus.Text = "Changes to the order were abandoned."

End Sub

'--------------------------------------------------------------

Function GetOrdersFromSessionOrServer(strCustID As String) As DataSet
'gets a DataSet containing all order details for this customer

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

Function GetProductsFromSessionOrServer() As DataSet
'gets a DataSet containing the list of Products

  Try

    Dim objDataSet As DataSet

    'try and get DataSet from user's Session
    objDataSet = CType(Session("4923HTMLProductsDataSet"), DataSet)

    If objDataSet Is Nothing Then   'not in Session

      'get connection string from web.config
      Dim strConnect As String
      strConnect = ConfigurationSettings.AppSettings("NorthwindConnectString")

      'create an instance of the data access component
      Dim objOrderList As New UpdateOrders(strConnect)

      'call the method to return the data as a DataSet
      objDataSet = objOrderList.GetProductsDataSet()

      'save DataSet in Session for next order inquiry
      Session("4923HTMLProductsDataSet") = objDataSet

    End If

    Return objDataSet

  Catch objErr As Exception

    'there was an error and no data will be returned
    lblMessage.Text = "* ERROR: Cannot retrieve list of products.<br />" _
                    & objErr.Message

    Return Nothing

  End Try

End Function

</script>

<!---------------------------------------------------------->
