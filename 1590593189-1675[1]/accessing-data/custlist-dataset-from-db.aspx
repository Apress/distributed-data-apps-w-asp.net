<%@Page Language="C#" EnableViewState="false" %>
<%@Import Namespace="OrderListData" %>
<%@Import Namespace="System.Data" %>

<!------------------ HTML page content --------------------->

<html>
<head>
<title>Customer List : DataSet from Relational Database</title>
<!-- #include file="../global/style.inc" -->
</head>
<body>

<div class="heading">Customer List : DataSet from Relational Database</div>

<div align="right" class="cite">
[<a href="../global/viewsource.aspx?compsrc=order-list-data.cs">view page source</a>]
</div><br />

<form runat="server">
  <asp:RadioButton id="optByID" groupname="SearchBy" Align="right"
                   text="Search by Customer ID: " runat="server" checked="true" />
  <asp:TextBox id="txtCustID" columns="5" maxlength="5"
               runat="server" text="ALFK" /> &nbsp; or &nbsp;
  <asp:RadioButton id="optByName" groupname="SearchBy" Align="right"
                   text="Search by Customer Name:" runat="server" />
  <asp:TextBox id="txtCustName" columns="25" maxlength="40" runat="server" text="super" />
  <asp:Button text="Go" runat="server" />
</form>

<asp:Label id="lblMessage" runat="server" />

<asp:DataGrid id="dgrCustomers" runat="server">
<HeaderStyle BackColor="#c0c0c0"></HeaderStyle>
<AlternatingItemStyle BackColor="#eeeeee"></AlternatingItemStyle>
</asp:DataGrid><br />


<!-- #include file="../global/foot.inc" -->
</body>
</html>

<!-------------- server-side script section ---------------->

<script language="C#" runat="server">

void Page_Load() {

  String strCustID = "";
  String strCustName = "";

  // get one or other value from text boxes depending on selection
  if (optByID.Checked)
    strCustID = txtCustID.Text;
  else
    strCustName = txtCustName.Text;

  // get connection string from web.config
  String strConnect = ConfigurationSettings.AppSettings["NorthwindConnectString"];

  try {

    // create an instance of the data access component
    OrderList objOrderList = new OrderList(strConnect);

    // create a variable to hold a DataSet object
    DataSet objDataSet;

    // call the method to return the data as a DataSet
    objDataSet = objOrderList.GetCustomerByIdOrName(strCustID, strCustName);

    if (objDataSet.Tables[0].Rows.Count > 0) {

      dgrCustomers.DataSource = objDataSet.Tables[0];
      dgrCustomers.DataBind();

    }
    else

      lblMessage.Text = "No matching customers found in database ...";

  }
  catch(Exception objErr) {

    // there was an error and no data will be returned
    lblMessage.Text = "ERROR: No data returned. " + objErr.Message;

  }

}

</script>

<!---------------------------------------------------------->
