Option Explicit On

Imports System
Imports System.Data
Imports System.Data.OleDb

'to perform tracing in the ASP.NET page from within the
'component requires the System.Web namespace as well
Imports System.Web

'the namespace for the component
Namespace DataSetUpdate

  'the main class definition
  Public Class UpdateDataSet

    'private internal variables
    Private m_ConnectString As String       'to hold the connection string

    'declare variable to hold Order ID of inserted order rows
    'used by event handlers for UpdateAllOrderDetails method
    Private m_InsertOrderID As Integer

    'declare variable to hold reference to DataSets during update process
    'these are used by event handlers for UpdateAllOrderDetails method
    Private m_ModifiedDataSet As DataSet
    Private m_MarshaledDataSet As DataSet

    'declare variable to hold reference to current page context
    Private m_Context As HttpContext

    'declare variable to indicate if HttpContext is available
    Private m_CanTrace As Boolean = False

    '----------------------------------------------------------------
    '----------------------------------------------------------------

    Public Sub New(ByVal ConnectString As String)
      'constructor for component - requires the connection
      'string to be provided as the single parameter

      MyBase.New() 'call constructor for base class
      m_ConnectString = ConnectString

      'for tracing variables and execution in ASP.NET page require
      'reference to current Context object if available
      Try
        m_Context = HttpContext.Current
        If Not m_Context Is Nothing Then m_CanTrace = True
      Catch
      End Try

    End Sub

    '----------------------------------------------------------------
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

        'create DataAdapter using Connection and Stored Proc name
        Dim objDataAdapter As New OleDbDataAdapter(strSelect, objConnect)

        'fill the table from the stored procedure
        objDataAdapter.Fill(objDataSet, "Products")

        Return objDataSet

      Catch objError As Exception

        Throw objError

      End Try

    End Function

    '----------------------------------------------------------------
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

        'create DataAdapter using Connection and Stored Proc name
        Dim objDataAdapter As New OleDbDataAdapter(strSelect, objConnect)

        'fill the table from the stored procedure
        objDataAdapter.Fill(objDataSet, "Shippers")

        Return objDataSet

      Catch objError As Exception

        Throw objError

      End Try

    End Function

    '----------------------------------------------------------------
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
        objCommand.Parameters.Add("CustID", CustomerID)

        'create a new DataAdapter using Command object
        Dim objDataAdapter As New OleDbDataAdapter(objCommand)

        'fill the Orders table from the stored procedure
        objDataAdapter.Fill(objDataSet, "Orders")

        'change the stored procedure name in the Command
        objCommand.CommandText = strSelectOrderLines

        'fill the Order Details table from stored procedure
        objDataAdapter.Fill(objDataSet, "Order Details")

        'get a reference to Orders table in DataSet
        Dim objTable As DataTable = objDataSet.Tables("Orders")

        'set primary key in table to OrderID column
        Dim arrKey(0) As DataColumn
        arrKey(0) = objTable.Columns("OrderID")
        objTable.PrimaryKey = arrKey

        'get a reference to Order Details table in DataSet
        objTable = objDataSet.Tables("Order Details")

        'set primary key in table to OrderID and ProductID columns
        ReDim arrKey(1)
        arrKey(0) = objTable.Columns("OrderID")
        arrKey(1) = objTable.Columns("ProductID")
        objTable.PrimaryKey = arrKey

        'create a relationship between the two tables
        Dim objParentCol, objChildCol As DataColumn
        objParentCol = objDataSet.Tables("Orders").Columns("OrderID")
        objChildCol = objDataSet.Tables("Order Details").Columns("OrderID")
        Dim objRelation As New DataRelation("CustOrders", objParentCol, objChildCol)
        objDataSet.Relations.Add(objRelation)

      Catch objError As Exception

        Throw objError

      End Try

      'accept the changes to "fix" the current state of the DataSet contents
      objDataSet.AcceptChanges()

      Return objDataSet

    End Function

    '----------------------------------------------------------------
    '----------------------------------------------------------------

    Public Function UpdateAllOrderDetails(ByVal CustomerID As String, _
                    ByRef ModifiedDataSet As DataSet) As DataSet

      'takes a DataSet containing changes to the original table(s) and
      'pushes the changes back into the data source. If concurrency or
      'other errors arise, these are itemized in a new DataSet that is
      'returned from this function.  Format for a DataSet submitted to
      'this function must be as follows. CustomerID must be the same as
      'was used when DataSet was first filled.
      '
      'NB: There must be a DataRelation set up in the DataSet
      'relating the Orders and OrderLines tables, and the Primary Keys
      'must have been set - either when the DataSet was created by the
      'GetOrderDetails method in this component or by loading a schema
      'that sets the Primary Keys.
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
      '
      'Table named "Order Details":
      ' OrderID         int           (row key)
      ' ProductID       int           (row key)
      ' UnitPrice       money
      ' Quantity        smallint
      ' Discount        real

      'save reference to original DataSet in class-level variable
      'for use in event handlers while updating
      m_ModifiedDataSet = ModifiedDataSet

      'write message to Trace object for display in ASP.NET page
      If m_CanTrace Then
        m_Context.Trace.Write("UpdateDataSet", "Starting Order Update Process")
      End If

      'marshall changed rows only into new DataSet
      'require class-level reference for use in event handlers
      m_MarshaledDataSet = m_ModifiedDataSet.GetChanges()

      '------------ update order rows --------------

      'write message to Trace object for display in ASP.NET page
      If m_CanTrace Then
        m_Context.Trace.Write("UpdateDataSet", "Creating Connection: " & m_ConnectString)
      End If

      'create a Connection object using the connection string
      Dim objConnect As New OleDbConnection(m_ConnectString)

      'create two new DataAdapter objects, one to update each table
      Dim objDAOrders As New OleDbDataAdapter()
      Dim objDAOrderDetails As New OleDbDataAdapter()

      'prevent exceptions being thrown due to concurrency errors
      'error details are obtained from RowError property of row that
      'generated the error after Update method completes
      objDAOrders.ContinueUpdateOnError = True
      objDAOrderDetails.ContinueUpdateOnError = True

      'write message to Trace object for display in ASP.NET page
      If m_CanTrace Then
        m_Context.Trace.Write("UpdateDataSet", "Creating Commands and Setting Parameter Values")
      End If

      'specify Command objects using separate custom functions that
      'take name of stored procedure, connection object and action
      'first for DataAdapter that updates Orders table
      objDAOrders.UpdateCommand = GetOrdersCommand("OrdersUpdate", objConnect, "UPDATE")
      objDAOrders.InsertCommand = GetOrdersCommand("OrdersInsert", objConnect, "INSERT")
      objDAOrders.DeleteCommand = GetOrdersCommand("OrdersDelete", objConnect, "DELETE")

      'then for DataAdapter that updates Order Details table
      objDAOrderDetails.UpdateCommand = GetOrderLinesCommand("OrderLinesUpdate", objConnect, "UPDATE")
      objDAOrderDetails.InsertCommand = GetOrderLinesCommand("OrderLinesInsert", objConnect, "INSERT")
      objDAOrderDetails.DeleteCommand = GetOrderLinesCommand("OrderLinesDelete", objConnect, "DELETE")

      'local variable to hold number of rows affected for Tracing
      Dim intRowsAffected As Integer

      'now ready to start updating the rows in the database
      'must delete child rows in Order Details table before
      'updating Orders parent table otherwise parent row
      'cannot be deleted from Orders table in database
      'get reference to Order Details table
      Dim objTable As DataTable = m_MarshaledDataSet.Tables("Order Details")

      'write message to Trace object for display in ASP.NET page
      If m_CanTrace Then
        m_Context.Trace.Write("UpdateDataSet", "Deleting Order Details rows")
      End If

      Try

        'perform the updates on the original data
        'for just deleted rows in Order Details table
        'Select method returns an array of matching rows
        intRowsAffected = objDAOrderDetails.Update(objTable.Select(Nothing, _
                                        Nothing, DataViewRowState.Deleted))

        'write number of rows updated to Trace object
        If m_CanTrace Then
          m_Context.Trace.Write("UpdateDataSet", "Deleted " _
                               & intRowsAffected.ToString() & " row(s)")
        End If

      Catch objError As Exception

        'raise the error to the calling routine
        Throw objError

      End Try

      'next, apply updates to all rows in Orders table
      'write message to Trace object for display in ASP.NET page
      If m_CanTrace Then
        m_Context.Trace.Write("UpdateDataSet", "Processing Orders rows")
      End If

      'add event handlers for RowUpdating and RowUpdated events
      'required to handle inserted rows by updating the OrderID
      'which is an IDENTITY column in the Orders table
      AddHandler objDAOrders.RowUpdating, _
                 New OleDbRowUpdatingEventHandler(AddressOf OnRowUpdating)
      AddHandler objDAOrders.RowUpdated, _
                 New OleDbRowUpdatedEventHandler(AddressOf OnRowUpdated)

      Try

        'perform the updates on the original data
        intRowsAffected = objDAOrders.Update(m_MarshaledDataSet, "Orders")

        'write number of rows updated to Trace object
        If m_CanTrace Then
          m_Context.Trace.Write("UpdateDataSet", "Updated " _
                               & intRowsAffected.ToString() & " row(s)")
        End If

      Catch objError As Exception

        'raise the error to the calling routine
        Throw objError

      End Try

      'now remove the event handlers for RowUpdating and RowUpdated events
      'not actually required as we're finished with it, but good practice
      RemoveHandler objDAOrders.RowUpdating, AddressOf OnRowUpdating
      RemoveHandler objDAOrders.RowUpdated, AddressOf OnRowUpdated

      'write message to Trace object for display in ASP.NET page
      If m_CanTrace Then
        m_Context.Trace.Write("UpdateDataSet", "Processing Remaining Order Detail Rows")
      End If

      'update remaining Order Detail rows for only the inserted
      'and modified rows - must do the inserts after inserting
      'new parent row into Orders table in database
      Try

        'insert new child rows and update modified ones in Order Details table
        intRowsAffected = objDAOrderDetails.Update(objTable.Select(Nothing, _
                                        Nothing, DataViewRowState.CurrentRows))

        'write number of rows updated to Trace object
        If m_CanTrace Then
          m_Context.Trace.Write("UpdateDataSet", "Inserted/Updated " _
                               & intRowsAffected.ToString() & " row(s)")
        End If

      Catch objError As Exception

        'raise the error to the calling routine
        Throw objError

      End Try

      '-------- refresh marshalled DataSet ---------

      'specify the stored procedure to extract the Orders data
      Dim strSelectOrders As String = "OrdersForEditByCustID"
      Dim strSelectOrderLines As String = "OrderLinesForEditByCustID"

      Try

        'write message to Trace object for display in ASP.NET page
        If m_CanTrace Then
          m_Context.Trace.Write("UpdateDataSet", "Starting Refresh Orders Table")
        End If

        'create a new Command object
        Dim objCommand As New OleDbCommand(strSelectOrders, objConnect)
        objCommand.CommandType = CommandType.StoredProcedure

        'add the required parameter
        objCommand.Parameters.Add("CustID", CustomerID)

        'assign to SelectCommand of Orders DataAdapter object
        objDAOrders.SelectCommand = objCommand

        'refresh the Orders table from the stored procedure
        intRowsAffected = objDAOrders.Fill(m_MarshaledDataSet, "Orders")

        'write number of rows updated to Trace object
        If m_CanTrace Then
          m_Context.Trace.Write("UpdateDataSet", "Refreshed " _
                               & intRowsAffected.ToString() & " row(s)")
        End If

        'change the stored procedure name in the Command
        objCommand.CommandText = strSelectOrderLines

        'assign to SelectCommand of Order Details DataAdapter object
        objDAOrderDetails.SelectCommand = objCommand

        'write message to Trace object for display in ASP.NET page
        If m_CanTrace Then
          m_Context.Trace.Write("UpdateDataSet", "Starting Refresh Order Details Table")
        End If

        'refresh the Order Details table from the stored procedure
        intRowsAffected = objDAOrderDetails.Fill(m_MarshaledDataSet, "Order Details")

        'write number of rows updated to Trace object
        If m_CanTrace Then
          m_Context.Trace.Write("UpdateDataSet", "Refreshed " _
                               & intRowsAffected.ToString() & " row(s)")
        End If

      Catch objError As Exception

        Throw objError

      End Try


      '------ merge with original DataSet ----------

      If m_CanTrace Then
        'write message to Trace object for display in ASP.NET page
        m_Context.Trace.Write("UpdateDataSet", "Starting Merge DataSet")
      End If

      'use parameter to preserve changes
      m_ModifiedDataSet.Merge(m_MarshaledDataSet, True)

      '----- return updated merged DataSet ---------

      If m_CanTrace Then
        'write message to Trace object for display in ASP.NET page
        m_Context.Trace.Write("UpdateDataSet", "Returning Updated DataSet")
      End If

      'return all rows including successful updates
      Return m_ModifiedDataSet

    End Function

    '----------------------------------------------------------------
    '----------------------------------------------------------------

    Private Function GetOrdersCommand(ByVal strStoredProcName As String, _
                                      ByRef objConnect As OleDbConnection, _
                                      ByVal strCommandType As String) _
                                      As OleDbCommand

      'creates a new Command object and adds parameters, specifying the
      'column name and version from which values will be taken

      Dim objCommand As New OleDbCommand(strStoredProcName, objConnect)
      objCommand.CommandType = CommandType.StoredProcedure

      Dim colParams As OleDbParameterCollection = objCommand.Parameters
      Dim objParam As OleDbParameter

      objParam = colParams.Add("OrderID", OleDbType.Integer, 4, "OrderID")
      objParam.SourceVersion = DataRowVersion.Original

      If strCommandType <> "INSERT" Then
        'add "Original" parameter values for Delete and Update actions
        objParam = colParams.Add("OldCustomerID", OleDbType.Char, 5, "CustomerID")
        objParam.SourceVersion = DataRowVersion.Original
        objParam = colParams.Add("OldOrderDate", OleDbType.DBDate, 4, "OrderDate")
        objParam.SourceVersion = DataRowVersion.Original
        objParam = colParams.Add("OldRequiredDate", OleDbType.DBDate, 4, "RequiredDate")
        objParam.SourceVersion = DataRowVersion.Original
        objParam = colParams.Add("OldShippedDate", OleDbType.DBDate, 4, "ShippedDate")
        objParam.SourceVersion = DataRowVersion.Original
        objParam = colParams.Add("OldShipVia", OleDbType.Integer, 4, "ShipVia")
        objParam.SourceVersion = DataRowVersion.Original
        objParam = colParams.Add("OldFreight", OleDbType.Decimal, 4, "Freight")
        objParam.SourceVersion = DataRowVersion.Original
        objParam = colParams.Add("OldShipName", OleDbType.VarChar, 40, "ShipName")
        objParam.SourceVersion = DataRowVersion.Original
        objParam = colParams.Add("OldShipAddress", OleDbType.VarChar, 60, "ShipAddress")
        objParam.SourceVersion = DataRowVersion.Original
        objParam = colParams.Add("OldShipCity", OleDbType.VarChar, 15, "ShipCity")
        objParam.SourceVersion = DataRowVersion.Original
        objParam = colParams.Add("OldShipPostalCode", OleDbType.VarChar, 10, "ShipPostalCode")
        objParam.SourceVersion = DataRowVersion.Original
        objParam = colParams.Add("OldShipCountry", OleDbType.VarChar, 15, "ShipCountry")
        objParam.SourceVersion = DataRowVersion.Original
      End If

      If strCommandType <> "DELETE" Then
        'add "Current" parameter values for Update and Insert actions
        objParam = colParams.Add("NewCustomerID", OleDbType.Char, 5, "CustomerID")
        objParam.SourceVersion = DataRowVersion.Current
        objParam = colParams.Add("NewOrderDate", OleDbType.DBDate, 4, "OrderDate")
        objParam.SourceVersion = DataRowVersion.Current
        objParam = colParams.Add("NewRequiredDate", OleDbType.DBDate, 4, "RequiredDate")
        objParam.SourceVersion = DataRowVersion.Current
        objParam = colParams.Add("NewShippedDate", OleDbType.DBDate, 4, "ShippedDate")
        objParam.SourceVersion = DataRowVersion.Current
        objParam = colParams.Add("NewShipVia", OleDbType.Integer, 4, "ShipVia")
        objParam.SourceVersion = DataRowVersion.Current
        objParam = colParams.Add("NewFreight", OleDbType.Decimal, 4, "Freight")
        objParam.SourceVersion = DataRowVersion.Current
        objParam = colParams.Add("NewShipName", OleDbType.VarChar, 40, "ShipName")
        objParam.SourceVersion = DataRowVersion.Current
        objParam = colParams.Add("NewShipAddress", OleDbType.VarChar, 60, "ShipAddress")
        objParam.SourceVersion = DataRowVersion.Current
        objParam = colParams.Add("NewShipCity", OleDbType.VarChar, 15, "ShipCity")
        objParam.SourceVersion = DataRowVersion.Current
        objParam = colParams.Add("NewShipPostalCode", OleDbType.VarChar, 10, "ShipPostalCode")
        objParam.SourceVersion = DataRowVersion.Current
        objParam = colParams.Add("NewShipCountry", OleDbType.VarChar, 15, "ShipCountry")
        objParam.SourceVersion = DataRowVersion.Current
      End If

      Return objCommand

    End Function

    '----------------------------------------------------------------
    '----------------------------------------------------------------

    Private Function GetOrderLinesCommand(ByVal strStoredProcName As String, _
                                          ByRef objConnect As OleDbConnection, _
                                          ByVal strCommandType As String) _
                                          As OleDbCommand

      'creates a new Command object and adds parameters, specifying the
      'column name and version from which values will be taken

      Dim objCommand As New OleDbCommand(strStoredProcName, objConnect)
      objCommand.CommandType = CommandType.StoredProcedure

      Dim colParams As OleDbParameterCollection = objCommand.Parameters
      Dim objParam As OleDbParameter

      objParam = colParams.Add("OrderID", OleDbType.Integer, 4, "OrderID")
      objParam.SourceVersion = DataRowVersion.Original
      objParam = colParams.Add("ProductID", OleDbType.Integer, 4, "ProductID")
      objParam.SourceVersion = DataRowVersion.Original

      If strCommandType <> "INSERT" Then
        'add "Original" parameter values for Delete and Update actions
        objParam = colParams.Add("OldUnitPrice", OleDbType.Decimal, 4, "UnitPrice")
        objParam.SourceVersion = DataRowVersion.Original
        objParam = colParams.Add("OldQuantity", OleDbType.SmallInt, 2, "Quantity")
        objParam.SourceVersion = DataRowVersion.Original
        objParam = colParams.Add("OldDiscount", OleDbType.Double, 2, "Discount")
        objParam.SourceVersion = DataRowVersion.Original
      End If

      If strCommandType <> "DELETE" Then
        'add "Current" parameter values for Update and Insert actions
        objParam = colParams.Add("NewUnitPrice", OleDbType.Decimal, 4, "UnitPrice")
        objParam.SourceVersion = DataRowVersion.Current
        objParam = colParams.Add("NewQuantity", OleDbType.SmallInt, 2, "Quantity")
        objParam.SourceVersion = DataRowVersion.Current
        objParam = colParams.Add("NewDiscount", OleDbType.Double, 2, "Discount")
        objParam.SourceVersion = DataRowVersion.Current
      End If

      Return objCommand

    End Function

    '----------------------------------------------------------------
    '----------------------------------------------------------------

    Sub OnRowUpdating(ByVal objSender As Object, _
                      ByVal objArgs As OleDbRowUpdatingEventArgs)

      'event handler for the RowUpdating event
      'see if its an INSERT statement. If so we need to save the
      'temporary order ID allocated on the client while disconnected
      'so we can update the child rows with the "real" order ID
      'after the row has been inserted into the data store
      If objArgs.StatementType = StatementType.Insert Then

        'save the temporary order ID in the class-level variable
        m_InsertOrderID = objArgs.Row("OrderID", DataRowVersion.Current)

      End If

    End Sub

    '----------------------------------------------------------------
    '----------------------------------------------------------------

    Sub OnRowUpdated(ByVal objSender As Object, _
                     ByVal objArgs As OleDbRowUpdatedEventArgs)

      'event handler for the RowUpdated event
      'see if its an INSERT statement
      If objArgs.StatementType = StatementType.Insert Then

        'see if the insert was successful
        'expect 1 in success, zero or -1 on failure
        If objArgs.RecordsAffected = 1 Then

          'get new order ID from IDENTITY column in this row.
          'the InsertOrders stored proc returns the newly inserted row
          'and this automatically updates the current values for the
          'columns in this row, including the auto-generated OrderID
          'because of Relation, also cascades updates to child table rows
          Dim intNewOrderID As Integer = objArgs.Row("OrderID", DataRowVersion.Current)

          'update matching Orders row in original DataSet otherwise the
          'rows will not be matched when the Merge method is used later
          'because of Relation, also cascades updates to child table rows
          Dim objTable As DataTable = m_ModifiedDataSet.Tables("Orders")
          Dim arrRows(), objRow As DataRow
          arrRows = objTable.Select("OrderID = '" & m_InsertOrderID & "'")
          For Each objRow In arrRows
            objRow("OrderID") = intNewOrderID
          Next

          'write message to Trace object
          If m_CanTrace Then
            m_Context.Trace.Write("UpdateDataSet", "Inserted Order row with OrderID " _
                                 & intNewOrderID.ToString())
          End If

        End If

      End If

    End Sub

  End Class

End Namespace

