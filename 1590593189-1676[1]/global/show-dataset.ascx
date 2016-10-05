<%@Control Language="VB"%>
<%@Import Namespace="System.Data" %>

<b><div id="divCaption" runat="server" /></b>
<div id="divValues" runat="server" /><p />

<script language="VB" runat="server">

Public Sub ShowValues(objTable As DataTable, strCaption As String)

   Dim intRow, intCol As Integer
   Dim objRow As DataRow
   Dim strColName, strResult As String

   'iterate through all the rows in the Table
   For intRow = 0 To objTable.Rows.Count - 1

     'get a reference to this row
     objRow = objTable.Rows(intRow)

     'show row state and row number
     strResult &= "<b>" & objRow.RowState.ToString() & "</b> row [" _
               & intRow & "] &nbsp; <b>Current</b>: "

     'iterate through all the columns in this row
     For intCol = 0 To objTable.Columns.Count - 1

       Try

         'get the name of this column and the Current value
         strColName = objTable.Columns(intCol).ColumnName
         strResult &= strColName & "=" _
                   & objRow(strColName, DataRowVersion.Current) & " "

       Catch

         strResult &= "{n/a}, "    'no Current value available

       End Try

     Next

     strResult &= " &nbsp; <b>Original</b>: "

     'iterate through the columns in the same row again
     For intCol = 0 To objTable.Columns.Count - 1

       Try

         'get the name of this column and the Current value
         strColName = objTable.Columns(intCol).ColumnName
         strResult &= strColName & "=" _
                   & objRow(strColName, DataRowVersion.Original) & " "

       Catch

         strResult &= "{n/a}, "    'no Original value available

       End Try

     Next

     strResult &= "<br />"

     'get any RowError value and display this
     If objRow.RowError.Length > 0 Then
       strResult &= " &nbsp; <b>* Row Error</b>: " & objRow.RowError & "<br />"
     End If

   Next

   'put text into <div> controls on page
   divValues.InnerHtml = strResult
   divCaption.InnerHtml = strCaption & ":"

End Sub

</script>
