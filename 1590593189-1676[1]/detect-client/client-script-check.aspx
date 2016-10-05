<%@Page Language="VB"%>

<%
Dim strClientPage As String = Request.QueryString("target")
%>
<!----------------- page content --------------------->

<html>
<head>
<meta http-equiv="refresh" content="1;url=<% = strClientPage %>" />
<title>Checking for Active Scripting Support</title>

<script language="JavaScript">
<!--
function jumpScripting() {
// jump to page using client-side JavaScript - if jump not executed
// then client does not have scripting available or it is disabled
window.location.href='<% = strClientPage %>?script=yes';
}
//-->
</script>

</head>
<body onload="jumpScripting()">
<font size="2" face="Tahoma,Arial,sans-serif">Checking support
for Active Scripting... </font>
</body>
</html>
