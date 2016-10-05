<%@Page Language="C#" %>

<script language="C#" runat="server">
void Page_Load() {

  // see if scripting is supported
  if (Request.QueryString["script"] == "yes")
    lblScripting.Text = "True";
  else
    lblScripting.Text = "False";

  // see if sessions are supported
  if ((String) Session["Supported"] == "Yes")
    lblSessions.Text = "True";
  else
    lblSessions.Text = "False";

}
</script>

<html>
<head>
<title>Page for Small-screen HTML Devices</title>
<style type="text/css">
body,td {font-family:Tahoma,Arial,sans-serif; font-size:9pt}
div {font-family:Tahoma,Arial,sans-serif; font-size:10pt; font-weight:bold;
     padding:10; color:gainsboro; background-color:darkgreen}
</style>
</head>
<body>
<p><img src="ppc.jpg" /></p>
<div>Page for Small-screen HTML Devices</div><p />

User-Agent Name: <b><% = Request.Browser.Browser %></b><br />
Browser Type: <b><% = Request.Browser.Type %></b><br />
Version Number: <b><% = Request.Browser.Version %></b><br />
MajorVersion Part: <b><% = Request.Browser.MajorVersion %></b><br />
MinorVersion Part: <b><% = Request.Browser.MinorVersion %></b><br />
America Online (AOL) browser: <b><% = Request.Browser.AOL %></b><br />
Beta Version: <b><% = Request.Browser.Beta %></b><br />
Web Crawler: <b><% = Request.Browser.Crawler %></b><p />
Supports ECMAScript Version: <b><% = Request.Browser.EcmaScriptVersion %></b><br />
Microsoft HTML DOM Version: <b><% = Request.Browser.MSDomVersion %></b><br />
W3C XML DOM Version: <b><% = Request.Browser.W3CDomVersion %></b><br />
.NET CLR Version: <b><% = Request.Browser.ClrVersion %></b><p />
Supports HTML Tables: <b><% = Request.Browser.Tables %></b><br />
Supports HTML Frames: <b><% = Request.Browser.Frames %></b><br />
Supports Cookies: <b><% = Request.Browser.Cookies %></b><br />
Supports Background Sounds: <b><% = Request.Browser.BackgroundSounds %></b><br />
Supports Channel Definition Format (CDF): <b><% = Request.Browser.CDF %></b><br />
Supports JavaScript: <b><% = Request.Browser.JavaScript %></b><br />
Supports VBScript: <b><% = Request.Browser.VBScript %></b><br />
Supports ActiveX Controls: <b><% = Request.Browser.ActiveXControls %></b><br />
Supports Java Applets: <b><% = Request.Browser.JavaApplets %></b><p />
O/S Platform: <b><% = Request.Browser.Platform %></b><br />
Is 16-bit Windows: <b><% = Request.Browser.Win16 %></b><br />
Is 32-bit Windows: <b><% = Request.Browser.Win32 %></b><p />
JavaScript Enabled: <b><asp:Label id="lblScripting" runat="server" /></b><br />
ASP.NET Session Support Enabled: <b><asp:Label id="lblSessions" runat="server" /></b><p />
Current Execution Path: <b><% = Request.CurrentExecutionFilePath %></b><br />
Complete User-Agent String: <b><% = Request.UserAgent %></b>
</body>
</html>
