<%@Page Language="VB"%>
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

<script language="VB" runat="server">

Sub Page_Load()

   'create a new DataSet object
   Dim objDataSet As New DataSet()

   Try

      'specify the XML and schema files to use
      Dim strVirtualPath As String = "somebooks.xml"
      Dim strVSchemaPath As String = "somebooks.xsd"

      'read schema and data into DataSet from XML documents on disk
      'must use the Physical path to the file not the Virtual path
      objDataSet.ReadXmlSchema(Request.MapPath(strVSchemaPath))
      outMessage.InnerHTML = "Loaded file: <b><a href=" & Chr(34) & strVSchemaPath & Chr(34) _
                & ">" & strVSchemaPath & "</a></b><br />"

      objDataSet.ReadXml(Request.MapPath(strVirtualPath))
      outMessage.InnerHTML += "Loaded file: <b><a href=" & Chr(34) & strVirtualPath & Chr(34) _
                           & ">" & strVirtualPath & "</a></b>"

   Catch objError As Exception

      'display error details
      outMessage.InnerHTML = "<b>* Error while reading disk file</b>.<br />" _
          & objError.Message & " " & objError.Source
      Exit Sub  ' and stop execution

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
