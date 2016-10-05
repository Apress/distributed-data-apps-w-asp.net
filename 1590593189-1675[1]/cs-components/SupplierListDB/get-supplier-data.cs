using System;
using System.Collections;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Xml;

// the namespace for the component
namespace SupplierListDB
{

  // the main class definition
  public class SupplierList
  {

    // privateinternal variable to store connection string
    private String m_ConnectString;

    // ----------------------------------------------------

    // constructor for component - requires the connection
    // string to be provided the single parameter
    public SupplierList(String ConnectString)
    {
      m_ConnectString = ConnectString;
    }

    // ----------------------------------------------------

    // method to return a DataSet containing the full
    // list of supplier details from database
    public DataSet GetSuppliersDataSet()
    {

      // declare a String containing the stored procedure name
      String strQuery = "GetSupplierList";

      // create a new Connection object using connection string
      OleDbConnection objConnect = new OleDbConnection(m_ConnectString);

      // create new DataAdapter using stored proc name and Connection
      OleDbDataAdapter objAdapter = new OleDbDataAdapter(strQuery, objConnect);

      // create a new DataSet object to hold the results
      DataSet objDataSet = new DataSet();

      try
      {

        // get the data into a table named "Suppliers" in the DataSet
        objAdapter.Fill(objDataSet, "Suppliers");

        // return the DataSet object to the calling routine
        return objDataSet;
      }
      catch (Exception objErr)
      {
        throw (objErr);
      }
    }
    // ----------------------------------------------------

    // method to return a DataReader pointing to a full
    // list of supplier details from database
    public OleDbDataReader GetSuppliersDataReader()
    {

      // declare a String containing the stored procedure name
      String strQuery = "GetSupplierList";

      // create a new Connection object using connection string
      OleDbConnection objConnect = new OleDbConnection(m_ConnectString);

      // create new Command using stored proc name and Connection
      OleDbCommand objCommand = new OleDbCommand(strQuery, objConnect);

      try
      {

        // open connection to the database
        objConnect.Open();

        // execute the stored proc to initialize the DataReader
        // connection will be closed when DataReader goes out of scope
        return objCommand.ExecuteReader(CommandBehavior.CloseConnection);
      }
      catch (Exception objErr)
      {

        throw (objErr);
      }
    }
    // ----------------------------------------------------

    // method to return an XML document (as a String) containing
    // a full list of supplier details from database
    public String GetSuppliersXml(Boolean IncludeSchema)
    {

      // declare a String containing the stored procedure name
      String strQuery = "GetSupplierList";

      // create a new Connection object using connection string
      OleDbConnection objConnect = new OleDbConnection(m_ConnectString);

      // create new DataAdapter using stored proc name and Connection
      OleDbDataAdapter objAdapter = new OleDbDataAdapter(strQuery, objConnect);

      // create a new DataSet object to hold the results
      DataSet objDataSet = new DataSet();

      // declare an empty String to hold the results
      String strXml = String.Empty;

      try
      {

        // get the data into a table named "Suppliers" in the DataSet
        objAdapter.Fill(objDataSet, "Suppliers");

        // get schema if ( specif (ied in optional method parameter
        if (IncludeSchema == true)
          strXml = objDataSet.GetXmlSchema() + (char)13 + (char)10 + (char)13 + (char)10;

        // get XML data and append to String
        strXml += objDataSet.GetXml();

        // return the XML string to the calling routine
        return strXml;
      }
      catch (Exception objErr)
      {
        throw (objErr);
      }
    }
    // ----------------------------------------------------

    // method to return an XmlDocument object containing
    // a full list of supplier details from database
    public XmlDocument GetSuppliersXmlDocument()
    {

      // declare a String containing the stored procedure name
      String strQuery = "GetSupplierList";

      // create a new Connection object using connection string
      OleDbConnection objConnect = new OleDbConnection(m_ConnectString);

      // create new DataAdapter using stored proc name and Connection
      OleDbDataAdapter objAdapter = new OleDbDataAdapter(strQuery, objConnect);

      // create a new DataSet object to hold the results
      DataSet objDataSet = new DataSet();

      try
      {

        // get the data into a table named "Suppliers" in the DataSet
        objAdapter.Fill(objDataSet, "Suppliers");

        // create a new XmlDataDocument object based on the DataSet
        XmlDataDocument objXmlDataDoc = new XmlDataDocument(objDataSet);

        // return it an XmlDocument object to the calling routine
        return (XmlDocument)objXmlDataDoc;
      }
      catch (Exception objErr)
      {
        throw (objErr);
      }
    }
    // ----------------------------------------------------

