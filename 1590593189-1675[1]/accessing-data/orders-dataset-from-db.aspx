<%@Page Language="C#" EnableViewState="false" %>
<%@Import Namespace="OrderListData" %>
<%@Import Namespace="System.Data" %>

<!------------------ HTML page content --------------------->

<html>
<head>
<title>Order Details : Related DataSet from Relational Database</title>
<!-- #include file="../global/style.inc" -->
</head>
<body>

<div class="heading">Order Details : Related DataSet from Relational Database</div>

<div align="right" class="cite">
[<a href="../global/viewsource.aspx?compsrc=order-list-data.cs">view page source</a>]
</div><br />

<form runat="server">
  Customer ID:
  <asp:TextBox id="txtCustID" columns="5" maxlength="5" runat="server" text="ALFK%" />
  <asp:Button text="Go" runat="server" /> &nbsp;  &nbsp; Show as:
  <asp:RadioButton id="optTables" groupname="ShowAs" text="Tables"
                   autopostback="true" runat="server" checked="true" />
  <asp:RadioButton id="optList" groupname="ShowAs" text="List"
                   autopostback="true" runat="server" />
</form>

<asp:Label id="lblMessage" runat="server" />

<asp:DataGrid id="dgrOrders" runat="server">
<HeaderStyle BackColor="#c0c0c0"></HeaderStyle>
<AlternatingItemStyle BackColor="#eeeeee"></AlternatingItemStyle>
</asp:DataGrid><br />

<asp:DataGrid id="dgrOrderLines" runat="server">
<HeaderStyle BackColor="#c0c0c0"></HeaderStyle>
<AlternatingItemStyle BackColor="#eeeeee"></AlternatingItemStyle>
</asp:DataGrid><br />

<b>
<asp:Hyperlink NavigateUrl="custlist-dataset-from-db.aspx"
              Text="Search for customers..." runat="server" />
</b>

<!-- #include file="../global/foot.inc" -->
</body>
</html>

<!-------------- server-side script section ---------------->

<script language="C#" runat="server">

void Page_Load() {

  // get customer ID to use in stored procs from text box
  String strCustID  = txtCustID.Text;

  // get connection string from web.config
  String strConnect = ConfigurationSettings.AppSettings["NorthwindConnectString"];

  // declare variable to hold instance of DataSet object
  DataSet objDataSet;

  try {

    // create an instance of the data access component
    OrderList objOrderList = new OrderList(strConnect);

    // call the method to return the data as a DataSet
    objDataSet = objOrderList.GetOrdersByCustomerDataSet(strCustID);

    if (optTables.Checked == true) {   // show as separate tables of data

      // assign table named Orders to first DataGrid server control
      dgrOrders.DataSource = objDataSet.Tables["Orders"];

      // assign table named OrderLines to second DataGrid server control
      dgrOrderLines.DataSource = objDataSet.Tables["OrderLines"];

      if (dgrOrders.DataSource != null) Page.DataBind();

    }
    else {  // show as a nested list

      // create a variable to hold the results for display
      String strResult = "";

      // create a reference to the Orders (parent) table in the DataSet
      DataTable objTable = objDataSet.Tables["Orders"];

      // create reference to the relationship object in the DataSet
      DataRelation objRelation  = objTable.ChildRelations["CustOrderLines"];

      // declare variables to hold row objects and an array of rows
      //DataRow objRow, objChildRow;
      DataRow[] colChildRows;

      // iterate through the rows in the Orders table
      foreach (DataRow objRow in objTable.Rows) {

        // get the order details and append them to the "results" string
        strResult += "<b>" + objRow["ShipName"] + "</b> ("
          + objRow["CustomerID"] + ")<br />&nbsp; Order ID: " + objRow["OrderID"]
          + " &nbsp; Order Date: " + objRow["OrderDate"].ToString() + "<br />&nbsp; ";

        if (objRow["ShippedDate"] == DBNull.Value)
          strResult += "Awaiting shipping";
        else
          strResult += "Shipped: " + objRow["ShippedDate"].ToString();

        strResult += " via " + objRow["CompanyName"] + "<br />"
          + " &nbsp; To: " + objRow["OrderAddress"] + "<br />";

        // get a collection (array) of all the matching OrderLines rows for this row
        colChildRows = objRow.GetChildRows(objRelation);

        // iterate through all the matching OrderLines rows adding to the result string
        foreach (DataRow objChildRow in colChildRows) {
           strResult += "  &nbsp;  &nbsp; " + objChildRow["Quantity"] + " ("
             + objChildRow["QuantityPerUnit"] + ") " + objChildRow["ProductName"]
             + " at " + objChildRow["UnitPrice"].ToString() + " less "
             + objChildRow["Discount"].ToString() + "<br />";
        }

        strResult += "<br />";

      }
      lblMessage.Text = strResult;  // display the results
    }
  }
  catch (Exception objErr) {

    // there was an error and no data will be returned
    lblMessage.Text = "ERROR: No data returned. " + objErr.Message;

  }

}

</script>

<!---------------------------------------------------------->
