<%@Page Language="VB"%>
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

<script language="VB" runat="server">

Sub Page_Load()

   'create a new DataSet object
   Dim objDataSet As New DataSet()

   'create variable to hold a reference to an XmlTextReader
   Dim objXTReader As XmlTextReader

   Try

     'specify the XML and schema files to use
     Dim strVSchemaPath As String = "somebooks.xsd"
     Dim strVirtualPath As String = "errorbooks.xml"
     If Request.QueryString("xmlfile") <> "" Then
       strVirtualPath = Request.QueryString("xmlfile")
     End If

     outMessage.InnerHTML += "Using schema: <b><a href=" _
               & Chr(34) & strVSchemaPath & Chr(34) _
               & ">" & strVSchemaPath & "</a></b><br />"

     outMessage.InnerHTML += "Using XML file: <b><a href=" _
                & Chr(34) & strVirtualPath & Chr(34) _
                & ">" & strVirtualPath & "</a></b><p />"

     'create the new XmlTextReader object and load the XML document
     objXTReader = New XmlTextReader(Server.MapPath(strVirtualPath))

     'create an XMLValidatingReader for this XmlTextReader
     Dim objValidator As New XmlValidatingReader(objXTReader)

     'set the validation type to use an XSD schema
     objValidator.ValidationType = ValidationType.Schema

     'create a new XmlSchemaCollection
     Dim objSchemaCol As New XmlSchemaCollection()

     'add the booklist-schema.xsd schema to it
     objSchemaCol.Add("", Server.MapPath(strVSchemaPath))

     'assign the schema collection to the XmlValidatingReader
     objValidator.Schemas.Add(objSchemaCol)

     'use XmlTextReader to load DataSet
      objDataSet.ReadXml(objValidator)

   Catch objError As Exception

      'display error details
      outError.InnerHTML = "<b>* Error while reading disk file</b>.<br />" _
          & objError.Message & " " & objError.Source
      Exit Sub  ' and stop execution

  Finally

     'must remember to always close the XmlTextReader after use
     objXTReader.Close()

   End Try

   Dim objTable As DataTable = objDataSet.Tables(0)

   'display current and original values after loading
   ctlShow1.ShowValues(objTable, "Row values after loading XML")

   'call AcceptChanges and display current and original values again
   objDataSet.AcceptChanges()
   ctlShow2.ShowValues(objTable, "Row values after AcceptChanges")

   'edit rows and display current and original values again
   objTable.Rows(1)("Date") = "2001-09-15"
   objTable.Rows(1)("Name") = "Chang"
   objTable.Rows(3)("Date") = "2001-02-10"
   objTable.Rows(3)("Name") = "Millington"
   Dim objDataRow As DataRow
   objDataRow = objTable.NewRow()
   objDataRow("ISBN") = "1861004923"
   objDataRow("Date") = "2002-03-02"
   objDataRow("Name") = "Sussman"
   objTable.Rows.Add(objDataRow)
   objTable.Rows(2).Delete()
   ctlShow3.ShowValues(objTable, "Row values after editing data")

End Sub
</script>

<!--------------------------------------------------------------------------->
<!-- #include file="..\global\foot-view.inc" -->
</body>
</html>
