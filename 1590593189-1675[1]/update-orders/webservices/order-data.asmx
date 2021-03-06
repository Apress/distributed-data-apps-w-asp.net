<%@WebService Language="C#" Class="UpdateOrders"%>

using DataSetUpdate;
using System;
using System.Data;
using System.Xml;
using System.Web;
using System.Web.Services;
using System.Configuration;

[WebService(Description="4923 Update Orders Service",
   Namespace="http://www.daveandal.net/books/webservices/4923/update-orders")]

public class UpdateOrders {

//------------------------------------------------------------------

[WebMethod] public DataSet GetOrdersDataSet(String strCustID) {
// uses data access component to get DataSet containing matching order details

  DataSet objDataSet;

  try {

    // get connection string from web.config <appSettings> section
    String strConnect = ConfigurationSettings.AppSettings["NorthwindConnectString"];

    // create an instance of the data access component
    UpdateDataSet objOrderUpdate = new UpdateDataSet(strConnect);

    // call component to get DataSet containing order details for customer
    objDataSet = objOrderUpdate.GetOrderDetails(strCustID);

    // add column containing total value of each line in OrderLines table
    DataTable objLinesTable = objDataSet.Tables["Order Details"];
    DataColumn objColumn = objLinesTable.Columns.Add("LineTotal", System.Type.GetType("System.Double"));
    objColumn.Expression = "[Quantity] * ([UnitPrice] - ([UnitPrice] * [Discount]))";

    // return the DataSet to the calling routine
    return objDataSet;

  }
  catch (Exception objErr) {

    // there was an error so no data is returned
    return null;
  }
}
//--------------------------------------------------------------

[WebMethod] public DataSet GetShippersDataSet() {
// uses data access component to get DataSet containing all shipper details

  try {

    // get connection string from web.config <appSettings> section
    String strConnect = ConfigurationSettings.AppSettings["NorthwindConnectString"];

    // create an instance of the data access component
    UpdateDataSet objOrderUpdate = new UpdateDataSet(strConnect);

    // call component to get DataSet containing shipper details
    return objOrderUpdate.GetShippersDataSet();
  }
  catch (Exception objErr) {

    // there was an error so no data is returned
    return null;
  }
}
//--------------------------------------------------------------

[WebMethod] public DataSet GetProductsDataSet() {
// uses data access component to get DataSet containing all product details

  try {

    // get connection string from web.config <appSettings> section
    String strConnect = ConfigurationSettings.AppSettings["NorthwindConnectString"];

    // create an instance of the data access component
    UpdateDataSet objOrderUpdate = new UpdateDataSet(strConnect);

    // call component to get DataSet containing product list
    return objOrderUpdate.GetProductsDataSet();
  }
  catch (Exception objErr) {

    // there was an error so no data is returned
    return null;
  }
}
//--------------------------------------------------------------

[WebMethod] public DataSet UpdateAllOrders(String strCustID, String strDiffGram) {
// uses data access component to update all edits to orders when
// client is a Web Browser sending updates via a DiffGram as a String

  // while Web Services support DataSet objects directly, the IE5
  // Web Service Behavior (Beta) does not, so data is sent to the
  // server as an HTMLEncoded string we have to decode
  strDiffGram = HttpUtility.HtmlDecode(strDiffGram);

  // create new DataSet to load diffgram
  DataSet objDataSet = new DataSet();

  try {

    // read the schema into the DataSet from file on disk
    // must use the Physical path to the file not the Virtual path
    // need reference to a Request object to use MapPath method
    HttpContext m_Context = HttpContext.Current;
    objDataSet.ReadXmlSchema(m_Context.Request.MapPath("orders-schema.xsd"));
  }
  catch (Exception objErr) {
  }

  try {

    // create an XmlTextReader to read data sent from client
    // specifying that string fragment is an XML Document
    XmlTextReader objReader = new XmlTextReader(strDiffGram, XmlNodeType.Document, null);

    // read in the DiffGram posted from the client
    objDataSet.ReadXml(objReader, XmlReadMode.DiffGram);
  }
  catch (Exception objErr) {
  }

  // *********************************************************
  // kludge required to get correct RowState values in DataSet
  objDataSet = objDataSet.GetChanges();
  // *********************************************************

  try {

    // get connection string from web.config <appSettings> section
    String strConnect = ConfigurationSettings.AppSettings["NorthwindConnectString"];

    // create an instance of the data access component
    UpdateDataSet objOrderUpdate = new UpdateDataSet(strConnect);

    // call  to do updates and return all rows
    // (due to kludge above, we can't return all rows)
    return objOrderUpdate.UpdateAllOrderDetails(strCustID, ref objDataSet);
  }
  catch (Exception objErr) {

    // there was an error
    return objDataSet;
  }
}
//------------------------------------------------------------------

}
