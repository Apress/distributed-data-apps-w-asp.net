<%@Page Language="VB"%>
<%@Import Namespace="OrderListData" %>
<%@Import Namespace="System.Data" %>

<script language="VB" runat="server">
'--------------------------------------------------------------

Sub Page_Load(objSender As Object, objArgs As EventArgs )

  ' get values from query string
  Dim strType As String = Request.QueryString("type")
  Dim strCustID As String = Request.QueryString("customerid")

  ' set content-type to return a tab-delimited text file
  Response.ContentType = "text/text"

  ' call function to create output and write to response
  Select Case strType
    Case "customerlist"
      Response.Write(GetCustomerDataFromServer())
    Case "orderlist"
      Response.Write(GetOrderDataFromServer(strCustID))
    Case "orderdetail"
      Response.Write(GetDetailDataFromServer(strCustID))
  End Select

End Sub

'--------------------------------------------------------------

Public Function GetCustomerDataFromServer() As String
' uses data access component to get tab-delimited string
' containing a list of all the customers

  ' get connection string from connect-strings.ascx user control
  Dim strConnect As String = ConfigurationSettings.AppSettings("NorthwindConnectString")

  Dim objDataSet As DataSet

  Try

    ' create an instance of the data access component
    Dim objOrderList As New OrderList(strConnect)

    ' call the method to get the data as a DataSet
    objDataSet = objOrderList.GetCustomerByIdOrName("", "")

    ' iterate through each row in the table building the output
    Dim strResult As String
    strResult = "CustomerID" & vbTab & "CompanyName" & vbTab _
              & "City" & vbTab & "ViewOrderHref" & vbCrlf

    Dim objTable As DataTable  = objDataSet.Tables("Customers")
    Dim objRow As DataRow
    For Each objRow In objTable.Rows
      strResult &= objRow("CustomerID").ToString() & vbTab _
                & objRow("CompanyName").ToString() & vbTab _
                & objRow("City").ToString() & vbTab _
                & "view-orders.aspx?customerid=" _
                & objRow("CustomerID").ToString() & vbCrlf

    Next

    Return strResult

  Catch

    ' there was an error so no data is returned
    Return ""

  End Try

End Function

'--------------------------------------------------------------

Public Function GetOrderDataFromServer(strCustID As String) As String
' uses data access component to get tab-delimited string
' containing a list of all orders for specified customer

  ' get connection string from connect-strings.ascx user control
  Dim strConnect As String = ConfigurationSettings.AppSettings("NorthwindConnectString")

  Dim objDataSet As DataSet

  Try

    ' create an instance of the data access component
    Dim objOrderList As New OrderList(strConnect)

    ' call the method to get the data as a DataSet
    objDataSet = objOrderList.GetOrdersByCustomerDataSet(strCustID)


    ' create the headings row for the output string
    Dim strResult As String
    strResult = "OrderID" & vbTab & "ShipName" & vbTab _
              & "OrderAddress" & vbTab & "OrderDate" & vbTab _
              & "ShippedDate" & vbTab & "CompanyName" & vbTab _
              & "OrderDetailHref" & vbCrlf

    ' iterate through each row in the table building the output
    Dim objTable As DataTable = objDataSet.Tables("Orders")
    Dim objRow As DataRow
    For Each objRow in objTable.Rows

      ' get values from columns as correct data types
      Dim datOrderDate As DateTime  = objRow("OrderDate")

      ' create the result string for this row
      strResult &= objRow("OrderID").ToString() & vbTab _
                & objRow("ShipName").ToString() & vbTab _
                & objRow("OrderAddress").ToString() & vbTab _
                & datOrderDate.ToString("yyyy-MM-dd") & vbTab
      If IsDBNull(objRow("ShippedDate")) Then
        strResult &= vbTab   ' no "shipped date" value
      Else
        Dim datShippedDate As DateTime  = objRow("ShippedDate")
        strResult &= datShippedDate.ToString("yyyy-MM-dd") & vbTab
      End If
      strResult &= objRow("CompanyName").ToString() & vbTab _
                & "javascript:ShowOrderDetail('" _
                & objRow("OrderID").ToString() & "')" & vbCrlf
    Next

    Return strResult

  Catch

    ' there was an error so no data is returned
    Return ""

  End Try

End Function
'--------------------------------------------------------------

Public Function GetDetailDataFromServer(strCustID As String) As String
' uses data access component to get tab-delimited string
' containing a list of all order lines for specified customer

  ' get connection string from connect-strings.ascx user control
  Dim strConnect As String = ConfigurationSettings.AppSettings("NorthwindConnectString")

  Dim objDataSet As DataSet

  Try

    ' create an instance of the data access component
    Dim objOrderList As New OrderList(strConnect)

    ' call the method to get the data as a DataSet
    objDataSet = objOrderList.GetOrdersByCustomerDataSet(strCustID)

    ' create the headings row for the output string
    Dim strResult As String
    strResult = "OrderID" & vbTab & "ProductName" & vbTab _
              & "QuantityPerUnit" & vbTab & "UnitPrice" & vbTab _
              & "Quantity" & vbTab & "Discount" & vbTab & "LineTotal" & vbCrlf

    ' iterate through each row in the table building the output
    Dim objTable As DataTable = objDataSet.Tables("OrderLines")
    Dim objRow As DataRow

    For Each objRow in objTable.Rows

      ' get values from columns as correct data types
      Dim decPrice As Decimal  = objRow("UnitPrice")
      Dim intQty As Integer = objRow("Quantity")
      Dim decDiscount As Decimal  = objRow("Discount")

      ' calculate total value of this order line
      Dim decTotal As Decimal = intQty * (decPrice - (decPrice * decDiscount))

      ' create the result string for this row
      strResult &= objRow("OrderID").ToString() & vbTab _
                & objRow("ProductName").ToString() & vbTab _
                & objRow("QuantityPerUnit").ToString() & vbTab _
                & decPrice.ToString("N2") & vbTab _
                & intQty.ToString() & vbTab _
                & decDiscount.ToString("p") & vbTab _
                & decTotal.ToString("N2") & vbCrlf
    Next

    Return strResult

  Catch

    ' there was an error so no data is returned
    Return ""

  End Try

End Function
'--------------------------------------------------------------
</script>
