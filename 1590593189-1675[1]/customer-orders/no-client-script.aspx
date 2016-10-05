<%@Page Language="C#"%>

<%
String strClientType = Request.QueryString["client"]
%>
<!----------------- page content --------------------->

<html>
<head>
<title>Client-side Scripting Not Available</title>
</head>
<body>

<h3><font size="4" face="Tahoma,Arial,sans-serif">
Client-side Scripting Not Available</font></h3>

<font size="2" face="Tahoma,Arial,sans-serif" color="#ff0000">
<b>Please note:</b></font><br />
<font size="2" face="Tahoma,Arial,sans-serif">Your browser does
not support Active Scripting or client-side JavaScript, or it is
disabled in your security settings. For best results, you should
enable this before using the application. If not, you can instead
use the simplified version of the application designed for portable
and small-screen devices.</font>
<ul>
<li><font size="2" face="Tahoma,Arial,sans-serif">I have
    <a href="<% = strClientType %>/default.aspx">enabled client-side scripting</a>
    and I want to use the default version of the application</font></li>
<li><font size="2" face="Tahoma,Arial,sans-serif">I will
    <a href="html32/default.aspx">use the standard HTML 3.2 version</a>
    of the application</font></li>
<li><font size="2" face="Tahoma,Arial,sans-serif">I will
    <a href="mobile/default.aspx">use the simplified version</a>
    of the application designed for portable devices</font></li>
</ul>

</body>
</html>
