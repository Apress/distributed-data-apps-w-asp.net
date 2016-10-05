<%@Page Language="VB"%>
<%@Import Namespace="System.Data"%>
<%@Import Namespace="System.Data.OleDb"%>

<%@Register TagPrefix="dda" TagName="showdataset"
            Src="..\global\show-dataset.ascx" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html><head>
<title>Reconciling Updates from a DataSet</title>
<!-- #include file="..\global\style.inc" -->
</head>
<body bgcolor="#ffffff">
<span class="heading">Reconciling Updates from a DataSet</span><hr />
<!--------------------------------------------------------------------------->

<!-- insert custom controls to display values -->
<dda:showdataset id="ctlShow1" runat="server" />
<dda:showdataset id="ctlShow2" runat="server" />
<dda:showdataset id="ctlShow3" runat="server" />
<dda:showdataset id="ctlShow4" runat="server" />
<dda:showdataset id="ctlShow5" runat="server" />
<dda:showdataset id="ctlShow6" runat="server" />
<dda:showdataset id="ctlShow7" runat="server" /><p />

<div id="outError" runat="server" />

<script language="vb" runat="server">

Sub Page_Load()

  'get connection string from web.config
  Dim strConnect As String
  strConnect = ConfigurationSettings.AppSettings("NorthwindConnectString")

  'specify the SELECT statement to extract the data
  Dim strSelect As String
  strSelect = "SELECT CustomerID, City, Country FROM [Customers] WHERE CustomerID LIKE 'A%'"

  'declare a variable to hold a DataSet object
  Dim objDataSet As New DataSet()

  'create a new Connection object using the connection string
  Dim objConnect As New OleDbConnection(strConnect)

  'create a new DataAdapter using the connection object and select statement
  Dim objDataAdapter As New OleDbDataAdapter(strSelect, objConnect)

  Try

    'fill the dataset with data from the DataAdapter object
    objDataAdapter.Fill(objDataSet, "Customers")

  Catch objError As Exception

    'display error details
    outError.innerHTML = "<b>* Error while accessing data</b>.<br />" _
        & objError.Message & " " & objError.Source
    Exit Sub  ' and stop execution

  End Try

  'get a reference to the new Customers Table in DataSet
  Dim objTable As DataTable = objDataSet.Tables(0)

  'set primary key in DataSet to allow Merge to work
  Dim arrKey(0) As DataColumn
  arrKey(0) = objTable.Columns("CustomerID")
  objTable.PrimaryKey = arrKey

  'show values in DataSet
  ctlShow1.ShowValues(objTable, "'Original' DataSet row values after loading data with Fill method")

  '---------------------------------------------------
  'edit some of the values
  objTable.Rows(0)("City") = GetRandomString()
  objTable.Rows(0)("Country") = GetRandomString()
  objTable.Rows(2)("City") = GetRandomString()
  objTable.Rows(2)("Country") = GetRandomString()

  'show values in DataSet
  ctlShow2.ShowValues(objTable, "'Original' DataSet row values after editing data")

  '---------------------------------------------------
  'change a value in the original table while the DataSet is holding
  'a disconnected copy of the data to force a concurrency error
  Dim strUpdate As String
  strUpdate = "UPDATE Customers SET City = '*" & GetRandomString() _
            & "*' WHERE CustomerID = 'ANTON'"

  Dim objNewConnect As New OleDbConnection(strConnect)
  Dim objNewCommand As New OleDbCommand(strUpdate, objNewConnect)

  Try

    'open the connection to the database
    objNewConnect.Open()

    'execute the SQL statement
    objNewCommand.ExecuteNonQuery()

  Catch objError As Exception

    'display error details
    outError.InnerHtml = "<b>* Error while updating original data</b>.<br />" _
        & objError.Message & "<br />" & objError.Source
    Exit Sub  ' and stop execution

  Finally

    objNewConnect.Close()

  End Try

  '---------------------------------------------------
  'marshal just the changed rows into a new DataSet
  Dim objChangesDS As DataSet = objDataSet.GetChanges()

  'show values in DataSet
  Dim objChangeTable As DataTable = objChangesDS.Tables(0)
  ctlShow3.ShowValues(objChangeTable, "'Changes' DataSet row values after creating with GetChanges method")

  '---------------------------------------------------
  'update original table in database using "changes" DataSet

  Try

   'create an auto-generated command builder to create the commands
   'to update, insert and delete the data
   Dim objCommandBuilder As New OleDbCommandBuilder(objDataAdapter)

   'prevent exceptions being thrown due to concurrency errors
   'error details obtained from the RowError property afterwards
   objDataAdapter.ContinueUpdateOnError = True

   'perform the update on the original data
   objDataAdapter.Update(objChangesDS, "Customers")

  Catch objError As Exception

   'display error details
   outError.innerHTML = "<b>* Error while updating original data</b>.<br />" _
                      & objError.Message & " " & objError.Source
    Exit Sub  'and stop

  End Try

  'show values in DataSet
  ctlShow4.ShowValues(objChangeTable, "'Changes' DataSet row values after calling Update method")

  '---------------------------------------------------
  'call Fill to fetch underlying values into "changes" DataSet

  Try

    'refresh "changes" dataset from database table
    objDataAdapter.Fill(objChangesDS, "Customers")

  Catch objError As Exception

    'display error details
    outError.innerHTML = "<b>* Error while accessing data</b>.<br />" _
        & objError.Message & " " & objError.Source
    Exit Sub  'and stop

  End Try

  'show values in DataSet
  ctlShow5.ShowValues(objChangeTable, "'Changes' DataSet row values after refreshing data with Fill method")

  '---------------------------------------------------
  'now merge "changes" DataSet back into original DataSet
  objDataSet.Merge(objChangesDS, True)

  'show values in original (now merged) DataSet
  ctlShow6.ShowValues(objTable, "'Original' DataSet row values after Merging Changes DataSet into it")

  '---------------------------------------------------
  'finally, build a table containing just the rows with errors

  Dim arrRows(), objRow As DataRow
  Dim objNewTable As DataTable

  'get number of tables in DataSet
  Dim intTableCount As Integer = objDataSet.Tables.Count
  Dim intTableIndex As Integer = 0

  'iterate through existing tables in DataSet
  For intTableIndex = 0 To intTableCount - 1

   'get a reference to this table in DataSet
   'always use index 0 as tables are added to end of
   'the Tables collection so remove/add process shown
   'later means new tables are never at index 0
   objTable = objDataSet.Tables(0)

   'make a copy of the table
   objNewTable = objTable.Clone

   'get reference to rows with errors into array
   arrRows = objTable.GetErrors()

   'copy these rows into the new table
   For Each objRow In arrRows
      objNewTable.ImportRow(objRow)
   Next

   'replace old table with the new one
   objDataSet.Tables.Remove(objTable)
   objDataSet.Tables.Add(objNewTable)

  Next

  ctlShow7.ShowValues(objDataSet.Tables(0), "'Errors' table created using GetErrors method")

End Sub

'-----------------------------------------------------
'-----------------------------------------------------

Function GetRandomString()
  'create a random string to simulate user editing the values
  Dim strResult As String = ""
  Dim intLoop As Integer
  Randomize
  For intLoop = 1 To 6
    strResult &= Chr(CInt(Rnd() * 25) + 65)
  Next
  Return strResult
End Function

</script>

<!--------------------------------------------------------------------------->
<!-- #include file="..\global\foot-view.inc" -->
</body>
</html>