    // method to return an XML document (as a String) containing
    // a full list of supplier details from database, and using
    // a SQL Server XML technology (FOR XML) query
    public String GetSuppliersSqlXml()
    {

      // declare a String containing the SQL-XML stored proc to execute
      String strQuery = "GetSupplierXml";

      // create a new Connection object using connection string
      SqlConnection objConnect = new SqlConnection(m_ConnectString);

      // create new Command using stored proc name and Connection
      SqlCommand objCommand = new SqlCommand(strQuery, objConnect);

      // create a variable to hold an XmlTextReader object
      XmlTextReader objReader = null;

      String strXml = String.Empty;
      Char QUOT = (char)34;

      try
      {

        // open connection to the database
        objConnect.Open();

        // execute the stored proc to initialize the XmlTextReader
        objReader = (XmlTextReader) objCommand.ExecuteXmlReader();

        // create the document prolog
        DateTime datToday = DateTime.Now;
        strXml = "<?xml version=" + QUOT + "1.0" + QUOT + "?>"
          + "<!-- Created: " + datToday.ToString("d") + " -->"
          + "<SupplierList>";

        // read the first result row and ) read remainder
        objReader.ReadString();
        strXml += objReader.GetRemainder().ReadToEnd();

        // add the document epilog
        strXml += "</SupplierList>";
      }
      catch (Exception objErr)
      {
        throw (objErr);
      }
      finally
      {
        // close connection and destroy reader object
        objConnect.Close();
        objReader = null;
      }
      // return the XML document object to the calling routine
      return strXml;
    }
    // ----------------------------------------------------

    // method to return an Array containing the full
    // name and address details of suppliers from the database
    public String[,] GetSuppliersArray(ref int MaximumRowNumber)
    {

      // declare a String containing the stored procedure name
      String strQuery = "GetSupplierList";

      // create a new Connection object using connection string
      OleDbConnection objConnect = new OleDbConnection(m_ConnectString);

      // create new Command using stored proc name and Connection
      OleDbCommand objCommand = new OleDbCommand(strQuery, objConnect);

      // create a variable to hold a DataReader object
      OleDbDataReader objReader = null;

      try
      {

        // open connection to the database
        objConnect.Open();

        // execute query to initialize DataReader object
        // connection will be closed when DataReader goes out of scope
        objReader = objCommand.ExecuteReader(CommandBehavior.CloseConnection);

        // get the index of the last column within the data
        int intLastColIndex = objReader.FieldCount;

        // declare a variable to hold the result array
        String[,] arrValues = new String[intLastColIndex, MaximumRowNumber];

        int intRowCount = 0;   // to hold number of rows returned
        int intCol;            // to hold the column iterator

        // iterate through rows by calling Read method until false
        while (objReader.Read() && intRowCount < MaximumRowNumber)
        {

          // store column values strings in result array
          for (intCol = 0; intCol < intLastColIndex; intCol++)
            arrValues[intCol, intRowCount] = (String) objReader[intCol];

          // increment number of rows found
          intRowCount++;

        }

        objReader = null;     // finished with DataReader

        // set Ref parameter value for number of rows in Array
        MaximumRowNumber = intRowCount - 1;

        return arrValues;   // and return array to the calling routine
      }
      catch (Exception objErr)
      {
        throw (objErr);
      }
    }
    // ----------------------------------------------------

    // method to return an ArrayList containing just the
    // name of each of the suppliers in the database
    public ArrayList GetSuppliersArrayList()
    {

      // declare a String containing the stored procedure name
      String strQuery = "GetSupplierName";

      // create a new Connection object using connection string
      OleDbConnection objConnect = new OleDbConnection(m_ConnectString);

      // create new Command using stored proc name and Connection
      OleDbCommand objCommand = new OleDbCommand(strQuery, objConnect);

      // create a variable to hold a DataReader object
      OleDbDataReader objReader = null;

      try
      {

        // open connection to the database
        objConnect.Open();

        // execute query to initialize DataReader object
        // connection will be closed when DataReader goes out of scope
        objReader = objCommand.ExecuteReader(CommandBehavior.CloseConnection);

        // create a new ArrayList object
        ArrayList arrValues = new ArrayList();

        // iterate through rows by calling Read method until false
        while (objReader.Read())
          arrValues.Add(objReader.GetString(0));

        objReader = null;     // finished with DataReader

        return arrValues;   // return ArrayList to the calling routine
      }
      catch (Exception objErr)
      {
        throw (objErr);
      }
    }
    // ----------------------------------------------------

  }
}
