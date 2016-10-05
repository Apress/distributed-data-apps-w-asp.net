<%@Page Language="VB" EnableViewState="false" %>
<%@Import Namespace="OrderListData" %>
<%@Import Namespace="System.Data" %>

<!------------------ HTML page content --------------------->

<html>
<head>
<title>Order Details : Related DataSet from Relational Database</title>
<!-- #include file="../global/style.inc" -->
</head>
<body>

<div class="heading">Order Details : Related DataSet from Relational Database</div>

<div align="right" class="cite">
[<a href="../global/viewsource.aspx?compsrc=order-list-data.vb">view page source</a>]
</div><br />

<form runat="server">
  Customer ID:
  <asp:TextBox id="txtCustID" columns="5" maxlength="5" runat="server" text="ALFK%" />
  <asp:Button text="Go" runat="server" /> &nbsp;  &nbsp; Show as:
  <asp:RadioButton id="optTables" groupname="ShowAs" text="Tables"
                   autopostback="true" runat="server" checked="true" />
  <asp:RadioButton id="optList" groupname="ShowAs" text="List"
                   autopostback="true" runat="server" />
</form>

<asp:Label id="lblMessage" runat="server" />

<asp:DataGrid id="dgrOrders" runat="server">
<HeaderStyle BackColor="#c0c0c0"></HeaderStyle>
<AlternatingItemStyle BackColor="#eeeeee"></AlternatingItemStyle>
</asp:DataGrid><br />

<asp:DataGrid id="dgrOrderLines" runat="server">
<HeaderStyle BackColor="#c0c0c0"></HeaderStyle>
<AlternatingItemStyle BackColor="#eeeeee"></AlternatingItemStyle>
</asp:DataGrid><br />

<b>
<asp:Hyperlink NavigateUrl="custlist-dataset-from-db.aspx"
              Text="Search for customers..." runat="server" />
</b>

<!-- #include file="../global/foot.inc" -->
</body>
</html>

<!-------------- server-side script section ---------------->

<script language="VB" runat="server">

Sub Page_Load()

  'get customer ID to use in stored procs from text box
  Dim strCustID As String = txtCustID.Text

  'get connection string from web.config
  Dim strConnect As String
  strConnect = ConfigurationSettings.AppSettings("NorthwindConnectString")

  'declare variable to hold instance of DataSet object
  Dim objDataSet As DataSet

  Try

    'create an instance of the data access component
    Dim objOrderList As New OrderList(strConnect)

    'call the method to return the data as a DataSet
    objDataSet = objOrderList.GetOrdersByCustomerDataSet(strCustID)

    If optTables.Checked Then   'show as separate tables of data

      'assign table named Orders to first DataGrid server control
      dgrOrders.DataSource = objDataSet.Tables("Orders")

      'assign table named OrderLines to second DataGrid server control
      dgrOrderLines.DataSource = objDataSet.Tables("OrderLines")

      'if there are tables in DataSet, bind all server controls on page
      If Not dgrOrders.DataSource Is Nothing Then Page.DataBind()

    Else   'show as a nested list

      'create a variable to hold the results for display
      Dim strResult As String = ""

      'create a reference to the Orders (parent) table in the DataSet
      Dim objTable As DataTable = objDataSet.Tables("Orders")

      'create reference to the relationship object in the DataSet
      Dim objRelation As DataRelation = objTable.ChildRelations("CustOrderLines")

      'declare variables to hold row objects and an array of rows
      Dim objRow, objChildRow As DataRow
      Dim colChildRows() As DataRow

      'iterate through the rows in the Orders table
      For Each objRow In objTable.Rows

        'get the order details and append them to the "results" string
        strResult &= "<b>" & objRow("ShipName") & "</b> (" _
          & objRow("CustomerID") & ")<br />&nbsp; Order ID: " & objRow("OrderID") _
          & " &nbsp; Order Date: " & FormatDateTime(objRow("OrderDate"), 1) & "<br />&nbsp; "
        If IsDbNull(objRow("ShippedDate")) Then
          strResult &= "Awaiting shipping"
        Else
          strResult &= "Shipped: " & FormatDateTime(objRow("ShippedDate"), 1)
        End If
        strResult &= " via " & objRow("CompanyName") & "<br />" _
          & " &nbsp; To: " & objRow("OrderAddress") & "<br />"

        'get a collection (array) of all the matching OrderLines rows for this row
        colChildRows = objRow.GetChildRows(objRelation)

        'iterate through all the matching OrderLines rows adding to the result string
        For Each objChildRow In colChildRows
           strResult &= "  &nbsp;  &nbsp; " & objChildRow("Quantity") & " (" _
             & objChildRow("QuantityPerUnit") & ") " & objChildRow("ProductName") _
             & " at " & FormatCurrency(objChildRow("UnitPrice")) & " less " _
             & FormatPercent(objChildRow("Discount")) & "<br />"
        Next

        strResult += "<br />"

      Next  'and repeat for next row in Orders table

      lblMessage.Text = strResult  'display the results

    End If

  Catch objErr As Exception

    'there was an error and no data will be returned
    lblMessage.Text = "ERROR: No data returned. " & objErr.Message

  End Try

End Sub

</script>

<!---------------------------------------------------------->
