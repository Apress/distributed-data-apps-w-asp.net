<%@Page Language="C#"%>
<%@Register TagPrefix="dda" TagName="showdataset"
            Src="..\global\show-dataset.ascx" %>
<%@Import Namespace="System.Data" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html><head>
<title>Inserting Values into a DataSet with Code</title>
<!-- #include file="..\global\style.inc" -->
</head>
<body bgcolor="#ffffff">
<span class="heading">Inserting Values into a DataSet with Code</span><hr />

<!-- insert custom controls to display values -->
<dda:showdataset id="ctlShow1" runat="server" />
<dda:showdataset id="ctlShow2" runat="server" />
<dda:showdataset id="ctlShow3" runat="server" />

<!--------------------------------------------------------------------------->

<script language="C#" runat="server">

void Page_Load() {

   DataSet objDataSet = new DataSet("TestDataSet");

   // create a new empty Table object with three columns
   DataTable objTable = new DataTable("Books");
   objTable.Columns.Add("ISBN", System.Type.GetType("System.String"));
   objTable.Columns.Add("Date", System.Type.GetType("System.String"));
   objTable.Columns.Add("Name", System.Type.GetType("System.String"));
   objDataSet.Tables.Add(objTable);  // add to DataSet

   // create new DataRows in table and fill in values
   DataRow objDataRow = objTable.NewRow();
   objDataRow["ISBN"] = "1861003323";
   objDataRow["Date"] = "2000-03-01";
   objDataRow["Name"] = "Britt";
   objTable.Rows.Add(objDataRow);
   objDataRow = objTable.NewRow();
   objDataRow["ISBN"] = "1861003315";
   objDataRow["Date"] = "2001-10-22";
   objDataRow["Name"] = "Burnham";
   objTable.Rows.Add(objDataRow);
   objDataRow = objTable.NewRow();
   objDataRow["ISBN"] = "1861003382";
   objDataRow["Date"] = "1999-07-15";
   objDataRow["Name"] = "Busar";
   objTable.Rows.Add(objDataRow);
   objDataRow = objTable.NewRow();
   objDataRow["ISBN"] = "1861003401";
   objDataRow["Date"] = "1998-11-09";
   objDataRow["Name"] = "Kauffman";
   objTable.Rows.Add(objDataRow);

   // display current and original values after loading
   ctlShow1.ShowValues(objTable, "Row values after loading data");

   // call AcceptChanges and display current and original values again
   objDataSet.AcceptChanges();
   ctlShow2.ShowValues(objTable, "Row values after AcceptChanges");

   // edit rows and display current and original values again
   objTable.Rows[1]["Date"] = "2001-09-15";
   objTable.Rows[1]["Name"] = "Chang";
   objTable.Rows[3]["Date"] = "2001-02-10";
   objTable.Rows[3]["Name"] = "Millington";
   objDataRow = objTable.NewRow();
   objDataRow["ISBN"] = "1861004923";
   objDataRow["Date"] = "2002-03-02";
   objDataRow["Name"] = "Sussman";
   objTable.Rows.Add(objDataRow);
   objTable.Rows[2].Delete();
   ctlShow3.ShowValues(objTable, "Row values after editing data");

}
</script>

<!--------------------------------------------------------------------------->
<!-- #include file="..\global\foot-view.inc" -->
</body>
</html>
