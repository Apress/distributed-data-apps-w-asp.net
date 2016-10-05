<%@Page Language="C#" %>
<%@Import Namespace="System.Data"%>
<%@Import Namespace="System.Data.OleDb"%>

<%@Register TagPrefix="dda" TagName="showdataset"
            Src="..\global\show-dataset.ascx" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html><head>
<title>Reconciling Updates from a DataSet</title>
<!-- #include file="..\global\style.inc" -->
</head>
<body bgcolor="#ffffff">
<span class="heading">Reconciling Updates from a DataSet</span><hr />
<!--------------------------------------------------------------------------->

<!-- insert custom controls to display values -->
<dda:showdataset id="ctlShow1" runat="server" />
<dda:showdataset id="ctlShow2" runat="server" />
<dda:showdataset id="ctlShow3" runat="server" />
<dda:showdataset id="ctlShow4" runat="server" />
<dda:showdataset id="ctlShow5" runat="server" />
<dda:showdataset id="ctlShow6" runat="server" />
<dda:showdataset id="ctlShow7" runat="server" /><p />

<div id="outError" runat="server" />

<script Language="C#" runat="server">

void Page_Load() {

  // get connection string from web.config
  String strConnect = ConfigurationSettings.AppSettings["NorthwindConnectString"];

  // specify the SELECT statement to extract the data
  String strSelect = "SELECT CustomerID, City, Country FROM [Customers] WHERE CustomerID LIKE 'A%'";

  // declare DataSet object
  DataSet objDataSet = new DataSet();

  // create a new Connection object using the connection string
  OleDbConnection objConnect = new OleDbConnection(strConnect);

  // create a new DataAdapter using the connection object and select statement
  OleDbDataAdapter objDataAdapter = new OleDbDataAdapter(strSelect, objConnect);

  try {

    // fill the dataset with data from the DataAdapter object
    objDataAdapter.Fill(objDataSet, "Customers");
  }
  catch (Exception objError) {

    // display error details
    outError.InnerHtml = "<b>* Error while accessing data</b>.<br />"
        + objError.Message + " " + objError.Source;
    return;  //  and stop execution
  }

  // get a reference to the new Customers Table in DataSet
  DataTable objTable = objDataSet.Tables[0];

  // set primary key in DataSet to allow Merge to work
  DataColumn[] arrKey = new DataColumn[1];
  arrKey[0] = objTable.Columns["CustomerID"];
  objTable.PrimaryKey = arrKey;

  // show values in DataSet
  ctlShow1.ShowValues(objTable, "'Original' DataSet row values after loading data with Fill method");

  // ---------------------------------------------------
  // edit some of the values
  objTable.Rows[0]["City"] = GetRandomString();
  objTable.Rows[0]["Country"] = GetRandomString();
  objTable.Rows[2]["City"] = GetRandomString();
  objTable.Rows[2]["Country"] = GetRandomString();

  // show values in DataSet
  ctlShow2.ShowValues(objTable, "'Original' DataSet row values after editing data");

  // ---------------------------------------------------
  // change a value in the original table while the DataSet is holding
  // a disconnected copy of the data to force a concurrency error
  String strUpdate = "UPDATE Customers SET City = '*" + GetRandomString()
                   + "*' WHERE CustomerID = 'ANTON'";

  OleDbConnection objNewConnect = new OleDbConnection(strConnect);
  OleDbCommand objNewCommand = new OleDbCommand(strUpdate, objNewConnect);

  try {

    // open the connection to the database
    objNewConnect.Open();

    // execute the SQL statement
    objNewCommand.ExecuteNonQuery();
  }
  catch (Exception objError) {

    // display error details
    outError.InnerHtml = "<b>* Error while updating original data</b>.<br />"
        + objError.Message + "<br />" + objError.Source;
    return;  //  and stop execution
  }
  finally {
    objNewConnect.Close();
  }

  // ---------------------------------------------------
  // marshal just the changed rows into a new DataSet
  DataSet objChangesDS = objDataSet.GetChanges();

  // show values in DataSet
  DataTable objChangeTable = objChangesDS.Tables[0];
  ctlShow3.ShowValues(objChangeTable, "'Changes' DataSet row values after creating with GetChanges method");

  // ---------------------------------------------------
  // update original table in database using "changes" DataSet

  try {

   // create an auto-generated command builder to create the commands
   // to update, insert and delete the data
   OleDbCommandBuilder objCommandBuilder = new OleDbCommandBuilder(objDataAdapter);

   // prevent exceptions being thrown due to concurrency errors
   // error details obtained from the RowError property afterwards
   objDataAdapter.ContinueUpdateOnError = true;

   // perform the update on the original data
   objDataAdapter.Update(objChangesDS, "Customers");
  }
  catch (Exception objError) {

   // display error details
   outError.InnerHtml = "<b>* Error while updating original data</b>.<br />"
                      + objError.Message + " " + objError.Source;
    return;  // and stop
  }

  // show values in DataSet
  ctlShow4.ShowValues(objChangeTable, "'Changes' DataSet row values after calling Update method");

  // ---------------------------------------------------
  // call Fill to fetch underlying values into "changes" DataSet

  try {

    // refresh "changes" dataset from database table
    objDataAdapter.Fill(objChangesDS, "Customers");
  }
  catch (Exception objError) {

    // display error details
    outError.InnerHtml = "<b>* Error while accessing data</b>.<br />"
        + objError.Message + " " + objError.Source;
    return;  // and stop
  }

  // show values in DataSet
  ctlShow5.ShowValues(objChangeTable, "'Changes' DataSet row values after refreshing data with Fill method");

  // ---------------------------------------------------
  // now merge "changes" DataSet back into original DataSet
  objDataSet.Merge(objChangesDS, true);

  // show values in original (now merged) DataSet
  ctlShow6.ShowValues(objTable, "'Original' DataSet row values after Merging Changes DataSet into it");

  // ---------------------------------------------------
  // finally, build a table containing just the rows with errors

  DataRow[] arrRows = new DataRow[0];
  DataTable objNewTable;

  // get number of tables in DataSet
  int intTableCount = objDataSet.Tables.Count;
  int intTableIndex = 0;

  // iterate through existing tables in DataSet
  for (intTableIndex = 0; intTableIndex < intTableCount; intTableIndex++) {

    // get a reference to this table in DataSet
    // always use index 0 as tables are added to end of
    // the Tables collection so remove/add process shown
    // later means new tables are never at index 0
    objTable = objDataSet.Tables[0];

    // make a copy of the table
    objNewTable = objTable.Clone();

    // get reference to rows with errors into array
    arrRows = objTable.GetErrors();

    // copy these rows into the new table
    foreach (DataRow objRow in arrRows) {
      objNewTable.ImportRow(objRow);
    }

    // replace old table with the new one
    objDataSet.Tables.Remove(objTable);
    objDataSet.Tables.Add(objNewTable);

  }

  ctlShow7.ShowValues(objDataSet.Tables[0], "'Errors' table created using GetErrors method");
}

// -----------------------------------------------------
// -----------------------------------------------------

private String GetRandomString() {
  // create a random string to simulate user editing the values
  String strResult = "";
  int intLoop;
  Random objRandom = new Random();
  for (intLoop = 1; intLoop <= 6; intLoop++) {
    strResult += (char) objRandom.Next(65, 90);
  }
  return strResult;
}

</script>

<!--------------------------------------------------------------------------->
<!-- #include file="..\global\foot-view.inc" -->
</body>
</html>
