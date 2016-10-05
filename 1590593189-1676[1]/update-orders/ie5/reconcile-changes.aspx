<%@Page Language="VB" ValidateRequest="False" EnableViewState="False" Debug="True" Trace="False"%>
<%-- Remove ValidateRequest="False" from page directive above if running on Version 1.1 --%>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="System.Xml" %>
<%@Import Namespace="System.IO" %>
<%@Import Namespace="DataSetUpdate" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html><head>
<title>Update Database and Reconcile Changes to Order Data</title>
<!-- #include file="..\..\global\style.inc" -->
</head>
<body link="#0000ff" alink="#0000ff" vlink="#0000ff">
<div class="heading">Update Database and Reconcile Changes to Order Data</div>
<div align="right" class="cite">
[<a href="../../global/viewsource.aspx?compsrc=updatedataset.vb">view page source</a>]
</div><hr />

<!--------------------------------------------------------------------------->

<script language="VB" runat="server">

Dim strCustID As String

Sub Page_Load()

  '-------------- load Diffgram from client into DataSet ----------------

  'get CustomerID from posted Form collection values
  strCustID = Request.Form("hidCustID")

  'see if used clicked the "Cancel" button
  If Request.Form("btnCancel") > "" Then
    Response.Redirect("edit-orders.aspx?customerid=" & strCustID)
  End If

  'put into hidden control to post back to this page
  hidCustID.Value = strCustID

  'get DiffGram from posted Form collection values
  Dim strDiffGram As String = Request.Form("hidPostXML")

  '*********************************************************************
  'kludge to work round  bug in ReadXml method of DataSet where the empty
  'element "<NewDataSet></NewDataSet>" causes it to ignore all contents
  'replacing it with "<NewDataSet />" solves the problem
  'required in version 1.0 only, fixed in version 1.1

  Dim strOldElement = "<NewDataSet>" & vbCrlf & vbTab & "</NewDataSet>"
  strDiffGram = strDiffGram.Replace(strOldElement, "<NewDataSet />")
  '*********************************************************************

  'create a new DataSet object
  Dim objDataSet As New DataSet()

  'variables to hold references to tables, rows and columns in DataSets
  Dim objTable As DataTable
  Dim objRow As DataRow

  Try

    'read the schema into the DataSet from file on disk
    'must use the Physical path to the file not the Virtual path
    objDataSet.ReadXmlSchema(Request.MapPath("orders-schema.xsd"))

  Catch objError As Exception

    'display error details
    outError.InnerHTML = "<b>* Error while reading schema</b>.<br />" _
                       & objError.Message & "<br />" _
                       & "No updates were applied to the database."
    Exit Sub  ' and stop execution

  End Try

  Try

    'create an XmlTextReader to read data sent from client
    'specifying that string fragment is an XML Document
    Dim objReader As New XmlTextReader(strDiffGram, _
                         XmlNodeType.Document, Nothing)

    'read in the DiffGram posted from the client
    objDataSet.ReadXml(objReader, XmlReadMode.DiffGram)

  Catch objError As Exception

    'display error details
    outError.InnerHTML = "<b>* Error while reading the DiffGram</b>.<br />" _
                       & objError.Message & "<br />" _
                       & "No updates were applied to the database."
    Exit Sub  ' and stop execution

  End Try

  'get a reference to the Columns collection and remove column
  'we added in the middle-tier for total value of each order line
  Dim colDataCols As DataColumnCollection
  colDataCols = objDataSet.Tables("Order Details").Columns
  colDataCols.Remove("LineTotal")

  '*********************************************************
  'kludge required to get correct RowState values in DataSet
  'required in version 1.0 only, fixed in version 1.1

  objDataSet = objDataSet.GetChanges()
  '*********************************************************

  '--------------- if it's a postback, edit the DataSet -----------------

  If Page.IsPostBack() Then

    'call routines in page to apply user's reconciliation choices
    'do in Try...Catch in case row has been deleted by another user
    Try
      EditTable(objDataSet.Tables("Orders"))
    Catch
    End Try
    Try
      EditTable(objDataSet.Tables("Order Details"))
    Catch
    End Try

  End If

  '--------- use data access component to update database ---------------

  If objDataSet.HasChanges Then   'there are edited rows in DataSet

    'get connection string from web.config
    Dim strConnect As String = ConfigurationSettings.AppSettings("NorthwindConnectString")

    'create an instance of the data access component
    Dim objOrderUpdate As New UpdateDataSet(strConnect)

    Try

     'call function in data access component to do the updates
     objDataSet = objOrderUpdate.UpdateAllOrderDetails(strCustID, objDataSet)

    Catch objError As Exception

      'get error message string
      Dim strError As String = objError.Message

      'see if it was a "constraints" violation within the component, if so a
      'concurrent user probaby inserted same product in Order Details table
      If strError.IndexOf("Failed to enable constraints") >= 0 Then
        strError = "This product was added to the order by another user."
      End If

      'display error details and links to edit more rows
      outError.InnerHtml = "<b>* Error during updates to original data</b>.<br />" _
        & strError & " Source: " & objError.Source & "<p />"
      divLinks.Visible = True

      Exit Sub  ' and stop execution

    End Try

    'get two arrays of the rows with errors from original DataSet
    Dim arrOrdersErrors() As DataRow = objDataSet.Tables("Orders").GetErrors()
    Dim arrDetailsErrors() As DataRow = objDataSet.Tables("Order Details").GetErrors()

    'get number of errors in each table and total number
    Dim intOrdersErrors As Integer = arrOrdersErrors.GetLength(0)
    Dim intDetailsErrors As Integer = arrDetailsErrors.GetLength(0)
    Dim intTotalErrors As Integer = intOrdersErrors + intDetailsErrors

    If intTotalErrors > 0 Then   'there were update errors detected

      'display a warning message
      outResult.InnerHtml = "<b>* Warning:</b> the following"
      If intTotalErrors = 1 Then
        outResult.InnerHtml &= " error was encountered while updating the database:<p />"
      Else
        outResult.InnerHtml &= " <b>" & intTotalErrors.ToString() _
        & "</b> errors were encountered while updating the database:<p />"
      End If

      'iterate through the Orders rows with errors
      For Each objRow In arrOrdersErrors

        'call function elsewhere in page to display error details
        outResult.InnerHtml &= GetDisplayString(objRow) & "<p />"

      Next

      'iterate through the Order Details rows with errors
      For Each objRow In arrDetailsErrors

        'call function elsewhere in page to display error details
        outResult.InnerHtml &= GetDisplayString(objRow) & "<p />"

      Next

      'get XML DiffGram from cloned DataSet for next update attempt
      'create a MemoryStream for writing XML from DataSet into
      Dim objStream As New MemoryStream()
      objDataSet.WriteXml(objStream, XmlWriteMode.DiffGram)

      'get contents of Stream as an array of bytes
      Dim arrXML() As Byte = objStream.GetBuffer()
      objStream.Close()   'remember to close the Stream

      'use the Encoding class to convert the array to a String
      Dim objEncoding As System.Text.Encoding = System.Text.Encoding.UTF8
      strDiffGram = objEncoding.GetString(arrXML)

      'put into hidden control to post back to this page
      hidPostXML.Value = strDiffGram

      'display the SUBMIT button to post changes back to this page
      'and hide list of links to edit more orders
      frmSubmit.Visible = True

    Else

      'no errors during update, show message and links to edit more rows
      divLinks.Visible = True

    End If

  Else

    'no errors during update, show message and links to edit more rows
    divLinks.Visible = True

  End If

