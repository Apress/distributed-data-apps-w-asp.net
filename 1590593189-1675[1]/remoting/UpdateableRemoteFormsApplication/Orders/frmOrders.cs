using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using System.Data;


namespace Orders
{
	/// <summary>
	/// Summary description for frmOrders.
	/// </summary>
	public class OrdersForm : System.Windows.Forms.Form
	{
		private System.Windows.Forms.DataGridTextBoxColumn UnitPrice;
		private System.Windows.Forms.DataGridTableStyle OrderDetailsStyle;
		internal System.Windows.Forms.Button btnCancelOrderDetails;
		internal System.Windows.Forms.Panel panDates;
		internal System.Windows.Forms.Label lblRequiredDate;
		internal System.Windows.Forms.Label Label2;
		internal System.Windows.Forms.Label Label1;
		internal System.Windows.Forms.Label lblShippedDate;
		internal System.Windows.Forms.TextBox OrderDate;
		internal System.Windows.Forms.TextBox RequiredDate;
		internal System.Windows.Forms.TextBox ShippedDate;
		internal System.Windows.Forms.Button btnDelete;
		internal System.Windows.Forms.DataGrid dgOrders;
		internal System.Windows.Forms.DataGridTableStyle ShippedOrderStyle;
		internal System.Windows.Forms.DataGridTextBoxColumn gcOrderID;
		internal System.Windows.Forms.DataGridTextBoxColumn gcOrderDate;
		internal System.Windows.Forms.DataGridTextBoxColumn gcRequiredDate;
		internal System.Windows.Forms.DataGridTextBoxColumn gcShippedDate;
		internal System.Windows.Forms.Button btnCancelAll;
		internal System.Windows.Forms.Panel panShipAddress;
		internal System.Windows.Forms.TextBox ShipAddress;
		internal System.Windows.Forms.TextBox ShipCountry;
		internal System.Windows.Forms.TextBox ShipPostalCode;
		internal System.Windows.Forms.TextBox ShipCity;
		internal System.Windows.Forms.Label lblShipName;
		internal System.Windows.Forms.Label lblShipAddress;
		internal System.Windows.Forms.Label lblShipCity;
		internal System.Windows.Forms.Label lblShipCountry;
		internal System.Windows.Forms.TextBox ShipName;
		internal System.Windows.Forms.Label lblShipPostalCode;
		internal System.Windows.Forms.Button btnNewOrderDetails;
		internal System.Windows.Forms.Button btnNew;
		private System.Windows.Forms.DataGridTableStyle dataGridTableStyle1;
		private System.Windows.Forms.DataGridTextBoxColumn dataGridTextBoxColumn1;
		internal System.Windows.Forms.DataGrid dgOrderDetails;
		internal System.Windows.Forms.DataGridTextBoxColumn ProductID;
		internal System.Windows.Forms.DataGridTextBoxColumn Product;
		internal System.Windows.Forms.DataGridTextBoxColumn Quantity;
		internal System.Windows.Forms.DataGridTextBoxColumn Discount;
		internal System.Windows.Forms.DataGridTextBoxColumn QtyPerUnit;
		internal System.Windows.Forms.DataGridTextBoxColumn LineTotal;
		internal System.Windows.Forms.Button btnUpdate;
		internal System.Windows.Forms.DataGridTextBoxColumn dataGridTextBoxColumn2;
		internal System.Windows.Forms.Button btnDeleteOrderDetails;
		internal System.Windows.Forms.Label lblStatus;
		internal System.Windows.Forms.Button btnCancel;
		internal System.Windows.Forms.Panel panShipper;
		internal System.Windows.Forms.ComboBox ShipperID;
		internal System.Windows.Forms.Label lblShipVia;
		internal System.Windows.Forms.TextBox Freight;
		internal System.Windows.Forms.Label lblFreight;
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.Container components = null;


		private string _CustID;
		private DataSet _dsOrders;
		private DataSet _dsLookups;


		public OrdersForm()
		{
			//
			// Required for Windows Form Designer support
			//
			InitializeComponent();

		}

		public OrdersForm(string CustID)
		{
			//
			// Required for Windows Form Designer support
			//
			InitializeComponent();


			_CustID = CustID;

			// create an instance of the orders Web Service
			// and fetch the data
			OrdersService.RemotingOrders wsOrders = new OrdersService.RemotingOrders();
			_dsOrders = wsOrders.Orders(CustID);
			_dsLookups = wsOrders.Lookups();

			BindData();

			// set some default values for new rows
			_dsOrders.Tables["Orders"].Columns["CustomerID"].DefaultValue = _CustID;
			_dsOrders.Tables["Orders"].Columns["ShipVia"].DefaultValue = _dsLookups.Tables["Shippers"].Rows[0]["ShipperID"];

			// set the position for the first row
			// this ensures that the buttons/textboxes are enabled or disabled according to the data
			OrdersRowPosition_Changed(this.BindingContext[_dsOrders, "Orders"], (EventArgs)null);
		}



