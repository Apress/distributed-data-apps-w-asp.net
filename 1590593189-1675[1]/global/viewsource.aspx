<%@ Page Language="C#"%>
<%@ Import Namespace="System.IO" %>

<%
String strURL, strFilePath, strNameOnly, strHrefPath, strCompSrc, strCompPath;
strURL = Request.UrlReferrer.AbsolutePath;
strHrefPath = strURL.Substring(0, strURL.LastIndexOf("/") + 1);
strFilePath = Server.MapPath(strURL);
strNameOnly = strFilePath.Substring(strFilePath.LastIndexOf("\\") + 1);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title><% = strNameOnly %></title>
<style type="text/css">
body {font-family:Tahoma,Arial,sans-serif; font-size:10pt}
input {font-family:Tahoma,Arial,sans-serif; font-size:9pt}
.heading {font-family:Tahoma,Arial,sans-serif; font-size:14pt; font-weight:bold}
.subhead {font-family:Tahoma,Arial,sans-serif; font-size:12pt; font-weight:bold; padding-bottom:5px}
.cite {font-family:Tahoma,Arial,sans-serif; font-size:8pt}
</style>
</head>
<body bgcolor="#ffffff">
<span class="heading"><% = strNameOnly %></span>
<!--------------------------------------------------------------------------->

<%

if (strFilePath.IndexOf("\\") > 0) {
  strCompSrc = Request.QueryString["compsrc"];
  if (strCompSrc != null && strCompSrc.Length > 0) {
    strCompPath = strHrefPath + "source\\" + strCompSrc + ".txt";
    Response.Write("<div align='right' class='cite'>[<a href='" + strCompPath
                 + "'>view source for component</a>]</div><hr />");
  }
  Response.Write("<xmp>");
  Response.WriteFile(strFilePath);
  Response.Write("</xmp>");
}
%>

<!--------------------------------------------------------------------------->

<!-- #include file="../global/foot.inc" -->
</body>
</html>
