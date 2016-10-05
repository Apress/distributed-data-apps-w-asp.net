<%@Page Language="VB"%>
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

<script language="VB" runat="server">

Sub Page_Load()

   'create a new DataSet object
   Dim objDataSet As New DataSet()

   Try

      'specify the XML and schema files to use
      Dim strVirtualPath As String = "booksdiffgram.xml"
      Dim strVSchemaPath As String = "somebooks.xsd"

      'read the schema into the DataSet from file on disk
      'must use the Physical path to the file not the Virtual path
      objDataSet.ReadXmlSchema(Request.MapPath(strVSchemaPath))
      outMessage.InnerHTML += "Reading file: <b><a href=" & Chr(34) & strVSchemaPath & Chr(34) _
                           & ">" & strVSchemaPath & "</a></b><br />"

      'read the diffgram into the DataSet from file on disk
      objDataSet.ReadXml(Request.MapPath(strVirtualPath))
      outMessage.InnerHTML += "Reading file: <b><a href=" & Chr(34) & strVirtualPath & Chr(34) _
                           & ">" & strVirtualPath & "</a></b>"

   Catch objError As Exception

      'display error details
      outMessage.InnerHTML = "<b>* Error while reading disk file</b>.<br />" _
          & objError.Message & " " & objError.Source
      Exit Sub  ' and stop execution

   End Try

   Dim objTable As DataTable = objDataSet.Tables(0)

   'display current and original values after loading
   ctlShow1.ShowValues(objTable, "Row values after loading DiffGram")

End Sub
</script>

<!--------------------------------------------------------------------------->
<!-- #include file="..\global\foot-view.inc" -->
</body>
</html>
