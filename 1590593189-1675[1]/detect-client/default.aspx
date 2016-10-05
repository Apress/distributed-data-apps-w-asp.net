<%@Page Language="C#"%>

<!-- register the user control that contains the detection code -->
<%@Register TagPrefix="dda" TagName="GetClientType" Src="../global/client-detect.ascx" %>

<!-- insert user control into the page -->
<dda:GetClientType id="ClientDetect" runat="server" />

<script language="C#" runat="server">

void Page_Load() {

  // set a Session variable to see if sessions are supported
  // by checking if it exists when the next page is loaded
  Session["Supported"] = "yes";

  // redirect depending on the client type
  switch (ClientDetect.ClientType()) {
    case 0: { // not supported
      Response.Clear();
      Response.ContentType = "text/text";
      Response.Write("Sorry, this application does not support your client type: " + Request.UserAgent);
      Response.End();
      break;
    }
    case 2: {  // IE 4.x
      Response.Clear();
      Response.Redirect("client-script-check.aspx?target=homepage-ie4.aspx");
      Response.End();
      break;
    }
    case 3: {  // IE 5.x and above
      Response.Clear();
      Response.Redirect("client-script-check.aspx?target=homepage-ie5.aspx");
      Response.End();
      break;
    }
    case 4: {  // small-screen HTML device
      Response.Clear();
      Response.Redirect("client-script-check.aspx?target=homepage-ppc.aspx");
      Response.End();
      break;
    }
    case 5: {  // WML-supported mobile phone client
      Response.Clear();
      Response.Redirect("homepage-wml.aspx");
      Response.End();
      break;
    }
    default: {  // assume HTML 3.2 client
      Response.Clear();
      Response.Redirect("client-script-check.aspx?target=homepage-html.aspx");
      Response.End();
      break;
    }
  }
}

</script>
