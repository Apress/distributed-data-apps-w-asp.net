using System;
using System.Data;
using System.Data.OleDb;

// to perform tracing in the ASP.NET page from within the
// component requires the System.Web namespace well
using System.Web;

// the namespace for the component
namespace DataSetUpdate {

  // the main class definition
  public class UpdateDataSet {

    // private internal variables
    private String m_ConnectString;       // to hold the connection string

    // declare variable to hold Order ID of inserted order rows
    // used by event handlers for UpdateAllOrderDetails method
    private int m_InsertOrderID;

    // declare variable to hold reference to DataSets during update process
    // these are used by event handlers for UpdateAllOrderDetails method
    private DataSet m_ModifiedDataSet;
    private DataSet m_MarshaledDataSet;

    // declare variable to hold reference to current page context
    private HttpContext m_Context;

    // declare variable to indicate if HttpContext is available
    private Boolean m_CanTrace = false;

    // ----------------------------------------------------------------
    // ----------------------------------------------------------------

    public UpdateDataSet(String ConnectString) {
      // constructor for component - requires the connection
      // string to be provided the single parameter

      m_ConnectString = ConnectString;

      // for tracing variables and execution in ASP.NET page require
      // reference to current Context object if available
      try {
      m_Context = HttpContext.Current;
      if (m_Context != null) m_CanTrace = true;
      }
      catch (Exception objErr) {
      }
    }
    // ----------------------------------------------------------------
    // ----------------------------------------------------------------

    public DataSet GetProductsDataSet() {
      // returns a DataSet containing one table. This table contains all
      // the rows from the Products table, with the following columns:

      // Table named "Products":
      //  ProductID         int           (row key)
      //  ProductName       nvarchar(40)
      //  QtyPerUnit        nvarchar(20)
      //  UnitPrice         money
      //  Available         smallint

      // specify the stored procedure to extract the Orders data
      String strSelect = "AllProductsList";

      // create a new DataSet object
      DataSet objDataSet = new DataSet();

      // create Connection object using the connection string
      OleDbConnection objConnect = new OleDbConnection(m_ConnectString);

      try
      {

        // create DataAdapter using Connection and Stored Proc name
        OleDbDataAdapter objDataAdapter = new OleDbDataAdapter(strSelect, objConnect);

        // fill the table from the stored procedure
        objDataAdapter.Fill(objDataSet, "Products");

        return objDataSet;
      }
      catch (Exception objError)
      {
        throw objError;
      }
    }
    // ----------------------------------------------------------------
    // ----------------------------------------------------------------

    public DataSet GetShippersDataSet() {

      // returns a DataSet containing one table. This table contains all
      // the rows from the Shippers table, with the following columns:

      // Table named "Shippers":
      //  ShipperID         int           (row key)
      //  ShipperName       nvarchar(40)
      //  ShipperPhone      nvarchar(24)

      // specify the stored procedure to extract the Orders data
      String strSelect = "AllShippersList";

      // create a new DataSet object
      DataSet objDataSet = new DataSet();

      // create Connection object using the connection string
      OleDbConnection objConnect = new OleDbConnection(m_ConnectString);

      try
      {

        // create DataAdapter using Connection and Stored Proc name
        OleDbDataAdapter objDataAdapter = new OleDbDataAdapter(strSelect, objConnect);

        // fill the table from the stored procedure
        objDataAdapter.Fill(objDataSet, "Shippers");

        return objDataSet;
      }
      catch (Exception objError)
      {
        throw objError;
      }
    }
    // ----------------------------------------------------------------
    // ----------------------------------------------------------------

