<%@Page Language="C#"%>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="System.Xml" %>
<%@Import Namespace="System.Xml.Schema" %>
<%@Register TagPrefix="dda" TagName="showdataset"
            Src="..\global\show-dataset.ascx" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html><head>
<title>Validating XML When Loading a DataSet</title>
<!-- #include file="..\global\style.inc" -->
</head>
<body bgcolor="#ffffff">
<span class="heading">Validating XML When Loading a DataSet</span><hr />


Use the
<a href="load-dataset-validate.aspx?xmlfile=somebooks.xml"><b>valid</b></a>
XML file or the
<a href="load-dataset-validate.aspx?xmlfile=errorbooks.xml"><b>invalid</b></a>
XML file<p />

<div id="outMessage" runat="server"></div><p />
<div id="outError" runat="server"></div><p />

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

   // create variable to hold a reference to an XmlTextReader
   XmlTextReader objXTReader = null;

   try {

     // specify the XML and schema files to use
     String strVSchemaPath = "somebooks.xsd";
     String strVirtualPath = "errorbooks.xml";
     if (Request.QueryString["xmlfile"] != null)
       strVirtualPath = Request.QueryString["xmlfile"];

     outMessage.InnerHtml += "Using schema: <b><a href="
               + QUOT + strVSchemaPath + QUOT
               + ">" + strVSchemaPath + "</a></b><br />";

     outMessage.InnerHtml += "Using XML file: <b><a href="
                + QUOT + strVirtualPath + QUOT
                + ">" + strVirtualPath + "</a></b><p />";

     // create the new XmlTextReader object and load the XML document
     objXTReader = new XmlTextReader(Server.MapPath(strVirtualPath));

     // create an XMLValidatingReader for this XmlTextReader
     XmlValidatingReader objValidator = new XmlValidatingReader(objXTReader);

     // set the validation type to use an XSD schema
     objValidator.ValidationType = ValidationType.Schema;

     // create a new XmlSchemaCollection
     XmlSchemaCollection objSchemaCol = new XmlSchemaCollection();

     // add the booklist-schema.xsd schema to it
     objSchemaCol.Add("", Server.MapPath(strVSchemaPath));

     // assign the schema collection to the XmlValidatingReader
     objValidator.Schemas.Add(objSchemaCol);

     // use XmlTextReader to load DataSet
      objDataSet.ReadXml(objValidator);
   }
   catch (Exception objError) {

      // display error details
      outError.InnerHtml = "<b>* Error while reading disk file</b>.<br />"
          + objError.Message + " " + objError.Source;
      return;  //  and stop execution
   }
   finally {

     // must remember to always close the XmlTextReader after use
     objXTReader.Close();
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
