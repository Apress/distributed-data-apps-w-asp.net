<%@Page Language="C#" %>

<html>
<head>
<title>View Customer Orders via Windows Forms Remoting</title>
<style type="text/css">
body, li {font-family:Tahoma,Arial,sans-serif; font-size:10pt;}
div {font-family:Tahoma,Arial,sans-serif; font-size:14pt; font-weight:bold;
     padding:20; color:gainsboro; background-color:darkblue}
</style>
</head>
<body>
<div align="center">View Customer Orders via Windows Forms Remoting</div><p />

<b>Note</b> that this example uses a .NET <b>Windows Forms</b> executable
application that runs on the client and communicates with the server via
<b>Web Services</b>. You can run it directly from the browser, which is just like
downloading any other application. However, because
the application will be running from your local disk, the .NET Security Framework
gives the application full rights. Even those full rights are granted,
the application doesn't do anything apart from load data via a web services.
</p>

<a href="UpdateableRemoteFormsApplication/bin/RemForm.exe">Run the application</a>


</body>
</html>
