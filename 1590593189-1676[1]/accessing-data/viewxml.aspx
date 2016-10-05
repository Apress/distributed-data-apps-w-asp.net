<%@Page Language="VB" %>
<%@Import Namespace="SupplierListDB" %>
<%@Import Namespace="System.Xml" %>

<script language="VB" runat="server">

Sub Page_Load()

  Response.ContentType = "text/xml"

  Try

    'call the appropriate method that returns XML
    'or write stylesheet to Response directly
    Select Case Request.QueryString("doc")

      Case "GetSuppliersSqlXml"
        Dim strConnect As String = ConfigurationSettings.AppSettings("NorthwindSqlClientConnectString")
        Dim objSupplierList As New SupplierList(strConnect)
        Response.Write(objSupplierList.GetSuppliersSqlXml())

      Case "GetSuppliersSqlXmlStyle"
        Response.WriteFile("supplier-sqlxml-style.xsl")

      Case "GetSuppliersXml"
        Dim strConnect As String = ConfigurationSettings.AppSettings("NorthwindConnectString")
        Dim objSupplierList As New SupplierList(strConnect)
        Response.Write(objSupplierList.GetSuppliersXml())

      Case "XmlGetSuppliersXmlString"
        Response.WriteFile("supplier-list.xml")

      Case "GetSuppliersXmlStyle"
        Response.WriteFile("supplier-list-style.xsl")

      Case "GetSuppliersXmlDoc"
        Dim strConnect As String = ConfigurationSettings.AppSettings("NorthwindConnectString")
        Dim objSupplierList As New SupplierList(strConnect)
        Dim objDoc As XmlDocument = objSupplierList.GetSuppliersXmlDocument()
        Response.Write(objDoc.OuterXml)

      Case "GetSuppliersXmlDocStyle"
        Response.WriteFile("supplier-list-style.xsl")

      Case "XmlGetSuppliersDSDoc"
        Response.WriteFile("supplier-list.xml")

      Case "XmlGetSuppliersDSSchema"
        Response.WriteFile("supplier-list.xsd")

    End Select

  Catch objErr As Exception

  End Try

End Sub

</script>
