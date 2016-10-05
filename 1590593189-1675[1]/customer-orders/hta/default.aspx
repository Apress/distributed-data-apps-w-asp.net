<%@Page Language="C#" %>

<html>
<head>
<title>View Customer Orders using a Hypertext Application</title>
<style type="text/css">
body, li {font-family:Tahoma,Arial,sans-serif; font-size:10pt;}
div {font-family:Tahoma,Arial,sans-serif; font-size:14pt; font-weight:bold;
     padding:20; color:gainsboro; background-color:darkgreen}
</style>
</head>
<body>
<div align="center">View Customer Orders using a Hypertext Application</div><p />

<b>Note</b> that this example uses an Internet Explorer Hypertext Application (HTA).
This allows the data to be stored locally on your machine (in your C:\Temp folder),
and so the application can be used when your machine is not connected to the network.
Click the first link below to start the application. You will be prompted to run or
save the page. To run it from our server directly, select <b>Open</b>.<p />

If you want to be able to run the application when not connected to the Internet,
you must save the pages to a local Web Server on your machine. You need to do this
with both the start page (<b>customer-list.hta</b>) and the order-list page
(<b>view-orders.hta</b>). The easiest way is to click the second link below to download
a ZIP file containing the two pages. Unzip this file and place the pages in a folder
within your Web site's <b>WWWRoot</b> folder. Then, to run the application locally,
open it in Internet Explorer from the folder where you saved the files using:
'<b>http://localhost/..[folder-name]../customers.hta</b>'.<p />

<ul>
<li><a href="customer-list.hta"><b>Run</b> the Customer Orders application</a></li>
<li><a href="customer-list.zip"><b>Download</b> the Customer Orders application</a></li>
</ul>

</body>
</html>
