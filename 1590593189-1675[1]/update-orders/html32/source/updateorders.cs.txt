using System;
using System.Data;
using System.Data.OleDb;

// the namespace for the component
namespace DDA4923OrderUpdate
{

  // the main class definition
  public class UpdateOrders
  {

    // privateinternal variables
    private DataSet mModifiedDataSet;    // to hold rows from database
    private DataSet mErrorsDataSet;      // to hold the Errors table
    private String mConnectString;       // to hold the connection string
    private Boolean mRollback;           // whether to roll back changes

    // ----------------------------------------------------------------

    public UpdateOrders(String ConnectString)
    {
      // constructor for component - requires the connection
      // string to be provided the single parameter
      mConnectString = ConnectString;
    }

    // ----------------------------------------------------------------

    public Boolean SetFreightCost(int OrderID) {
      // calculates freight shipping cost and updates Orders table

      // specify the stored procedure to insert the row
      String strProcName = "SetFreightCost";
      // create Connection object using the connection string
      OleDbConnection objConnect = new OleDbConnection(mConnectString);

      try
      {

        // create Command using Connection and storedproc name
        OleDbCommand objCommand = new OleDbCommand(strProcName, objConnect);
        objCommand.CommandType = CommandType.StoredProcedure;

        // add required parameters for input
        objCommand.Parameters.Add("@OrderID", OrderID);

        // open connection
        objConnect.Open();

        // execute the stored procedure and return true or false
        return (objCommand.ExecuteNonQuery() == 1);
      }
      catch (Exception objError)
      {
        return false;
      }
      finally
      {
        // close connection
        objConnect.Close();
      }
    }

    // ----------------------------------------------------------------

    public int SingleRowOrderDelete(int UpdateOrderID,
      Object RequiredDateWas, Object ShippedDateWas, Double FreightWas, String ShipNameWas,
      String ShipAddressWas, String ShipCityWas, String ShipPostalCodeWas,
      String ShipCountryWas, int ShipViaWas) {
      // deletes existing row in the Order table for the specified order
      // checking for concurrency errors by comparing original values

      // specify the stored procedure to insert the row
      String strProcName = "DeleteExistingOrder";

      // create Connection object using the connection string
      OleDbConnection objConnect = new OleDbConnection(mConnectString);

      try
      {

        // create Command using Connection and storedproc name
        OleDbCommand objCommand = new OleDbCommand(strProcName, objConnect);
        objCommand.CommandType = CommandType.StoredProcedure;

        // create "dummy" DateTime to compare values to. CompareTo
        // returns 1 if value we compare this with is null.
        DateTime datDummy = new DateTime(2002,1,1);

        // add required parameters for input
        objCommand.Parameters.Add("@OrderID", UpdateOrderID);
        if (RequiredDateWas == null)
          objCommand.Parameters.Add("@RequiredWas", DBNull.Value);
        else
          objCommand.Parameters.Add("@RequiredWas", (DateTime) RequiredDateWas);
        if (ShippedDateWas == null)
          objCommand.Parameters.Add("@ShippedWas", DBNull.Value);
        else
          objCommand.Parameters.Add("@ShippedWas", (DateTime) ShippedDateWas);
        objCommand.Parameters.Add("@FreightWas", FreightWas);
        objCommand.Parameters.Add("@NameWas", ShipNameWas);
        objCommand.Parameters.Add("@AddressWas", ShipAddressWas);
        objCommand.Parameters.Add("@CityWas", ShipCityWas);
        objCommand.Parameters.Add("@PostalCodeWas", ShipPostalCodeWas);
        objCommand.Parameters.Add("@CountryWas", ShipCountryWas);
        objCommand.Parameters.Add("@ShipViaWas", ShipViaWas);

        // open connection
        objConnect.Open();

        // execute the stored procedure and return the result
        return objCommand.ExecuteNonQuery();
      }
      catch (Exception objError)
      {
        throw objError;
      }
      finally
      {
        // close connection
        objConnect.Close();
      }
    }

    // ----------------------------------------------------------------

