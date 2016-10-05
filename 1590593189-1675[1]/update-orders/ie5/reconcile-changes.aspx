<%@Page Language="C#" ValidateRequest="False" EnableViewState="False" Trace="False" Debug="True" %>
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
[<a href="../../global/viewsource.aspx?compsrc=updatedataset.cs">view page source</a>]
</div><hr />

<!--------------------------------------------------------------------------->

<script Language="C#" runat="server">

String strCustID = String.Empty;

void Page_Load() {

  // -------------- load Diffgram from client into DataSet ----------------

  // get CustomerID from posted Form collection values
  strCustID = Request.Form["hidCustID"];

  // see if used clicked the "Cancel" button
  if (Request.Form["btnCancel"] != null && Request.Form["btnCancel"] != "")
    Response.Redirect("edit-orders.aspx?customerid=" + strCustID);

  // put into hidden control to post back to this page
  hidCustID.Value = strCustID;

  // get DiffGram from posted Form collection values
  String  strDiffGram = Request.Form["hidPostXML"];

  // *********************************************************************
  // kludge to work round  bug in ReadXml method of DataSet where the empty
  // element "<NewDataSet></NewDataSet>" causes it to ignore all contents
  // replacing it with "<NewDataSet />" solves the problem.
  // required in 1.0 only, fixed in 1.1

  String strOldElement = "<NewDataSet>" + (char)13 + (char)10 + (char)9 + "</NewDataSet>";
  strDiffGram = strDiffGram.Replace(strOldElement, "<NewDataSet />");
  // *********************************************************************

  // create a new DataSet object
  DataSet objDataSet = new DataSet();

  // variables to hold references to tables, rows and columns in DataSets
  DataTable objTable;

  try {

    // read the schema into the DataSet from file on disk
    // must use the Physical path to the file not the Virtual path
    objDataSet.ReadXmlSchema(Request.MapPath("orders-schema.xsd"));
  }
  catch (Exception objError) {

    // display error details
    outError.InnerHtml = "<b>* Error while reading schema</b>.<br />"
                       + objError.Message + "<br />"
                       + "No updates were applied to the database.";
    return; //  and stop execution
  }

  try {

    // create an XmlTextReader to read data sent from client
    // specifying that string fragment is an XML Document
    XmlTextReader objReader = new XmlTextReader(strDiffGram, XmlNodeType.Document, null);

    // read in the DiffGram posted from the client
    objDataSet.ReadXml(objReader, XmlReadMode.DiffGram);

  }
  catch (Exception objError) {

    // display error details
    outError.InnerHtml = "<b>* Error while reading the DiffGram</b>.<br />"
                       + objError.Message + "<br />"
                       + "No updates were applied to the database.";
    return; //  and stop execution
  }

  // get a reference to the Columns collection and remove column
  // we added in the middle-tier for total value of each order line
  DataColumnCollection colDataCols;
  colDataCols = objDataSet.Tables["Order Details"].Columns;
  colDataCols.Remove("LineTotal");

  // *********************************************************
  // kludge required to get correct RowState values in DataSet.
  // required in 1.0 only, fixed in 1.1

  objDataSet = objDataSet.GetChanges();
  // *********************************************************

  // --------------- if it's a postback, edit the DataSet -----------------

  if (Page.IsPostBack == true) {

    // call routines in page to apply user's reconciliation choices
    // do in try...catch in case row has been deleted by another user
    try {
      EditTable(objDataSet.Tables["Orders"]);
    }
    catch (Exception objError) {
    }
    try {
      EditTable(objDataSet.Tables["Order Details"]);
    }
    catch (Exception objError) {
    }
  }

  // --------- use data access component to update database ---------------

  if (objDataSet.HasChanges() == true) {  // there are edited rows in DataSet

    // get connection string from ..\global\connect-strings.ascx user control
    String strConnect = ConfigurationSettings.AppSettings["NorthwindConnectString"];

    // create an instance of the data access component
    UpdateDataSet objOrderUpdate = new UpdateDataSet(strConnect);

    try {

     // call method in data access component to do the updates
     objDataSet = objOrderUpdate.UpdateAllOrderDetails(strCustID, ref objDataSet);

    }
    catch (Exception objError) {

      // get error message string
      String  strError = objError.Message;

      // see if it was a "constraints" violation within the component, if so a
      // concurrent user probaby inserted same product in Order Details table
      if (strError.IndexOf("Failed to enable constraints") >= 0)
        strError = "This product was added to the order by another user.";

      // display error details and links to edit more rows
      outError.InnerHtml = "<b>* Error during updates to original data</b>.<br />"
        + strError + " Source: " + objError.Source + "<p />";
      divLinks.Visible = true;

      return; //  and stop execution
    }

    // get two arrays of the rows with errors from original DataSet
    DataRow[] arrOrdersErrors = objDataSet.Tables["Orders"].GetErrors();
    DataRow[] arrDetailsErrors = objDataSet.Tables["Order Details"].GetErrors();

    // get number of errors in each table and total number
    int intOrdersErrors = arrOrdersErrors.GetLength(0);
    int intDetailsErrors = arrDetailsErrors.GetLength(0);
    int intTotalErrors = intOrdersErrors + intDetailsErrors;

    if (intTotalErrors > 0) {  // there were update errors detected

      // display a warning message
      outResult.InnerHtml = "<b>* Warning:</b> the following";
      if (intTotalErrors == 1)
        outResult.InnerHtml += " error was encountered while updating the database:<p />";
      else
        outResult.InnerHtml += " <b>" + intTotalErrors.ToString()
           + "</b> errors were encountered while updating the database:<p />";

      // iterate through the Orders rows with errors
      foreach (DataRow objRow in arrOrdersErrors) {

        // call method elsewhere in page to display error details
        outResult.InnerHtml += GetDisplayString(objRow) + "<p />";
      }

      // iterate through the Order Details rows with errors
      foreach (DataRow objRow in arrDetailsErrors) {

        // call method elsewhere in page to display error details
        outResult.InnerHtml += GetDisplayString(objRow) + "<p />";
      }

      // get XML DiffGram from cloned DataSet for next update attempt
      // create a MemoryStream for writing XML from DataSet into
      MemoryStream objStream = new MemoryStream();
      objDataSet.WriteXml(objStream, XmlWriteMode.DiffGram);

      // get contents of Stream as an array of bytes
      Byte[] arrXML = objStream.GetBuffer();
      objStream.Close();   // remember to close the Stream

      // use the Encoding class to convert the array to a String
      System.Text.Encoding objEncoding = System.Text.Encoding.UTF8;
      strDiffGram = objEncoding.GetString(arrXML);

      // put into hidden control to post back to this page
      hidPostXML.Value = strDiffGram;

      // display the SUBMIT button to post changes back to this page
      // and hide list of links to edit more orders
      frmSubmit.Visible = true;

    }
    else

      // no errors during update, show message and links to edit more rows
      divLinks.Visible = true;
  }
  else

    // no errors during update, show message and links to edit more rows
    divLinks.Visible = true;
}
//-------------------------------------------------------------
//-------------------------------------------------------------

