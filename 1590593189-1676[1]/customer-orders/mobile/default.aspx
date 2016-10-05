<%@Page Inherits="System.Web.UI.MobileControls.MobilePage" Language="VB"%>
<%@Register TagPrefix="Mobile" Namespace="System.Web.UI.MobileControls" Assembly="System.Web.Mobile"%>
<%@Import Namespace="OrderListData" %>
<%@Import Namespace="System.Data" %>

<mobile:Form id="frmCustType" title="View Customer Orders" styleReference="styPage" runat="server">
  <mobile:Label id="lblMsg1" styleReference="styHeading" runat="server">Select Search Type</mobile:Label><br /><br />
  <mobile:Label id="lblType" Font-Bold="true" runat="server">Search by:</mobile:Label>
  <mobile:List id="lstType" styleReference="styListAndLink" OnItemCommand="SetSearchType" runat="server">
    <Item Text="Customer ID" Value="CustID" />
    <Item Text="Customer Name" Value="CustName" />
  </mobile:List>
</mobile:Form>

<mobile:Form id="frmCustSearch" title="Customer Search" styleReference="styPage" runat="server">
  <mobile:Label id="lblMsg2" styleReference="styHeading" runat="server">Search for Customer</mobile:Label><br /><br />
  <mobile:Label id="lblSearchType" Font-Bold="true" runat="server" />
  <mobile:TextBox id="txtSearchString" runat="server" />
  <mobile:Command id="cmdSearch" CommandName="Search" OnClick="GetCustomers" SoftKeyLabel="Search" Text="Search" runat="server" /><br />
  <mobile:Label id="lblSearchTips" runat="server" /><br />
  <mobile:Link NavigateUrl="#frmCustType" SoftKeyLabel="Back" Text="Change Search Type" styleReference="styListAndLink" runat="server" />
</mobile:Form>

<mobile:Form id="frmCustSelect" title="Select Customer" styleReference="styPage" runat="server">
  <mobile:Label id="lblMsg3" styleReference="styHeading" runat="server">Select Customer</mobile:Label><br /><br />
  <mobile:Label id="lblStatus1" Font-Bold="true" runat="server" />
  <mobile:List id="lstCustomers" OnItemCommand="GetOrders" styleReference="styListAndLink" runat="server" /><br />
  <mobile:Link NavigateUrl="#frmCustType" SoftKeyLabel="Customer" Text="Change Search" styleReference="styListAndLink" runat="server" />
</mobile:Form>

<mobile:Form id="frmOrderSelect" title="Select Order" styleReference="styPage" runat="server">
  <mobile:Label id="lblMsg4" styleReference="styHeading" runat="server">Select Order</mobile:Label><br /><br />
  <mobile:Label id="lblStatus2" Font-Bold="true" runat="server" />
  <mobile:List id="lstOrders" OnItemCommand="ShowOrderDetail" styleReference="styListAndLink" runat="server" /><br />
  <mobile:Link NavigateUrl="#frmCustType" SoftKeyLabel="Customer" Text="Select Customer" styleReference="styListAndLink" runat="server" />
  <mobile:Link id="lnkEditOrders" SoftKeyLabel="Edit Orders" Text="Edit Orders" styleReference="styListAndLink" runat="server" />
</mobile:Form>

<mobile:Form id="frmOrderDetail" title="Order Details" styleReference="styPage" runat="server">
  <mobile:Label id="lblOrderNo" Font-Bold="true" runat="server" />
  <mobile:Label id="lblCustName" runat="server" />
  <mobile:Label id="lblAddress" runat="server" />
  <mobile:Label id="lblOrdered" runat="server" />
  <mobile:Label id="lblShipped" runat="server" />
  <mobile:Label id="lblVia" runat="server" /><br /><br />
  <mobile:List id="lstOrderLines" styleReference="styListAndLink" runat="server" /><br />
  <mobile:Label id="lblTotal" Font-Bold="true" runat="server" /><br />
  <mobile:Link NavigateUrl="#frmOrderSelect" SoftKeyLabel="Order" Text="Select Order" styleReference="styListAndLink" runat="server" />
  <mobile:Link NavigateUrl="#frmCustType" SoftKeyLabel="Customer" Text="Select Customer" styleReference="styListAndLink" runat="server" />
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

<!-------------- server-side script section ---------------->

<script language="VB" runat="server">