    public DataSet GetOrderDetails(String CustomerID) {
      // creates and returns a DataSet containing rows from the Northwind
      // sample database Orders and OrderLines tables for a specific
      // customer identified by the complete CustomerID parameter.
      // Format for DataSet returned is follows:
      //
      // Table named "Orders":
      //  OrderID         int           (row key)
      //  CustomerID      nchar(5)
      //  OrderDate       datetime
      //  RequiredDate    datetime
      //  ShippedDate     datetime
      //  ShipVia         int
      //  Freight         money
      //  ShipName        nvarchar(40)
      //  ShipAddress     nvarchar(60)
      //  ShipCity        nvarchar(15)
      //  ShipPostalCode  nvarchar(10)
      //  ShipCountry     nvarchar(15)
      //  ShipperName     nvarchar(40) (not updateable)
      //
      // Table named "Order Details":
      //  OrderID         int           (row key)
      //  ProductID       int           (row key)
      //  UnitPrice       money
      //  Quantity        smallint
      //  Discount        real
      //  ProductName     nvarchar(40) (not updateable)
      //  QtyPerUnit      nvarchar(20) (not updateable)


      // specify the stored procedure to extract the Orders data
      String strSelectOrders = "OrdersForEditByCustID";
      String strSelectOrderLines = "OrderLinesForEditByCustID";

      // create a new DataSet object
      DataSet objDataSet = new DataSet();

      // create a new Connection object using the connection string
      OleDbConnection objConnect = new OleDbConnection(m_ConnectString);

      try
      {
        // create a new Command object
        OleDbCommand objCommand = new OleDbCommand(strSelectOrders, objConnect);
        objCommand.CommandType = CommandType.StoredProcedure;

        // add the required parameter
        objCommand.Parameters.Add("CustID", CustomerID);

        // create a new DataAdapter using Command object
        OleDbDataAdapter objDataAdapter = new OleDbDataAdapter(objCommand);

        // fill the Orders table from the stored procedure
        objDataAdapter.Fill(objDataSet, "Orders");

        // change the stored procedure name in the Command
        objCommand.CommandText = strSelectOrderLines;

        // fill the Order Details table from stored procedure
        objDataAdapter.Fill(objDataSet, "Order Details");

        // get a reference to Orders table in DataSet
        DataTable objTable = objDataSet.Tables["Orders"];

        // set primary key in table to OrderID column
        DataColumn[] arrKey = new DataColumn[1];
        arrKey[0] = objTable.Columns["OrderID"];
        objTable.PrimaryKey = arrKey;

        // get a reference to Order Details table in DataSet
        objTable = objDataSet.Tables["Order Details"];

        // set primary key in table to OrderID and ProductID columns
        arrKey = new DataColumn[2];
        arrKey[0] = objTable.Columns["OrderID"];
        arrKey[1] = objTable.Columns["ProductID"];
        objTable.PrimaryKey = arrKey;

        // create a relationship between the two tables
        DataColumn objParentCol = objDataSet.Tables["Orders"].Columns["OrderID"];
        DataColumn objChildCol = objDataSet.Tables["Order Details"].Columns["OrderID"];
        DataRelation objRelation = new DataRelation("CustOrders", objParentCol, objChildCol);
        objDataSet.Relations.Add(objRelation);
      }
      catch (Exception objError)
      {
        throw objError;
      }

      // accept the changes to "fix" the current state of the DataSet contents
      objDataSet.AcceptChanges();

      return objDataSet;
    }
    // ----------------------------------------------------------------
    // ----------------------------------------------------------------