private void EditTable(DataTable objTable) {
// updates rows to reflect reconciliation choices made by user

  // declare variables we'll need
  int intLoop;
  String strKey, strColName;

  // get name of table for display in page
  String strTableName = objTable.TableName;

  // iterate through each row in table
  foreach (DataRow objRow in objTable.Rows) {

    // see if this row resulted in an error during previous
    // update process - if so, RowError will not be empty
    if (objRow.RowError == "")

      // the previous update succeeded, so prevent another
      // update this time by setting RowState to "Unchanged"
      // by accepting changes - works because if update was
      // successful Original and Current values are the same
      objRow.AcceptChanges();

    else {

      // the previous update resulted in an error, and user
      // will have specified reconciliation actions required
      // first remove the error message in RowError property
      objRow.ClearErrors();

      // get primary key value(s)
      if (objRow.RowState == DataRowState.Deleted)
        strKey = objRow["OrderID", DataRowVersion.Original].ToString();
      else
        strKey = objRow["OrderID", DataRowVersion.Current].ToString();
      if (strTableName == "Order Details") {
        if (objRow.RowState == DataRowState.Deleted)
          strKey += "" + objRow["ProductID", DataRowVersion.Original].ToString();
        else
          strKey += "" + objRow["ProductID", DataRowVersion.Current].ToString();
      }

      // see if it's a modified row
      if (objRow.RowState == DataRowState.Modified) {

        // iterate through each column in this row
        foreach (DataColumn objColumn in objTable.Columns) {

          // get the name of the column as a String
          strColName = objColumn.ColumnName;

          // see if the checkbox to keep this value is *not* set
          if (Request.Form["chk" + strKey + "" + strColName] == null)

            // set Current value to same as existing (Original) value
            // so that Original values are persisted in database
            objRow[strColName] = objRow[strColName, DataRowVersion.Original];
        }
      }

      // see if it's an added or deleted row
      if (objRow.RowState == DataRowState.Added || objRow.RowState == DataRowState.Deleted) {

        // see if the checkbox to keep this row is *not* set
        if (Request.Form["chk" + strKey] == null)

          // call AcceptChanges to set RowState to Unchanged
          // so that the update is not applied to the database
          objRow.AcceptChanges();
      }
    }
  }   // process next error row
}
//-------------------------------------------------------------
//-------------------------------------------------------------

