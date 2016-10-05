Option Explicit On

Imports System
Imports System.Data
Imports System.Data.OleDb

'the namespace for the component
Namespace OrderListData

  'the main class definition
  Public Class OrderList

    'private internal variables
    Private m_ConnectString As String  'database connection string

    '----------------------------------------------------

    'constructor for component - requires the connection
    'string to be provided as the single parameter
    Public Sub New(ByVal ConnectString As String)
      MyBase.New() 'call constructor for base class
      m_ConnectString = ConnectString
    End Sub

    '------------------------------------------------------

    'function to return DataSet containing two tables
    'Orders and related Order Lines for a specified CustomerID
    Public Function GetOrdersByCustomerDataSet(ByVal strCustID As String) As DataSet

      'specify the stored procedure names
      Dim strGetOrders As String = "GetOrdersByCustomer"
      Dim strGetOrderLines As String = "GetOrderLinesByCustomer"

      'declare a variable to hold a DataSet object
      Dim objDataSet As New DataSet()

      'create a new Connection object using the connection string
      Dim objConnect As New OleDbConnection(m_ConnectString)

      Try

        'create a new Command object and set the CommandType
        Dim objCommand As New OleDbCommand(strGetOrders, objConnect)
        objCommand.CommandType = CommandType.StoredProcedure

        'create a variable to hold a Parameter object
        Dim objParam As OleDbParameter

        'create a new Parameter object named 'CustID' with the correct data
        'type to match a SQL database 'varchar' field of 5 characters
        objParam = objCommand.Parameters.Add("CustID", OleDbType.VarChar, 5)

        'specify that it's an Input parameter and set the value
        objParam.Direction = ParameterDirection.Input
        objParam.Value = strCustID

        'create a new DataAdapter object
        Dim objDataAdapter As New OleDbDataAdapter()

        'and assign the Command object to it
        objDataAdapter.SelectCommand = objCommand

        'open database connection first for max efficiency
        'because were calling Fill method twice
        objConnect.Open()

        'get data from stored proc into table named "Orders"
        objDataAdapter.Fill(objDataSet, "Orders")

        'change the stored proc name in the Command object
        objCommand.CommandText = strGetOrderLines

        'get data from stored proc into table named "OrderLines"
        objDataAdapter.Fill(objDataSet, "OrderLines")

        'declare a variable to hold a DataRelation object
        Dim objRelation As DataRelation

        'create a Relation object to link Orders and OrderLines
        objRelation = New DataRelation("CustOrderLines", _
                          objDataSet.Tables("Orders").Columns("OrderID"), _
                          objDataSet.Tables("OrderLines").Columns("OrderID"))

        'and add it to the DataSet object's Relations collection
        objDataSet.Relations.Add(objRelation)

      Catch objError As Exception

        Throw objError  'throw error to calling routine

      Finally

        'must remember to close connection - we opened it ourselves
        'so the Fill method will not close it automatically
        objConnect.Close()

      End Try

      Return objDataSet   'return populated DataSet to calling routine

    End Function

    '------------------------------------------------------

    'function to return DataSet containing list of customers that match
    'on ID or name - one parameter should be an empty string each time
    'performs partial or full matching automatically:
    ' - up to 5 chars max for ID, returns results sorted by ID
    ' - up to 40 chars for name, returns results sorted by name
    Public Function GetCustomerByIdOrName(ByVal strCustID As String, _
                                          ByVal strCustName As String) As DataSet

      'specify the stored procedure name
      Dim strCustListProc As String = "GetCustomerListByIdOrName"

      'declare a variable to hold a DataSet object
      Dim objDataSet As New DataSet()

      Try

        'create a new Connection object using the connection string
        Dim objConnect As New OleDbConnection(m_ConnectString)

        'create a new Command object and set the CommandType
        Dim objCommand As New OleDbCommand(strCustListProc, objConnect)
        objCommand.CommandType = CommandType.StoredProcedure

        'create a Parameter for the customer ID
        Dim objParam As OleDbParameter
        objParam = objCommand.Parameters.Add("CustID", OleDbType.VarChar, 5)
        objParam.Direction = ParameterDirection.Input
        objParam.Value = strCustID

        'create a Parameter for the customer name
        objParam = objCommand.Parameters.Add("CustName", OleDbType.VarChar, 40)
        objParam.Direction = ParameterDirection.Input
        objParam.Value = strCustName

        'create a new DataAdapter object
        Dim objDataAdapter As New OleDbDataAdapter()
        'and assign the Command object to it
        objDataAdapter.SelectCommand = objCommand

        'get data from stored proc into table named "Orders"
        objDataAdapter.Fill(objDataSet, "Customers")

      Catch objError As Exception

        Throw objError  'throw error to calling routine

      End Try

      Return objDataSet   'return populated DataSet to calling routine

    End Function

    '------------------------------------------------------

  End Class

End Namespace
