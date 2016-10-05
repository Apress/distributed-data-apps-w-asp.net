<%@Page Language="VB" EnableViewState="False"%>
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

<script language="VB" runat="server">

'page-level variables accessed from more than one routine
Dim strCustID As String = ""
Dim strOrderID As String = ""

'--------------------------------------------------------------

Sub Page_Load()

  If Not Page.IsPostBack Then

    strCustID = Request.QueryString("customerid")
    strOrderID = Request.QueryString("orderid")
    If (strOrderID Is Nothing) Or (strOrderID = "") _
    Or (strCustID Is Nothing) Or (strCustID = "") Then

      'display help message
      lblMessage.Text = "Select an order from the first column " _
        & "in the list shown on the left to display the order details."

    Else

      'display order details for this order
      ShowOrderLines()

    End If

  End If

End Sub

'--------------------------------------------------------------

Sub ShowOrderLines()
'display all the order line details for this order in DataGrid control

  'get DataSet using function elsewhere in this page
  Dim objDataSet As DataSet = GetDataSetFromSessionOrServer(strCustID)

  'create filtered DataView from Orders table in DataSet
  Dim objOrderView As DataView = objDataSet.Tables("Orders").DefaultView
  objOrderView.RowFilter = "OrderID = " & strOrderID

  'create filtered DataView from LinesTable table
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

    'display the shipping details in Message Label
    lblMessage.Text = "Order ID: <b>" & strOrderID & "</b>" _
      & " &nbsp; Customer Name: <b>" & objOrderView.Item(0)("ShipName") & "</b><br />" _
      & "Delivery Address: " & objOrderView.Item(0)("OrderAddress") & "<br />" _
      & "Ordered: " & FormatDateTime(objOrderView.Item(0)("OrderDate")) & " &nbsp; "
    If IsDbNull(objOrderView.Item(0)("ShippedDate")) Then
      lblMessage.Text &= "Awaiting shipping"
    Else
      lblMessage.Text &= "Shipped: " & FormatDateTime(objOrderView.Item(0)("ShippedDate"))
    End If
    lblMessage.Text &= " via " & objOrderView.Item(0)("CompanyName")

    'set DataSource and bind the DataGrid
    dgrOrders.DataSource = objLinesView
    dgrOrders.DataBind()

    'display the total value of the order
    lblTotal.Text = "Total order value: <b>" & dblTotal.ToString("$#,##0.00") & "</b>"

  Else

    lblMessage.Text = "No order lines found for this order..."

  End If

End Sub

'--------------------------------------------------------------

Function GetDataSetFromSessionOrServer(strCustID As String) As DataSet
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
      Dim objOrderList As New OrderList(strConnect)

      'call the method to return the data as a DataSet
      objDataSet = objOrderList.GetOrdersByCustomerDataSet(strCustID)

      'add a column containing the total value of each line
      Dim objLinesTable As DataTable = objDataSet.Tables("OrderLines")
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

</script>

<!---------------------------------------------------------->
