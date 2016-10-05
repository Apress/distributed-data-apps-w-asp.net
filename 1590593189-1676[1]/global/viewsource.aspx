<%@ Page Language="VB" %>
<%@ Import Namespace="System.IO" %>

<%
Dim strURL, strFilePath, strNameOnly, strHrefPath, strCompSrc, strCompPath As String
strURL = Request.URLReferrer.AbsolutePath
If strURL > "" Then
  strHrefPath = Left(strURL, InStrRev(strURL, "/"))
  strFilePath = Server.MapPath(strURL.Replace("%20", " "))
  strFilePath = Server.URLDecode(strFilePath)
  strNameOnly = Mid(strFilePath, InStrRev(strFilePath, "\") + 1)
End If
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

'response.write(strHrefPath)


If InStr(strFilePath, "\") > 0 Then
  strCompSrc = Request.QueryString("compsrc")
  If Len(strCompSrc) > 0 Then
    Dim QUOT As String = Chr(34)
    strCompPath = strHrefPath & "source\" & strCompSrc & ".txt"
    Response.Write("<div align=" & QUOT & "right" & QUOT & " class=" & QUOT & "cite" _
                 & QUOT & ">[<a href=" & QUOT & strCompPath & QUOT _
                 & ">view source for component</a>]</div><hr />")
  End If
  Response.Write("<xmp>")
  Response.WriteFile(strFilePath)
  Response.Write("</xmp>")
End If
%>

<!--------------------------------------------------------------------------->

<!-- #include file="../global/foot.inc" -->
</body>
</html>
