using System;
using System.Data;
using System.Data.OleDb;

// the namespace for the component
namespace OrderListData
{

  // the main class definition
  public class OrderList
  {

    // private internal variables
    private String m_ConnectString;  // database connection string

    // ----------------------------------------------------

    // constructor for component - requires the connection
    // string to be provided the single parameter
    public OrderList(String ConnectString)
    {
      m_ConnectString = ConnectString;
    }

    // ------------------------------------------------------

    // method to return DataSet containing two tables
    // Orders and related Order Lines for a specified CustomerID
    public DataSet GetOrdersByCustomerDataSet(String strCustID)
    {

      // specify the stored procedure names
      String strGetOrders = "GetOrdersByCustomer";
      String strGetOrderLines = "GetOrderLinesByCustomer";

      // declare a variable to hold a DataSet object
      DataSet objDataSet = new DataSet();

      // create a new Connection object using the connection string
      OleDbConnection objConnect = new OleDbConnection(m_ConnectString);

      try
      {

        // create a new Command object and set the CommandType
        OleDbCommand objCommand = new OleDbCommand(strGetOrders, objConnect);
        objCommand.CommandType = CommandType.StoredProcedure;

        // create a new Parameter object named // CustID' with the correct data
        // type to match a SQL database // varchar' field of 5 characters
        OleDbParameter objParam = objCommand.Parameters.Add("CustID", OleDbType.VarChar, 5);

        // specify that it's an Input parameter and set the value
        objParam.Direction = ParameterDirection.Input;
        objParam.Value = strCustID;

        // create a new DataAdapter object
        OleDbDataAdapter objDataAdapter = new OleDbDataAdapter();

        // and assign the Command object to it
        objDataAdapter.SelectCommand = objCommand;

        // open database connection first for max efficiency
        // because were calling Fill method twice
        objConnect.Open();

        // get data from stored proc into table named "Orders"
        objDataAdapter.Fill(objDataSet, "Orders");

        // change the stored proc name in the Command object
        objCommand.CommandText = strGetOrderLines;

        // get data from stored proc into table named "OrderLines"
        objDataAdapter.Fill(objDataSet, "OrderLines");

        // create a Relation object to link Orders and OrderLines
        DataRelation objRelation = new DataRelation("CustOrderLines",
          objDataSet.Tables["Orders"].Columns["OrderID"],
          objDataSet.Tables["OrderLines"].Columns["OrderID"]);

        // and add it to the DataSet object's Relations collection
        objDataSet.Relations.Add(objRelation);
      }
      catch (Exception objError)
      {
        throw objError;  // throw error to calling routine
      }
      finally
      {
        // must remember to close connection - we opened it ourselves
        // so the Fill method will not close it automatically
        objConnect.Close();
      }
      return objDataSet;   // return populated DataSet to calling routine
    }

    // ------------------------------------------------------

    // method to return DataSet containing list of customers that match
    // on ID or name - one parameter should be an empty string each time
    // performs partial or full matching automatically:
    //  - up to 5 chars max for ID, returns results sorted by ID
    //  - up to 40 chars for name, returns results sorted by name
    public DataSet GetCustomerByIdOrName(String strCustID, String strCustName)
    {

      // specify the stored procedure name
      String strCustListProc = "GetCustomerListByIdOrName";

      // declare a variable to hold a DataSet object
      DataSet objDataSet = new DataSet();

      try
      {

        // create a new Connection object using the connection string
        OleDbConnection objConnect = new OleDbConnection(m_ConnectString);

        // create a new Command object and set the CommandType
        OleDbCommand objCommand = new OleDbCommand(strCustListProc, objConnect);
        objCommand.CommandType = CommandType.StoredProcedure;

        // create a Parameter for the customer ID
        OleDbParameter objParam = objCommand.Parameters.Add("CustID", OleDbType.VarChar, 5);
        objParam.Direction = ParameterDirection.Input;
        objParam.Value = strCustID;

        // create a Parameter for the customer name
        objParam = objCommand.Parameters.Add("CustName", OleDbType.VarChar, 40);
        objParam.Direction = ParameterDirection.Input;
        objParam.Value = strCustName;

        // create a new DataAdapter object
        OleDbDataAdapter objDataAdapter = new OleDbDataAdapter();
        // and assign the Command object to it
        objDataAdapter.SelectCommand = objCommand;

        // get data from stored proc into table named "Orders"
        objDataAdapter.Fill(objDataSet, "Customers");
      }
      catch (Exception objError)
      {
        throw objError;  // throw error to calling routine
      }
      return objDataSet;   // return populated DataSet to calling routine
    }

    // ------------------------------------------------------
  }
}
