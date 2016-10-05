Option Explicit On

Imports System
Imports System.Data
Imports System.Data.OleDb
Imports System.Data.SqlClient
Imports System.Xml
Imports System.Collections
Imports Microsoft.VisualBasic

'the namespace for the component
Namespace SupplierListDB

  'the main class definition
  Public Class SupplierList

    'private internal variable to store connection string
    Private m_ConnectString As String

    '----------------------------------------------------

    'constructor for component - requires the connection
    'string to be provided as the single parameter
    Public Sub New(ByVal ConnectString As String)
      MyBase.New() 'call constructor for base class
      m_ConnectString = ConnectString
    End Sub

    '----------------------------------------------------

    'function to return a DataSet containing the full
    'list of supplier details from database
    Public Function GetSuppliersDataSet() As DataSet

      'declare a String containing the stored procedure name
      Dim strQuery As String = "GetSupplierList"

      'create a new Connection object using connection string
      Dim objConnect As New OleDbConnection(m_ConnectString)

      'create new DataAdapter using stored proc name and Connection
      Dim objAdapter As New OleDbDataAdapter(strQuery, objConnect)

      'create a new DataSet object to hold the results
      Dim objDataSet As New DataSet()

      Try

        'get the data into a table named "Suppliers" in the DataSet
        objAdapter.Fill(objDataSet, "Suppliers")

        'return the DataSet object to the calling routine
        Return objDataSet

      Catch objErr As Exception

        Throw objErr

      End Try

    End Function

    '----------------------------------------------------

    'function to return a DataReader pointing to a full
    'list of supplier details from database
    Public Function GetSuppliersDataReader() As OleDbDataReader

      'declare a String containing the stored procedure name
      Dim strQuery As String = "GetSupplierList"

      'create a new Connection object using connection string
      Dim objConnect As New OleDbConnection(m_ConnectString)

      'create new Command using stored proc name and Connection
      Dim objCommand As New OleDbCommand(strQuery, objConnect)

      'create a variable to hold a DataReader object
      Dim objReader As OleDbDataReader

      Try

        'open connection to the database
        objConnect.Open()

        'execute the stored proc to initialize the DataReader
        'connection will be closed when DataReader goes out of scope
        Return objCommand.ExecuteReader(CommandBehavior.CloseConnection)

      Catch objErr As Exception

        Throw objErr

      End Try

    End Function

    '----------------------------------------------------

    'function to return an XML document (as a String) containing
    'a full list of supplier details from database
    Public Function GetSuppliersXml(Optional ByVal IncludeSchema As Boolean = False) As String

      'declare a String containing the stored procedure name
      Dim strQuery As String = "GetSupplierList"

      'create a new Connection object using connection string
      Dim objConnect As New OleDbConnection(m_ConnectString)

      'create new DataAdapter using stored proc name and Connection
      Dim objAdapter As New OleDbDataAdapter(strQuery, objConnect)

      'create a new DataSet object to hold the results
      Dim objDataSet As New DataSet()

      'declare an empty String to hold the results
      Dim strXml As String = ""

      Try

        'get the data into a table named "Suppliers" in the DataSet
        objAdapter.Fill(objDataSet, "Suppliers")

        'get schema if specified in optional method parameter
        If IncludeSchema = True Then
          strXml = objDataSet.GetXmlSchema & vbCrLf & vbCrLf
        End If

        'get XML data and append to String
        strXml &= objDataSet.GetXml

        'return the XML string to the calling routine
        Return strXml

      Catch objErr As Exception

        Throw objErr

      End Try

    End Function

    '----------------------------------------------------

    'function to return an XmlDocument object containing
    'a full list of supplier details from database
    Public Function GetSuppliersXmlDocument() As XmlDocument

      'declare a String containing the stored procedure name
      Dim strQuery As String = "GetSupplierList"

      'create a new Connection object using connection string
      Dim objConnect As New OleDbConnection(m_ConnectString)

      'create new DataAdapter using stored proc name and Connection
      Dim objAdapter As New OleDbDataAdapter(strQuery, objConnect)

      'create a new DataSet object to hold the results
      Dim objDataSet As New DataSet()

      Try

        'get the data into a table named "Suppliers" in the DataSet
        objAdapter.Fill(objDataSet, "Suppliers")

        'create a new XmlDataDocument object based on the DataSet
        Dim objXmlDataDoc As New XmlDataDocument(objDataSet)

        'return it as an XmlDocument object to the calling routine
        Return CType(objXmlDataDoc, XmlDocument)

      Catch objErr As Exception

        Throw objErr

      End Try

    End Function

    '----------------------------------------------------

    'function to return an XML document (as a String) containing
    'a full list of supplier details from database, and using
    'a SQL Server XML technology (FOR XML) query
    Public Function GetSuppliersSqlXml() As String

      'declare a String containing the SQL-XML stored proc to execute
      Dim strQuery As String = "GetSupplierXml"

      'create a new Connection object using connection string
      Dim objConnect As New SqlConnection(m_ConnectString)

      'create new Command using stored proc name and Connection
      Dim objCommand As New SqlCommand(strQuery, objConnect)

      'create a variable to hold an XmlTextReader object
      Dim objReader As XmlTextReader

      Dim strXml As String
      Dim QUOT As String = Chr(34)

      Try

        'open connection to the database
        objConnect.Open()

        'execute the stored proc to initialize the XmlTextReader
        objReader = objCommand.ExecuteXmlReader()

        'create the document prolog
        strXml = "<?xml version=" & QUOT & "1.0" & QUOT & "?>" _
               & "<!-- Created: " & Now() & " -->" _
               & "<SupplierList>"

        'read the first result row and then read remainder
        objReader.ReadString()
        strXml &= objReader.GetRemainder().ReadToEnd()

        'add the document epilog
        strXml &= "</SupplierList>"

      Catch objErr As Exception

        Throw objErr

      Finally

        'close connection and destroy reader object
        objConnect.Close()
        objReader = Nothing

      End Try

      'return the XML document object to the calling routine
      Return strXml

    End Function

    '----------------------------------------------------

    'function to return an Array containing the full
    'name and address details of suppliers from the database
    Public Function GetSuppliersArray(Optional ByVal MaximumRowNumber As Integer = 10) As Array

      'declare a String containing the stored procedure name
      Dim strQuery As String = "GetSupplierList"

      'create a new Connection object using connection string
      Dim objConnect As New OleDbConnection(m_ConnectString)

      'create new Command using stored proc name and Connection
      Dim objCommand As New OleDbCommand(strQuery, objConnect)

      'create a variable to hold a DataReader object
      Dim objReader As OleDbDataReader

      Try

        'open connection to the database
        objConnect.Open()

        'execute query to initialize DataReader object
        'connection will be closed when DataReader goes out of scope
        objReader = objCommand.ExecuteReader(CommandBehavior.CloseConnection)

        'get the index of the last column within the data
        Dim intLastColIndex As Integer = objReader.FieldCount - 1

        'declare a variable to hold the result array
        Dim arrValues(intLastColIndex, MaximumRowNumber) As String

        Dim intRowCount As Integer = 0   'to hold number of rows returned
        Dim intCol As Integer      'to hold the column iterator

        'iterate through rows by calling Read method until False
        While objReader.Read() And intRowCount < MaximumRowNumber

          'store column values as strings in result array
          For intCol = 0 To intLastColIndex
            arrValues(intCol, intRowCount) = CType(objReader(intCol), String)
          Next

          'increment number of rows found
          intRowCount += 1

        End While

        objReader = Nothing     'finished with DataReader

        're-size the array to the number of rows found
        'may be less than the number specified in optional method parameter
        ReDim Preserve arrValues(intLastColIndex, intRowCount - 1)

        Return arrValues   'and return array to the calling routine

      Catch objErr As Exception

        Throw objErr

      End Try

    End Function

    '----------------------------------------------------

    'function to return an ArrayList containing just the
    'name of each of the suppliers in the database
    Public Function GetSuppliersArrayList() As ArrayList

      'declare a String containing the stored procedure name
      Dim strQuery As String = "GetSupplierName"

      'create a new Connection object using connection string
      Dim objConnect As New OleDbConnection(m_ConnectString)

      'create new Command using stored proc name and Connection
      Dim objCommand As New OleDbCommand(strQuery, objConnect)

      'create a variable to hold a DataReader object
      Dim objReader As OleDbDataReader

      Try

        'open connection to the database
        objConnect.Open()

        'execute query to initialize DataReader object
        'connection will be closed when DataReader goes out of scope
        objReader = objCommand.ExecuteReader(CommandBehavior.CloseConnection)

        'create a new ArrayList object
        Dim arrValues As New ArrayList()

        'iterate through rows by calling Read method until False
        While objReader.Read()

          arrValues.Add(objReader.GetString(0))

        End While

        objReader = Nothing     'finished with DataReader

        Return arrValues   'return ArrayList to the calling routine

      Catch objErr As Exception

        Throw objErr

      End Try

    End Function

    '----------------------------------------------------

  End Class

End Namespace
