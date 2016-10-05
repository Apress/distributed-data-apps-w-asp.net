<%@Page Language="C#" %>

<!-- register the user control that contains the detection code -->
<%@Register TagPrefix="dda" TagName="GetClientType" Src="../global/client-detect.ascx" %>

<!-- insert user control into the page -->
<dda:GetClientType id="ClientDetect" runat="server" />

<script language="C#" runat="server">

void Page_Load() {

  Session["Supported"] = "yes";

  switch(ClientDetect.ClientType()) {
    case 2:  // IE 4.x
      Response.Clear();
      Server.Transfer("homepage-ie4.aspx");
      break;
    case 3:  // IE 5.x and above
      Response.Clear();
      Server.Transfer("homepage-ie5.aspx");
      break;
    case 4:  // small-screen HTML device
      Response.Clear();
      Server.Transfer("homepage-ppc.aspx");
      break;
    case 5:  // WML client
      Response.Clear();
      Server.Transfer("homepage-wml.aspx");
      break;
    default: // assume HTML 3.2 client
      Response.Clear();
      Server.Transfer("homepage-html.aspx");
      break;
  }
}

</script>
