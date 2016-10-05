<%@Page Language="VB"%>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="System.Xml" %>
<%@Register TagPrefix="dda" TagName="showdataset"
            Src="..\..\global\show-dataset.ascx" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html><head>
<title>View the Edited DiffGram</title>
<!-- #include file="..\..\global\style.inc" -->
</head>
<body link="#0000ff" alink="#0000ff" vlink="#0000ff">
<div class="heading">View the Edited DiffGram</div>
<div align="right" class="cite">
[<a href="../../global/viewsource.aspx">view page source</a>]
</div><hr />

<div id="outError" runat="server"></div><p />

<b>DataSet Tables Collection:</b>
<asp:Datagrid id="dgr1" runat="server" /><p />

<!-- insert custom controls to display values -->
<dda:showdataset id="ctlShow1" runat="server" />
<dda:showdataset id="ctlShow2" runat="server" /><p />

<b>Posted XML Content:</b>
<div id="outXML" runat="server"></div><p />

<!--------------------------------------------------------------------------->

<script language="VB" runat="server">

Sub Page_Load()

  'create a new DataSet object
  Dim objDataSet As New DataSet()

  Try

    'create an XmlTextReader to read data sent from client
    'specifying that string fragment is an XML Document
    Dim objReader As New XmlTextReader(Request.Form("hidPostXML"), _
                                      XmlNodeType.Document, Nothing)

    'read the schema into the DataSet from file on disk
    'must use the Physical path to the file not the Virtual path
    objDataSet.ReadXmlSchema(Request.MapPath("orders-schema.xsd"))

    'read in the DiffGram posted from the client
    objDataSet.ReadXml(objReader)

  Catch objError As Exception

    'display error details
    outError.InnerHTML = "<b>* Error while reading disk file</b>.<br />" _
                         & objError.Message & " " & objError.Source

  End Try


  '-------------- show contents of DataSet ----------------

  Try

    'bind DataGrid control to DataSet Tables collection
    dgr1.DataSource = objDataSet.Tables
    dgr1.DataBind()

    'display Orders current and original values after loading
    Dim objTable As DataTable = objDataSet.Tables("Orders")
    ctlShow1.ShowValues(objTable, "Orders row values after loading DiffGram")

    'display Order Details current and original values
    objTable = objDataSet.Tables("Order Details")
    ctlShow2.ShowValues(objTable, "Order Details row values after loading DiffGram")

  Catch
  End Try

  'display the XML DiffGram itself
  outXML.InnerHtml = "<xmp>" & Request.Form("hidPostXML") & "</xmp>"

End Sub
</script>

<!--------------------------------------------------------------------------->
<!-- #include file="..\..\global\foot.inc" -->
</body>
</html>
