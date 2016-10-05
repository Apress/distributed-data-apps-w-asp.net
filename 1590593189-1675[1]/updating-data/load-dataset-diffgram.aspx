<%@Page Language="C#"%>
<%@Import Namespace="System.Data" %>
<%@Register TagPrefix="dda" TagName="showdataset"
            Src="..\global\show-dataset.ascx" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html><head>
<title>Loading a DataSet from a DiffGram</title>
<!-- #include file="..\global\style.inc" -->
</head>
<body bgcolor="#ffffff">
<span class="heading">Loading a DataSet from a DiffGram</span><hr />

<div id="outMessage" runat="server"></div><p />

<!-- insert custom controls to display values -->
<dda:showdataset id="ctlShow1" runat="server" />

<!--------------------------------------------------------------------------->

<script Language="C#" runat="server">

void Page_Load() {

   char QUOT = (char)34;   // double-quote character

   // create a new DataSet object
   DataSet objDataSet = new DataSet();

   try {

      // specify the XML and schema files to use
      String strVirtualPath = "booksdiffgram.xml";
      String strVSchemaPath = "somebooks.xsd";

      // read the schema into the DataSet from file on disk
      // must use the Physical path to the file not the Virtual path
      objDataSet.ReadXmlSchema(Request.MapPath(strVSchemaPath));
      outMessage.InnerHtml += "Reading file: <b><a href=" + QUOT + strVSchemaPath + QUOT
                           + ">" + strVSchemaPath + "</a></b><br />";

      // read the dif (fgram into the DataSet from file on disk
      objDataSet.ReadXml(Request.MapPath(strVirtualPath));
      outMessage.InnerHtml += "Reading file: <b><a href=" + QUOT + strVirtualPath + QUOT
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
   ctlShow1.ShowValues(objTable, "Row values after loading DiffGram");
}
</script>

<!--------------------------------------------------------------------------->
<!-- #include file="..\global\foot-view.inc" -->
</body>
</html>