    public DataSet UpdateAllOrderDetails(String CustomerID, ref DataSet ModifiedDataSet) {
      // pushes the changes back into the data source. If concurrency or
      // other errors arise, these are itemized in a new DataSet that is
      // returned from this function.  Format for a DataSet submitted to
      // this function must be as follows. CustomerID must be the same as
      // was used when DataSet was first filled.
      //
      // NB: There must be a DataRelation set up in the DataSet
      // relating the Orders and OrderLines tables, and the Primary Keys
      // must have been set - either when the DataSet was created by the
      // GetOrderDetails method in this component or by loading a schema
      // that sets the Primary Keys.
      //
      // Table named "Orders":
      //  OrderID         int           (row key)
      //  CustomerID      nchar(5)
      //  OrderDate       datetime
      //  RequiredDate    datetime
      //  ShippedDate     datetime
      //  ShipVia         int
      //  Freight         money
      //  ShipName        nvarchar(40)
      //  ShipAddress     nvarchar(60)
      //  ShipCity        nvarchar(15)
      //  ShipPostalCode  nvarchar(10)
      //  ShipCountry     nvarchar(15)
      //
      // Table named "Order Details":
      //  OrderID         int           (row key)
      //  ProductID       int           (row key)
      //  UnitPrice       money
      //  Quantity        smallint
      //  Discount        real

      // save reference to original DataSet in class-level variable
      // for use in event handlers while updating
      m_ModifiedDataSet = ModifiedDataSet;

      // write message to Trace object for display in ASP.NET page
      if (m_CanTrace == true)
        m_Context.Trace.Write("UpdateDataSet", "Starting Order Update Process");

      // marshall changed rows only into new DataSet
      // require class-level reference for use in event handlers
      m_MarshaledDataSet = m_ModifiedDataSet.GetChanges();

      // ------------ update order rows --------------

      // write message to Trace object for display in ASP.NET page
      if (m_CanTrace == true)
        m_Context.Trace.Write("UpdateDataSet", "Creating Connection: " + m_ConnectString);

      // create a Connection object using the connection string
      OleDbConnection objConnect = new OleDbConnection(m_ConnectString);

      // create two new DataAdapter objects, one to update each table
      OleDbDataAdapter objDAOrders = new OleDbDataAdapter();
      OleDbDataAdapter objDAOrderDetails = new OleDbDataAdapter();

      // prevent exceptions being thrown due to concurrency errors
      // error details are obtained from RowError property of row that
      // generated the error after Update method completes
      objDAOrders.ContinueUpdateOnError = true;
      objDAOrderDetails.ContinueUpdateOnError = true;

      // write message to Trace object for display in ASP.NET page
      if (m_CanTrace == true)
        m_Context.Trace.Write("UpdateDataSet", "Creating Commands and Setting Parameter Values");

      // specify Command objects using separate custom functions that
      // take name of stored procedure, connection object and action
      // first for DataAdapter that updates Orders table
      objDAOrders.UpdateCommand = GetOrdersCommand("OrdersUpdate", ref objConnect, "UPDATE");
      objDAOrders.InsertCommand = GetOrdersCommand("OrdersInsert", ref objConnect, "INSERT");
      objDAOrders.DeleteCommand = GetOrdersCommand("OrdersDelete", ref objConnect, "DELETE");

      // then for DataAdapter that updates Order Details table
      objDAOrderDetails.UpdateCommand = GetOrderLinesCommand("OrderLinesUpdate", ref objConnect, "UPDATE");
      objDAOrderDetails.InsertCommand = GetOrderLinesCommand("OrderLinesInsert", ref objConnect, "INSERT");
      objDAOrderDetails.DeleteCommand = GetOrderLinesCommand("OrderLinesDelete", ref objConnect, "DELETE");

      // local variable to hold number of rows affected for Tracing
      int intRowsAffected;

      // now ready to start updating the rows in the database
      // must delete child rows in Order Details table before
      // updating Orders parent table otherwise parent row
      // cannot be deleted from Orders table in database
      // get reference to Order Details table
      DataTable objTable = m_MarshaledDataSet.Tables["Order Details"];

      // write message to Trace object for display in ASP.NET page
      if (m_CanTrace == true)
        m_Context.Trace.Write("UpdateDataSet", "Deleting Order Details rows");

      try
      {
        // perform the updates on the original data
        // for just deleted rows in Order Details table
        // Select method returns an array of matching rows
        intRowsAffected = objDAOrderDetails.Update(objTable.Select(null, null, DataViewRowState.Deleted));

        // write number of rows updated to Trace object
        if (m_CanTrace == true)
          m_Context.Trace.Write("UpdateDataSet", "Deleted " + intRowsAffected.ToString() + " row(s)");
      }
      catch (Exception objError)
      {
        // raise the error to the calling routine
        throw objError;
      }

      // next, apply updates to all rows in Orders table
      // write message to Trace object for display in ASP.NET page
      if (m_CanTrace == true)
        m_Context.Trace.Write("UpdateDataSet", "Processing Orders rows");

      // add event handlers for RowUpdating and RowUpdated events
      // required to handle inserted rows by updating the OrderID
      // which is an IDENTITY column in the Orders table
      objDAOrders.RowUpdating += new OleDbRowUpdatingEventHandler(OnRowUpdating);
      objDAOrders.RowUpdated += new OleDbRowUpdatedEventHandler(OnRowUpdated);

      try
      {
        // perform the updates on the original data
        intRowsAffected = objDAOrders.Update(m_MarshaledDataSet, "Orders");

        // write number of rows updated to Trace object
        if (m_CanTrace == true)
          m_Context.Trace.Write("UpdateDataSet", "Updated " + intRowsAffected.ToString() + " row(s)");
      }
      catch (Exception objError  )
      {
        // raise the error to the calling routine
        throw objError;
      }

      // write message to Trace object for display in ASP.NET page
      if (m_CanTrace == true)
        m_Context.Trace.Write("UpdateDataSet", "Processing Remaining Order Detail Rows");

      // update remaining Order Detail rows for only the inserted
      // and modified rows - must do the inserts after inserting
      // new parent row into Orders table in database
      try
      {
        // insert new child rows and update modified ones in Order Details table
        intRowsAffected = objDAOrderDetails.Update(objTable.Select(null, null, DataViewRowState.CurrentRows));

        // write number of rows updated to Trace object
        if (m_CanTrace == true)
          m_Context.Trace.Write("UpdateDataSet", "Inserted/Updated " + intRowsAffected.ToString() + " row(s)");
      }
      catch (Exception objError)
      {
        // raise the error to the calling routine
        throw objError;
      }

      // -------- refresh marshalled DataSet ---------
      // specify the stored procedure to extract the Orders data
      String strSelectOrders = "OrdersForEditByCustID";
      String strSelectOrderLines = "OrderLinesForEditByCustID";

      try
      {
        // write message to Trace object for display in ASP.NET page
        if (m_CanTrace == true)
          m_Context.Trace.Write("UpdateDataSet", "Starting Refresh Orders Table");

        // create a new Command object
        OleDbCommand objCommand = new OleDbCommand(strSelectOrders, objConnect);
        objCommand.CommandType = CommandType.StoredProcedure;

        // add the required parameter
        objCommand.Parameters.Add("CustID", CustomerID);

        // assign to SelectCommand of Orders DataAdapter object
        objDAOrders.SelectCommand = objCommand;

        // refresh the Orders table from the stored procedure
        intRowsAffected = objDAOrders.Fill(m_MarshaledDataSet, "Orders");

        // write number of rows updated to Trace object
        if (m_CanTrace == true)
          m_Context.Trace.Write("UpdateDataSet", "Refreshed " + intRowsAffected.ToString() + " row(s)");

        // change the stored procedure name in the Command
        objCommand.CommandText = strSelectOrderLines;

        // assign to SelectCommand of Order Details DataAdapter object
        objDAOrderDetails.SelectCommand = objCommand;

        // write message to Trace object for display in ASP.NET page
        if (m_CanTrace == true)
          m_Context.Trace.Write("UpdateDataSet", "Starting Refresh Order Details Table");

        // refresh the Order Details table from the stored procedure
        intRowsAffected = objDAOrderDetails.Fill(m_MarshaledDataSet, "Order Details");

        // write number of rows updated to Trace object
        if (m_CanTrace == true)
          m_Context.Trace.Write("UpdateDataSet", "Refreshed " + intRowsAffected.ToString() + " row(s)");
      }
      catch (Exception objError)
      {
        throw objError;
      }

      // ------ merge with original DataSet ----------

      // write message to Trace object for display in ASP.NET page
      if (m_CanTrace == true)
        m_Context.Trace.Write("UpdateDataSet", "Starting Merge DataSet");

      // use parameter to preserve changes
      m_ModifiedDataSet.Merge(m_MarshaledDataSet, true);

      // ----- return updated merged DataSet ---------

      // write message to Trace object for display in ASP.NET page
      if (m_CanTrace == true)
        m_Context.Trace.Write("UpdateDataSet", "Returning Updated DataSet");

      // return all rows including successful updates
      return m_ModifiedDataSet;

    }
    // ----------------------------------------------------------------
    // ----------------------------------------------------------------

