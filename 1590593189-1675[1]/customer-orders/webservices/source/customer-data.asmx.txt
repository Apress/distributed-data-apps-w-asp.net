<%@WebService Language="C#" Class="CustomerOrders"%>

using OrderListData;
using System;
using System.Data;
using System.Web;
using System.Web.Services;
using System.Configuration;

[WebService(Description="4923 Customer Orders Service",
  Namespace="http://www.daveandal.com/webservices/4923/customer-orders")]

public class CustomerOrders {

// ------------------------------------------------------------------

[WebMethod] public DataSet GetCustomers(String strCustID, String strCustName) {
// uses data access component to get DataSet containing matching customer details

  try {

    // get connection string from web.config <appSettings> section
    String strConnect = ConfigurationSettings.AppSettings["NorthwindConnectString"];

    // create an instance of the data access component
    OrderList objOrderList = new OrderList(strConnect);

    // call the method to return the data as a DataSet
    return objOrderList.GetCustomerByIdOrName(strCustID, strCustName);
  }
  catch (Exception objErr) {

    // there was an error so no data is returned
    return null;
  }
}
// ------------------------------------------------------------------

[WebMethod()] public DataSet GetOrders(String strCustID) {
// uses data access component to get DataSet containing matching order details

  DataSet objDataSet;

  try {

    // get connection string from web.config <appSettings> section
    String strConnect = ConfigurationSettings.AppSettings["NorthwindConnectString"];

    // create an instance of the data access component
    OrderList objOrderList = new OrderList(strConnect);

    // call the method to get the data as a DataSet
    objDataSet = objOrderList.GetOrdersByCustomerDataSet(strCustID);

    // add column containing total value of each line in OrderLines table
    DataTable objLinesTable = objDataSet.Tables["OrderLines"];
    DataColumn objColumn = objLinesTable.Columns.Add("LineTotal", System.Type.GetType("System.Double"));
    objColumn.Expression = "[Quantity] * ([UnitPrice] - ([UnitPrice] * [Discount]))";

    // set the Nested property of the relationship between the tables so the XML output
    // is in "nested" form (i.e. appropriate linked OrderLines nested within each Order)
    objDataSet.Relations[0].Nested = true;

    // return the DataSet to the calling routine
    return objDataSet;
  }
  catch (Exception objErr) {

    // there was an error so no data is returned
    return null;
  }
}
// ------------------------------------------------------------------

}