private String GetDisplayString(DataRow objRow) {
// creates string containing HTML table with values and controls
// to be used to reconcile the error of possible

  // declare variables we'll need
  DataTable objTable;
  String strTableName, strKey, strDisplay;
  int intColCount;
  float fFreight, fPrice, fDiscount;

  // get reference to table for this row and table name as a String
  objTable = objRow.Table;
  strTableName = objTable.TableName;

  // get number of columns and key value for row depending on table name
  intColCount = 10;
  if (objRow.RowState == DataRowState.Deleted)
    strKey = objRow["OrderID", DataRowVersion.Original].ToString();
  else
    strKey = objRow["OrderID", DataRowVersion.Current].ToString();
  if (strTableName == "Order Details") {
    intColCount = 4;
    if (objRow.RowState == DataRowState.Deleted)
      strKey += "" + objRow["ProductID", DataRowVersion.Original].ToString();
    else
      strKey += "" + objRow["ProductID", DataRowVersion.Current].ToString();
  }

  // build output <table> as a String
  strDisplay = "<table cellspacing='0' cellpadding='5' "
    + "rules='cols' border='1' style='border-collapse:collapse;'>";

  // first row, containing row details and order ID, etc.
  strDisplay += "<tr><td colspan='" + intColCount + "'><b>"
    + objRow.RowState.ToString() + "</b> row in <b>"
    + strTableName + "</b> table. Order ID:<b>";
  if (objRow.RowState == DataRowState.Deleted) {
    strDisplay += objRow["OrderID", DataRowVersion.Original] + "</b>";
    if (strTableName == "Order Details") {
      strDisplay += "<br />Product: ";
      try {
        strDisplay += "<b>"
          + objRow["ProductName", DataRowVersion.Original]
          + "</b> [Product ID:"
          + objRow["ProductID", DataRowVersion.Original] + "]";
      }
      catch {
        strDisplay += "{details not available}";
      }
    }
  }
  else {
    strDisplay += objRow["OrderID", DataRowVersion.Current] + "</b>";
    if (strTableName == "Order Details") {
      strDisplay += "<br />Product: ";
      try {
        strDisplay += "<b>"
          + objRow["ProductName", DataRowVersion.Current]
          + "</b> [Product ID:"
          + objRow["ProductID", DataRowVersion.Current] + "]";
      }
      catch {
        strDisplay += "{details not available}";
      }
    }
  }
  strDisplay += "</td></tr>";

  // second row, containing error message from RowError property
  strDisplay += "<tr bgcolor='#ffeeee'><td colspan='" + intColCount
    + "'><b>Error</b>: " + objRow.RowError + "</td></tr>";

  // third row, containing column names from row depending on table name
  if (strTableName == "Orders")
    strDisplay += "<tr bgcolor='#c0c0c0'><td></td><td align='center'>Required</td>"
      + "<td align='center'>Shipped</td><td align='center'>ShipVia</td><td align='center'>Freight</td>"
      + "<td align='center'>Name</td><td align='center'>Address</td><td align='center'>City</td><td align='center'>Code</td>"
      + "<td align='center'>Country</td></tr>";
  else
    strDisplay += "<tr bgcolor='#c0c0c0'><td></td><td align='center'>Quantity</td>"
      + "<td align='center'>Price</td><td align='center'>Discount</td></tr>";

  // next row, add Proposed value if applicable depending on table name
  if (objRow.RowState == DataRowState.Modified || objRow.RowState == DataRowState.Added) {
    strDisplay += "<tr><td>Proposed values:</td>";
    if (strTableName == "Orders") {
      fFreight = float.Parse(objRow["Freight", DataRowVersion.Current].ToString());
      strDisplay += "<td align='center'>"
        + objRow["RequiredDate", DataRowVersion.Current] + "</td><td align='center'>"
        + objRow["ShippedDate", DataRowVersion.Current] + "</td><td align='center'>"
        + objRow["ShipperName", DataRowVersion.Current] + "["
        + objRow["ShipVia", DataRowVersion.Current] + "]</td><td align='center'>$"
        + fFreight.ToString("#0.00") + "</td><td align='center'>"
        + objRow["ShipName", DataRowVersion.Current] + "</td><td align='center'>"
        + objRow["ShipAddress", DataRowVersion.Current] + "</td><td align='center'>"
        + objRow["ShipCity", DataRowVersion.Current] + "</td><td align='center'>"
        + objRow["ShipPostalCode", DataRowVersion.Current] + "</td><td align='center'>"
        + objRow["ShipCountry", DataRowVersion.Current] + "</td></tr>";
    }
    else {
      fPrice = float.Parse(objRow["UnitPrice", DataRowVersion.Current].ToString());
      fDiscount = float.Parse(objRow["Discount", DataRowVersion.Current].ToString());
      strDisplay += "<td align='center'>" + objRow["Quantity", DataRowVersion.Current]
        + "</td><td align='center'>$" + fPrice.ToString("#0.00") + "</td><td align='center'>"
        + fDiscount.ToString("P") + "</td></tr>";
    }
  }

  // next row, add Existing value if applicable depending on table name
  if (objRow.RowState == DataRowState.Modified || objRow.RowState == DataRowState.Deleted) {
    strDisplay += "<tr><td>Existing values:</td>";
    if (strTableName == "Orders") {
      fFreight = float.Parse(objRow["Freight", DataRowVersion.Original].ToString());
      strDisplay += "<td align='center'>"
        + objRow["RequiredDate", DataRowVersion.Original] + "</td><td align='center'>"
        + objRow["ShippedDate", DataRowVersion.Original] + "</td><td align='center'>"
        + objRow["ShipperName", DataRowVersion.Original] + "["
        + objRow["ShipVia", DataRowVersion.Original] + "]</td><td align='center'>$"
        + fFreight.ToString("#0.00") + "</td><td align='center'>"
        + objRow["ShipName", DataRowVersion.Original] + "</td><td align='center'>"
        + objRow["ShipAddress", DataRowVersion.Original] + "</td><td align='center'>"
        + objRow["ShipCity", DataRowVersion.Original] + "</td><td align='center'>"
        + objRow["ShipPostalCode", DataRowVersion.Original] + "</td><td align='center'>"
        + objRow["ShipCountry", DataRowVersion.Original] + "</td></tr>";
    }
    else {
      fPrice = float.Parse(objRow["UnitPrice", DataRowVersion.Original].ToString());
      fDiscount = float.Parse(objRow["Discount", DataRowVersion.Original].ToString());
      strDisplay += "<td align='center'>" + objRow["Quantity", DataRowVersion.Original]
        + "</td><td align='center'>$" + fPrice.ToString("#0.00") + "</td><td align='center'>"
        + fDiscount.ToString("P") + "</td></tr>";
    }
  }

  // now add table row containing HTML controls, depending on update type
  // user can only try again to insert complete row for failed Inserts
  if (objRow.RowState == DataRowState.Added)
    strDisplay += "<tr><td colspan='" + intColCount
      + "'>&nbsp; <input type='checkbox' name='chk" + strKey
      + "'> Add this row to the database</td></tr>";

  // user can only try again to delete complete row for failed Deletes
  if (objRow.RowState == DataRowState.Deleted)
    strDisplay += "<tr><td colspan='" + intColCount
      + "'>&nbsp; <input type='checkbox' name='chk" + strKey
      + "'> Delete this row from the database</td></tr>";

  // user can select which columns to keep for Modified rows
  if (objRow.RowState == DataRowState.Modified) {
    strDisplay += "<tr><td>Replace existing values?</td>";
    if (strTableName == "Orders")
      strDisplay += "<td align='center'><input type='checkbox' "
        + "name='chk" + strKey + "RequiredDate'></td>"
        + "<td align='center'><input type='checkbox' "
        + "name='chk" + strKey + "ShippedDate'></td>"
        + "<td align='center'><input type='checkbox' "
        + "name='chk" + strKey + "ShipVia'></td>"
        + "<td align='center'><input type='checkbox' "
        + "name='chk" + strKey + "Freight'></td>"
        + "<td align='center'><input type='checkbox' "
        + "name='chk" + strKey + "ShipName'></td>"
        + "<td align='center'><input type='checkbox' "
        + "name='chk" + strKey + "ShipAddress'></td>"
        + "<td align='center'><input type='checkbox' "
        + "name='chk" + strKey + "ShipCity'></td>"
        + "<td align='center'><input type='checkbox' "
        + "name='chk" + strKey + "ShipPostalCode'></td>"
        + "<td align='center'><input type='checkbox' "
        + "name='chk" + strKey + "ShipCountry'></td></tr>";
    else {
      strDisplay += "<td align='center'><input type='checkbox' "
        + "name='chk" + strKey + "Quantity'></td>"
        + "<td align='center'><input type='checkbox' "
        + "name='chk" + strKey + "UnitPrice'></td>"
        + "<td align='center'><input type='checkbox' "
        + "name='chk" + strKey + "Discount'></td></tr>";
    }
  }
  strDisplay += "</table>";
  return strDisplay;
}
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