    private OleDbCommand GetOrdersCommand(String strStoredProcName, ref OleDbConnection objConnect, String strCommandType) {
      // creates a new Command object and adds parameters, specifying the
      // column name and version from which values will be taken

      OleDbCommand objCommand = new OleDbCommand(strStoredProcName, objConnect);
      objCommand.CommandType = CommandType.StoredProcedure;

      OleDbParameterCollection colParams = objCommand.Parameters;
      OleDbParameter objParam;

      objParam = colParams.Add("OrderID", OleDbType.Integer, 4, "OrderID");
      objParam.SourceVersion = DataRowVersion.Original;

      if (strCommandType != "INSERT")
      {
        // add "Original" parameter values for Delete and Update actions
        objParam = colParams.Add("OldCustomerID", OleDbType.Char, 5, "CustomerID");
        objParam.SourceVersion = DataRowVersion.Original;
        objParam = colParams.Add("OldOrderDate", OleDbType.DBDate, 4, "OrderDate");
        objParam.SourceVersion = DataRowVersion.Original;
        objParam = colParams.Add("OldRequiredDate", OleDbType.DBDate, 4, "RequiredDate");
        objParam.SourceVersion = DataRowVersion.Original;
        objParam = colParams.Add("OldShippedDate", OleDbType.DBDate, 4, "ShippedDate");
        objParam.SourceVersion = DataRowVersion.Original;
        objParam = colParams.Add("OldShipVia", OleDbType.Integer, 4, "ShipVia");
        objParam.SourceVersion = DataRowVersion.Original;
        objParam = colParams.Add("OldFreight", OleDbType.Decimal, 4, "Freight");
        objParam.SourceVersion = DataRowVersion.Original;
        objParam = colParams.Add("OldShipName", OleDbType.VarChar, 40, "ShipName");
        objParam.SourceVersion = DataRowVersion.Original;
        objParam = colParams.Add("OldShipAddress", OleDbType.VarChar, 60, "ShipAddress");
        objParam.SourceVersion = DataRowVersion.Original;
        objParam = colParams.Add("OldShipCity", OleDbType.VarChar, 15, "ShipCity");
        objParam.SourceVersion = DataRowVersion.Original;
        objParam = colParams.Add("OldShipPostalCode", OleDbType.VarChar, 10, "ShipPostalCode");
        objParam.SourceVersion = DataRowVersion.Original;
        objParam = colParams.Add("OldShipCountry", OleDbType.VarChar, 15, "ShipCountry");
        objParam.SourceVersion = DataRowVersion.Original;
      }

      if (strCommandType != "DELETE")
      {
        // add "Current" parameter values for Update and Insert actions
        objParam = colParams.Add("NewCustomerID", OleDbType.Char, 5, "CustomerID");
        objParam.SourceVersion = DataRowVersion.Current;
        objParam = colParams.Add("NewOrderDate", OleDbType.DBDate, 4, "OrderDate");
        objParam.SourceVersion = DataRowVersion.Current;
        objParam = colParams.Add("NewRequiredDate", OleDbType.DBDate, 4, "RequiredDate");
        objParam.SourceVersion = DataRowVersion.Current;
        objParam = colParams.Add("NewShippedDate", OleDbType.DBDate, 4, "ShippedDate");
        objParam.SourceVersion = DataRowVersion.Current;
        objParam = colParams.Add("NewShipVia", OleDbType.Integer, 4, "ShipVia");
        objParam.SourceVersion = DataRowVersion.Current;
        objParam = colParams.Add("NewFreight", OleDbType.Decimal, 4, "Freight");
        objParam.SourceVersion = DataRowVersion.Current;
        objParam = colParams.Add("NewShipName", OleDbType.VarChar, 40, "ShipName");
        objParam.SourceVersion = DataRowVersion.Current;
        objParam = colParams.Add("NewShipAddress", OleDbType.VarChar, 60, "ShipAddress");
        objParam.SourceVersion = DataRowVersion.Current;
        objParam = colParams.Add("NewShipCity", OleDbType.VarChar, 15, "ShipCity");
        objParam.SourceVersion = DataRowVersion.Current;
        objParam = colParams.Add("NewShipPostalCode", OleDbType.VarChar, 10, "ShipPostalCode");
        objParam.SourceVersion = DataRowVersion.Current;
        objParam = colParams.Add("NewShipCountry", OleDbType.VarChar, 15, "ShipCountry");
        objParam.SourceVersion = DataRowVersion.Current;
      }

      return objCommand;
    }

