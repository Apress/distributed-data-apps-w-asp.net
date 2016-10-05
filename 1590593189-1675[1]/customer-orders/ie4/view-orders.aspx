<%@Page Language="C#"%>

<html>
<head>

<title>View Customer Orders - Select Order</title>
<!-- #include file="../../global/style.inc" -->

<!-------------- Server-side Script Section ---------------->

<script language="C#" runat="server">

String strCustID, strOrdersURL, strDetailURL;

void Page_Load() {

  // get the customer ID from the query string
  strCustID = Request.QueryString["customerid"];

  if (strCustID != "") {

    // create URLs and query strings to load order details for this customer
    strOrdersURL = "order-data.aspx?type=orderlist&customerid=" + strCustID;
    strDetailURL = "order-data.aspx?type=orderdetail&customerid=" + strCustID;

  }
}
</script>

<!-------------- Client-side Script Section ---------------->

<script language="VBScript">
<!--

Dim objOrdersData   'to hold reference to Order List TDC
Dim objDetailData   'to hold reference to Order Detail TDC
Dim strCustID       'ID of the customer to view orders for
QUOT = Chr(34)      'double-quote character

'----------------------------------------------------

Sub Document_OnReadyStateChange()
'runs once page and all content (including TDC data) is loaded

  If Document.ReadyState = "complete" Then
    strCustID = "<% = strCustID %>"
    ShowOrderList()
  End If

End Sub

'----------------------------------------------------

Sub ShowOrderList()
'show the list of orders in the left-hand table

  'set the reference to the left-hand TDC object
  Set objOrdersData = document.all("tdcOrders")

  'see if we got any rows loaded into the TDC by trying
  'to reference the first ID value
  On Error Resume Next
  strFirstID = objOrdersData.Recordset(0)
  On Error Goto 0

  If Len(strFirstID) > 0 Then

    'display messages and make table visible
    document.all("lblStatus").InnerHTML = _
           "Orders for customer ID <b>'" & strCustID & "'</b>"
    document.all("tblOrders").style.display = ""
    strMsg = "Click an <b>Order ID</b> in the grid above<br />" _
           & "to display details of that order. Click<br />" _
           & "a <b>column heading</b> to sort orders<br />" _
           & "by the values in that column ...<br />" _
           & "or <a href='default.aspx'><b>select a different customer</b></a>."

  Else

    document.all("lblStatus").InnerHTML = ""
    strMsg = "No orders found for this customer ...<br />" _
           & "<a href='default.aspx'><b>Select a different customer</b></a>"

  End If

  document.all("lblMessage").InnerHTML = strMsg

End Sub

'----------------------------------------------------

Sub SortOrderList(strSortOrder)
're-sort the list of orders in the left-hand table

    objOrdersData.Sort = strSortOrder
    objOrdersData.Reset

End Sub

'----------------------------------------------------

Sub ShowOrderDetail(strOrderID)
'show the order details and right-hand table of order lines

  'set the reference to the right-hand TDC object
  Set objDetailData = document.all("tdcDetail")

  'set the Filter property to display just the selected order
  objDetailData.Filter = "OrderID = " & QUOT & strOrderID & QUOT
  objDetailData.Reset

  'get references to the two TDC Recordsets
  Set objOrdersRecs = objOrdersData.Recordset
  Set objDetailRecs = objDetailData.Recordset

  'scroll through Orders records to find the selected one
  objOrdersRecs.MoveFirst()
  Do While objOrdersRecs("OrderID") <> objDetailRecs("OrderID")
    objOrdersRecs.MoveNext()
  Loop

  'display the shipping details of the order
  strDetail = "Order ID: <b>" & objDetailRecs("OrderID") & "</b>" _
    & " &nbsp; Customer Name: <b>" & objOrdersRecs("ShipName") & "</b><br />" _
    & "Delivery Address: " & objOrdersRecs("OrderAddress") & "<br />" _
    & "Ordered: " & objOrdersRecs("OrderDate") & " &nbsp; "
  If objOrdersRecs("ShippedDate") = "" Then
    strDetail = strDetail & "Awaiting shipping"
  Else
    strDetail = strDetail & "Shipped: " & objOrdersRecs("ShippedDate")
  End If
  strDetail = strDetail & " via " & objOrdersRecs("CompanyName")
  document.all("lblOrderDetail").InnerHTML = strDetail

  'calculate and display the total value of the order
  dblTotal = 0
  Do While Not objDetailRecs.EOF
    dblTotal = dblTotal + objDetailRecs("LineTotal")
    objDetailRecs.MoveNext()
  Loop
  document.all("lblOrderTotal").InnerHTML = "Total order value: <b>$" _
    & FormatNumber(dblTotal, 2) & "</b>"

  'make the table visible
  document.all("tblDetail").style.display = ""

