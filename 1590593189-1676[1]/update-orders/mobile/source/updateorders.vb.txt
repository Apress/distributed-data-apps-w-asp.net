Option Explicit On

Imports System
Imports System.Data
Imports System.Data.OleDb

'the namespace for the component
Namespace DDA4923OrderUpdate

  'the main class definition
  Public Class UpdateOrders

    'private internal variables
    Private m_ModifiedDataSet As DataSet    'to hold rows from database
    Private m_ErrorsDataSet As DataSet      'to hold the Errors table
    Private m_ConnectString As String       'to hold the connection string
    Private m_Rollback As Boolean           'whether to roll back changes

    '----------------------------------------------------------------

    Public Sub New(ByVal ConnectString As String)
      'constructor for component - requires the connection
      'string to be provided as the single parameter
      MyBase.New() 'call constructor for base class
      m_ConnectString = ConnectString
    End Sub

    '----------------------------------------------------------------

    Public Function SetFreightCost(ByVal OrderID As Integer) As Boolean

      'calculates freight shipping cost and updates Orders table

      'specify the stored procedure to insert the row
      Dim strProcName As String = "SetFreightCost"

      'create Connection object using the connection string
      Dim objConnect As New OleDbConnection(m_ConnectString)

      Try

        'create Command using Connection and storedproc name
        Dim objCommand As New OleDbCommand(strProcName, objConnect)
        objCommand.CommandType = CommandType.StoredProcedure

        'add required parameters for input
        objCommand.Parameters.Add("@OrderID", OrderID)

        'open connection
        objConnect.Open()

        'execute the stored procedure and return True or False
        Return (objCommand.ExecuteNonQuery() = 1)

      Catch objError As Exception

        Return False

      Finally

        'close connection
        objConnect.Close()

      End Try

    End Function

    '----------------------------------------------------------------

    Public Function SingleRowOrderDelete(ByVal UpdateOrderID As Integer, _
                                         ByVal RequiredDateWas As Date, _
                                         ByVal ShippedDateWas As Date, _
                                         ByVal FreightWas As Double, _
                                         ByVal ShipNameWas As String, _
                                         ByVal ShipAddressWas As String, _
                                         ByVal ShipCityWas As String, _
                                         ByVal ShipPostalCodeWas As String, _
                                         ByVal ShipCountryWas As String, _
                                         ByVal ShipViaWas As Integer) _
                                         As Integer

      'deletes existing row in the Order table for the specified order
      'checking for concurrency errors by comparing original values

      'specify the stored procedure to insert the row
      Dim strProcName As String = "DeleteExistingOrder"

      'create Connection object using the connection string
      Dim objConnect As New OleDbConnection(m_ConnectString)

      Try

        'create Command using Connection and storedproc name
        Dim objCommand As New OleDbCommand(strProcName, objConnect)
        objCommand.CommandType = CommandType.StoredProcedure

        'add required parameters for input
        objCommand.Parameters.Add("@OrderID", UpdateOrderID)
        If RequiredDateWas = Nothing Then
          objCommand.Parameters.Add("@RequiredWas", DBNull.Value)
        Else
          objCommand.Parameters.Add("@RequiredWas", RequiredDateWas)
        End If
        If ShippedDateWas = Nothing Then
          objCommand.Parameters.Add("@ShippedWas", DBNull.Value)
        Else
          objCommand.Parameters.Add("@ShippedWas", ShippedDateWas)
        End If
        objCommand.Parameters.Add("@FreightWas", FreightWas)
        objCommand.Parameters.Add("@NameWas", ShipNameWas)
        objCommand.Parameters.Add("@AddressWas", ShipAddressWas)
        objCommand.Parameters.Add("@CityWas", ShipCityWas)
        objCommand.Parameters.Add("@PostalCodeWas", ShipPostalCodeWas)
        objCommand.Parameters.Add("@CountryWas", ShipCountryWas)
        objCommand.Parameters.Add("@ShipViaWas", ShipViaWas)

        'open connection
        objConnect.Open()

        'execute the stored procedure and return the result
        Return objCommand.ExecuteNonQuery()

      Catch objError As Exception

        Throw objError

      Finally

        'close connection
        objConnect.Close()

      End Try

    End Function

    '----------------------------------------------------------------

    Public Function SingleRowOrderUpdate(ByVal UpdateOrderID As Integer, _
                                         ByVal RequiredDate As Date, _
                                         ByVal ShippedDate As Date, _
                                         ByVal Freight As Double, _
                                         ByVal ShipName As String, _
                                         ByVal ShipAddress As String, _
                                         ByVal ShipCity As String, _
                                         ByVal ShipPostalCode As String, _
                                         ByVal ShipCountry As String, _
                                         ByVal ShipVia As Integer, _
                                         ByVal RequiredDateWas As Date, _
                                         ByVal ShippedDateWas As Date, _
                                         ByVal FreightWas As Double, _
                                         ByVal ShipNameWas As String, _
                                         ByVal ShipAddressWas As String, _
                                         ByVal ShipCityWas As String, _
                                         ByVal ShipPostalCodeWas As String, _
                                         ByVal ShipCountryWas As String, _
                                         ByVal ShipViaWas As Integer) _
                                         As Integer

      'updates existing row into the Order table for the specified order
      'checking for concurrency errors by comparing original values

      'specify the stored procedure to insert the row
      Dim strProcName As String = "UpdateExistingOrder"

      'create Connection object using the connection string
      Dim objConnect As New OleDbConnection(m_ConnectString)

      Try

        'create Command using Connection and storedproc name
        Dim objCommand As New OleDbCommand(strProcName, objConnect)
        objCommand.CommandType = CommandType.StoredProcedure

        'add required parameters for input
        objCommand.Parameters.Add("@OrderID", UpdateOrderID)
        If RequiredDate = Nothing Then
          objCommand.Parameters.Add("@Required", DBNull.Value)
        Else
          objCommand.Parameters.Add("@Required", RequiredDate)
        End If
        If ShippedDate = Nothing Then
          objCommand.Parameters.Add("@Shipped", DBNull.Value)
        Else
          objCommand.Parameters.Add("@Shipped", ShippedDate)
        End If
        objCommand.Parameters.Add("@Freight", Freight)
        objCommand.Parameters.Add("@ShipName", ShipName)
        objCommand.Parameters.Add("@Address", ShipAddress)
        objCommand.Parameters.Add("@City", ShipCity)
        objCommand.Parameters.Add("@PostalCode", ShipPostalCode)
        objCommand.Parameters.Add("@Country", ShipCountry)
        objCommand.Parameters.Add("@ShipVia", ShipVia)
        If RequiredDateWas = Nothing Then
          objCommand.Parameters.Add("@RequiredWas", DBNull.Value)
        Else
          objCommand.Parameters.Add("@RequiredWas", RequiredDateWas)
        End If
        If ShippedDateWas = Nothing Then
          objCommand.Parameters.Add("@ShippedWas", DBNull.Value)
        Else
          objCommand.Parameters.Add("@ShippedWas", ShippedDateWas)
        End If
        objCommand.Parameters.Add("@FreightWas", FreightWas)
        objCommand.Parameters.Add("@NameWas", ShipNameWas)
        objCommand.Parameters.Add("@AddressWas", ShipAddressWas)
        objCommand.Parameters.Add("@CityWas", ShipCityWas)
        objCommand.Parameters.Add("@PostalCodeWas", ShipPostalCodeWas)
        objCommand.Parameters.Add("@CountryWas", ShipCountryWas)
        objCommand.Parameters.Add("@ShipViaWas", ShipViaWas)

        'open connection
        objConnect.Open()

        'execute the stored procedure and return the result
        Return objCommand.ExecuteNonQuery()

      Catch objError As Exception

        Throw objError

      Finally

        'close connection
        objConnect.Close()

      End Try

    End Function

    '----------------------------------------------------------------

    Public Function InsertNewOrder(ByVal CustomerID As String) As Integer
      'inserts a new row into the Order table for the specified customer
      'with address details pre-filled, and returns the new OrderID

      'specify the stored procedure to insert the row
      Dim strProcName As String = "InsertNewOrder"

      'create Connection object using the connection string
      Dim objConnect As New OleDbConnection(m_ConnectString)

      Try

        'create Command using Connection and storedproc name
        Dim objCommand As New OleDbCommand(strProcName, objConnect)
        objCommand.CommandType = CommandType.StoredProcedure

        'add required parameters for input and output
        objCommand.Parameters.Add("@CustID", OleDbType.VarChar, 5)
        objCommand.Parameters("@CustID").Value = CustomerID
        objCommand.Parameters.Add("@OrderID", OleDbType.Integer)
        objCommand.Parameters("@OrderID").Direction = ParameterDirection.Output

        'open connection
        objConnect.Open()

        'execute the stored procedure and return the result
        objCommand.ExecuteNonQuery()
        Return objCommand.Parameters("@OrderId").Value

      Catch objError As Exception

        Throw objError

      Finally

        'close connection
        objConnect.Close()

      End Try

    End Function

    '----------------------------------------------------------------

    Public Function InsertNewOrderLine(ByVal OrderID As Integer, _
                                       ByVal ProductID As Integer) _
                                       As Boolean
      'inserts a new row into the Order Details table for the specified
      'order, with product details pre-filled

      'specify the stored procedure to insert the row
      Dim strProcName As String = "InsertNewOrderLine"

      'create Connection object using the connection string
      Dim objConnect As New OleDbConnection(m_ConnectString)

      Try

        'create Command using Connection and storedproc name
        Dim objCommand As New OleDbCommand(strProcName, objConnect)
        objCommand.CommandType = CommandType.StoredProcedure

        'add required parameters for input
        objCommand.Parameters.Add("@OrderID", OrderID)
        objCommand.Parameters.Add("@ProductID", ProductID)

        'open connection
        objConnect.Open()

        'execute the stored procedure and return the result
        Return (objCommand.ExecuteNonQuery() = 1)

      Catch objError As Exception

        Throw objError

      Finally

        'close connection
        objConnect.Close()

      End Try

    End Function

    '----------------------------------------------------------------

    Public Function SingleOrderLineUpdate(ByVal OrderID As Integer, _
                                          ByVal ProductID As Integer, _
                                          ByVal UnitPrice As Double, _
                                          ByVal Quantity As Integer, _
                                          ByVal Discount As Double, _
                                          ByVal UnitPriceWas As Double, _
                                          ByVal QuantityWas As Integer, _
                                          ByVal DiscountWas As Double) _
                                          As Integer
      'updates existing row in Order Details table for specified order
      'line, checking for concurrency errors by comparing original values

      'specify the stored procedure to insert the row
      Dim strProcName As String = "UpdateExistingOrderLine"

      'create Connection object using the connection string
      Dim objConnect As New OleDbConnection(m_ConnectString)

      Try

        'create Command using Connection and storedproc name
        Dim objCommand As New OleDbCommand(strProcName, objConnect)
        objCommand.CommandType = CommandType.StoredProcedure

        'add required parameters for input
        objCommand.Parameters.Add("@OrderID", OrderID)
        objCommand.Parameters.Add("@ProductID", ProductID)
        objCommand.Parameters.Add("@UnitPrice", UnitPrice)
        objCommand.Parameters.Add("@Quantity", Quantity)
        objCommand.Parameters.Add("@Discount", Discount)
        objCommand.Parameters.Add("@UnitPriceWas", UnitPriceWas)
        objCommand.Parameters.Add("@QuantityWas", QuantityWas)
        objCommand.Parameters.Add("@DiscountWas", DiscountWas)

        'open connection
        objConnect.Open()

        'execute the stored procedure and return the result
        Return objCommand.ExecuteNonQuery()

      Catch objError As Exception

        Throw objError

      Finally

        'close connection
        objConnect.Close()

      End Try

    End Function

    '----------------------------------------------------------------

    Public Function SingleOrderLineDelete(ByVal OrderID As Integer, _
                                          ByVal ProductID As Integer, _
                                          ByVal UnitPriceWas As Double, _
                                          ByVal QuantityWas As Integer, _
                                          ByVal DiscountWas As Double) _
                                          As Integer
      'deletes existing row in Order Details table for specified order
      'line, checking for concurrency errors by comparing original values

      'specify the stored procedure to insert the row
      Dim strProcName As String = "DeleteExistingOrderLine"

      'create Connection object using the connection string
      Dim objConnect As New OleDbConnection(m_ConnectString)

      Try

        'create Command using Connection and storedproc name
        Dim objCommand As New OleDbCommand(strProcName, objConnect)
        objCommand.CommandType = CommandType.StoredProcedure

        'add required parameters for input
        objCommand.Parameters.Add("@OrderID", OrderID)
        objCommand.Parameters.Add("@ProductID", ProductID)
        objCommand.Parameters.Add("@UnitPriceWas", UnitPriceWas)
        objCommand.Parameters.Add("@QuantityWas", QuantityWas)
        objCommand.Parameters.Add("@DiscountWas", DiscountWas)

        'open connection
        objConnect.Open()

        'execute the stored procedure and return the result
        Return objCommand.ExecuteNonQuery()

      Catch objError As Exception

        Throw objError

      Finally

        'close connection
        objConnect.Close()

      End Try

    End Function

    '----------------------------------------------------------------

    Public Function GetProductsDataSet() As DataSet

      'returns a DataSet containing one table. This table contains all
      'the rows from the Products table, with the following columns:

      'Table named "Products":
      ' ProductID         int           (row key)
      ' ProductName       nvarchar(40)
      ' QtyPerUnit        nvarchar(20)
      ' UnitPrice         money
      ' Available         smallint

      'specify the stored procedure to extract the Orders data
      Dim strSelect As String = "AllProductsList"

      'create a new DataSet object
      Dim objDataSet As New DataSet()

      'create Connection object using the connection string
      Dim objConnect As New OleDbConnection(m_ConnectString)

      Try

        'create DataAdapter using Connection and storedproc name
        Dim objDataAdapter As New OleDbDataAdapter(strSelect, objConnect)

        'fill the table from the stored procedure
        objDataAdapter.Fill(objDataSet, "Products")

        Return objDataSet

      Catch objError As Exception

        Throw objError

      End Try

    End Function

    '----------------------------------------------------------------

    Public Function GetShippersDataSet() As DataSet

      'returns a DataSet containing one table. This table contains all
      'the rows from the Shippers table, with the following columns:

      'Table named "Shippers":
      ' ShipperID         int           (row key)
      ' ShipperName       nvarchar(40)
      ' ShipperPhone      nvarchar(24)

      'specify the stored procedure to extract the Orders data
      Dim strSelect As String = "AllShippersList"

      'create a new DataSet object
      Dim objDataSet As New DataSet()

      'create Connection object using the connection string
      Dim objConnect As New OleDbConnection(m_ConnectString)

      Try

        'create DataAdapter using Connection and storedproc name
        Dim objDataAdapter As New OleDbDataAdapter(strSelect, objConnect)

        'fill the table from the stored procedure
        objDataAdapter.Fill(objDataSet, "Shippers")

        Return objDataSet

      Catch objError As Exception

        Throw objError

      End Try

    End Function

    '----------------------------------------------------------------

    Public Function GetOrderDetails(ByVal CustomerID As String) _
                                    As DataSet

      'creates and returns a DataSet containing rows from the Northwind
      'sample database Orders and OrderLines tables for a specific
      'customer identified by the complete CustomerID parameter.
      'Format for DataSet returned is as follows:
      '
      'Table named "Orders":
      ' OrderID         int           (row key)
      ' CustomerID      nchar(5)
      ' OrderDate       datetime
      ' RequiredDate    datetime
      ' ShippedDate     datetime
      ' ShipVia         int
      ' Freight         money
      ' ShipName        nvarchar(40)
      ' ShipAddress     nvarchar(60)
      ' ShipCity        nvarchar(15)
      ' ShipPostalCode  nvarchar(10)
      ' ShipCountry     nvarchar(15)
      ' ShipperName     nvarchar(40) (not updateable)
      '
      'Table named "Order Details":
      ' OrderID         int           (row key)
      ' ProductID       int           (row key)
      ' UnitPrice       money
      ' Quantity        smallint
      ' Discount        real
      ' ProductName     nvarchar(40) (not updateable)
      ' QtyPerUnit      nvarchar(20) (not updateable)


      'specify the stored procedure to extract the Orders data
      Dim strSelectOrders As String = "OrdersForEditByCustID"
      Dim strSelectOrderLines As String = "OrderLinesForEditByCustID"

      'create a new DataSet object
      Dim objDataSet As New DataSet()

      'create a new Connection object using the connection string
      Dim objConnect As New OleDbConnection(m_ConnectString)

      Try

        'create a new Command object
        Dim objCommand As New OleDbCommand(strSelectOrders, objConnect)
        objCommand.CommandType = CommandType.StoredProcedure

        'add the required parameter
        objCommand.Parameters.Add("@CustID", CustomerID)

        'create a new DataAdapter using the connection object and select statement
        Dim objDataAdapter As New OleDbDataAdapter(objCommand)

        'fill the Orders table from the stored procedure
        objDataAdapter.Fill(objDataSet, "Orders")

        'change the stored procedure name in the Command
        objCommand.CommandText = strSelectOrderLines

        'fill the Order Details table from the stored procedure
        objDataAdapter.Fill(objDataSet, "Order Details")

      Catch objError As Exception

        Throw objError

      End Try

      'accept the changes to "fix" the current state of the DataSet contents
      objDataSet.AcceptChanges()

      Return objDataSet

    End Function

  End Class

End Namespace

