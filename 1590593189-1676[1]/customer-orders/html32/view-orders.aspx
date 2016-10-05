<%@Page Language="VB"%>

<!-------------- server-side script section ---------------->

<%
'get value of customer ID and specify in the query string
'for the page in the left-hand frame
Dim strCustID As String = Request.QueryString("customerid")
%>

<!------------------ HTML frameset --------------------->

<html>

<head>
<title>View Customer Orders - View Order Details</title>
</head>

<frameset rows="*,60" frameborder="0">
  <frameset cols="320,*" frameborder="0">
    <frame name="left" src="order-list.aspx?customerid=<% = strCustID %>"
           frameborder="0" />
    <frame name="right" src="order-detail.aspx"
           frameborder="0" />
  </frameset>
  <frame src="footer.htm" frameborder="0" scrolling="no"/>
</frameset>

<noframes>
<font size="2" face="Tahoma,Arial,sans-serif">
This page requires HTML Frames support. As your browser does
not support<br />frames, you should use the <b>
<a href="../mobile/default.aspx">simplified version</a></b>
of the application instead.</font>
</noframes>

</html>
