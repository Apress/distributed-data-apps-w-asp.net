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
<title>Page for Internet Explorer 5.x and Above</title>
<style type="text/css">
body,td {font-family:Tahoma,Arial,sans-serif; font-size:10pt}
div {font-family:Tahoma,Arial,sans-serif; font-size:14pt; font-weight:bold;
     padding:20; color:gainsboro; background-color:darkblue}
</style>
</head>
<body>
<p align="center"><a href="http://www.microsoft.com/ie/"><img src="ie5.jpg" border="0"/></a></p>
<div align="center">Page for Internet Explorer 5.x and Above</div><p />

<table border="0" width="95%">
<tr><td>
<ul>
<li>User-Agent Name: <b><% = Request.Browser.Browser %></b></li>
<li>Browser Type: <b><% = Request.Browser.Type %></b></li>
<li>Version Number: <b><% = Request.Browser.Version %></b></li>
<li>MajorVersion Part: <b><% = Request.Browser.MajorVersion %></b></li>
<li>MinorVersion Part: <b><% = Request.Browser.MinorVersion %></b></li>
<li>America Online (AOL) browser: <b><% = Request.Browser.AOL %></b></li>
<li>Beta Version: <b><% = Request.Browser.Beta %></b></li>
<li>Web Crawler: <b><% = Request.Browser.Crawler %></b></li><p />
<li>Supports ECMAScript Version: <b><% = Request.Browser.EcmaScriptVersion %></b></li>
<li>Microsoft HTML DOM Version: <b><% = Request.Browser.MSDomVersion %></b></li>
<li>W3C XML DOM Version: <b><% = Request.Browser.W3CDomVersion %></b></li>
<li>.NET CLR Version: <b><% = Request.Browser.ClrVersion %></b></li><p />
<li>JavaScript Enabled: <b><asp:Label id="lblScripting" runat="server" /></b></li><p />
<ul>
</td><td>
<ul>
<li>Supports HTML Tables: <b><% = Request.Browser.Tables %></b></li>
<li>Supports HTML Frames: <b><% = Request.Browser.Frames %></b></li>
<li>Supports Cookies: <b><% = Request.Browser.Cookies %></b></li>
<li>Supports Background Sounds: <b><% = Request.Browser.BackgroundSounds %></b></li>
<li>Supports Channel Definition Format (CDF): <b><% = Request.Browser.CDF %></b></li>
<li>Supports JavaScript: <b><% = Request.Browser.JavaScript %></b></li>
<li>Supports VBScript: <b><% = Request.Browser.VBScript %></b></li>
<li>Supports ActiveX Controls: <b><% = Request.Browser.ActiveXControls %></b></li>
<li>Supports Java Applets: <b><% = Request.Browser.JavaApplets %></b></li><p />
<li>O/S Platform: <b><% = Request.Browser.Platform %></b></li>
<li>Is 16-bit Windows: <b><% = Request.Browser.Win16 %></b></li>
<li>Is 32-bit Windows: <b><% = Request.Browser.Win32 %></b></li><p />
<li>ASP.NET Session Support Enabled: <b><asp:Label id="lblSessions" runat="server" /></b></li>
</ul>
</td></tr>
<tr><td colspan="2">
<ul>
<li>Current Execution Path: <b><% = Request.CurrentExecutionFilePath %></b></li>
<li>Complete User-Agent String: <b><% = Request.UserAgent %></b></li>
</ul>
</td></tr>
</table>

</body>
</html>
