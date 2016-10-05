<%@Page Language="C#" Trace="True" %>

<%@Import Namespace="System.Data" %>
<%@Import Namespace="System.Data.OleDb" %>
<%@Import Namespace="DataSetUpdate" %>

<%@Register TagPrefix="dda" TagName="showdataset"
            Src="../global/show-dataset.ascx" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html><head>
<title>Updating Customer Orders and Order Details</title>
<!-- #include file="..\global\style.inc" -->
</head>
<body bgcolor="#ffffff">
<span class="heading">Updating Customer Orders and Order Details</span>
<div align="right" class="cite">
[<a href="../global/viewsource.aspx?compsrc=updatedataset.cs" target="_blank">view page source</a>]
</div><hr />
<!--------------------------------------------------------------------------->

<!-- insert custom controls to display values -->
<dda:showdataset id="ctlShow1" runat="server" />
<dda:showdataset id="ctlShow2" runat="server" />

<div id="outConcurrent" runat="server"></div><p />

<!-- insert custom controls to display values -->
<dda:showdataset id="ctlShow3" runat="server" />
<dda:showdataset id="ctlShow4" runat="server" />

<div id="outError" runat="server">&nbsp;</div><p />

<!---------------- server-side code section ------------------>

<script Language="C#" runat="server">