    // ----------------------------------------------------------------
    // ----------------------------------------------------------------

    private OleDbCommand GetOrderLinesCommand(String strStoredProcName, ref OleDbConnection objConnect, String strCommandType) {
      // creates a new Command object and adds parameters, specifying the
      // column name and version from which values will be taken

      OleDbCommand objCommand = new OleDbCommand(strStoredProcName, objConnect);
      objCommand.CommandType = CommandType.StoredProcedure;

      OleDbParameterCollection colParams = objCommand.Parameters;
      OleDbParameter objParam;

      objParam = colParams.Add("OrderID", OleDbType.Integer, 4, "OrderID");
      objParam.SourceVersion = DataRowVersion.Original;
      objParam = colParams.Add("ProductID", OleDbType.Integer, 4, "ProductID");
      objParam.SourceVersion = DataRowVersion.Original;

      if (strCommandType != "INSERT")
      {
        // add "Original" parameter values for Delete and Update actions
        objParam = colParams.Add("OldUnitPrice", OleDbType.Decimal, 4, "UnitPrice");
        objParam.SourceVersion = DataRowVersion.Original;
        objParam = colParams.Add("OldQuantity", OleDbType.SmallInt, 2, "Quantity");
        objParam.SourceVersion = DataRowVersion.Original;
        objParam = colParams.Add("OldDiscount", OleDbType.Double, 2, "Discount");
        objParam.SourceVersion = DataRowVersion.Original;
      }

      if (strCommandType != "DELETE")
      {
        // add "Current" parameter values for Update and Insert actions
        objParam = colParams.Add("NewUnitPrice", OleDbType.Decimal, 4, "UnitPrice");
        objParam.SourceVersion = DataRowVersion.Current;
        objParam = colParams.Add("NewQuantity", OleDbType.SmallInt, 2, "Quantity");
        objParam.SourceVersion = DataRowVersion.Current;
        objParam = colParams.Add("NewDiscount", OleDbType.Double, 2, "Discount");
        objParam.SourceVersion = DataRowVersion.Current;
      }
      return objCommand;
    }
    // ----------------------------------------------------------------
    // ----------------------------------------------------------------

