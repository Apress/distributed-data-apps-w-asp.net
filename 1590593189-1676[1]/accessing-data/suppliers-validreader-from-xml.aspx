<%@Page Language="VB" %>
<%@Import Namespace="System.Xml" %>
<%@Import Namespace="SupplierListXml" %>

<!------------------ HTML page content --------------------->

<html>
<head>
<title>Supplier List : XmlValidatingReader from XML Disk File</title>
<!-- #include file="../global/style.inc" -->
</head>
<body>

<div class="heading">Supplier List : XmlValidatingReader from XML Disk File</div>

<div align="right" class="cite">
[<a href="../global/viewsource.aspx?compsrc=get-supplier-xml.vb">view page source</a>]<br />
[<a href="viewxml.aspx?doc=XmlGetSuppliersXmlString">view XML document</a>]<br />
[<a href="viewxml.aspx?doc=XmlGetSuppliersDSSchema">view XSD schema</a>]
</div><br />

<asp:Label id="lblMessage" runat="server" />

<!-- #include file="../global/foot.inc" -->
</body>
</html>

<!-------------- server-side script section ---------------->

<script language="VB" runat="server">

Sub Page_Load()

  'create physical path to XML file (in same folder as ASPX page)
  Dim strCurrentPath As String = Request.PhysicalPath
  Dim strPathOnly As String = Left(strCurrentPath, InStrRev(strCurrentPath, "\"))
  Dim strXMLPath As String = strPathOnly & "supplier-list.xml"
  Dim strSchemaPath As String = strPathOnly & "supplier-list.xsd"

  'declare variable to hold XmlValidatingReader object
  Dim objReader As XmlValidatingReader

  Try

    'create an instance of the data access component
    Dim objSupplierList As New SupplierList(strXMLPath, strSchemaPath)

    'call the method to return the data as an XmlValidatingReader
    objReader = objSupplierList.GetSuppliersValidatingReader()

    'if we got a result, display the parsed content
    If Not objReader Is Nothing Then
      lblMessage.Text = ParseXmlContent(objReader)
    End If

  Catch objErr As Exception

    'there was an error and no data will be returned
    lblMessage.Text = "ERROR: No data returned. " & objErr.Message

  Finally

    objReader.Reader.Close()   'close the Reader to release file

  End Try

End Sub


Function ParseXmlContent(objXMLReader As XmlValidatingReader) As String

  'read or "pull" the nodes of the XML document
  Dim strNodeResult As String = ""
  Dim objNodeType As XmlNodeType

  'read each node in turn - returns False if no more nodes to read
  Do While objXMLReader.Read()

    'select on the type of the node (these are only some of the types)
    objNodeType = objXMLReader.NodeType

    Select Case objNodeType

      Case XmlNodeType.XmlDeclaration:
         'get the name and value
         strNodeResult += "XML Declaration: <b>" & objXMLReader.Name _
                       & " " & objXMLReader.Value & "</b><br />"

      Case XmlNodeType.Element:
         'just get the name, any value will be in next (#text) node
         strNodeResult += "Element: <b>" & objXMLReader.Name & "</b><br />"

      Case XmlNodeType.Text:
         'just display the value, node name is "#text" in this case
         strNodeResult += "&nbsp; - Value: <b>" & objXMLReader.Value _
                       & "</b><br />"

    End Select

    'see if this node has any attributes
    If objXMLReader.AttributeCount > 0 Then

      'iterate through the attributes by moving to the next one
      'could use MoveToFirstAttribute but MoveToNextAttribute does
      'the same when the current node is an element-type node
      Do While objXMLReader.MoveToNextAttribute()

        'get the attribute name and value
        strNodeResult += "&nbsp; - Attribute: <b>" & objXMLReader.Name _
                       & "</b> &nbsp; Value: <b>" & objXMLReader.Value _
                       & "</b><br />"
      Loop

    End If

  Loop   'and read the next node

  'finished with the reader so close it
  objXMLReader.Close()

  'and retrun the resulting string
  Return strNodeResult

End Function

</script>

<!---------------------------------------------------------->