		private void BindData()
		{
			// Add the delegate for the PositionChanged event.
			this.BindingContext[_dsOrders, "Orders"].PositionChanged += new EventHandler(OrdersRowPosition_Changed);

			// bind the orders grid to the orders for that customer
			dgOrders.SetDataBinding(_dsOrders, "Orders");

			// and bind the order details grid to the relation in the dataset
			// this keeps them in sync
			dgOrderDetails.SetDataBinding(_dsOrders, "Orders.CustOrders");
			dgOrderDetails.ReadOnly = false;

			// and bind the textboxes
			ShipPostalCode.DataBindings.Add("Text", _dsOrders, "Orders.ShipPostalCode");
			ShipCountry.DataBindings.Add("Text", _dsOrders, "Orders.ShipCountry");
			ShipCity.DataBindings.Add("Text", _dsOrders, "Orders.ShipCity");
			ShipAddress.DataBindings.Add("Text", _dsOrders, "Orders.ShipAddress");
			ShipName.DataBindings.Add("Text", _dsOrders, "Orders.ShipName");
			Freight.DataBindings.Add("Text", _dsOrders, "Orders.Freight");
			ShippedDate.DataBindings.Add("Text", _dsOrders, "Orders.ShippedDate");
			RequiredDate.DataBindings.Add("Text", _dsOrders, "Orders.RequiredDate");
			OrderDate.DataBindings.Add("Text", _dsOrders, "Orders.OrderDate");

			// load and bind shipper details
			ShipperID.DataSource = _dsLookups.Tables["Shippers"];
			ShipperID.DisplayMember = "ShipperName";
			ShipperID.ValueMember = "ShipperID";
			ShipperID.DataBindings.Add("SelectedValue", _dsOrders, "Orders.ShipVia");
		}



		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		protected override void Dispose( bool disposing )
		{
			if( disposing )
			{
				if(components != null)
				{
					components.Dispose();
				}
			}
			base.Dispose( disposing );
		}