End Sub

'-------------------------------------------------------------
'-------------------------------------------------------------

Private Sub EditTable(objTable As DataTable)
'updates rows to reflect reconciliation choices made by user

  'declare variables we'll need
  Dim objRow As DataRow
  Dim objColumn As DataColumn
  Dim intLoop As Integer
  Dim strKey, strColName As String

  'get name of table for display in page
  Dim strTableName As String = objTable.TableName

  'iterate through each row in table
  For Each objRow In objTable.Rows

    'see if this row resulted in an error during previous
    'update process - if so, RowError will not be empty
    If objRow.RowError = "" Then

      'the previous update succeeded, so prevent another
      'update this time by setting RowState to "Unchanged"
      'by accepting changes - works because if update was
      'successful Original and Current values are the same
      objRow.AcceptChanges()

    Else

      'the previous update resulted in an error, and user
      'will have specified reconciliation actions required
      'first remove the error message in RowError property
      objRow.ClearErrors()

      'get primary key value(s)
      If objRow.RowState = DataRowState.Deleted Then
        strKey = objRow("OrderID", DataRowVersion.Original)
      Else
        strKey = objRow("OrderID", DataRowVersion.Current)
      End If
      If strTableName = "Order Details" Then
        If objRow.RowState = DataRowState.Deleted Then
          strKey &= "_" & objRow("ProductID", DataRowVersion.Original)
        Else
          strKey &= "_" & objRow("ProductID", DataRowVersion.Current)
        End If
      End If

      'see if it's a modified row
      If objRow.RowState = DataRowState.Modified Then

        'iterate through each column in this row
        For Each objColumn In objTable.Columns

          'get the name of the column as a String
          strColName = objColumn.ColumnName

          'see if the checkbox to keep this value is *not* set
          If Request.Form("chk_" & strKey & "_" & strColName) = Nothing Then

            'set Current value to same as existing (Original) value
            'so that Original values are persisted in database
            objRow(strColName) = objRow(strColName, DataRowVersion.Original)

          End If

        Next

      End If

      'see if it's an added or deleted row
      If (objRow.RowState = DataRowState.Added) _
      Or (objRow.RowState = DataRowState.Deleted) Then

        'see if the checkbox to keep this row is *not* set
        If Request.Form("chk_" & strKey) = Nothing Then

          'call AcceptChanges to set RowState to Unchanged
          'so that the update is not applied to the database
          objRow.AcceptChanges()

        End If

      End If

    End If

  Next   'process next error row

