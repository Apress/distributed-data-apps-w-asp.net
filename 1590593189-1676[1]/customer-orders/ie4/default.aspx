<%@Page Language="VB" %>

<html>
<head>

<title>View Customer Orders - Select Customer</title>
<!-- #include file="../../global/style.inc" -->

<!-------------- Client-side Script Section ---------------->

<script language="VBScript">
<!--

Dim objCustData  'to hold reference to TDC control
QUOT = Chr(34)   'double-quote character

'----------------------------------------------------

Sub Document_OnReadyStateChange()
'runs once page and all content (including TDC data) is loaded
'enable the Search button and show the Help details

  If Document.ReadyState = "complete" Then
    document.all("btnSearch").disabled = false
    document.all("lblStatus").InnerHTML = ""
    ShowHelp()
  End If

End Sub

'----------------------------------------------------

Sub SetCheck(strName)
'set radio buttons to correct option as text is typed
  document.forms(0).elements(strName).checked = True
End Sub

'----------------------------------------------------

Sub DoSearch(strSortOrder)
'display the list of matching customers in the table

  'get a reference to the TDC control
  Set objCustData = document.all("tdcCustomers")

  'set the sorting order
  objCustData.Sort = strSortOrder

  'get one or other value from text boxes depending on selection
  If document.all("optByID").checked Then

    strCustID = UCase(document.all("txtCustID").value)
    strMsg = "Listing customers with an<br /><b>ID</b> that matches: <b>'" _
           & strCustID + "'</b>"

    'set the Filter for the TDC to show matching customers only
    objCustData.Filter = "CustomerID = " & QUOT & strCustID & "*" & QUOT

  Else

    strCustName = document.all("txtCustName").value
    strMsg = "Listing customers whose<br /><b>Name</b> contains: <b>'" _
           & strCustName & "'</b>"

    'set the Filter for the TDC to show matching customers only
    objCustData.Filter = "CompanyName = " & QUOT & "*" & strCustName & "*" & QUOT

  End If

  'force TDC to rebind the data
  objCustData.Reset

  'show the results table and display message
  document.all("lblStatus").InnerHTML = strMsg

  'get a reference to the TDC control's Recordset
  'there will be an error if the data was not loaded
  On Error Resume Next
  intRecs = objCustData.Recordset.RecordCount
  On Error Goto 0

  'see if we found any records for this search
  If intRecs > 0 Then

    'show the "results" table and create message
    document.all("tblCustomers").style.display = ""
    strMsg = "Click a <b>Customer Name</b> in the grid above to" _
        & "<br /> list all of the orders for that customer ..." _
        & "<br /> Click a <b>column heading</b> in the grid above to sort" _
        & "<br /> the customers by the values in that column ..."

    'show or hide the Next/Prev links depending on rows found
    If intRecs > document.all("tblCustomers").DataPageSize Then
      document.all("tblNavControls").style.display = ""
    Else
      document.all("tblNavControls").style.display = "none"
    End If

  Else

    'hide the "results" table and create message
    document.all("tblCustomers").style.display = "none"
    strMsg = "No matching customers found ..."

  End If
  document.all("lblMessage").InnerHTML = strMsg

End Sub

'----------------------------------------------------

Sub ShowHelp()
'show help on using page in right-hand part of window

  strHelp = "<b>To list customer orders you can</b>:<p />" _
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
  document.all("lblMessage").InnerHTML = strHelp

End Sub

'-->
</script>

<!------------------ HTML page content --------------------->

</head>
<body link="#0000ff" alink="#0000ff" vlink="#0000ff" xonload="ShowHelp()">

<object id="tdcCustomers" width="0" height="0"
        classid="CLSID:333c7bc4-460f-11d0-bc04-0080c7055a83">
  <param name="FieldDelim" value="&#09;">
  <param name="DataURL" value="order-data.aspx?type=customerlist">
  <param name="UseHeader" value="true">
  <param name="CaseSensitive" value="false">
  <param name="CharSet" value="utf-8">
</object>

<div class="heading">View Customer Orders - Select Customer</div>

<div align="right" class="cite">
[<a href="../../global/viewsource.aspx?compsrc=order-data.aspx">view page source</a>]
</div><hr />

<form action="">

  <table border="0" cellpadding="20"><tr><td valign="top" bgcolor="#fffacd">

    <!-- controls for specifying the required customer ID or name -->
    <input type="radio" id="optByID" name="SearchBy" checked="checked" />
    Search by Customer <u>I</u>D:<br /> &nbsp; &nbsp;
    <input type="text" id="txtCustID" size="5" maxlength="5" accesskey="I"
           onkeypress='SetCheck("optByID")' /><p /> &nbsp; or<p />
    <input type="radio" id="optByName" name="SearchBy" />
    Search by Customer <u>N</u>ame:<br /> &nbsp; &nbsp;
    <input type="text" id="txtCustName" size="20" maxlength="40"  accesskey="N"
           onkeypress='SetCheck("optByName")' /><p />
    <button id="btnSearch" disabled="disabled" accesskey="S" onclick="doSearch('CustomerID')"><u>S</u>earch</button>
    &nbsp; &nbsp;
    <button id="btnHelp" accesskey="H" onclick="ShowHelp()"><u>H</u>elp</button><p />
    <span id="lblStatus">Loading customer list, please wait ...</span>

  </td><td valign="top">

    <table id="tblCustomers" datasrc="#tdcCustomers" datapagesize="6"
           cellspacing="0" cellpadding="5" border="1"
           style="border-collapse:collapse;display:none;">
     <thead>
      <tr style="background-color:silver;">
       <td align="center">
        <a href="javascript:DoSearch('CustomerID')"><b>ID</b></a>
       </td>
       <td align="left">
        <a href="javascript:DoSearch('CompanyName')"><b>Customer Name</b></a>
       </td>
       <td align="left">
        <a href="javascript:DoSearch('City')"><b>City</b></a>
       </td>
      </tr>
     </thead>
     <tbody>
     <tr>
      <td align="center" style="background-color:#add8e6;">
       <span datafld="CustomerID" dataformatas="html"></span>
      </td>
      <td align="left">
       <a datafld="ViewOrderHref"><span datafld="CompanyName" dataformatas="html"></span></a>
      </td>
      <td align="left">
       <span datafld="City" dataformatas="html"></span>
      </td>
     </tr>
    </tbody>
    <tfoot id="tblNavControls" style="display:none;">
     <tr><td colspan="4" align="right">
       <a href="javascript:tblCustomers.previousPage()">Previous</a>
       <a href="javascript:tblCustomers.nextPage()">Next</a>
     </td></tr>
    </tfoot>
    </table><p />

    <!-- label to display interactive messages -->
    <div id="lblMessage"></div>

  </td></tr></table>

</form>

<!-- #include file="../../global/foot.inc" -->

</body>
</html>
