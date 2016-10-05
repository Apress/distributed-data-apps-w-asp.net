<%@Page Language="C#"%>

<!-- register the user control that contains the detection code -->
<%@Register TagPrefix="dda" TagName="GetClientType" Src="../global/client-detect.ascx" %>

<!-- insert user control into the page -->
<dda:GetClientType id="ClientDetect" runat="server" />

<script language="C#" runat="server">

void Page_Load() {
  switch (ClientDetect.ClientType()) {
    case 0:  // not supported
      Response.Clear();
      Response.ContentType = "text/text";
      Response.Write("Sorry, this application does not support your client type: " + Request.UserAgent);
      Response.End();
      break;
    case 2:  // IE 4.x
      Response.Clear();
      Response.Redirect("client-script-check.aspx?client=ie4");
      Response.End();
      break;
    case 3:  // IE 5.x and above
      Response.Clear();
      Response.Redirect("client-script-check.aspx?client=ie5");
      Response.End();
      break;
    case 4:  // small-screen HTML device or WML client
    case 5:
      Response.Clear();
      Server.Transfer("mobile/default.aspx");
      break;
    default:  // assume HTML 3.2 client
      Response.Clear();
      Response.Redirect("client-script-check.aspx?client=html32");
      Response.End();
      break;
  }
}

</script>