End Sub

'-------------------------------------------------------------
'-------------------------------------------------------------

Private Function GetDisplayString(objRow As DataRow) As String
'creates string containing HTML table with values and controls
'to be used to reconcile the error of possible

  'declare variables we'll need
  Dim objTable As DataTable
  Dim strTableName, strKey, strDisplay As String
  Dim intColCount As Integer
  Dim decFreight, decPrice As Decimal
  Dim sngDiscount As Single

  'get reference to table for this row and table name as a String
  objTable = objRow.Table
  strTableName = objTable.TableName

  'get number of columns and key value for row depending on table name
  intColCount = 10
  If objRow.RowState = DataRowState.Deleted Then
    strKey = objRow("OrderID", DataRowVersion.Original)
  Else
    strKey = objRow("OrderID", DataRowVersion.Current)
  End If
  If strTableName = "Order Details" Then
    intColCount = 4
    If objRow.RowState = DataRowState.Deleted Then
      strKey &= "_" & objRow("ProductID", DataRowVersion.Original)
    Else
      strKey &= "_" & objRow("ProductID", DataRowVersion.Current)
    End If
  End If

  'build output <table> as a String
  strDisplay = "<table cellspacing='0' cellpadding='5' " _
    & "rules='cols' border='1' style='border-collapse:collapse;'>"

  'first row, containing row details and order ID, etc.
  strDisplay &= "<tr><td colspan='" & intColCount & "'><b>" _
    & objRow.RowState.ToString() & "</b> row in <b>" _
    & strTableName & "</b> table. Order ID:<b>"
  If objRow.RowState = DataRowState.Deleted Then
    strDisplay &= objRow("OrderID", DataRowVersion.Original) & "</b>"
    If strTableName = "Order Details" Then
      strDisplay &= "<br />Product: "
      Try
        strDisplay &= "<b>" _
          & objRow("ProductName", DataRowVersion.Original) _
          & "</b> [Product ID:" _
          & objRow("ProductID", DataRowVersion.Original) & "]"
      Catch
        strDisplay &= "{details not available}"
      End Try
    End If
  Else
    strDisplay &= objRow("OrderID", DataRowVersion.Current) & "</b>"
    If strTableName = "Order Details" Then
      strDisplay &= "<br />Product: "
      Try
        strDisplay &= "<b>" _
          & objRow("ProductName", DataRowVersion.Current) _
          & "</b> [Product ID:" _
          & objRow("ProductID", DataRowVersion.Current) & "]"
      Catch
        strDisplay &= "{details not available}"
      End Try
    End If
  End If
  strDisplay &= "</td></tr>"

  'second row, containing error message from RowError property
  strDisplay &= "<tr bgcolor='#ffeeee'><td colspan='" & intColCount _
    & "'><b>Error</b>: " & objRow.RowError & "</td></tr>"

  'third row, containing column names from row depending on table name
  If strTableName = "Orders" Then
    strDisplay &= "<tr bgcolor='#c0c0c0'><td></td><td align='center'>Required</td>" _
      & "<td align='center'>Shipped</td><td align='center'>ShipVia</td><td align='center'>Freight</td>" _
      & "<td align='center'>Name</td><td align='center'>Address</td><td align='center'>City</td><td align='center'>Code</td>" _
      & "<td align='center'>Country</td></tr>"
  Else
    strDisplay &= "<tr bgcolor='#c0c0c0'><td></td><td align='center'>Quantity</td>" _
      & "<td align='center'>Price</td><td align='center'>Discount</td></tr>"
  End If

  'next row, add Proposed value if applicable depending on table name
  If (objRow.RowState = DataRowState.Modified) _
  Or (objRow.RowState = DataRowState.Added) Then
    strDisplay &= "<tr><td>Proposed values:</td>"
    If strTableName = "Orders" Then
      decFreight = objRow("Freight", DataRowVersion.Current)
      strDisplay &= "<td align='center'>" _
        & objRow("RequiredDate", DataRowVersion.Current) & "</td><td align='center'>" _
        & objRow("ShippedDate", DataRowVersion.Current) & "</td><td align='center'>" _
        & objRow("ShipperName", DataRowVersion.Current) & "[" _
        & objRow("ShipVia", DataRowVersion.Current) & "]</td><td align='center'>$" _
        & decFreight.ToString("#0.00") & "</td><td align='center'>" _
        & objRow("ShipName", DataRowVersion.Current) & "</td><td align='center'>" _
        & objRow("ShipAddress", DataRowVersion.Current) & "</td><td align='center'>" _
        & objRow("ShipCity", DataRowVersion.Current) & "</td><td align='center'>" _
        & objRow("ShipPostalCode", DataRowVersion.Current) & "</td><td align='center'>" _
        & objRow("ShipCountry", DataRowVersion.Current) & "</td></tr>"
    Else
      decPrice = objRow("UnitPrice", DataRowVersion.Current)
      sngDiscount = objRow("Discount", DataRowVersion.Current)
      strDisplay &= "<td align='center'>" & objRow("Quantity", DataRowVersion.Current) _
        & "</td><td align='center'>$" & decPrice.ToString("#0.00") & "</td><td align='center'>" _
        & sngDiscount.ToString("P") & "</td></tr>"
    End If
  End If

  'next row, add Existing value if applicable depending on table name
  If (objRow.RowState = DataRowState.Modified) _
  Or (objRow.RowState = DataRowState.Deleted) Then
    strDisplay &= "<tr><td>Existing values:</td>"
    If strTableName = "Orders" Then
      decFreight = objRow("Freight", DataRowVersion.Original)
      strDisplay &= "<td align='center'>" _
        & objRow("RequiredDate", DataRowVersion.Original) & "</td><td align='center'>" _
        & objRow("ShippedDate", DataRowVersion.Original) & "</td><td align='center'>" _
        & objRow("ShipperName", DataRowVersion.Original) & "[" _
        & objRow("ShipVia", DataRowVersion.Original) & "]</td><td align='center'>$" _
        & decFreight.ToString("#0.00") & "</td><td align='center'>" _
        & objRow("ShipName", DataRowVersion.Original) & "</td><td align='center'>" _
        & objRow("ShipAddress", DataRowVersion.Original) & "</td><td align='center'>" _
        & objRow("ShipCity", DataRowVersion.Original) & "</td><td align='center'>" _
        & objRow("ShipPostalCode", DataRowVersion.Original) & "</td><td align='center'>" _
        & objRow("ShipCountry", DataRowVersion.Original) & "</td></tr>"
    Else
      decPrice = objRow("UnitPrice", DataRowVersion.Original)
      sngDiscount = objRow("Discount", DataRowVersion.Original)
      strDisplay &= "<td align='center'>" & objRow("Quantity", DataRowVersion.Original) _
        & "</td><td align='center'>$" & decPrice.ToString("#0.00") & "</td><td align='center'>" _
        & sngDiscount.ToString("P") & "</td></tr>"
    End If
  End If

  'now add table row containing HTML controls, depending on update type
  'user can only try again to insert complete row for failed Inserts
  If objRow.RowState = DataRowState.Added Then
    strDisplay &= "<tr><td colspan='" & intColCount _
      & "'>&nbsp; <input type='checkbox' name='chk_" & strKey _
      & "'> Add this row to the database</td></tr>"
  End If

  'user can only try again to delete complete row for failed Deletes
  If objRow.RowState = DataRowState.Deleted Then
    strDisplay &= "<tr><td colspan='" & intColCount _
      & "'>&nbsp; <input type='checkbox' name='chk_" & strKey _
      & "'> Delete this row from the database</td></tr>"
  End If

  'user can select which columns to keep for Modified rows
  If objRow.RowState = DataRowState.Modified Then
    strDisplay &= "<tr><td>Replace existing values?</td>"
    If strTableName = "Orders" Then
      strDisplay &= "<td align='center'><input type='checkbox' " _
        & "name='chk_" & strKey & "_RequiredDate'></td>" _
        & "<td align='center'><input type='checkbox' " _
        & "name='chk_" & strKey & "_ShippedDate'></td>" _
        & "<td align='center'><input type='checkbox' " _
        & "name='chk_" & strKey & "_ShipVia'></td>" _
        & "<td align='center'><input type='checkbox' " _
        & "name='chk_" & strKey & "_Freight'></td>" _
        & "<td align='center'><input type='checkbox' " _
        & "name='chk_" & strKey & "_ShipName'></td>" _
        & "<td align='center'><input type='checkbox' " _
        & "name='chk_" & strKey & "_ShipAddress'></td>" _
        & "<td align='center'><input type='checkbox' " _
        & "name='chk_" & strKey & "_ShipCity'></td>" _
        & "<td align='center'><input type='checkbox' " _
        & "name='chk_" & strKey & "_ShipPostalCode'></td>" _
        & "<td align='center'><input type='checkbox' " _
        & "name='chk_" & strKey & "_ShipCountry'></td></tr>"
    Else
      strDisplay &= "<td align='center'><input type='checkbox' " _
        & "name='chk_" & strKey & "_Quantity'></td>" _
        & "<td align='center'><input type='checkbox' " _
        & "name='chk_" & strKey & "_UnitPrice'></td>" _
        & "<td align='center'><input type='checkbox' " _
        & "name='chk_" & strKey & "_Discount'></td></tr>"
    End If
  End If

  strDisplay &= "</table>"

  Return strDisplay

