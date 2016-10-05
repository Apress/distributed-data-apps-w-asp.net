<%@Page Language="C#" %>
<%@Import Namespace="SupplierListDB" %>

<!------------------ HTML page content --------------------->

<html>
<head>
<title>Supplier List : Array from Relational Database</title>
<!-- #include file="../global/style.inc" -->
</head>
<body>

<div class="heading">Supplier List : Array from Relational Database</div>

<div align="right" class="cite">
[<a href="../global/viewsource.aspx?compsrc=get-supplier-data.cs">view page source</a>]
</div><br />

<asp:Label id="lblMessage" runat="server" />

<//-- #include file="../global/foot.inc" -->
</body>
</html>

<!-------------- server-side script section ---------------->

<script language="C#" runat="server">

void Page_Load() {

  // get connection string from web.config
  String strConnect = ConfigurationSettings.AppSettings["NorthwindConnectString"];

  // declare a varable to hold the array returned from the method
  String[,] arrResult;

  // declare varable to hold number of rows in array returned
  // specify that we only want the first 10
  int intRowCount = 10;

  try {

    // create an instance of the data access component
    SupplierList objSupplierList = new SupplierList(strConnect);

    // call the method to return the data as an Array and
    // specify we only want a maximum of 10 items
    arrResult = objSupplierList.GetSuppliersArray(ref intRowCount);

  }
  catch(Exception objErr) {

     // there was an error and no data will be returned
     lblMessage.Text = "ERROR: No data returned. " + objErr.Message;

     return;   // and stop processing here

  }

  // iterate through array to display values returned
  String strResult = "";  // to hold results for display
  int intRow;             // to hold column iterator

  for (intRow = 0; intRow <= intRowCount; intRow++) {
    strResult += "<b>" + arrResult[0, intRow] + "</b><br />"
              + "* Address: " + arrResult[1, intRow] + "<br />"
              + "* Contact: " + arrResult[2, intRow] + "<p />";
  }

  lblMessage.Text = strResult;  // assign result string to Label control

}

</script>

<!---------------------------------------------------------->
