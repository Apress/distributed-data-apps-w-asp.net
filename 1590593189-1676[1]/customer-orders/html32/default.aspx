<%@Page Language="VB"%>
<%@Import Namespace="OrderListData" %>
<%@Import Namespace="System.Data" %>

<!------------------ HTML page content --------------------->

<html>
<head>
<title>View Customer Orders - Select Customer</title>
<!-- #include file="../../global/style.inc" -->
<script language="JavaScript">
<!--
// client-side script section used to set radio
// buttons to correct option as text is typed.
function setCheck(strName) {
  document.forms(0).elements(strName).checked = true;
}
//-->
</script>
</head>
<body link="#0000ff" alink="#0000ff" vlink="#0000ff">

<div class="heading">View Customer Orders - Select Customer</div>

<div align="right" class="cite">
[<a href="../../global/viewsource.aspx" target="_blank">view page source</a>]
</div><hr />

<form runat="server">
<table border="0" cellpadding="20"><tr><td valign="top" bgcolor="#fffacd">

  <!-- controls for specifying the required customer ID or name -->
  <asp:RadioButton id="optByID" groupname="SearchBy" Align="right"
                   text="Search by Customer ID: " runat="server" checked="true" /><br />
  &nbsp; &nbsp;
  <asp:TextBox id="txtCustID" columns="5" maxlength="5"
               onkeypress="setCheck('optByID');" runat="server" /><p />
  &nbsp; or<p />
  <asp:RadioButton id="optByName" groupname="SearchBy" Align="right"
                   text="Search by Customer Name:" runat="server" /><br />
  &nbsp; &nbsp;
  <asp:TextBox id="txtCustName" columns="20" maxlength="40"
               onkeypress="setCheck('optByName');" runat="server" /><p />
  <asp:Button id="btnSearch" text="Search" onclick="DoSearch" runat="server" />
  &nbsp; &nbsp;
  <asp:Button id="btnHelp" text="Help" onclick="ShowHelp" runat="server" /><p />
  <asp:Label id="lblStatus" runat="server" />

</td><td valign="top">

  <!-- DataGrid control to display matching customers -->
  <asp:DataGrid id="dgrCustomers" runat="server"
       AutoGenerateColumns="False"
       CellPadding="5"
       GridLines="Vertical"
       HeaderStyle-BackColor="silver"
       PagerStyle-BackColor="silver"
       AlternatingItemStyle-BackColor="#eeeeee"
       AllowPaging="true"
       PageSize="8"
       PagerStyle-Mode="NextPrev"
       PagerStyle-NextPageText="Next"
       PagerStyle-PrevPageText="Previous"
       PagerStyle-HorizontalAlign="Right"
       PagerStyle-Visible="false"
       DataKeyField="CustomerID"
       OnPageIndexChanged="ShowGridPage">

    <Columns>
      <asp:BoundColumn HeaderText="<b>ID</b>" HeaderStyle-HorizontalAlign="center"
                           DataField="CustomerID" ItemStyle-BackColor="#add8e6" />
      <asp:HyperlinkColumn HeaderText="<b>Customer Name</b>"
                           DataTextField="CompanyName" DataNavigateUrlField="CustomerID"
                           DataNavigateUrlFormatString="view-orders.aspx?customerid={0}" />
      <asp:BoundColumn HeaderText="<b>City</b>" DataField="City" />
      <asp:HyperlinkColumn Text="Edit Orders" DataNavigateUrlField="CustomerID"
                           DataNavigateUrlFormatString = "../../update-orders/html32/edit-orders.aspx?customerid={0}"/>
    </Columns>

  </asp:DataGrid><p />

  <!-- label to display interactive messages -->
  <asp:Label id="lblMessage" runat="server" />

</td></tr></table>
</form>

<!-- #include file="../../global/foot.inc" -->
</body>
</html>

<!-------------- server-side script section ---------------->

<script language="VB" runat="server">

'page-level variables accessed from more than one routine
Dim strCustID As String = ""
Dim strCustName As String = ""

'--------------------------------------------------------------

Sub Page_Load()

  'show Help when page first loads
  If Not Page.IsPostBack Then ShowHelp(Nothing, Nothing)

End Sub

'--------------------------------------------------------------