void Page_Load() {

   // get connection string from ..\global\connect-strings.ascx user control
   String strConnect = ConfigurationSettings.AppSettings["NorthwindConnectString"];

   // create an instance of the data access component
   UpdateDataSet objOrderUpdate = new UpdateDataSet(strConnect);

   // declare variable to hold a DataSet from the server
   DataSet objDataSet;

   try {

     // call component to get DataSet containing order details for customer
     objDataSet = objOrderUpdate.GetOrderDetails("THECR");
   }
   catch (Exception objError) {

      // display error details
      outError.InnerHtml = "<b>* Error while fetching order details</b>.<br />"
          + objError.Message + " Source: " + objError.Source;
      return;  //  and stop execution
   }

   // get a reference to the Orders table
   DataTable objTable = objDataSet.Tables["Orders"];

   // now modify the values held in this table
   objTable.Rows[0]["ShipCity"] = GetRandomString();
   objTable.Rows[1]["ShipCountry"] = GetRandomString();
   Random objRandom = new Random();
   int intRand = objRandom.Next(0, 9);
   objTable.Rows[2]["ShipVia"] = (int)(intRand / 2);

   // add a new row to the Orders table
   DataRow objDataRow = objTable.NewRow();
   objDataRow["OrderID"] = 999999;
   objDataRow["CustomerID"] = "THECR";
   objDataRow["OrderDate"] = "06/01/2002";
   objDataRow["RequiredDate"] = "06/01/2002";
   objDataRow["ShippedDate"] = "06/01/2002";
   objDataRow["ShipVia"] = 2;
   objDataRow["Freight"] = 10.50;
   objDataRow["ShipName"] = "*new row*";
   objDataRow["ShipCity"] = "*new row*";
   objDataRow["ShipPostalCode"] = "*new row*";
   objDataRow["ShipCountry"] = "*new row*";
   objTable.Rows.Add(objDataRow);

   // display contents after changing the data
   ctlShow1.ShowValues(objTable, "Contents of the Orders table after editing locally");

   // get a reference to the Order Details table
   objTable = objDataSet.Tables["Order Details"];

   // now modify the values held in this table
   objTable.Rows[0]["Quantity"] = intRand + 7;
   objTable.Rows[1]["Quantity"] = intRand + 3;
   objTable.Rows[2]["Quantity"] = intRand - 1;

   // add a new row to the Order Details table
   objDataRow = objTable.NewRow();
   objDataRow["OrderID"] = 999999;
   objDataRow["ProductID"] = 40;
   objDataRow["UnitPrice"] = 25;
   objDataRow["Quantity"] = 10;
   objDataRow["Discount"] = 0.07;
   objTable.Rows.Add(objDataRow);

   // display contents after changing the data
   ctlShow2.ShowValues(objTable, "Contents of the Order Details table after editing locally");

   // -------------------------------------------------------------------

   // change some values in the original table while the DataSet is holding
   // a disconnected copy of the data to force a concurrency error

   String strConcurrent = String.Empty;
   String strUpdate = String.Empty;
   int intRowsAffected;

   // need a new (separate) Connection and Command object
   OleDbConnection objNewConnect = new OleDbConnection(strConnect);
   OleDbCommand objNewCommand = new OleDbCommand();
   objNewCommand.Connection = objNewConnect;

   try {

      objNewConnect.Open();

      // modify rows to force concurrency errors
      strConcurrent += "<b>Concurrently executed</b>:<br />";

      strUpdate = "UPDATE Orders SET Freight = "
                + (intRand * 10).ToString() + " WHERE OrderID = 11003";
      objNewCommand.CommandText = strUpdate;
      intRowsAffected = objNewCommand.ExecuteNonQuery();
      strConcurrent += strUpdate + " ... <b>"
             + intRowsAffected.ToString() + "</b> row(s) affected<br />";

      strUpdate = "UPDATE Orders SET Freight = "
                + (intRand * 7).ToString() + " WHERE OrderID = 10775";
      objNewCommand.CommandText = strUpdate;
      intRowsAffected = objNewCommand.ExecuteNonQuery();
      strConcurrent += strUpdate + " ... <b>"
             + intRowsAffected.ToString() + "</b> row(s) affected<br />";

      intRand = intRand / 10;

      strUpdate = "UPDATE [Order Details] SET Discount = "
                + intRand.ToString() + " WHERE OrderID = 10624 AND ProductID = 28";
      objNewCommand.CommandText = strUpdate;
      intRowsAffected = objNewCommand.ExecuteNonQuery();
      strConcurrent += strUpdate + " ... <b>"
             + intRowsAffected.ToString() + "</b> row(s) affected<br />";

      strUpdate = "UPDATE [Order Details] SET Discount = "
                + intRand.ToString() + " WHERE OrderID = 10624 AND ProductID = 29";
      objNewCommand.CommandText = strUpdate;
      intRowsAffected = objNewCommand.ExecuteNonQuery();
      strConcurrent += strUpdate + " ... <b>"
             + intRowsAffected.ToString() + "</b> row(s) affected<br />";
   }
   catch (Exception objError) {

      // display error details
      outError.InnerHtml = "<b>* Error during concurrent updates</b>.<br />"
          + objError.Message + " Source: " + objError.Source;
      return;  //  and stop execution
   }
   finally {
     objNewConnect.Close();
   }

   outConcurrent.InnerHtml = strConcurrent;

   // -------------------------------------------------------------------

   // now ready to perform updates using modified DataSet object
   // create a DataSet variable to hold the results
   DataSet objReturnedDS;

   try {

     // call function to do updates - pass in changed DataSet
     objReturnedDS = objOrderUpdate.UpdateAllOrderDetails("THECR", ref objDataSet);
   }
   catch (Exception objError) {

      // display error details
      outError.InnerHtml = "<b>* Error during updates to original data</b>.<br />"
          + objError.Message + " Source: " + objError.Source;
      return;  //  and stop execution
   }

   // -------------------------------------------------------------------

   // see if we got a component error, method returns Nothing in this case
   if (objReturnedDS == null)

     // component failed
     outError.InnerHtml = "There was an error within the component.";

   else {

     // show values within the DataSet tables
     ctlShow3.ShowValues(objReturnedDS.Tables["Orders"],
              "Contents of the Orders table in the DataSet after updating");
     ctlShow4.ShowValues(objReturnedDS.Tables["Order Details"],
              "Contents of the Order Details table in the DataSet after updating");

   }

   // -------------------------------------------------------------------

   // finally delete the new rows we added to the Orders and Order Details table

   try {

      objNewConnect.Open();

      // get order ID of newly inserted row
      strUpdate = "SELECT OrderID FROM Orders WHERE ShipName = '*new row*'";
      objNewCommand.CommandText = strUpdate;
      OleDbDataReader objReader = objNewCommand.ExecuteReader();
      objReader.Read();
      int intOrderID = (int) objReader["OrderID"];
      objReader.Close();

      // delete new child row(s) from Order Details table
      strUpdate = "DELETE FROM [Order Details] WHERE OrderID = " + intOrderID.ToString();
      objNewCommand.CommandText = strUpdate;
      objNewCommand.ExecuteNonQuery();

      // delete new row from Orders table
      strUpdate = "DELETE FROM Orders WHERE OrderID = " + intOrderID.ToString();
      objNewCommand.CommandText = strUpdate;
      objNewCommand.ExecuteNonQuery();

      outConcurrent.InnerHtml += "Deleted newly inserted row after updates completed.";
   }
   catch (Exception objError) {

      // display error details
      outError.InnerHtml = "<br /><b>* Error deleting inserted row</b>.<br />"
          + objError.Message + " Source: " + objError.Source;
   }
   finally {
     objNewConnect.Close();
   }
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
<!-- #include file="..\global\foot.inc" -->
</body>
</html>