		#region Windows Form Designer generated code
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			this.UnitPrice = new System.Windows.Forms.DataGridTextBoxColumn();
			this.OrderDetailsStyle = new System.Windows.Forms.DataGridTableStyle();
			this.btnCancelOrderDetails = new System.Windows.Forms.Button();
			this.panDates = new System.Windows.Forms.Panel();
			this.lblRequiredDate = new System.Windows.Forms.Label();
			this.Label2 = new System.Windows.Forms.Label();
			this.Label1 = new System.Windows.Forms.Label();
			this.lblShippedDate = new System.Windows.Forms.Label();
			this.OrderDate = new System.Windows.Forms.TextBox();
			this.RequiredDate = new System.Windows.Forms.TextBox();
			this.ShippedDate = new System.Windows.Forms.TextBox();
			this.btnDelete = new System.Windows.Forms.Button();
			this.dgOrders = new System.Windows.Forms.DataGrid();
			this.ShippedOrderStyle = new System.Windows.Forms.DataGridTableStyle();
			this.gcOrderID = new System.Windows.Forms.DataGridTextBoxColumn();
			this.gcOrderDate = new System.Windows.Forms.DataGridTextBoxColumn();
			this.gcRequiredDate = new System.Windows.Forms.DataGridTextBoxColumn();
			this.gcShippedDate = new System.Windows.Forms.DataGridTextBoxColumn();
			this.btnCancelAll = new System.Windows.Forms.Button();
			this.panShipAddress = new System.Windows.Forms.Panel();
			this.ShipAddress = new System.Windows.Forms.TextBox();
			this.ShipCountry = new System.Windows.Forms.TextBox();
			this.ShipPostalCode = new System.Windows.Forms.TextBox();
			this.ShipCity = new System.Windows.Forms.TextBox();
			this.lblShipName = new System.Windows.Forms.Label();
			this.lblShipAddress = new System.Windows.Forms.Label();
			this.lblShipCity = new System.Windows.Forms.Label();
			this.lblShipCountry = new System.Windows.Forms.Label();
			this.ShipName = new System.Windows.Forms.TextBox();
			this.lblShipPostalCode = new System.Windows.Forms.Label();
			this.btnNewOrderDetails = new System.Windows.Forms.Button();
			this.btnNew = new System.Windows.Forms.Button();
			this.dataGridTableStyle1 = new System.Windows.Forms.DataGridTableStyle();
			this.dataGridTextBoxColumn1 = new System.Windows.Forms.DataGridTextBoxColumn();
			this.dgOrderDetails = new System.Windows.Forms.DataGrid();
			this.ProductID = new System.Windows.Forms.DataGridTextBoxColumn();
			this.Product = new System.Windows.Forms.DataGridTextBoxColumn();
			this.Quantity = new System.Windows.Forms.DataGridTextBoxColumn();
			this.Discount = new System.Windows.Forms.DataGridTextBoxColumn();
			this.QtyPerUnit = new System.Windows.Forms.DataGridTextBoxColumn();
			this.LineTotal = new System.Windows.Forms.DataGridTextBoxColumn();
			this.btnUpdate = new System.Windows.Forms.Button();
			this.dataGridTextBoxColumn2 = new System.Windows.Forms.DataGridTextBoxColumn();
			this.btnDeleteOrderDetails = new System.Windows.Forms.Button();
			this.lblStatus = new System.Windows.Forms.Label();
			this.btnCancel = new System.Windows.Forms.Button();
			this.panShipper = new System.Windows.Forms.Panel();
			this.ShipperID = new System.Windows.Forms.ComboBox();
			this.lblShipVia = new System.Windows.Forms.Label();
			this.Freight = new System.Windows.Forms.TextBox();
			this.lblFreight = new System.Windows.Forms.Label();
			this.panDates.SuspendLayout();
			((System.ComponentModel.ISupportInitialize)(this.dgOrders)).BeginInit();
			this.panShipAddress.SuspendLayout();
			((System.ComponentModel.ISupportInitialize)(this.dgOrderDetails)).BeginInit();
			this.panShipper.SuspendLayout();
			this.SuspendLayout();
			// 
			// UnitPrice
			// 
			this.UnitPrice.Alignment = System.Windows.Forms.HorizontalAlignment.Right;
			this.UnitPrice.Format = "C";
			this.UnitPrice.FormatInfo = null;
			this.UnitPrice.HeaderText = "Price Per Unit";
			this.UnitPrice.MappingName = "UnitPrice";
			this.UnitPrice.Width = 75;
			// 
			// OrderDetailsStyle
			// 
			this.OrderDetailsStyle.AlternatingBackColor = System.Drawing.Color.OldLace;
			this.OrderDetailsStyle.BackColor = System.Drawing.Color.OldLace;
			this.OrderDetailsStyle.ForeColor = System.Drawing.Color.DarkSlateGray;
			this.OrderDetailsStyle.GridColumnStyles.AddRange(new System.Windows.Forms.DataGridColumnStyle[] {
																												this.UnitPrice});
			this.OrderDetailsStyle.GridLineColor = System.Drawing.Color.Tan;
			this.OrderDetailsStyle.HeaderBackColor = System.Drawing.Color.Wheat;
			this.OrderDetailsStyle.HeaderForeColor = System.Drawing.Color.SaddleBrown;
			this.OrderDetailsStyle.LinkColor = System.Drawing.Color.DarkSlateBlue;
			this.OrderDetailsStyle.MappingName = "";
			this.OrderDetailsStyle.SelectionBackColor = System.Drawing.Color.SlateGray;
			this.OrderDetailsStyle.SelectionForeColor = System.Drawing.Color.White;
			// 
			// btnCancelOrderDetails
			// 
			this.btnCancelOrderDetails.Location = new System.Drawing.Point(560, 385);
			this.btnCancelOrderDetails.Name = "btnCancelOrderDetails";
			this.btnCancelOrderDetails.Size = new System.Drawing.Size(72, 24);
			this.btnCancelOrderDetails.TabIndex = 129;
			this.btnCancelOrderDetails.Text = "&Cancel";
			this.btnCancelOrderDetails.Click += new System.EventHandler(this.btnCancelOrderDetails_Click);
			// 
			// panDates
			// 
			this.panDates.BackColor = System.Drawing.Color.OldLace;
			this.panDates.Controls.AddRange(new System.Windows.Forms.Control[] {
																				   this.lblRequiredDate,
																				   this.Label2,
																				   this.Label1,
																				   this.lblShippedDate,
																				   this.OrderDate,
																				   this.RequiredDate,
																				   this.ShippedDate});
			this.panDates.Enabled = false;
			this.panDates.Location = new System.Drawing.Point(320, 153);
			this.panDates.Name = "panDates";
			this.panDates.Size = new System.Drawing.Size(232, 88);
			this.panDates.TabIndex = 123;
			// 
			// lblRequiredDate
			// 
			this.lblRequiredDate.BackColor = System.Drawing.Color.OldLace;
			this.lblRequiredDate.Location = new System.Drawing.Point(8, 32);
			this.lblRequiredDate.Name = "lblRequiredDate";
			this.lblRequiredDate.TabIndex = 93;
			this.lblRequiredDate.Text = "Required Date";
			// 
			// Label2
			// 
			this.Label2.BackColor = System.Drawing.Color.OldLace;
			this.Label2.Location = new System.Drawing.Point(8, 8);
			this.Label2.Name = "Label2";
			this.Label2.TabIndex = 98;
			this.Label2.Text = "Order Date";
			// 
			// Label1
			// 
			this.Label1.BackColor = System.Drawing.Color.OldLace;
			this.Label1.Location = new System.Drawing.Point(-160, -91);
			this.Label1.Name = "Label1";
			this.Label1.Size = new System.Drawing.Size(120, 43);
			this.Label1.TabIndex = 92;
			this.Label1.Text = "Order Date";
			// 
			// lblShippedDate
			// 
			this.lblShippedDate.BackColor = System.Drawing.Color.OldLace;
			this.lblShippedDate.Location = new System.Drawing.Point(8, 56);
			this.lblShippedDate.Name = "lblShippedDate";
			this.lblShippedDate.TabIndex = 94;
			this.lblShippedDate.Text = "Shipped Date";
			// 
			// OrderDate
			// 
			this.OrderDate.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
			this.OrderDate.Location = new System.Drawing.Point(120, 8);
			this.OrderDate.Name = "OrderDate";
			this.OrderDate.Size = new System.Drawing.Size(104, 20);
			this.OrderDate.TabIndex = 95;
			this.OrderDate.Text = "";
			// 
			// RequiredDate
			// 
			this.RequiredDate.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
			this.RequiredDate.Location = new System.Drawing.Point(120, 32);
			this.RequiredDate.Name = "RequiredDate";
			this.RequiredDate.Size = new System.Drawing.Size(104, 20);
			this.RequiredDate.TabIndex = 96;
			this.RequiredDate.Text = "";
			// 
			// ShippedDate
			// 
			this.ShippedDate.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
			this.ShippedDate.Location = new System.Drawing.Point(120, 56);
			this.ShippedDate.Name = "ShippedDate";
			this.ShippedDate.Size = new System.Drawing.Size(104, 20);
			this.ShippedDate.TabIndex = 97;
			this.ShippedDate.Text = "";
			// 
			// btnDelete
			// 
			this.btnDelete.Location = new System.Drawing.Point(560, 185);
			this.btnDelete.Name = "btnDelete";
			this.btnDelete.Size = new System.Drawing.Size(72, 24);
			this.btnDelete.TabIndex = 118;
			this.btnDelete.Text = "Delete";
			this.btnDelete.Click += new System.EventHandler(this.btnDelete_Click);
			// 
			// dgOrders
			// 
			this.dgOrders.AllowNavigation = false;
			this.dgOrders.AlternatingBackColor = System.Drawing.Color.OldLace;
			this.dgOrders.Anchor = ((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right);
			this.dgOrders.BackColor = System.Drawing.Color.OldLace;
			this.dgOrders.BackgroundColor = System.Drawing.Color.Tan;
			this.dgOrders.BorderStyle = System.Windows.Forms.BorderStyle.None;
			this.dgOrders.CaptionBackColor = System.Drawing.Color.SaddleBrown;
			this.dgOrders.CaptionForeColor = System.Drawing.Color.OldLace;
			this.dgOrders.CaptionText = "Orders";
			this.dgOrders.DataMember = "Orders";
			this.dgOrders.FlatMode = true;
			this.dgOrders.Font = new System.Drawing.Font("Tahoma", 8F);
			this.dgOrders.ForeColor = System.Drawing.Color.DarkSlateGray;
			this.dgOrders.GridLineColor = System.Drawing.Color.Tan;
			this.dgOrders.HeaderBackColor = System.Drawing.Color.Wheat;
			this.dgOrders.HeaderFont = new System.Drawing.Font("Tahoma", 8F, System.Drawing.FontStyle.Bold);
			this.dgOrders.HeaderForeColor = System.Drawing.Color.SaddleBrown;
			this.dgOrders.LinkColor = System.Drawing.Color.DarkSlateBlue;
			this.dgOrders.Location = new System.Drawing.Point(8, 9);
			this.dgOrders.Name = "dgOrders";
			this.dgOrders.ParentRowsBackColor = System.Drawing.Color.OldLace;
			this.dgOrders.ParentRowsForeColor = System.Drawing.Color.DarkSlateGray;
			this.dgOrders.ReadOnly = true;
			this.dgOrders.SelectionBackColor = System.Drawing.Color.SlateGray;
			this.dgOrders.SelectionForeColor = System.Drawing.Color.White;
			this.dgOrders.Size = new System.Drawing.Size(544, 136);
			this.dgOrders.TabIndex = 116;
			this.dgOrders.TableStyles.AddRange(new System.Windows.Forms.DataGridTableStyle[] {
																								 this.ShippedOrderStyle});
			// 
			// ShippedOrderStyle
			// 
			this.ShippedOrderStyle.AlternatingBackColor = System.Drawing.Color.OldLace;
			this.ShippedOrderStyle.BackColor = System.Drawing.Color.OldLace;
			this.ShippedOrderStyle.DataGrid = this.dgOrders;
			this.ShippedOrderStyle.ForeColor = System.Drawing.Color.DarkSlateGray;
			this.ShippedOrderStyle.GridColumnStyles.AddRange(new System.Windows.Forms.DataGridColumnStyle[] {
																												this.gcOrderID,
																												this.gcOrderDate,
																												this.gcRequiredDate,
																												this.gcShippedDate});
			this.ShippedOrderStyle.GridLineColor = System.Drawing.Color.Tan;
			this.ShippedOrderStyle.HeaderBackColor = System.Drawing.Color.Wheat;
			this.ShippedOrderStyle.HeaderForeColor = System.Drawing.Color.SaddleBrown;
			this.ShippedOrderStyle.LinkColor = System.Drawing.Color.DarkSlateBlue;
			this.ShippedOrderStyle.MappingName = "Orders";
			this.ShippedOrderStyle.SelectionBackColor = System.Drawing.Color.SlateGray;
			this.ShippedOrderStyle.SelectionForeColor = System.Drawing.Color.White;
			// 
			// gcOrderID
			// 
			this.gcOrderID.Format = "";
			this.gcOrderID.FormatInfo = null;
			this.gcOrderID.HeaderText = "Order ID";
			this.gcOrderID.MappingName = "OrderID";
			this.gcOrderID.ReadOnly = true;
			this.gcOrderID.Width = 75;
			// 
			// gcOrderDate
			// 
			this.gcOrderDate.Format = "";
			this.gcOrderDate.FormatInfo = null;
			this.gcOrderDate.HeaderText = "Ordered On";
			this.gcOrderDate.MappingName = "OrderDate";
			this.gcOrderDate.ReadOnly = true;
			this.gcOrderDate.Width = 75;
			// 
			// gcRequiredDate
			// 
			this.gcRequiredDate.Format = "d";
			this.gcRequiredDate.FormatInfo = null;
			this.gcRequiredDate.HeaderText = "Required By";
			this.gcRequiredDate.MappingName = "RequiredDate";
			this.gcRequiredDate.NullText = "";
			this.gcRequiredDate.ReadOnly = true;
			this.gcRequiredDate.Width = 75;
			// 
			// gcShippedDate
			// 
			this.gcShippedDate.Format = "d";
			this.gcShippedDate.FormatInfo = null;
			this.gcShippedDate.HeaderText = "Shipped On";
			this.gcShippedDate.MappingName = "ShippedDate";
			this.gcShippedDate.NullText = "";
			this.gcShippedDate.Width = 75;
			// 
			// btnCancelAll
			// 
			this.btnCancelAll.Anchor = ((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right);
			this.btnCancelAll.Location = new System.Drawing.Point(560, 521);
			this.btnCancelAll.Name = "btnCancelAll";
			this.btnCancelAll.Size = new System.Drawing.Size(72, 24);
			this.btnCancelAll.TabIndex = 120;
			this.btnCancelAll.Text = "Ca&ncel All";
			this.btnCancelAll.Click += new System.EventHandler(this.btnCancelAll_Click);
			// 
			// panShipAddress
			// 
			this.panShipAddress.BackColor = System.Drawing.Color.OldLace;
			this.panShipAddress.Controls.AddRange(new System.Windows.Forms.Control[] {
																						 this.ShipAddress,
																						 this.ShipCountry,
																						 this.ShipPostalCode,
																						 this.ShipCity,
																						 this.lblShipName,
																						 this.lblShipAddress,
																						 this.lblShipCity,
																						 this.lblShipCountry,
																						 this.ShipName,
																						 this.lblShipPostalCode});
			this.panShipAddress.Enabled = false;
			this.panShipAddress.Location = new System.Drawing.Point(8, 153);
			this.panShipAddress.Name = "panShipAddress";
			this.panShipAddress.Size = new System.Drawing.Size(312, 160);
			this.panShipAddress.TabIndex = 122;
			// 
			// ShipAddress
			// 
			this.ShipAddress.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
			this.ShipAddress.Location = new System.Drawing.Point(120, 32);
			this.ShipAddress.Name = "ShipAddress";
			this.ShipAddress.Size = new System.Drawing.Size(168, 20);
			this.ShipAddress.TabIndex = 116;
			this.ShipAddress.Text = "";
			// 
			// ShipCountry
			// 
			this.ShipCountry.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
			this.ShipCountry.Location = new System.Drawing.Point(120, 104);
			this.ShipCountry.Name = "ShipCountry";
			this.ShipCountry.TabIndex = 115;
			this.ShipCountry.Text = "";
			// 
			// ShipPostalCode
			// 
			this.ShipPostalCode.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
			this.ShipPostalCode.Location = new System.Drawing.Point(120, 80);
			this.ShipPostalCode.Name = "ShipPostalCode";
			this.ShipPostalCode.TabIndex = 114;
			this.ShipPostalCode.Text = "";
			// 
			// ShipCity
			// 
			this.ShipCity.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
			this.ShipCity.Location = new System.Drawing.Point(120, 56);
			this.ShipCity.Name = "ShipCity";
			this.ShipCity.Size = new System.Drawing.Size(168, 20);
			this.ShipCity.TabIndex = 113;
			this.ShipCity.Text = "";
			// 
			// lblShipName
			// 
			this.lblShipName.BackColor = System.Drawing.Color.OldLace;
			this.lblShipName.Location = new System.Drawing.Point(8, 8);
			this.lblShipName.Name = "lblShipName";
			this.lblShipName.TabIndex = 106;
			this.lblShipName.Text = "ShipName";
			// 
			// lblShipAddress
			// 
			this.lblShipAddress.BackColor = System.Drawing.Color.OldLace;
			this.lblShipAddress.Location = new System.Drawing.Point(8, 32);
			this.lblShipAddress.Name = "lblShipAddress";
			this.lblShipAddress.TabIndex = 107;
			this.lblShipAddress.Text = "Address";
			// 
			// lblShipCity
			// 
			this.lblShipCity.BackColor = System.Drawing.Color.OldLace;
			this.lblShipCity.Location = new System.Drawing.Point(8, 56);
			this.lblShipCity.Name = "lblShipCity";
			this.lblShipCity.TabIndex = 108;
			this.lblShipCity.Text = "City";
			// 
			// lblShipCountry
			// 
			this.lblShipCountry.BackColor = System.Drawing.Color.OldLace;
			this.lblShipCountry.Location = new System.Drawing.Point(8, 104);
			this.lblShipCountry.Name = "lblShipCountry";
			this.lblShipCountry.TabIndex = 111;
			this.lblShipCountry.Text = "Country";
			// 
			// ShipName
			// 
			this.ShipName.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
			this.ShipName.Location = new System.Drawing.Point(120, 8);
			this.ShipName.Name = "ShipName";
			this.ShipName.TabIndex = 112;
			this.ShipName.Text = "";
			// 
			// lblShipPostalCode
			// 
			this.lblShipPostalCode.BackColor = System.Drawing.Color.OldLace;
			this.lblShipPostalCode.Location = new System.Drawing.Point(8, 80);
			this.lblShipPostalCode.Name = "lblShipPostalCode";
			this.lblShipPostalCode.TabIndex = 110;
			this.lblShipPostalCode.Text = "Postal Code";
			// 
			// btnNewOrderDetails
			// 
			this.btnNewOrderDetails.Location = new System.Drawing.Point(560, 321);
			this.btnNewOrderDetails.Name = "btnNewOrderDetails";
			this.btnNewOrderDetails.Size = new System.Drawing.Size(72, 24);
			this.btnNewOrderDetails.TabIndex = 127;
			this.btnNewOrderDetails.Text = "New";
			this.btnNewOrderDetails.Click += new System.EventHandler(this.btnNewOrderDetails_Click);
			// 
			// btnNew
			// 
			this.btnNew.Location = new System.Drawing.Point(560, 153);
			this.btnNew.Name = "btnNew";
			this.btnNew.Size = new System.Drawing.Size(72, 24);
			this.btnNew.TabIndex = 117;
			this.btnNew.Text = "New";
			this.btnNew.Click += new System.EventHandler(this.btnNew_Click);
			// 
			// dataGridTableStyle1
			// 
			this.dataGridTableStyle1.AlternatingBackColor = System.Drawing.Color.OldLace;
			this.dataGridTableStyle1.BackColor = System.Drawing.Color.OldLace;
			this.dataGridTableStyle1.DataGrid = this.dgOrderDetails;
			this.dataGridTableStyle1.ForeColor = System.Drawing.Color.DarkSlateGray;
			this.dataGridTableStyle1.GridColumnStyles.AddRange(new System.Windows.Forms.DataGridColumnStyle[] {
																												  this.ProductID,
																												  this.Product,
																												  this.dataGridTextBoxColumn1,
																												  this.Quantity,
																												  this.Discount,
																												  this.QtyPerUnit,
																												  this.LineTotal});
			this.dataGridTableStyle1.GridLineColor = System.Drawing.Color.Tan;
			this.dataGridTableStyle1.HeaderBackColor = System.Drawing.Color.Wheat;
			this.dataGridTableStyle1.HeaderForeColor = System.Drawing.Color.SaddleBrown;
			this.dataGridTableStyle1.LinkColor = System.Drawing.Color.DarkSlateBlue;
			this.dataGridTableStyle1.MappingName = "Order Details";
			this.dataGridTableStyle1.SelectionBackColor = System.Drawing.Color.SlateGray;
			this.dataGridTableStyle1.SelectionForeColor = System.Drawing.Color.White;
			// 
			// dataGridTextBoxColumn1
			// 
			this.dataGridTextBoxColumn1.Alignment = System.Windows.Forms.HorizontalAlignment.Right;
			this.dataGridTextBoxColumn1.Format = "C";
			this.dataGridTextBoxColumn1.FormatInfo = null;
			this.dataGridTextBoxColumn1.HeaderText = "Price Per Unit";
			this.dataGridTextBoxColumn1.MappingName = "UnitPrice";
			this.dataGridTextBoxColumn1.Width = 75;
			// 
			// dgOrderDetails
			// 
			this.dgOrderDetails.AlternatingBackColor = System.Drawing.Color.OldLace;
			this.dgOrderDetails.Anchor = ((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right);
			this.dgOrderDetails.BackColor = System.Drawing.Color.OldLace;
			this.dgOrderDetails.BackgroundColor = System.Drawing.Color.Tan;
			this.dgOrderDetails.BorderStyle = System.Windows.Forms.BorderStyle.None;
			this.dgOrderDetails.CaptionBackColor = System.Drawing.Color.SaddleBrown;
			this.dgOrderDetails.CaptionForeColor = System.Drawing.Color.OldLace;
			this.dgOrderDetails.CaptionText = "Orders Details";
			this.dgOrderDetails.DataMember = "";
			this.dgOrderDetails.FlatMode = true;
			this.dgOrderDetails.Font = new System.Drawing.Font("Tahoma", 8F);
			this.dgOrderDetails.ForeColor = System.Drawing.Color.DarkSlateGray;
			this.dgOrderDetails.GridLineColor = System.Drawing.Color.Tan;
			this.dgOrderDetails.HeaderBackColor = System.Drawing.Color.Wheat;
			this.dgOrderDetails.HeaderFont = new System.Drawing.Font("Tahoma", 8F, System.Drawing.FontStyle.Bold);
			this.dgOrderDetails.HeaderForeColor = System.Drawing.Color.SaddleBrown;
			this.dgOrderDetails.LinkColor = System.Drawing.Color.DarkSlateBlue;
			this.dgOrderDetails.Location = new System.Drawing.Point(8, 321);
			this.dgOrderDetails.Name = "dgOrderDetails";
			this.dgOrderDetails.ParentRowsBackColor = System.Drawing.Color.OldLace;
			this.dgOrderDetails.ParentRowsForeColor = System.Drawing.Color.DarkSlateGray;
			this.dgOrderDetails.ReadOnly = true;
			this.dgOrderDetails.SelectionBackColor = System.Drawing.Color.SlateGray;
			this.dgOrderDetails.SelectionForeColor = System.Drawing.Color.White;
			this.dgOrderDetails.Size = new System.Drawing.Size(544, 192);
			this.dgOrderDetails.TabIndex = 125;
			this.dgOrderDetails.TableStyles.AddRange(new System.Windows.Forms.DataGridTableStyle[] {
																									   this.dataGridTableStyle1});
			// 
			// ProductID
			// 
			this.ProductID.Format = "";
			this.ProductID.FormatInfo = null;
			this.ProductID.MappingName = "ProductID";
			this.ProductID.Width = 75;
			// 
			// Product
			// 
			this.Product.Format = "";
			this.Product.FormatInfo = null;
			this.Product.HeaderText = "Product";
			this.Product.MappingName = "ProductName";
			this.Product.Width = 75;
			// 
			// Quantity
			// 
			this.Quantity.Alignment = System.Windows.Forms.HorizontalAlignment.Right;
			this.Quantity.Format = "N";
			this.Quantity.FormatInfo = null;
			this.Quantity.HeaderText = "Quantity";
			this.Quantity.MappingName = "Quantity";
			this.Quantity.Width = 75;
			// 
			// Discount
			// 
			this.Discount.Alignment = System.Windows.Forms.HorizontalAlignment.Right;
			this.Discount.Format = "P";
			this.Discount.FormatInfo = null;
			this.Discount.HeaderText = "Discount";
			this.Discount.MappingName = "Discount";
			this.Discount.Width = 75;
			// 
			// QtyPerUnit
			// 
			this.QtyPerUnit.Alignment = System.Windows.Forms.HorizontalAlignment.Right;
			this.QtyPerUnit.Format = "N";
			this.QtyPerUnit.FormatInfo = null;
			this.QtyPerUnit.HeaderText = "Qty Per Unit";
			this.QtyPerUnit.MappingName = "QtyPerUnt";
			this.QtyPerUnit.ReadOnly = true;
			this.QtyPerUnit.Width = 75;
			// 
			// LineTotal
			// 
			this.LineTotal.Alignment = System.Windows.Forms.HorizontalAlignment.Right;
			this.LineTotal.Format = "C";
			this.LineTotal.FormatInfo = null;
			this.LineTotal.HeaderText = "Total";
			this.LineTotal.MappingName = "LineTotal";
			this.LineTotal.ReadOnly = true;
			this.LineTotal.Width = 75;
			// 
			// btnUpdate
			// 
			this.btnUpdate.Anchor = ((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right);
			this.btnUpdate.Location = new System.Drawing.Point(480, 521);
			this.btnUpdate.Name = "btnUpdate";
			this.btnUpdate.Size = new System.Drawing.Size(72, 24);
			this.btnUpdate.TabIndex = 119;
			this.btnUpdate.Text = "&Update All";
			this.btnUpdate.Click += new System.EventHandler(this.btnUpdate_Click);
			// 
			// dataGridTextBoxColumn2
			// 
			this.dataGridTextBoxColumn2.Format = "";
			this.dataGridTextBoxColumn2.FormatInfo = null;
			this.dataGridTextBoxColumn2.MappingName = "OrderID";
			this.dataGridTextBoxColumn2.Width = 75;
			// 
			// btnDeleteOrderDetails
			// 
			this.btnDeleteOrderDetails.Location = new System.Drawing.Point(560, 353);
			this.btnDeleteOrderDetails.Name = "btnDeleteOrderDetails";
			this.btnDeleteOrderDetails.Size = new System.Drawing.Size(72, 24);
			this.btnDeleteOrderDetails.TabIndex = 128;
			this.btnDeleteOrderDetails.Text = "Delete";
			this.btnDeleteOrderDetails.Click += new System.EventHandler(this.btnDeleteOrderDetails_Click);
			// 
			// lblStatus
			// 
			this.lblStatus.Location = new System.Drawing.Point(16, 521);
			this.lblStatus.Name = "lblStatus";
			this.lblStatus.Size = new System.Drawing.Size(424, 24);
			this.lblStatus.TabIndex = 126;
			// 
			// btnCancel
			// 
			this.btnCancel.Location = new System.Drawing.Point(560, 217);
			this.btnCancel.Name = "btnCancel";
			this.btnCancel.Size = new System.Drawing.Size(72, 24);
			this.btnCancel.TabIndex = 121;
			this.btnCancel.Text = "&Cancel";
			this.btnCancel.Click += new System.EventHandler(this.btnCancel_Click);
			// 
			// panShipper
			// 
			this.panShipper.BackColor = System.Drawing.Color.OldLace;
			this.panShipper.Controls.AddRange(new System.Windows.Forms.Control[] {
																					 this.ShipperID,
																					 this.lblShipVia,
																					 this.Freight,
																					 this.lblFreight});
			this.panShipper.Enabled = false;
			this.panShipper.Location = new System.Drawing.Point(320, 249);
			this.panShipper.Name = "panShipper";
			this.panShipper.Size = new System.Drawing.Size(232, 64);
			this.panShipper.TabIndex = 124;
			// 
			// ShipperID
			// 
			this.ShipperID.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
			this.ShipperID.ItemHeight = 13;
			this.ShipperID.Location = new System.Drawing.Point(120, 8);
			this.ShipperID.Name = "ShipperID";
			this.ShipperID.Size = new System.Drawing.Size(104, 21);
			this.ShipperID.TabIndex = 113;
			// 
			// lblShipVia
			// 
			this.lblShipVia.BackColor = System.Drawing.Color.OldLace;
			this.lblShipVia.Location = new System.Drawing.Point(8, 8);
			this.lblShipVia.Name = "lblShipVia";
			this.lblShipVia.TabIndex = 94;
			this.lblShipVia.Text = "Shipper";
			// 
			// Freight
			// 
			this.Freight.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
			this.Freight.Location = new System.Drawing.Point(120, 32);
			this.Freight.Name = "Freight";
			this.Freight.Size = new System.Drawing.Size(104, 20);
			this.Freight.TabIndex = 97;
			this.Freight.Text = "";
			// 
			// lblFreight
			// 
			this.lblFreight.BackColor = System.Drawing.Color.OldLace;
			this.lblFreight.Location = new System.Drawing.Point(8, 32);
			this.lblFreight.Name = "lblFreight";
			this.lblFreight.TabIndex = 95;
			this.lblFreight.Text = "Freight";
			// 
			// frmOrders
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.BackColor = System.Drawing.Color.OldLace;
			this.ClientSize = new System.Drawing.Size(640, 555);
			this.Controls.AddRange(new System.Windows.Forms.Control[] {
																		  this.btnCancelOrderDetails,
																		  this.panDates,
																		  this.btnDelete,
																		  this.dgOrders,
																		  this.btnCancelAll,
																		  this.panShipAddress,
																		  this.btnNewOrderDetails,
																		  this.btnNew,
																		  this.dgOrderDetails,
																		  this.btnUpdate,
																		  this.btnDeleteOrderDetails,
																		  this.lblStatus,
																		  this.btnCancel,
																		  this.panShipper});
			this.Name = "frmOrders";
			this.Text = "frmOrders";
			this.panDates.ResumeLayout(false);
			((System.ComponentModel.ISupportInitialize)(this.dgOrders)).EndInit();
			this.panShipAddress.ResumeLayout(false);
			((System.ComponentModel.ISupportInitialize)(this.dgOrderDetails)).EndInit();
			this.panShipper.ResumeLayout(false);
			this.ResumeLayout(false);

		}
		#endregion

		// add a new order
		private void btnNew_Click(object sender, System.EventArgs e)
		{
			// Clear out the current edits
			this.BindingContext[_dsOrders, "Orders"].EndCurrentEdit();
			this.BindingContext[_dsOrders, "Orders"].AddNew();

			SetButtonUsability(true);

		}

		// delete the current order
		private void btnDelete_Click(object sender, System.EventArgs e)
		{
			CurrencyManager cmgr = (CurrencyManager)this.BindingContext[_dsOrders, "Orders"];

			if (MessageBox.Show("Are you sure you wish to delete this order?", "Delete Order",
						MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
			{
				// now we can delete the parent row
				cmgr.RemoveAt(cmgr.Position);
			}
		}


		// the current row has been changed
		private void OrdersRowPosition_Changed(Object sender, EventArgs e)
		{
			DataRowView CurrentRowView = (DataRowView)((CurrencyManager)sender).Current;

			// change enabled state of editable controls based
			// on whether the order has been shipped or not
			bool AllowEdit = CurrentRowView["ShippedDate"].ToString() == "";
			SetButtonUsability(AllowEdit);
		}


		private void SetButtonUsability(bool Allowed)
		{
			btnDelete.Enabled = Allowed;
			btnDeleteOrderDetails.Enabled = Allowed;
			btnNewOrderDetails.Enabled = Allowed;
			btnCancelOrderDetails.Enabled = Allowed;
			btnCancel.Enabled = Allowed;
			panDates.Enabled = Allowed;
			panShipAddress.Enabled = Allowed;
			panShipper.Enabled = Allowed;
			dgOrderDetails.Enabled = Allowed;
		}

		private void btnCancelAll_Click(object sender, System.EventArgs e)
		{
			// cancel any current edits
			this.BindingContext[_dsOrders, "Orders.CustOrders"].CancelCurrentEdit();
			this.BindingContext[_dsOrders, "Orders"].CancelCurrentEdit();

			// reject all changes
			this._dsOrders.RejectChanges();

			// clear the errors
			ClearAllErrors();
		}


		private void btnCancel_Click(object sender, System.EventArgs e)
		{
			this.BindingContext[_dsOrders, "Orders"].CancelCurrentEdit();
		}


		//process all of the updates
		private void btnUpdate_Click(object sender, System.EventArgs e)
		{
			OrdersService.RemotingOrders OrdersService;

			// Stop any current edits.
			this.BindingContext[_dsOrders, "Orders"].EndCurrentEdit();
			this.BindingContext[_dsOrders, "Orders.CustOrders"].EndCurrentEdit();

			// Check to see if any changes have been made.
			if (_dsOrders.HasChanges())
			{
				DataSet dsUpdate;
				DataSet dsChanges;

				// Clear all old errors in the Customers table before
				// we attempt to save
				ClearAllErrors();

				// Get the changes that have been made to the main dataset.
				dsChanges = _dsOrders.GetChanges();

				if (dsChanges != null)
				{
					// update the data source
					OrdersService = new OrdersService.RemotingOrders();
					dsUpdate = OrdersService.UpdateOrders(_CustID, dsChanges);

					// clear the current data
					// it will be reloaded with the full data returned from the web service
					_dsOrders.Clear();

					// merge the changed rows back into the original data
					_dsOrders.Merge(dsUpdate, false);

					// If there are errors show the error form
					if (_dsOrders.HasErrors)
					{
						ErrorsForm f = new ErrorsForm(_CustID, dsUpdate, _dsLookups);
						this.AddOwnedForm(f);
						f.Show();

						// add a handler so that we know when the error form has been closed
						f.Closed += new EventHandler(ErrorFormClosed);
					}
					else
					{
						// no errors, so just accept the changes
						_dsOrders.AcceptChanges();
					}
				}
			}
		}


		// clear all existing error details
		private void ClearAllErrors()
		{
			foreach (DataTable dt in _dsOrders.Tables)
				foreach (DataRow dr in dt.Rows)
					dr.ClearErrors();
		}


		// the errors form has been closed so refresh the data
		void ErrorFormClosed(Object sender , EventArgs e)
		{
			OrdersService.RemotingOrders wsOrders = new OrdersService.RemotingOrders();
			DataSet dsOrders = wsOrders.Orders(_CustID);

			_dsOrders.Merge(dsOrders, false);
			_dsOrders.AcceptChanges();
		}

		private void btnNewOrderDetails_Click(object sender, System.EventArgs e)
		{
			this.BindingContext[_dsOrders, "Orders.CustOrders"].EndCurrentEdit();
			this.BindingContext[_dsOrders, "Orders.CustOrders"].AddNew();
		}

		private void btnDeleteOrderDetails_Click(object sender, System.EventArgs e)
		{
			CurrencyManager cmgr = (CurrencyManager)this.BindingContext[_dsOrders, "Orders.CustOrders"];

			if (cmgr.Count > 0)
			{
				if (MessageBox.Show("Are you sure you wish to delete this order line?", "Delete Order Line",
							MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
				{
					// now we can delete the row
					cmgr.RemoveAt(cmgr.Position);

				}
			}
		}

		private void btnCancelOrderDetails_Click(object sender, System.EventArgs e)
		{
			this.BindingContext[_dsOrders, "Orders.CustOrders"].CancelCurrentEdit();
		}



	}
}