Sub DoSearch(ByVal objSender As Object, ByVal objArgs As EventArgs)
'display the list of matching customers in the DataGrid control

  'remove any existing "Orders" DataSets from the user's Session
  'as we're searching now for a different customer
  Session("4923HTMLOrdersDataSet") = Nothing

  'get one or other value from text boxes depending on selection
  If optByID.Checked Then
    strCustID = txtCustID.Text.ToUpper()
    lblStatus.Text = "Listing customers with an<br /><b>ID</b> that matches: '<b>" & strCustID & "</b>'"
  Else
    strCustName = txtCustName.Text
    lblStatus.Text = "Listing customers whose<br /><b>Name</b> contains: '<b>" & strCustName & "</b>'"
  End If

  'get DataSet using function elsewhere in this page
  Dim objDataSet As DataSet = GetDataSetFromServer(strCustID, strCustName)

  'check how many matching customers were found
  Dim intRowsFound As Integer = objDataSet.Tables(0).Rows.Count

  If intRowsFound > 0 Then

    'reset DataGrid page index to zero for new rowset and set DataSource
    dgrCustomers.CurrentPageIndex = 0
    dgrCustomers.DataSource = objDataSet.Tables(0)

    'display the "paging" controls (Previous/Next) only when required
    dgrCustomers.PagerStyle.Visible = (intRowsFound > dgrCustomers.PageSize)

    'bind the DataGrid and display status message
    dgrCustomers.DataBind()
    lblMessage.Text = "Click a <b>Customer Name</b> in the grid above to list" _
                    & "<br />all of the orders for that customer ... or click the" _
                    & "<br /><b>Edit Orders</b> link to edit orders for that customer."

  Else

    lblMessage.Text = "No matching customers found in database ..."

  End If

End Sub

'--------------------------------------------------------------

Sub ShowGridPage(ByVal objSender As Object, ByVal objArgs As DataGridPageChangedEventArgs)
'runs when the paging contols are clicked to display different page

  'set page index of DataGrid control to new value
  dgrCustomers.CurrentPageIndex = objArgs.NewPageIndex

  'get one or other value from text boxes depending on selection
  If optByID.Checked Then
    strCustID = txtCustID.Text.ToUpper()
  Else
    strCustName = txtCustName.Text
  End If

  'get the DataSet to populate the control and bind it
  dgrCustomers.DataSource = GetDataSetFromServer(strCustID, strCustName)
  dgrCustomers.DataBind()

End Sub

'--------------------------------------------------------------

Function GetDataSetFromServer(strCustID As String, strCustName As String) As DataSet
'uses data access component to get DataSet containing matching customer details

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
    lblMessage.Text = "ERROR: No data returned. " & objErr.Message

  End Try

End Function

'--------------------------------------------------------------

Sub ShowHelp(ByVal objSender As Object, ByVal objArgs As EventArgs)
'shows help on using page in the right-hand part of the window

  lblMessage.Text = "<b>To list customer orders you can</b>:<p />" _
  & "&nbsp; * Search for customers using their five-character <b>Customer ID</b>.<br />" _
  & "&nbsp; &nbsp; &nbsp; - Enter all or part of a customer identifier in the top text box<br />" _
  & "&nbsp; &nbsp; &nbsp; &nbsp; and click the <b>Search</b> button. You can enter a maximum of<br />" _
  & "&nbsp; &nbsp; &nbsp; &nbsp; <b>five</b> characters, and the list will show all the customers<br />" _
  & "&nbsp; &nbsp; &nbsp; &nbsp; whose ID starts with those characters.<p />" _
  & "&nbsp; * Search for customers using their <b>Name</b>.<br />" _
  & "&nbsp; &nbsp; &nbsp; - Enter all or part of a customer name in the lower text box<br />" _
  & "&nbsp; &nbsp; &nbsp; &nbsp; and click the <b>Search</b> button. You can enter a maximum of<br />" _
  & "&nbsp; &nbsp; &nbsp; &nbsp; <b>40</b> characters, and the list will show all the customers<br />" _
  & "&nbsp; &nbsp; &nbsp; &nbsp; whose name contains that word or set of characters.<p />"

End Sub

</script>

<!---------------------------------------------------------->
