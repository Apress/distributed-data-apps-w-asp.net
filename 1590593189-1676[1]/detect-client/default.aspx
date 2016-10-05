<%@Page Language="VB"%>

<!-- register the user control that contains the detection code -->
<%@Register TagPrefix="dda" TagName="GetClientType" Src="../global/client-detect.ascx" %>

<!-- insert user control into the page -->
<dda:GetClientType id="ClientDetect" runat="server" />

<script language="VB" runat="server">

Sub Page_Load()

  'set a Session variable to see if sessions are supported
  'by checking if it exists when the next page is loaded
  Session("Supported") = "Yes"

  'redirect depending on the client type
  Select Case ClientDetect.ClientType
    Case 0  'not supported
      Response.Clear
      Response.ContentType = "text/text"
      Response.Write("Sorry, this application does not support your client type: " & Request.UserAgent)
      Response.End
    Case 2  'IE 4.x
      Response.Clear
      Response.Redirect("client-script-check.aspx?target=homepage-ie4.aspx")
      Response.End
    Case 3  'IE 5.x and above
      Response.Clear
      Response.Redirect("client-script-check.aspx?target=homepage-ie5.aspx")
      Response.End
    Case 4  'small-screen HTML device
      Response.Clear
      Response.Redirect("client-script-check.aspx?target=homepage-ppc.aspx")
      Response.End
    Case 5  'WML-supported mobile phone client
      Response.Clear
      Response.Redirect("homepage-wml.aspx")
      Response.End
    Case Else  'assume HTML 3.2 client
      Response.Clear
      Response.Redirect("client-script-check.aspx?target=homepage-html.aspx")
      Response.End
  End Select
End Sub

</script>