    public int SingleRowOrderUpdate(int UpdateOrderID, Object RequiredDate,
       Object ShippedDate, Double Freight, String ShipName, String ShipAddress,
      String ShipCity, String ShipPostalCode, String ShipCountry,
         int ShipVia, Object RequiredDateWas, Object ShippedDateWas, Double FreightWas,
      String ShipNameWas, String ShipAddressWas, String ShipCityWas,
      String ShipPostalCodeWas, String ShipCountryWas, int ShipViaWas) {
      // updates existing row into the Order table for the specified order
      // checking for concurrency errors by comparing original values

      // specify the stored procedure to insert the row
      String strProcName = "UpdateExistingOrder";

      // create Connection object using the connection string
      OleDbConnection objConnect =new OleDbConnection(mConnectString);

      try
      {

        // create Command using Connection and storedproc name
        OleDbCommand objCommand = new OleDbCommand(strProcName, objConnect);
        objCommand.CommandType = CommandType.StoredProcedure;

        // add required parameters for input
        objCommand.Parameters.Add("@OrderID", UpdateOrderID);

        // create "dummy" DateTime to compare values to. CompareTo
        // returns 1 if value we compare this with is null.
        DateTime datDummy = new DateTime(2002,1,1);
        if (RequiredDate == null)
          objCommand.Parameters.Add("@Required", DBNull.Value);
        else
          objCommand.Parameters.Add("@Required", (DateTime) RequiredDate);
        if (ShippedDate == null)
          objCommand.Parameters.Add("@Shipped", DBNull.Value);
        else
          objCommand.Parameters.Add("@Shipped", (DateTime) ShippedDate);
        objCommand.Parameters.Add("@Freight", Freight);
        objCommand.Parameters.Add("@ShipName", ShipName);
        objCommand.Parameters.Add("@Address", ShipAddress);
        objCommand.Parameters.Add("@City", ShipCity);
        objCommand.Parameters.Add("@PostalCode", ShipPostalCode);
        objCommand.Parameters.Add("@Country", ShipCountry);
        objCommand.Parameters.Add("@ShipVia", ShipVia);
        if (RequiredDateWas == null)
          objCommand.Parameters.Add("@RequiredWas", DBNull.Value);
        else
          objCommand.Parameters.Add("@RequiredWas", (DateTime) RequiredDateWas);
        if (ShippedDateWas == null)
          objCommand.Parameters.Add("@ShippedWas", DBNull.Value);
        else
          objCommand.Parameters.Add("@ShippedWas", (DateTime) ShippedDateWas);
        objCommand.Parameters.Add("@FreightWas", FreightWas);
        objCommand.Parameters.Add("@NameWas", ShipNameWas);
        objCommand.Parameters.Add("@AddressWas", ShipAddressWas);
        objCommand.Parameters.Add("@CityWas", ShipCityWas);
        objCommand.Parameters.Add("@PostalCodeWas", ShipPostalCodeWas);
        objCommand.Parameters.Add("@CountryWas", ShipCountryWas);
        objCommand.Parameters.Add("@ShipViaWas", ShipViaWas);

        // open connection
        objConnect.Open();

        // execute the stored procedure and return the result
        return objCommand.ExecuteNonQuery();
      }
      catch (Exception objError)
      {
        throw objError;
      }
      finally
      {
        // close connection
        objConnect.Close();
      }
    }

    // ----------------------------------------------------------------

    public int InsertNewOrder(String CustomerID) {
      // inserts a new row into the Order table for the specified customer
      // with address details pre-filled, and returns the new OrderID

      // specify the stored procedure to insert the row
      String strProcName = "InsertNewOrder";

      // create Connection object using the connection string
      OleDbConnection objConnect = new OleDbConnection(mConnectString);

      try {
        // create Command using Connection and storedproc name
        OleDbCommand objCommand = new OleDbCommand(strProcName, objConnect);
        objCommand.CommandType = CommandType.StoredProcedure;

        // add required parameters for input and output
        objCommand.Parameters.Add("@CustID", OleDbType.VarChar, 5);
        objCommand.Parameters["@CustID"].Value = CustomerID;
        objCommand.Parameters.Add("@OrderID", OleDbType.Integer);
        objCommand.Parameters["@OrderID"].Direction = ParameterDirection.Output;

        // open connection
        objConnect.Open();

        // execute the stored procedure and return the result
        objCommand.ExecuteNonQuery();
        return (int)objCommand.Parameters["@OrderId"].Value;
      }
      catch (Exception objError)
      {
        throw objError;
      }
      finally
      {
        // close connection
        objConnect.Close();
      }
    }

    // ----------------------------------------------------------------

    public Boolean InsertNewOrderLine(int OrderID, int ProductID) {
    // inserts a new row into the Order Details table for the specified
    // order, with product details pre-filled

      // specify the stored procedure to insert the row
      String strProcName = "InsertNewOrderLine";

      // create Connection object using the connection string
      OleDbConnection objConnect = new OleDbConnection(mConnectString);

      try
      {
        // create Command using Connection and storedproc name
        OleDbCommand objCommand = new OleDbCommand(strProcName, objConnect);
        objCommand.CommandType = CommandType.StoredProcedure;

        // add required parameters for input
        objCommand.Parameters.Add("@OrderID", OrderID);
        objCommand.Parameters.Add("@ProductID", ProductID);

        // open connection
        objConnect.Open();

        // execute the stored procedure and return the result
        return (objCommand.ExecuteNonQuery() == 1);
      }
      catch (Exception objError)
      {
        throw objError;
      }
      finally
      {
        // close connection
        objConnect.Close();
      }
    }