    void OnRowUpdating(Object objSender, OleDbRowUpdatingEventArgs objArgs) {
      // event handler for the RowUpdating event
      // see if its an INSERT statement. If so we need to save the
      // temporary order ID allocated on the client while disconnected
      // so we can update the child rows with the "real" order ID
      // after the row has been inserted into the data store
      if (objArgs.StatementType == StatementType.Insert)
      {
        // save the temporary order ID in the class-level variable
        m_InsertOrderID = (int) objArgs.Row["OrderID", DataRowVersion.Current];
      }
    }
    // ----------------------------------------------------------------
    // ----------------------------------------------------------------

    void OnRowUpdated(Object objSender, OleDbRowUpdatedEventArgs objArgs) {

      // event handler for the RowUpdated event
      // see if its an INSERT statement
      if (objArgs.StatementType == StatementType.Insert)
      {

        // see if the insert was successful
        // expect 1 in success, zero or -1 on failure
        if (objArgs.RecordsAffected == 1)
        {

          // get new order ID from IDENTITY column in this row.
          // the InsertOrders stored proc returns the newly inserted row
          // and this automatically updates the current values for the
          // columns in this row, including the auto-generated OrderID
          // because of Relation, also cascades updates to child table rows
          int intNewOrderID = (int) objArgs.Row["OrderID", DataRowVersion.Current];

          // update matching Orders row in original DataSet otherwise the
          // rows will not be matched when the Merge method is used later
          // because of Relation, also cascades updates to child table rows
          DataTable objTable = m_ModifiedDataSet.Tables["Orders"];
          DataRow[] arrRows;
          arrRows = objTable.Select("OrderID = '" + m_InsertOrderID + "'");
          foreach (DataRow objRow in arrRows)
            objRow["OrderID"] = intNewOrderID;

          // write message to Trace object
          if (m_CanTrace == true)
            m_Context.Trace.Write("UpdateDataSet", "Inserted Order row with OrderID " + intNewOrderID.ToString());
        }
      }
    }
    // ----------------------------------------------------------------
    // ----------------------------------------------------------------
  }
}