End Function

</script>

<!--------------------------------------------------------------------------->

<div id="outError" runat="server"></div>

<form id="frmSubmit" visible="false" runat="server">
  <div id="outResult" runat="server"></div>
  Select the actions you wish to take to reconcile these errors detected during the update process.<br />
  By default, your updates will be abandoned and <b>not</b> applied to the database. However, you can<br />
  overwrite individual column values by selecting the checkboxes for each column in a modified<br />
  row, or to force rows to be inserted or deleted. Click the <b>Apply updates</b> button below when<br />
  complete to update the database.<p />
  <input type="submit" id="btnSubmit" value="Apply updates" runat="server" /> &nbsp;
  <input type="submit" id="btnCancel" value="Cancel" runat="server" />
  <input type="hidden" id="hidCustID" runat="server" />
  <input type="hidden" id="hidPostXML" runat="server" />
</form>

<div id="divLinks" visible="false" runat="server">
<b>The update process is complete.</b>
<ul>
<li><b><a href="edit-orders.aspx?customerid=<% = strCustID %>">Edit more orders for this customer</a></b></li>
<li><b><a href="../../customer-orders/ie5/default.aspx">Select a different customer</a></b></li>
</ul>
</div>

<!-- #include file="..\..\global\foot.inc" -->
</body>
</html>
