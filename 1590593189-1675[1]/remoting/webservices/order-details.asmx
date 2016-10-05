<%@WebService Language="C#" Class="RemotingOrders"%>

using System;
using System.Data;
using System.Data.OleDb;
using System.Xml;
using System.Web;
using System.Web.Services;
using System.Configuration;
//using UpdateDataSet;
using Wrox4923DataSetUpdate;

[WebService(Description="4923 Remoting Orders Service", 
 Namespace="http://www.wrox.com/webservices/4923/remoting")]
public class RemotingOrders
{
	//------------------------------------------------------------------
	// uses data access component to get DataSet containing matching order details

	[WebMethod]
	public DataSet Orders(string strCustID)
	{
		DataSet objDataSet;

		try
		{
			// get connection string from web.config <appSettings> section
			string strConnect = ConfigurationSettings.AppSettings["NorthwindConnectString"];

			// create an instance of the data access component
			UpdateDataSet objOrderUpdate = new Wrox4923DataSetUpdate.UpdateDataSet(strConnect);

			// call component to get DataSet containing order details for customer
			objDataSet = objOrderUpdate.GetOrderDetails(strCustID);

			// add column containing total value of each line in OrderLines table
			DataTable objLinesTable  = objDataSet.Tables["Order Details"];
			DataColumn objColumn = objLinesTable.Columns.Add("LineTotal", System.Type.GetType("System.Double"));
			objColumn.Expression = "[Quantity] * ([UnitPrice] - ([UnitPrice] * [Discount]))";

			// set the Nested property of the relationship between the tables so they
			// are appropriately linked (OrderLines nested within each Order)
			objDataSet.Relations[0].Nested = true;

			// add autoincrement details, so the dataset handles
			// new values correctly. Using 0 & -1 ensures that new order IDs
			// don't clash with existing ones. The database will generate correct IDs
			// during update, and these are flushed back to the dataset
			objColumn = objDataSet.Tables["Orders"].Columns["OrderID"];
			objColumn.AutoIncrement = true;
			objColumn.AutoIncrementStep = -1;
			objColumn.AutoIncrementSeed = 0;
			objColumn.AllowDBNull = false;
			objColumn.Unique = true;


			// return the DataSet to the calling routine
			return objDataSet;
		}
		catch (Exception objErr)
		{
			// there was an error so no data is returned
			return null;
		}
	}

	//--------------------------------------------------------------
	// uses data access component to get DataSet containing all shipper details
	// and all product details
	// This allows us to ship one dataset containing all of the look up information

	[WebMethod]
	public DataSet Lookups()
	{
		try
		{
			// get connection string from web.config <appSettings> section
			string strConnect = ConfigurationSettings.AppSettings["NorthwindConnectString"];

			// create an instance of the data access component
			UpdateDataSet objOrderUpdate = new Wrox4923DataSetUpdate.UpdateDataSet(strConnect);

			// call component to get DataSet containing shipper details
			DataSet dsLookups = objOrderUpdate.GetShippersDataSet();

			// now add more data for other lookups
			dsLookups.Merge (objOrderUpdate.GetProductsDataSet());


			return dsLookups;
		}
		catch (Exception objErr)
		{
			// there was an error so no data is returned
			return null;
		}
	}


	//--------------------------------------------------------------
	// uses data access component to get DataSet containing all shipper details

	[WebMethod]
	public DataSet UpdateOrders(string strCustID, DataSet objDataSet)
	{
		// kludge required to get correct RowState values in DataSet
		objDataSet = objDataSet.GetChanges();


		// get connection string from web.config <appSettings> section
		string strConnect = ConfigurationSettings.AppSettings["NorthwindConnectString"];

		// create an instance of the data access component
		UpdateDataSet objOrderUpdate = new Wrox4923DataSetUpdate.UpdateDataSet(strConnect);

		// call function to do updates and return error rows only
		return objOrderUpdate.UpdateAllOrderDetails(strCustID, ref objDataSet);
	}
}