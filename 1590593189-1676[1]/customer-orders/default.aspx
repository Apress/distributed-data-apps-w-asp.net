<%@Page Language="VB"%>

<!-- register the user control that contains the detection code -->
<%@Register TagPrefix="dda" TagName="GetClientType" Src="../global/client-detect.ascx" %>

<!-- insert user control into the page -->
<dda:GetClientType id="ClientDetect" runat="server" />

<script language="VB" runat="server">

Sub Page_Load()
  Select Case ClientDetect.ClientType
    Case 0  'not supported
      Response.Clear
      Response.ContentType = "text/text"
      Response.Write("Sorry, this application does not support your client type: " & Request.UserAgent)
      Response.End
    Case 2  'IE 4.x
      Response.Clear
      Response.Redirect("client-script-check.aspx?client=ie4")
      Response.End
    Case 3  'IE 5.x and above
      Response.Clear
      Response.Redirect("client-script-check.aspx?client=ie5")
      Response.End
    Case 4, 5  'small-screen HTML device or WML client
      Response.Clear
      Server.Transfer("mobile/default.aspx")
    Case Else  'assume HTML 3.2 client
      Response.Clear
      Response.Redirect("client-script-check.aspx?client=html32")
      Response.End
  End Select
End Sub

</script>