Sub SetSearchType(objSender As Object, objArgs As ListCommandEventArgs)
'set the correct text on page 2 (frmCustSearch) and display it

  'fill in Label text
  If objArgs.ListItem.Value = "CustName" Then
    lblSearchType.Text = "Customer Name:"
    lblSearchTips.Text = "Hint: enter any part of the customer's name - up to 40 characters in total."
  Else
    lblSearchType.Text = "Customer ID:"
    lblSearchTips.Text = "Hint: enter all or the first part of the customer's ID - up to 5 characters in total."
  End If

  'display page 2
  ActiveForm = frmCustSearch

End Sub

'------------------------------------------------------------

Sub GetCustomers(objSender As Object, objArgs As EventArgs)
'create the list of matching customers on page 3 and display it

  Dim strCustID As String = ""
  Dim strCustName As String = ""

  'hide the list control until we see if we get a result
  lstCustomers.Visible = "False"

  'check customer search type selection
  If Instr(lblSearchType.Text, "Name") > 0 Then
    strCustName = txtSearchString.Text
  Else
    strCustID = txtSearchString.Text.ToUpper()
  End If

  'get DataSet using function elsewhere in this page
  Dim objDataSet As DataSet = GetCustomerDataSetFromServer(strCustID, strCustName)

  'if there was an error display message
  If objDataSet Is Nothing Then

    lblStatus1.Text = "Error accessing database"

  Else

    'check how many matching customers were found
    Dim intRowsFound As Integer = objDataSet.Tables(0).Rows.Count

    If intRowsFound > 0 Then

      'bind the DataGrid and display status message
      lstCustomers.DataSource = objDataSet.Tables(0)
      lstCustomers.DataTextField = "CompanyName"
      lstCustomers.DataValueField = "CustomerID"
      lstCustomers.DataBind()
      lstCustomers.Visible = True
      lblStatus1.Text = "Found Customers:"

    Else

      lblStatus1.Text = "No matching customers found in database ..."

    End If

  End If

  'display page 3 containing the list
  ActiveForm = frmCustSelect

End Sub

'------------------------------------------------------------

Sub GetOrders(objSender As Object, objArgs As ListCommandEventArgs)
'create a list of all orders for this customer on page 4

  'get CustomerID from selection made in List control on page 3
  Dim strCustID As String = objArgs.ListItem.Value

  'get DataSet using function elsewhere in this page
  Dim objDataSet As DataSet = GetOrderDataSetFromSessionOrServer(strCustID)

  'if there was an error display message
  If objDataSet Is Nothing Then

    lblStatus1.Text = "Error accessing database"

  Else

    'check if any orders were found for this customer
    If objDataSet.Tables("Orders").Rows.Count > 0 Then

      'diplay heading above List control
      lblStatus2.Text = "Customer '" & strCustID & "'"

      'set DataSource and bind the List control
      lstOrders.DataSource = objDataSet.Tables("Orders")
      lstOrders.DataTextField = "DisplayCol"
      lstOrders.DataValueField = "OrderID"
      lstOrders.DataBind()

      'set URL for editing orders in Link control
      lnkEditOrders.NavigateUrl = "../../update-orders/mobile/edit-orders.aspx" _
                                & "?customerid=" & strCustID

    Else

      lblStatus2.Text = "No orders found for this customer ..."

    End If

  End If

  'display page 4 containing the list
  ActiveForm = frmOrderSelect

End Sub

'------------------------------------------------------------