End Sub

'-->
</script>

<!------------------ HTML page content --------------------->

</head>

<body link="#0000ff" alink="#0000ff" vlink="#0000ff">

<object id="tdcOrders" width="0" height="0"
        classid="CLSID:333c7bc4-460f-11d0-bc04-0080c7055a83">
  <param name="FieldDelim" value="&#09;">
  <param name="UseHeader" value="true">
  <param name="CaseSensitive" value="false">
  <param name="CharSet" value="utf-8">
  <param name="DataURL" value="<% = strOrdersURL %>" />
</object>

<object id="tdcDetail" width="0" height="0"
        classid="CLSID:333c7bc4-460f-11d0-bc04-0080c7055a83">
  <param name="FieldDelim" value="&#09;">
  <param name="UseHeader" value="true">
  <param name="CaseSensitive" value="false">
  <param name="CharSet" value="utf-8">
  <param name="DataURL" value="<% = strDetailURL %>" />
</object>

<div class="heading">View Customer Orders - Select Order</div>

<div align="right" class="cite">
[<a href="../../global/viewsource.aspx?compsrc=order-data.aspx">view page source</a>]
</div><hr />

<table border="0" cellpadding="20"><tr><td valign="top" bgcolor="#fffacd">

  <!-- label to display customer ID -->
  <span id="lblStatus">Loading order data, please wait...</span><p />

  <table id="tblOrders" cellspacing="0" cellpadding="5" datasrc="#tdcOrders"
         rules="cols" border="1" style="border-collapse:collapse;display:none;">
   <thead>
   <tr style="background-color:silver;">
    <td align="center" nowrap="nowrap">
      <a href="javascript:SortOrderList('OrderID')"><b>ID</b></a>
    </td>
    <td align="left" nowrap="nowrap">
      <a href="javascript:SortOrderList('-OrderDate')"><b>Order Date</b></a>
    </td>
    <td align="left" nowrap="nowrap">
      <a href="javascript:SortOrderList('-ShippedDate')"><b>Shipped</b></a>
    </td>
   </tr>
   </thead>
   <tbody>
    <tr>
     <td align="center" nowrap="nowrap" style="background-color:#add8e6;">
      <a datafld="OrderDetailHref" dataformatas="text"><span datafld="OrderID"></span></a>
     </td>
     <td align="left" nowrap="nowrap" style="background-color:#ffffff;">
      <span datafld="OrderDate" dataformatas="html"></span>
     </td>
     <td align="left" nowrap="nowrap" style="background-color:#ffffff;">
      <span datafld="ShippedDate" dataformatas="html"></span>
     </td>
    </tr>
   </tbody>
  </table><p />

  <!-- label to display interactive messages -->
  <span id="lblMessage"></span>

</td><td valign="top">

  <!-- controls to display order details -->
  <span id="lblOrderDetail">
    Select an order from the first column in the list shown on
    the left to display the order details.
  </span><p />

   <table id="tblDetail" cellspacing="0" cellpadding="5" datasrc="#tdcDetail"
          border="1" style="border-collapse:collapse;display:none;">
   <thead>
    <tr style="background-color:silver;">
     <td align="center"><b>Qty</b></td>
     <td align="center"><b>Product</b></td>
     <td align="center"><b>Packs</b></td>
     <td align="center"><b>Each</b></td>
     <td align="center"><b>Discount</b></td>
     <td align="center"><b>Total</b></td>
    </tr>
   </thead>
   <tbody>
    <tr>
     <td align="center">
      <span datafld="Quantity" dataformatas="html"></span>
     </td>
     <td align="left">
      <span datafld="ProductName" dataformatas="html"></span>
     </td>
     <td align="left">
      <span datafld="QuantityPerUnit" dataformatas="html"></span>
     </td>
     <td align="right" nowrap="nowrap">
      $<span datafld="UnitPrice" dataformatas="html"></span>
     </td>
     <td align="right" nowrap="nowrap">
      <span datafld="Discount" dataformatas="html"></span>
     </td>
     <td align="right" nowrap="nowrap">
      $<span datafld="LineTotal" dataformatas="html"></span>
     </td>
    </tr>
   </tbody>
  </table><p />

  <span id="lblOrderTotal"></span>

</td></tr></table>

<!-- #include file="../../global/foot.inc" -->

</body>
</html>
