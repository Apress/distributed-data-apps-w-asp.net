<%@Page Language="VB" Trace="True" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="System.Data.OleDb" %>
<%@Import Namespace="DataSetUpdate" %>

<%@Register TagPrefix="dda" TagName="showdataset"
            Src="../global/show-dataset.ascx" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html><head>
<title>Updating Customer Orders and Order Details</title>
<!-- #include file="..\global\style.inc" -->
</head>
<body bgcolor="#ffffff">
<span class="heading">Updating Customer Orders and Order Details</span>
<div align="right" class="cite">
[<a href="../global/viewsource.aspx?compsrc=updatedataset.vb" target="_blank">view page source</a>]
</div><hr />
<!--------------------------------------------------------------------------->

<!-- insert custom controls to display values -->
<dda:showdataset id="ctlShow1" runat="server" />
<dda:showdataset id="ctlShow2" runat="server" />

<div id="outConcurrent" runat="server"></div><p />

<!-- insert custom controls to display values -->
<dda:showdataset id="ctlShow3" runat="server" />
<dda:showdataset id="ctlShow4" runat="server" />

<div id="outError" runat="server">&nbsp;</div><p />

<!---------------- server-side code section ------------------>

<script language="vb" runat="server">

Sub Page_Load()

   'get connection string from web.config
   Dim strConnect As String = ConfigurationSettings.AppSettings("NorthwindConnectString")

   'create an instance of the data access component
   Dim objOrderUpdate As New UpdateDataSet(strConnect)

   'declare variable to hold a DataSet from the server
   Dim objDataSet As DataSet

   Try

     'call component to get DataSet containing order details for customer
     objDataSet = objOrderUpdate.GetOrderDetails("THECR")

   Catch objError As Exception

      'display error details
      outError.InnerHtml = "<b>* Error while fetching order details</b>.<br />" _
          & objError.Message & " Source: " & objError.Source
      Exit Sub  ' and stop execution

   End Try

   'get a reference to the Orders table
   Dim objTable As DataTable = objDataSet.Tables("Orders")

   'now modify the values held in this table
   objTable.Rows(0)("ShipCity") = GetRandomString()
   objTable.Rows(1)("ShipCountry") = GetRandomString()
   Randomize    'get random value between 0 and 9
   Dim intRand As Single = Int(9 * Rnd())
   objTable.Rows(2)("ShipVia") = CInt(intRand / 2)

   'add a new row to the Orders table
   Dim objDataRow As DataRow
   objDataRow = objTable.NewRow()
   objDataRow("OrderID") = 999999
   objDataRow("CustomerID") = "THECR"
   objDataRow("OrderDate") = "06/01/2002"
   objDataRow("RequiredDate") = "06/01/2002"
   objDataRow("ShippedDate") = "06/01/2002"
   objDataRow("ShipVia") = 2
   objDataRow("Freight") = 10.50
   objDataRow("ShipName") = "*new row*"
   objDataRow("ShipCity") = "*new row*"
   objDataRow("ShipPostalCode") = "*new row*"
   objDataRow("ShipCountry") = "*new row*"
   objTable.Rows.Add(objDataRow)

   'display contents after changing the data
   ctlShow1.ShowValues(objTable, _
                       "Contents of the Orders table after editing locally")

   'get a reference to the Order Details table
   objTable = objDataSet.Tables("Order Details")

   'now modify the values held in this table
   objTable.Rows(0)("Quantity") = intRand + 7
   objTable.Rows(1)("Quantity") = intRand + 3
   objTable.Rows(2)("Quantity") = intRand - 1

   'add a new row to the Order Details table
   objDataRow = objTable.NewRow()
   objDataRow("OrderID") = 999999
   objDataRow("ProductID") = 40
   objDataRow("UnitPrice") = 25
   objDataRow("Quantity") = 10
   objDataRow("Discount") = 0.07
   objTable.Rows.Add(objDataRow)

   'display contents after changing the data
   ctlShow2.ShowValues(objTable, _
                       "Contents of the Order Details table after editing locally")

   '-------------------------------------------------------------------

   'change some values in the original table while the DataSet is holding
   'a disconnected copy of the data to force a concurrency error

   Dim strConcurrent, strUpdate As String
   Dim intRowsAffected As Integer

   'need a new (separate) Connection and Command object
   Dim objNewConnect As New OleDbConnection(strConnect)
   Dim objNewCommand As New OleDbCommand()
   objNewCommand.Connection = objNewConnect

   Try

      objNewConnect.Open()

      'modify rows to force concurrency errors
      strConcurrent += "<b>Concurrently executed</b>:<br />"

      strUpdate = "UPDATE Orders SET Freight = " _
                & CStr(intRand * 10) & " WHERE OrderID = 11003"
      objNewCommand.CommandText = strUpdate
      intRowsAffected = objNewCommand.ExecuteNonQuery()
      strConcurrent += strUpdate & " ... <b>" _
             & CStr(intRowsAffected) & "</b> row(s) affected<br />"

      strUpdate = "UPDATE Orders SET Freight = " _
                & CStr(intRand * 7) & " WHERE OrderID = 10775"
      objNewCommand.CommandText = strUpdate
      intRowsAffected = objNewCommand.ExecuteNonQuery()
      strConcurrent += strUpdate & " ... <b>" _
             & CStr(intRowsAffected) & "</b> row(s) affected<br />"

      intRand = intRand / 10

      strUpdate = "UPDATE [Order Details] SET Discount = " _
                & intRand & " WHERE OrderID = 10624 AND ProductID = 28"
      objNewCommand.CommandText = strUpdate
      intRowsAffected = objNewCommand.ExecuteNonQuery()
      strConcurrent += strUpdate & " ... <b>" _
             & CStr(intRowsAffected) & "</b> row(s) affected<br />"

      strUpdate = "UPDATE [Order Details] SET Discount = " _
                & intRand & " WHERE OrderID = 10624 AND ProductID = 29"
      objNewCommand.CommandText = strUpdate
      intRowsAffected = objNewCommand.ExecuteNonQuery()
      strConcurrent &= strUpdate & " ... <b>" _
             & CStr(intRowsAffected) & "</b> row(s) affected<br />"

   Catch objError As Exception

      'display error details
      outError.InnerHtml = "<b>* Error during concurrent updates</b>.<br />" _
          & objError.Message & " Source: " & objError.Source
      Exit Sub  ' and stop execution

   Finally

     objNewConnect.Close()

   End Try

   outConcurrent.InnerHtml = strConcurrent

   '-------------------------------------------------------------------

   'now ready to perform updates using modified DataSet object
   'create a DataSet variable to hold the results
   Dim objReturnedDS As DataSet

   Try

     'call function to do updates - pass in changed DataSet
     objReturnedDS = _
             objOrderUpdate.UpdateAllOrderDetails("THECR", objDataSet)

   Catch objError As Exception

      'display error details
      outError.InnerHtml = "<b>* Error during updates to original data</b>.<br />" _
          & objError.Message & " Source: " & objError.Source
      Exit Sub  ' and stop execution

   End Try

   '-------------------------------------------------------------------

   'see if we got any errors - method returns Nothing if all OK with
   'no errors, and the ReturnErrorRowsOnly parameter is set to True

   If objReturnedDS Is Nothing Then

     'no errors during update
     outError.InnerHtml = "<b>There were no errors during the update process.</b>"

   Else

     'show values within the DataSet tables
     ctlShow3.ShowValues(objReturnedDS.Tables("Orders"), _
              "Contents of the Orders table in the DataSet after updating")
     ctlShow4.ShowValues(objReturnedDS.Tables("Order Details"), _
              "Contents of the Order Details table in the DataSet after updating")

   End If

   '-------------------------------------------------------------------

   'finally delete the new rows we added to the Orders and Order Details table

   Try


      objNewConnect.Open()

      'get order ID of newly inserted row
      strUpdate = "SELECT OrderID FROM Orders WHERE ShipName = '*new row*'"
      objNewCommand.CommandText = strUpdate
      Dim objReader As OleDbDataReader = objNewCommand.ExecuteReader()
      objReader.Read()
      Dim intOrderID As Integer = objReader("OrderID")
      objReader.Close()

      'delete new child row(s) from Order Details table
      strUpdate = "DELETE FROM [Order Details] WHERE OrderID = " & intOrderID.ToString()
      objNewCommand.CommandText = strUpdate
      objNewCommand.ExecuteNonQuery()

      'delete new row from Orders table
      strUpdate = "DELETE FROM Orders WHERE OrderID = " & intOrderID.ToString()
      objNewCommand.CommandText = strUpdate
      objNewCommand.ExecuteNonQuery()

      outConcurrent.InnerHtml += "Deleted newly inserted row after updates completed."

   Catch objError As Exception

      'display error details
      outError.InnerHtml = "<br /><b>* Error deleting inserted row</b>.<br />" _
          & objError.Message & " Source: " & objError.Source

   Finally

     objNewConnect.Close()

   End Try

End Sub

'-----------------------------------------------------
'-----------------------------------------------------

Function GetRandomString() As String
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
<!-- #include file="..\global\foot.inc" -->
</body>
</html>