Sub ShowOrderDetail(objSender As Object, objArgs As ListCommandEventArgs)
'create order line details to display on page 5

  'get OrderID from selection made in List control on page 4
  Dim strOrderID As String = objArgs.ListItem.Value

  'get CustomerID by parsing out of Label control on page 4
  Dim strCustID As String = Mid(lblStatus2.Text, InStr(lblStatus2.Text, ":") + 1)

  'get DataSet using function elsewhere in this page
  Dim objDataSet As DataSet = GetOrderDataSetFromSessionOrServer(strCustID)

  'create filtered DataView from Orders table in DataSet
  Dim objOrderView As DataView = objDataSet.Tables("Orders").DefaultView
  objOrderView.RowFilter = "OrderID = " & strOrderID

  'create filtered DataView from OrderLines table in DataSet
  Dim objLinesView As DataView = objDataSet.Tables("OrderLines").DefaultView
  objLinesView.RowFilter = "OrderID = " & strOrderID

  'calculate total value of order
  Dim dblTotal As Double = 0
  Dim objDataRowView As DataRowView
  For Each objDataRowView In objLinesView
    dblTotal += objDataRowView("LineTotal")
  Next

  'check that there are some matching order lines
  If objLinesView.Count > 0 Then

    'display the shipping details in Labels
    lblOrderNo.Text = "Order No: " & strOrderID
    lblCustName.Text = "Customer: " & objOrderView.Item(0)("ShipName")
    lblAddress.Text = objOrderView.Item(0)("OrderAddress")
    Dim datThisDate as DateTime = objOrderView.Item(0)("OrderDate")
    lblOrdered.Text = "Ordered: " & datThisDate.ToString("d")
    If IsDbNull(objOrderView.Item(0)("ShippedDate")) Then
      lblShipped.Text = "Awaiting shipping"
    Else
      datThisDate = objOrderView.Item(0)("ShippedDate")
      lblShipped.Text = "Shipped: " & datThisDate.ToString("d")
    End If
    lblVia.Text = "via " & objOrderView.Item(0)("CompanyName")

    'display the total value of the order
    lblTotal.Text = "Total value: " & dblTotal.ToString("$#,##0.00")

    'set DataSource and bind the List control
    lstOrderLines.DataSource = objLinesView
    lstOrderLines.DataTextField = "DisplayCol"
    lstOrderLines.DataBind()

  Else

    lblOrderNo.Text = "No order lines found for this order..."

  End If

  'display page 4 containing the details
  ActiveForm = frmOrderDetail

End Sub

'------------------------------------------------------------

Function GetCustomerDataSetFromServer(strCustID As String, strCustName As String) As DataSet
'uses data access component to get DataSet containing matching customer details

  'remove any existing "Orders" DataSet from the user's Session
  'as we're searching now for a different customer
  Session("4923MobileShowOrdersDataSet") = Nothing

  'get connection string from web.config
  Dim strConnect As String
  strConnect = ConfigurationSettings.AppSettings("NorthwindConnectString")

  Try

    'create an instance of the data access component
    Dim objOrderList As New OrderList(strConnect)

    'call the method to return the data as a DataSet
    Return objOrderList.GetCustomerByIdOrName(strCustID, strCustName)

  Catch objErr As Exception

    'there was an error and no data will be returned
    Return Nothing

  End Try

End Function

'------------------------------------------------------------

Function GetOrderDataSetFromSessionOrServer(strCustID As String) As DataSet
'uses data access component to get DataSet containing orders for this customer
'DataSet is cached in the user's Session and retrieved from there next time
'if client does not support cookies it's extracted from the database each time

  Dim objDataSet As DataSet

  Try

    'try and get DataSet from user's Session
    objDataSet = CType(Session("4923MobileShowOrdersDataSet"), DataSet)

    If objDataSet Is Nothing Then   'not in Session

      'get connection string from web.config
      Dim strConnect As String
      strConnect = ConfigurationSettings.AppSettings("NorthwindConnectString")

      'create an instance of the data access component
      Dim objOrderList As New OrderList(strConnect)

      'call the method to return the data as a DataSet
      objDataSet = objOrderList.GetOrdersByCustomerDataSet(strCustID)

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

      'get a reference to the "OrderLines" table in the DataSet
      objTable = objDataSet.Tables("OrderLines")

      'add a column containing the total value of each line to use for calculating total
      objColumn = objTable.Columns.Add("LineTotal", System.Type.GetType("System.Double"))
      objColumn.Expression = "[Quantity] * ([UnitPrice] - ([UnitPrice] * [Discount]))"

      'add a column containing the order details as one string value
      objColumn = objTable.Columns.Add("DisplayCol", System.Type.GetType("System.String"))

      'fill in this column for each row as "qty x product (pack) @ price less discount = total"
      Dim strColValue As String
      For Each objRow In objTable.Rows
        Dim dblThisPrice as Double = objRow("UnitPrice")
        strColValue = objRow("Quantity").ToString & " x " & objRow("ProductName") _
                    & " (" & objRow("QuantityPerUnit") & ") @ " & dblThisPrice.ToString("$#0.00")
        If objRow("Discount") > 0 Then
          dblThisPrice = objRow("Discount")
          strColValue &= " Less " & dblThisPrice.ToString("P")
        End If
        dblThisPrice = objRow("LineTotal")
        objRow("DisplayCol") = strColValue & " = " & dblThisPrice.ToString("$#0.00")
      Next

      'save DataSet in Session for next order inquiry
      Session("4923MobileShowOrdersDataSet") = objDataSet

    End If

    Return objDataSet   'return DataSet to calling routine

  Catch objErr As Exception

    'there was an error and no data will be returned
    Return Nothing

  End Try

End Function

'------------------------------------------------------------
</script>
