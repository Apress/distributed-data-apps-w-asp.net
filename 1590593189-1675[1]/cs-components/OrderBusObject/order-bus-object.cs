using System;
using System.Data;
using System.Data.OleDb;

// the namespace for the component
namespace DDA4923OrderObject
{

  // the main class definition
  public class ProcessOrderList
  {

    // private internal variables
    private String m_ConnectString;  // database connection string

    // ----------------------------------------------------

    // constructor for component - requires the connection
    // string to be provided the single parameter
    public ProcessOrderList(String ConnectString) {
      m_ConnectString = ConnectString;
    }
    // ------------------------------------------------------

    // method to return DataSet containing two tables
    // Orders and related Order Lines for a specified CustomerID
    public DataSet GetOrdersByCustomerDataSet(String strCustID) {

    // specify the stored procedure names
    String strGetOrders = "GetOrdersByCustomer";
    String strGetOrderLines = "GetOrderLinesByCustomer";

    // declare a variable to hold a DataSet object
    DataSet objDataSet = new DataSet();

      try
      {

        // create a new Connection object using the connection string
        OleDbConnection objConnect = new OleDbConnection(m_ConnectString);

        // create a new Command object and set the CommandType
        OleDbCommand objCommand = new OleDbCommand(strGetOrders, objConnect);
        objCommand.CommandType = CommandType.StoredProcedure;

        // create a variable to hold a Parameter object
        OleDbParameter objParam;

        // create a new Parameter object named // ISBN' with the correct data
        // type to match a SQL database // varchar' field of 12 characters
        objParam = objCommand.Parameters.Add("CustID", OleDbType.VarChar, 5);

        // specify that it's an Input parameter and set the value
        objParam.Direction = ParameterDirection.Input;
        objParam.Value = strCustID;

        // create a new DataAdapter object
        OleDbDataAdapter objDataAdapter = new OleDbDataAdapter();

        // and assign the Command object to it
        objDataAdapter.SelectCommand = objCommand;

        // get data from stored proc into table named "Orders"
        objDataAdapter.Fill(objDataSet, "Orders");

        // change the stored proc name in the Command object
        objCommand.CommandText = strGetOrderLines;

        // get data from stored proc into table named "OrderLines"
        objDataAdapter.Fill(objDataSet, "OrderLines");

        // create a Relation object to link Books and Authors
        DataRelation objRelation = new DataRelation("CustOrderLines",
          objDataSet.Tables["Orders"].Columns["OrderID"],
          objDataSet.Tables["OrderLines"].Columns["OrderID"]);

        // and add it to the DataSet object's Relations collection
        objDataSet.Relations.Add(objRelation);

      }
      catch (Exception objError) {
        throw objError;  // throw error to calling routine
      }
    return objDataSet;   // return populated DataSet to calling routine
    }

    // ------------------------------------------------------
  }
}
