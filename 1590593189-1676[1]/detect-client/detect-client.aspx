<%@Page Language="VB" %>

<!-- register the user control that contains the detection code -->
<%@Register TagPrefix="dda" TagName="GetClientType" Src="../global/client-detect.ascx" %>

<!-- insert user control into the page -->
<dda:GetClientType id="ClientDetect" runat="server" />

<script language="VB" runat="server">

Sub Page_Load()

  Session("Supported") = "Yes"

  Select Case ClientDetect.ClientType
    Case 2  'IE 4.x
      Response.Clear
      Server.Transfer("homepage-ie4.aspx")
    Case 3  'IE 5.x and above
      Response.Clear
      Server.Transfer("homepage-ie5.aspx")
    Case 4  'small-screen HTML device
      Response.Clear
      Server.Transfer("homepage-ppc.aspx")
    Case 5  'WML client
      Response.Clear
      Server.Transfer("homepage-wml.aspx")
    Case Else  'assume HTML 3.2 client
      Response.Clear
      Server.Transfer("homepage-html.aspx")
  End Select
End Sub

</script>
