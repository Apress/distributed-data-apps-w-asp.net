<%@Page Language="C#"%>
<%@Import Namespace="System.Data"%>
<%@Import Namespace="System.Data.OleDb"%>

<%@Register TagPrefix="dda" TagName="showdataset"
            Src="..\global\show-dataset.ascx" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html><head>
<title>The AcceptChangesDuringFill Property</title>
<!-- #include file="..\global\style.inc" -->
</head>
<body bgcolor="#ffffff">
<span class="heading">The AcceptChangesDuringFill Property</span><hr />
<!--------------------------------------------------------------------------->

<!-- insert custom controls to display values -->
<dda:showdataset id="ctlShow1" runat="server" />
<dda:showdataset id="ctlShow2" runat="server" />
<dda:showdataset id="ctlShow3" runat="server" />
<dda:showdataset id="ctlShow4" runat="server" />

<div id="outError" runat="server" />

<script Language="C#" runat="server">

void Page_Load() {

  // get connection string from web.config
  String strConnect = ConfigurationSettings.AppSettings["NorthwindConnectString"];

  // specify the SELECT statement to extract the data
  String strSelect = "SELECT CustomerID, City, Country FROM [Customers] WHERE CustomerID LIKE 'A%'";

  // declare a DataSet object
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
  String strUpdate = "UPDATE Customers SET City = '*"
         + GetRandomString() + "*' WHERE CustomerID = 'ANTON'";

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
  // call Fill to fetch underlying values into DataSet

  try {

    // turn off AcceptChanges after Fill
    objDataAdapter.AcceptChangesDuringFill = false;

    // refresh DataSet from database table
    objDataAdapter.Fill(objDataSet, "Customers");
  }
  catch (Exception objError) {

    // display error details
    outError.InnerHtml = "<b>* Error while accessing data</b>.<br />"
        + objError.Message + " " + objError.Source;
    return;  // and stop
  }

  // show values in DataSet
  ctlShow4.ShowValues(objTable, "Row values after calling Fill without AcceptChanges");
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