    // ----------------------------------------------------------------

    public int SingleOrderLineUpdate(int OrderID, int ProductID,
      Double UnitPrice, int Quantity, Double Discount, Double UnitPriceWas,
      int QuantityWas, Double DiscountWas) {
      // updates existing row in Order Details table for specified order
      // line, checking for concurrency errors by comparing original values

      // specify the stored procedure to insert the row
      String strProcName = "UpdateExistingOrderLine";

      // create Connection object using the connection string
      OleDbConnection objConnect = new OleDbConnection(mConnectString);

      try
      {
        // create Command using Connection and storedproc name
        OleDbCommand objCommand = new OleDbCommand(strProcName, objConnect);
        objCommand.CommandType = CommandType.StoredProcedure;

        // add required parameters for input
        objCommand.Parameters.Add("@OrderID", OrderID);
        objCommand.Parameters.Add("@ProductID", ProductID);
        objCommand.Parameters.Add("@UnitPrice", UnitPrice);
        objCommand.Parameters.Add("@Quantity", Quantity);
        objCommand.Parameters.Add("@Discount", Discount);
        objCommand.Parameters.Add("@UnitPriceWas", UnitPriceWas);
        objCommand.Parameters.Add("@QuantityWas", QuantityWas);
        objCommand.Parameters.Add("@DiscountWas", DiscountWas);

        // open connection
        objConnect.Open();

        // execute the stored procedure and return the result
        return objCommand.ExecuteNonQuery();
      }
      catch (Exception objError)
      {
        throw objError;
      }
      finally
      {
        // close connection
        objConnect.Close();
      }
    }

    // ----------------------------------------------------------------

    public int SingleOrderLineDelete(int OrderID, int ProductID,
      Double UnitPriceWas, int QuantityWas, Double DiscountWas) {
      // deletes existing row in Order Details table for specified order
      // line, checking for concurrency errors by comparing original values

      // specify the stored procedure to insert the row
      String strProcName = "DeleteExistingOrderLine";

      // create Connection object using the connection string
      OleDbConnection objConnect = new OleDbConnection(mConnectString);

      try
      {
        // create Command using Connection and storedproc name
        OleDbCommand objCommand = new OleDbCommand(strProcName, objConnect);
        objCommand.CommandType = CommandType.StoredProcedure;

        // add required parameters for input
        objCommand.Parameters.Add("@OrderID", OrderID);
        objCommand.Parameters.Add("@ProductID", ProductID);
        objCommand.Parameters.Add("@UnitPriceWas", UnitPriceWas);
        objCommand.Parameters.Add("@QuantityWas", QuantityWas);
        objCommand.Parameters.Add("@DiscountWas", DiscountWas);

        // open connection
        objConnect.Open();

        // execute the stored procedure and return the result
        return objCommand.ExecuteNonQuery();
      }
      catch (Exception objError)
      {
        throw objError;
      }
      finally
      {
        // close connection
        objConnect.Close();
      }
    }

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
      OleDbConnection objConnect = new OleDbConnection(mConnectString);

      try
      {
        // create DataAdapter using Connection and storedproc name
        OleDbDataAdapter objDataAdapter =new OleDbDataAdapter(strSelect, objConnect);

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
      OleDbConnection objConnect = new OleDbConnection(mConnectString);

      try
      {
        // create DataAdapter using Connection and storedproc name
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
      OleDbConnection objConnect = new OleDbConnection(mConnectString);

      try
      {

        // create a new Command object
        OleDbCommand objCommand = new OleDbCommand(strSelectOrders, objConnect);
        objCommand.CommandType = CommandType.StoredProcedure;

        // add the required parameter
        objCommand.Parameters.Add("@CustID", CustomerID);

        // create a new DataAdapter using the connection object and select statement
        OleDbDataAdapter objDataAdapter = new OleDbDataAdapter(objCommand);

        // fill the Orders table from the stored procedure
        objDataAdapter.Fill(objDataSet, "Orders");

        // change the stored procedure name in the Command
        objCommand.CommandText = strSelectOrderLines;

        // fill the Order Details table from the stored procedure
        objDataAdapter.Fill(objDataSet, "Order Details");
      }
      catch (Exception objError)
      {
        throw objError;
      }
         // accept the changes to "fix" the current state of the DataSet contents
      objDataSet.AcceptChanges();
      return objDataSet;
    }
  }
}

