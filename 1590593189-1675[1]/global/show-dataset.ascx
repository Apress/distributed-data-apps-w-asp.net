<%@Control Language="C#"%>
<%@Import Namespace="System.Data" %>

<b><div id="divCaption" runat="server" /></b>
<div id="divValues" runat="server" /><p />

<script Language="C#" runat="server">

public void ShowValues(DataTable objTable, String strCaption) {

   int intRow, intCol;
   DataRow objRow;
   String strColName = String.Empty;
   String strResult = String.Empty;

   // iterate through all the rows in the Table
   for (intRow = 0; intRow < objTable.Rows.Count; intRow++) {

     // get a reference to this row
     objRow = objTable.Rows[intRow];

     // show row state and row number
     strResult += "<b>" + objRow.RowState.ToString() + "</b> row ["
               + intRow + "] &nbsp; <b>Current</b>: ";

     // iterate through all the columns in this row
     for (intCol = 0; intCol < objTable.Columns.Count; intCol++) {
       try {
         // get the name of this column and the Current value
         strColName = objTable.Columns[intCol].ColumnName;
         strResult += strColName + "=" + objRow[strColName, DataRowVersion.Current] + " ";
       }
       catch {
         strResult += "{n/a}, ";    // no Current value available
       }
     }  // next column

     strResult += " &nbsp; <b>Original</b>: ";

     // iterate through the columns in the same row again
     for (intCol = 0; intCol < objTable.Columns.Count; intCol++) {
       try {
         // get the name of this column and the Original value
         strColName = objTable.Columns[intCol].ColumnName;
         strResult += strColName + "=" + objRow[strColName, DataRowVersion.Original] + " ";
       }
       catch {
         strResult += "{n/a}, ";    // no Original value available
       }
     }  // next column

     strResult += "<br />";

     // get any RowError value and display this
     if (objRow.RowError.Length > 0) {
       strResult += " &nbsp; <b>* Row Error</b>: " + objRow.RowError + "<br />";
     }

   }  // next table row

   // put text into <div> controls on page
   divValues.InnerHtml = strResult;
   divCaption.InnerHtml = strCaption + ":";
}

</script>
