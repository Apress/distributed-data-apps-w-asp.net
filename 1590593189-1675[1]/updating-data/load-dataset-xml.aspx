<%@Page Language="C#"%>
<%@Import Namespace="System.Data" %>
<%@Register TagPrefix="dda" TagName="showdataset"
            Src="..\global\show-dataset.ascx" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html><head>
<title>Loading a DataSet from an XML File</title>
<!-- #include file="..\global\style.inc" -->
</head>
<body bgcolor="#ffffff">
<span class="heading">Loading a DataSet from an XML File</span><hr />

<div id="outMessage" runat="server"></div><p />

<!-- insert custom controls to display values -->
<dda:showdataset id="ctlShow1" runat="server" />
<dda:showdataset id="ctlShow2" runat="server" />
<dda:showdataset id="ctlShow3" runat="server" />

<!--------------------------------------------------------------------------->

<script Language="C#" runat="server">

void Page_Load() {

   char QUOT = (char)34;   // double-quote character

   // create a new DataSet object
   DataSet objDataSet = new DataSet();

   try {

      // specify the XML and schema files to use
      String strVirtualPath = "somebooks.xml";
      String strVSchemaPath = "somebooks.xsd";

      // read schema and data into DataSet from XML documents on disk
      // must use the Physical path to the file not the Virtual path
      objDataSet.ReadXmlSchema(Request.MapPath(strVSchemaPath));
      outMessage.InnerHtml = "Loaded file: <b><a href=" + QUOT + strVSchemaPath + QUOT
                + ">" + strVSchemaPath + "</a></b><br />";

      objDataSet.ReadXml(Request.MapPath(strVirtualPath));
      outMessage.InnerHtml += "Loaded file: <b><a href=" + QUOT + strVirtualPath + QUOT
                           + ">" + strVirtualPath + "</a></b>";
   }
   catch (Exception objError) {

      // display error details
      outMessage.InnerHtml = "<b>* Error while reading disk file</b>.<br />"
          + objError.Message + " " + objError.Source;
      return;  //  and stop execution
   }

   DataTable objTable = objDataSet.Tables[0];

   // display current and original values after loading
   ctlShow1.ShowValues(objTable, "Row values after loading XML");

   // call AcceptChanges and display current and original values again
   objDataSet.AcceptChanges();
   ctlShow2.ShowValues(objTable, "Row values after AcceptChanges");

   // edit rows and display current and original values again
   objTable.Rows[1]["Date"] = "2001-09-15";
   objTable.Rows[1]["Name"] = "Chang";
   objTable.Rows[3]["Date"] = "2001-02-10";
   objTable.Rows[3]["Name"] = "Millington";
   DataRow objDataRow = objTable.NewRow();
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
