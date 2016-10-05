using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using System.Data;
using System.Diagnostics;

namespace Orders
{
	/// <summary>
	/// Summary description for frmErrors.
	/// </summary>
	public class ErrorsForm : System.Windows.Forms.Form
	{
		internal System.Windows.Forms.Label Discount;
		internal System.Windows.Forms.Button btnCancel;
		internal System.Windows.Forms.Label lblStatus;
		internal System.Windows.Forms.Panel panDeletedDetails;
		internal System.Windows.Forms.Button btnDeletedDetailsLeave;
		internal System.Windows.Forms.Button btnDeletedDetailsDelete;
		internal System.Windows.Forms.Panel panDeleted;
		internal System.Windows.Forms.Button btnDeletedLeaveIn;
		internal System.Windows.Forms.Button btnDeletedDelete;
		internal System.Windows.Forms.Label ProductID;
		internal System.Windows.Forms.ErrorProvider ErrorProvider2;
		internal System.Windows.Forms.Panel panOriginal;
		internal System.Windows.Forms.Button btnKeepTheirs;
		internal System.Windows.Forms.Button btnKeepMine;
		internal System.Windows.Forms.Label lblOriginalValue;
		internal System.Windows.Forms.Label Label4;
		internal System.Windows.Forms.Label Quantity;
		internal System.Windows.Forms.Label UnitPrice;
		internal System.Windows.Forms.Label Freight;
		internal System.Windows.Forms.ErrorProvider ErrorProvider1;
		internal System.Windows.Forms.Label ShipperName;
		internal System.Windows.Forms.Label ShippedDate;
		internal System.Windows.Forms.Label RequiredDate;
		internal System.Windows.Forms.Label OrderDate;
		internal System.Windows.Forms.Label ShipCountry;
		internal System.Windows.Forms.Label ShipPostalCode;
		internal System.Windows.Forms.Label ShipAddress;
		internal System.Windows.Forms.Label ShipName;
		internal System.Windows.Forms.Label ShipCity;
		internal System.Windows.Forms.Label lblOrderDetailsError;
		internal System.Windows.Forms.Label lblOrderDetailsNav;
		internal System.Windows.Forms.Label lblOrderNav;
		internal System.Windows.Forms.Label lblOrderError;
		internal System.Windows.Forms.Label lblOrderNumber;
		internal System.Windows.Forms.Label Label3;
		internal System.Windows.Forms.Label Label1;
		internal System.Windows.Forms.Label lblShipName;
		internal System.Windows.Forms.Label lblShipAddress;
		internal System.Windows.Forms.Label lblShipCity;
		internal System.Windows.Forms.Label lblShipCountry;
		internal System.Windows.Forms.Label lblShipPostalCode;
		internal System.Windows.Forms.Label lblRequiredDate;
		internal System.Windows.Forms.Label Label2;
		internal System.Windows.Forms.Label lblShippedDate;
		internal System.Windows.Forms.Label lblShipVia;
		internal System.Windows.Forms.Label lblFreight;
		internal System.Windows.Forms.Label Label19;
		internal System.Windows.Forms.Label Label18;
		internal System.Windows.Forms.Label Label17;
		internal System.Windows.Forms.Label Label16;
		internal System.Windows.Forms.Button btnSave;
		internal System.Windows.Forms.Button btnMoveFirstDetail;
		internal System.Windows.Forms.Button btnMovePrevDetail;
		internal System.Windows.Forms.Button btnMoveNextDetail;
		internal System.Windows.Forms.Button btnMoveLastDetail;
		internal System.Windows.Forms.Button btnMoveFirst;
		internal System.Windows.Forms.Button btnMovePrev;
		internal System.Windows.Forms.Button btnMoveNext;
		internal System.Windows.Forms.Button btnMoveLast;
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.Container components = null;


		private string _CustID;
		private DataSet _dsOrders;
		internal new System.Windows.Forms.Label ProductName;
		private DataSet _dsLookups;

		private enum MovePosition
		{
			FirstRow,
			PreviousRow,
			NextRow,
			LastRow
		}

		public ErrorsForm()
		{
			//
			// Required for Windows Form Designer support
			//
			InitializeComponent();

			//
			// TODO: Add any constructor code after InitializeComponent call
			//
		}

		public ErrorsForm(string CustID , DataSet dsChanges , DataSet dsLookups)
		{
			//
			// Required for Windows Form Designer support
			//
			InitializeComponent();

			_CustID = CustID;
			_dsLookups = dsLookups;

			// clone the dataset - this ensure we have the correct schema
			_dsOrders = dsChanges.Clone();

			ShowData(dsChanges);

		}


		// bind the data
		private void ShowData(DataSet dsChanges)
		{
			DataRow[] drOrders;
			DataRow[] drOrderDetails = null;

			// set the column error details
			// this also ensures that parent rows have errors so we
			// don//t get orphaned children
			SetColumnErrors(ref dsChanges);

			// clear any existing data before merging
			_dsOrders.Clear();

			// get the error rows and merge into our emtpy dataset
			// this way we can have a dataset of just errors
			drOrders = dsChanges.Tables["Orders"].GetErrors();
			_dsOrders.Merge(drOrders);

			// If there are child rows, then merge in the chilren.
			// For occasions where errors only occur in child rows, we
			// know that the parent exists, because our calling routine
			// set a row error on the parent, even if one didn//t exist
			if (dsChanges.Tables["Order Details"].HasErrors)
			{
				drOrderDetails = dsChanges.Tables["Order Details"].GetErrors();
				_dsOrders.Merge(drOrderDetails);

				// create the relationship if it doesn//t already exist
				// (which will be the first time this is opened)
				if (_dsOrders.Relations.Count == 0)
				{
					DataColumn ParentCol;
					DataColumn ChildCol;
					ParentCol = _dsOrders.Tables["Orders"].Columns["OrderID"];
					ChildCol = _dsOrders.Tables["Order Details"].Columns["OrderID"];
					DataRelation  objRelation = new DataRelation("CustOrders", ParentCol, ChildCol);
					_dsOrders.Relations.Add(objRelation);
				}
			}

			// and bind the textboxes for the orders
			lblOrderNumber.DataBindings.Add("Text", _dsOrders, "Orders.OrderID");
			ShipPostalCode.DataBindings.Add("Text", _dsOrders, "Orders.ShipPostalCode");
			ShipCountry.DataBindings.Add("Text", _dsOrders, "Orders.ShipCountry");
			ShipCity.DataBindings.Add("Text", _dsOrders, "Orders.ShipCity");
			ShipAddress.DataBindings.Add("Text", _dsOrders, "Orders.ShipAddress");
			ShipName.DataBindings.Add("Text", _dsOrders, "Orders.ShipName");
			Freight.DataBindings.Add("Text", _dsOrders, "Orders.Freight");
			ShippedDate.DataBindings.Add("Text", _dsOrders, "Orders.ShippedDate");
			RequiredDate.DataBindings.Add("Text", _dsOrders, "Orders.RequiredDate");
			OrderDate.DataBindings.Add("Text", _dsOrders, "Orders.OrderDate");
			ShipperName.DataBindings.Add("Text", _dsOrders, "Orders.ShipperName");

			// bind error provider
			// this gives us automatic notification of errors on the text boxes
			ErrorProvider1.DataSource = _dsOrders;
			ErrorProvider1.DataMember = "Orders";
			ErrorProvider1.ContainerControl = this;

			// only bind to order details if there are errors in the order details
			if (drOrderDetails != null)
			{
				// bind the textboxes for the order details
				ProductID.DataBindings.Add("Text", _dsOrders, "Orders.CustOrders.ProductID");
				ProductName.DataBindings.Add("Text", _dsOrders, "Orders.CustOrders.ProductName");
				UnitPrice.DataBindings.Add("Text", _dsOrders, "Orders.CustOrders.UnitPrice");
				Quantity.DataBindings.Add("Text", _dsOrders, "Orders.CustOrders.Quantity");
				Discount.DataBindings.Add("Text", _dsOrders, "Orders.CustOrders.Discount");

				// bind error provider
				// this gives us automatic notification of errors on the text boxes
				ErrorProvider2.DataSource = _dsOrders;
				ErrorProvider2.DataMember = "Orders.CustOrders";
				ErrorProvider2.ContainerControl = this;
			}

			// update controls for current row
			this.BindingContext[_dsOrders, "Orders"].PositionChanged += new EventHandler(OrdersRowPosition_Changed);

			CheckForDeleted();
			UpdateParentView();
		}


		private void CheckForDeleted()
		{
			// if the number of rows bound differs from the number of rows in the table
			// then there must be deleted rows
			if (_dsOrders.Tables["Orders"].Rows.Count != this.BindingContext[_dsOrders, "Orders"].Count
				|| _dsOrders.Tables["Order Details"].Rows.Count != this.BindingContext[_dsOrders, "Order Details"].Count)
			{
				int i;
				DataRow dr;

				foreach (DataTable dt in _dsOrders.Tables)
				{
					for (i = 0; i <= dt.Rows.Count - 1; i++)
					{
						dr = dt.Rows[i];
						if (dr.RowState == DataRowState.Deleted)
						{
							dr.RejectChanges();
							dr.RowError = "Deleted";
						}
					}
				}
			}
		}


		// set the navigation controls
		private void UpdateParentView()
		{
			int CurrentRowNumber = this.BindingContext[_dsOrders, "Orders"].Position;
			DataRow CurrentRow = ((DataRowView)this.BindingContext[_dsOrders, "Orders"].Current).Row;

			// set the error label
			lblOrderError.Text = CurrentRow.RowError;
			lblOrderNav.Text = (CurrentRowNumber + 1).ToString()
				+ " of  " + _dsOrders.Tables["Orders"].Rows.Count.ToString();

			// if deleted show different buttons
			if (CurrentRow.RowError == "Deleted")
				panDeleted.Visible = true;
			else
				panDeleted.Visible = false;

			// enable or disable children, depending on whether there are child rows
			bool EnableChild = (CurrentRow.GetChildRows("CustOrders").Length > 0);
			btnMoveFirstDetail.Enabled = EnableChild;
			btnMoveLastDetail.Enabled = EnableChild;
			btnMoveNextDetail.Enabled = EnableChild;
			btnMovePrevDetail.Enabled = EnableChild;
			ProductName.Enabled = EnableChild;
			UnitPrice.Enabled = EnableChild;
			Quantity.Enabled = EnableChild;
			Discount.Enabled = EnableChild;


			if (EnableChild)
				UpdateChildView();


			panOriginal.Visible = false;

			// set any error messages (try/catch just eliminates indexing errors
			// for controls that don//t exist in the data. This is easier than looping
			// through the DataColumns since you can//t index into the Form.Controls 
			// collection by name.
			foreach (Control ctl in this.Controls)
				if (CurrentRow.Table.Columns.Contains(ctl.Name))
					ErrorProvider1.SetError(ctl, CurrentRow.GetColumnError(ctl.Name));
		}


		private void UpdateChildView()
		{
			int CurrentRowNumber = this.BindingContext[_dsOrders, "Orders.CustOrders"].Position;
			DataRow CurrentRow = ((DataRowView)this.BindingContext[_dsOrders, "Orders.CustOrders"].Current).Row;

			// set the error label
			lblOrderDetailsError.Text = CurrentRow.RowError;
			lblOrderDetailsNav.Text = (CurrentRowNumber + 1).ToString()
				+ " of  " + _dsOrders.Tables["Order Details"].Rows.Count.ToString();

			// if deleted show different buttons
			if (CurrentRow.RowError == "Deleted")
				panDeletedDetails.Visible = true;
			else
				panDeletedDetails.Visible = false;

			panOriginal.Visible = false;

			// set any error messages (try/catch just eliminates indexing errors
			// for controls that don//t exist in the data. This is easier than looping
			// through the DataColumns since you can//t index into the Form.Controls 
			// collection by name.
			foreach (Control ctl in this.Controls)
				if (CurrentRow.Table.Columns.Contains(ctl.Name))
					ErrorProvider2.SetError(ctl, CurrentRow.GetColumnError(ctl.Name));
		}

			
		// return the original value for a given column
		private string GetOriginalRowValue(DataRow CurrentRow, string ColumnName)
		{
			DataColumn dc = CurrentRow.Table.Columns[ColumnName];

			switch(CurrentRow.RowState)
			{
				case DataRowState.Modified:
					if (!((CurrentRow.IsNull(dc, DataRowVersion.Current) && CurrentRow.IsNull(dc, DataRowVersion.Original))
						|| (CurrentRow[dc, DataRowVersion.Current] == CurrentRow[dc, DataRowVersion.Original])))
						return CurrentRow[dc, DataRowVersion.Original].ToString();
					break;

				case DataRowState.Added:
					return null;
					break;

				case DataRowState.Deleted:
					return CurrentRow[dc, DataRowVersion.Original].ToString();
					break;
			}

			return null;
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
			this.Discount = new System.Windows.Forms.Label();
			this.btnCancel = new System.Windows.Forms.Button();
			this.lblStatus = new System.Windows.Forms.Label();
			this.ProductName = new System.Windows.Forms.Label();
			this.panDeletedDetails = new System.Windows.Forms.Panel();
			this.btnDeletedDetailsLeave = new System.Windows.Forms.Button();
			this.btnDeletedDetailsDelete = new System.Windows.Forms.Button();
			this.panDeleted = new System.Windows.Forms.Panel();
			this.btnDeletedLeaveIn = new System.Windows.Forms.Button();
			this.btnDeletedDelete = new System.Windows.Forms.Button();
			this.ProductID = new System.Windows.Forms.Label();
			this.ErrorProvider2 = new System.Windows.Forms.ErrorProvider();
			this.panOriginal = new System.Windows.Forms.Panel();
			this.btnKeepTheirs = new System.Windows.Forms.Button();
			this.btnKeepMine = new System.Windows.Forms.Button();
			this.lblOriginalValue = new System.Windows.Forms.Label();
			this.Label4 = new System.Windows.Forms.Label();
			this.Quantity = new System.Windows.Forms.Label();
			this.UnitPrice = new System.Windows.Forms.Label();
			this.Freight = new System.Windows.Forms.Label();
			this.ErrorProvider1 = new System.Windows.Forms.ErrorProvider();
			this.ShipperName = new System.Windows.Forms.Label();
			this.ShippedDate = new System.Windows.Forms.Label();
			this.RequiredDate = new System.Windows.Forms.Label();
			this.OrderDate = new System.Windows.Forms.Label();
			this.ShipCountry = new System.Windows.Forms.Label();
			this.ShipPostalCode = new System.Windows.Forms.Label();
			this.ShipAddress = new System.Windows.Forms.Label();
			this.ShipName = new System.Windows.Forms.Label();
			this.ShipCity = new System.Windows.Forms.Label();
			this.lblOrderDetailsError = new System.Windows.Forms.Label();
			this.lblOrderDetailsNav = new System.Windows.Forms.Label();
			this.lblOrderNav = new System.Windows.Forms.Label();
			this.lblOrderError = new System.Windows.Forms.Label();
			this.lblOrderNumber = new System.Windows.Forms.Label();
			this.Label3 = new System.Windows.Forms.Label();
			this.Label1 = new System.Windows.Forms.Label();
			this.lblShipName = new System.Windows.Forms.Label();
			this.lblShipAddress = new System.Windows.Forms.Label();
			this.lblShipCity = new System.Windows.Forms.Label();
			this.lblShipCountry = new System.Windows.Forms.Label();
			this.lblShipPostalCode = new System.Windows.Forms.Label();
			this.lblRequiredDate = new System.Windows.Forms.Label();
			this.Label2 = new System.Windows.Forms.Label();
			this.lblShippedDate = new System.Windows.Forms.Label();
			this.lblShipVia = new System.Windows.Forms.Label();
			this.lblFreight = new System.Windows.Forms.Label();
			this.Label19 = new System.Windows.Forms.Label();
			this.Label18 = new System.Windows.Forms.Label();
			this.Label17 = new System.Windows.Forms.Label();
			this.Label16 = new System.Windows.Forms.Label();
			this.btnSave = new System.Windows.Forms.Button();
			this.btnMoveFirstDetail = new System.Windows.Forms.Button();
			this.btnMovePrevDetail = new System.Windows.Forms.Button();
			this.btnMoveNextDetail = new System.Windows.Forms.Button();
			this.btnMoveLastDetail = new System.Windows.Forms.Button();
			this.btnMoveFirst = new System.Windows.Forms.Button();
			this.btnMovePrev = new System.Windows.Forms.Button();
			this.btnMoveNext = new System.Windows.Forms.Button();
			this.btnMoveLast = new System.Windows.Forms.Button();
			this.panDeletedDetails.SuspendLayout();
			this.panDeleted.SuspendLayout();
			this.panOriginal.SuspendLayout();
			this.SuspendLayout();
			// 
			// Discount
			// 
			this.Discount.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
			this.Discount.Location = new System.Drawing.Point(468, 302);
			this.Discount.Name = "Discount";
			this.Discount.Size = new System.Drawing.Size(96, 23);
			this.Discount.TabIndex = 267;
			this.Discount.Click += new System.EventHandler(this.Item_Click);
			// 
			// btnCancel
			// 
			this.btnCancel.Location = new System.Drawing.Point(484, 422);
			this.btnCancel.Name = "btnCancel";
			this.btnCancel.Size = new System.Drawing.Size(120, 23);
			this.btnCancel.TabIndex = 271;
			this.btnCancel.Text = "Cancel All Changes";
			this.btnCancel.Click += new System.EventHandler(this.btnCancel_Click);
			// 
			// lblStatus
			// 
			this.lblStatus.Location = new System.Drawing.Point(12, 422);
			this.lblStatus.Name = "lblStatus";
			this.lblStatus.Size = new System.Drawing.Size(456, 23);
			this.lblStatus.TabIndex = 270;
			// 
			// ProductName
			// 
			this.ProductName.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
			this.ProductName.Location = new System.Drawing.Point(468, 230);
			this.ProductName.Name = "ProductName";
			this.ProductName.TabIndex = 271;
			this.ProductName.Click += new System.EventHandler(this.Item_Click);
			// 
			// panDeletedDetails
			// 
			this.panDeletedDetails.Controls.AddRange(new System.Windows.Forms.Control[] {
																							this.btnDeletedDetailsLeave,
																							this.btnDeletedDetailsDelete});
			this.panDeletedDetails.Location = new System.Drawing.Point(444, 342);
			this.panDeletedDetails.Name = "panDeletedDetails";
			this.panDeletedDetails.Size = new System.Drawing.Size(296, 40);
			this.panDeletedDetails.TabIndex = 274;
			this.panDeletedDetails.Visible = false;
			// 
			// btnDeletedDetailsLeave
			// 
			this.btnDeletedDetailsLeave.Location = new System.Drawing.Point(152, 8);
			this.btnDeletedDetailsLeave.Name = "btnDeletedDetailsLeave";
			this.btnDeletedDetailsLeave.Size = new System.Drawing.Size(136, 23);
			this.btnDeletedDetailsLeave.TabIndex = 1;
			this.btnDeletedDetailsLeave.Text = "Leave Row In Database";
			this.btnDeletedDetailsLeave.Click += new System.EventHandler(this.btnDeletedDetailsLeave_Click);
			// 
			// btnDeletedDetailsDelete
			// 
			this.btnDeletedDetailsDelete.Location = new System.Drawing.Point(8, 8);
			this.btnDeletedDetailsDelete.Name = "btnDeletedDetailsDelete";
			this.btnDeletedDetailsDelete.Size = new System.Drawing.Size(136, 23);
			this.btnDeletedDetailsDelete.TabIndex = 0;
			this.btnDeletedDetailsDelete.Text = "Keep Row As Deleted";
			this.btnDeletedDetailsDelete.Click += new System.EventHandler(this.btnDeletedDetailsDelete_Click);
			// 
			// panDeleted
			// 
			this.panDeleted.Controls.AddRange(new System.Windows.Forms.Control[] {
																					 this.btnDeletedLeaveIn,
																					 this.btnDeletedDelete});
			this.panDeleted.Location = new System.Drawing.Point(12, 342);
			this.panDeleted.Name = "panDeleted";
			this.panDeleted.Size = new System.Drawing.Size(296, 40);
			this.panDeleted.TabIndex = 273;
			this.panDeleted.Visible = false;
			// 
			// btnDeletedLeaveIn
			// 
			this.btnDeletedLeaveIn.Location = new System.Drawing.Point(152, 8);
			this.btnDeletedLeaveIn.Name = "btnDeletedLeaveIn";
			this.btnDeletedLeaveIn.Size = new System.Drawing.Size(136, 23);
			this.btnDeletedLeaveIn.TabIndex = 1;
			this.btnDeletedLeaveIn.Text = "Leave Row In Database";
			this.btnDeletedLeaveIn.Click += new System.EventHandler(this.btnDeletedLeaveIn_Click);
			// 
			// btnDeletedDelete
			// 
			this.btnDeletedDelete.Location = new System.Drawing.Point(8, 8);
			this.btnDeletedDelete.Name = "btnDeletedDelete";
			this.btnDeletedDelete.Size = new System.Drawing.Size(136, 23);
			this.btnDeletedDelete.TabIndex = 0;
			this.btnDeletedDelete.Text = "Keep Row As Deleted";
			this.btnDeletedDelete.Click += new System.EventHandler(this.btnDeletedDelete_Click);
			// 
			// ProductID
			// 
			this.ProductID.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
			this.ProductID.Location = new System.Drawing.Point(684, 230);
			this.ProductID.Name = "ProductID";
			this.ProductID.Size = new System.Drawing.Size(28, 23);
			this.ProductID.TabIndex = 272;
			this.ProductID.Tag = "";
			this.ProductID.Visible = false;
			// 
			// ErrorProvider2
			// 
			this.ErrorProvider2.BlinkStyle = System.Windows.Forms.ErrorBlinkStyle.NeverBlink;
			this.ErrorProvider2.DataMember = null;
			// 
			// panOriginal
			// 
			this.panOriginal.Controls.AddRange(new System.Windows.Forms.Control[] {
																					  this.btnKeepTheirs,
																					  this.btnKeepMine,
																					  this.lblOriginalValue,
																					  this.Label4,
																					  this.panDeletedDetails});
			this.panOriginal.Location = new System.Drawing.Point(12, 342);
			this.panOriginal.Name = "panOriginal";
			this.panOriginal.Size = new System.Drawing.Size(728, 72);
			this.panOriginal.TabIndex = 269;
			this.panOriginal.Visible = false;
			// 
			// btnKeepTheirs
			// 
			this.btnKeepTheirs.Location = new System.Drawing.Point(600, 8);
			this.btnKeepTheirs.Name = "btnKeepTheirs";
			this.btnKeepTheirs.Size = new System.Drawing.Size(120, 23);
			this.btnKeepTheirs.TabIndex = 3;
			this.btnKeepTheirs.Text = "Keep database value";
			this.btnKeepTheirs.Click += new System.EventHandler(this.btnKeepTheirs_Click);
			// 
			// btnKeepMine
			// 
			this.btnKeepMine.Location = new System.Drawing.Point(472, 8);
			this.btnKeepMine.Name = "btnKeepMine";
			this.btnKeepMine.Size = new System.Drawing.Size(120, 23);
			this.btnKeepMine.TabIndex = 2;
			this.btnKeepMine.Text = "Keep my value";
			this.btnKeepMine.Click += new System.EventHandler(this.btnKeepMine_Click);
			// 
			// lblOriginalValue
			// 
			this.lblOriginalValue.Location = new System.Drawing.Point(104, 8);
			this.lblOriginalValue.Name = "lblOriginalValue";
			this.lblOriginalValue.Size = new System.Drawing.Size(360, 23);
			this.lblOriginalValue.TabIndex = 1;
			// 
			// Label4
			// 
			this.Label4.Location = new System.Drawing.Point(8, 8);
			this.Label4.Name = "Label4";
			this.Label4.Size = new System.Drawing.Size(88, 23);
			this.Label4.TabIndex = 0;
			this.Label4.Text = "Database value:";
			// 
			// Quantity
			// 
			this.Quantity.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
			this.Quantity.Location = new System.Drawing.Point(468, 278);
			this.Quantity.Name = "Quantity";
			this.Quantity.Size = new System.Drawing.Size(96, 23);
			this.Quantity.TabIndex = 266;
			this.Quantity.Click += new System.EventHandler(this.Item_Click);
			// 
			// UnitPrice
			// 
			this.UnitPrice.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
			this.UnitPrice.Location = new System.Drawing.Point(468, 254);
			this.UnitPrice.Name = "UnitPrice";
			this.UnitPrice.Size = new System.Drawing.Size(96, 23);
			this.UnitPrice.TabIndex = 265;
			this.UnitPrice.Click += new System.EventHandler(this.Item_Click);
			// 
			// Freight
			// 
			this.Freight.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
			this.Freight.Location = new System.Drawing.Point(132, 310);
			this.Freight.Name = "Freight";
			this.Freight.Size = new System.Drawing.Size(96, 23);
			this.Freight.TabIndex = 264;
			this.Freight.Click += new System.EventHandler(this.Item_Click);
			// 
			// ErrorProvider1
			// 
			this.ErrorProvider1.BlinkStyle = System.Windows.Forms.ErrorBlinkStyle.NeverBlink;
			// 
			// ShipperName
			// 
			this.ShipperName.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
			this.ShipperName.Location = new System.Drawing.Point(132, 286);
			this.ShipperName.Name = "ShipperName";
			this.ShipperName.Size = new System.Drawing.Size(96, 23);
			this.ShipperName.TabIndex = 263;
			this.ShipperName.Tag = "Shippers;ShipperID;ShipperName;ShipVia";
			this.ShipperName.Click += new System.EventHandler(this.Item_Click);
			// 
			// ShippedDate
			// 
			this.ShippedDate.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
			this.ShippedDate.Location = new System.Drawing.Point(132, 246);
			this.ShippedDate.Name = "ShippedDate";
			this.ShippedDate.Size = new System.Drawing.Size(136, 23);
			this.ShippedDate.TabIndex = 262;
			this.ShippedDate.Click += new System.EventHandler(this.Item_Click);
			// 
			// RequiredDate
			// 
			this.RequiredDate.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
			this.RequiredDate.Location = new System.Drawing.Point(132, 222);
			this.RequiredDate.Name = "RequiredDate";
			this.RequiredDate.Size = new System.Drawing.Size(136, 23);
			this.RequiredDate.TabIndex = 261;
			this.RequiredDate.Click += new System.EventHandler(this.Item_Click);
			// 
			// OrderDate
			// 
			this.OrderDate.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
			this.OrderDate.Location = new System.Drawing.Point(132, 198);
			this.OrderDate.Name = "OrderDate";
			this.OrderDate.Size = new System.Drawing.Size(136, 23);
			this.OrderDate.TabIndex = 260;
			this.OrderDate.Click += new System.EventHandler(this.Item_Click);
			// 
			// ShipCountry
			// 
			this.ShipCountry.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
			this.ShipCountry.Location = new System.Drawing.Point(132, 174);
			this.ShipCountry.Name = "ShipCountry";
			this.ShipCountry.Size = new System.Drawing.Size(96, 23);
			this.ShipCountry.TabIndex = 259;
			this.ShipCountry.Click += new System.EventHandler(this.Item_Click);
			// 
			// ShipPostalCode
			// 
			this.ShipPostalCode.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
			this.ShipPostalCode.Location = new System.Drawing.Point(132, 150);
			this.ShipPostalCode.Name = "ShipPostalCode";
			this.ShipPostalCode.Size = new System.Drawing.Size(96, 23);
			this.ShipPostalCode.TabIndex = 258;
			this.ShipPostalCode.Click += new System.EventHandler(this.Item_Click);
			// 
			// ShipAddress
			// 
			this.ShipAddress.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
			this.ShipAddress.Location = new System.Drawing.Point(132, 102);
			this.ShipAddress.Name = "ShipAddress";
			this.ShipAddress.Size = new System.Drawing.Size(168, 23);
			this.ShipAddress.TabIndex = 257;
			this.ShipAddress.Click += new System.EventHandler(this.Item_Click);
			// 
			// ShipName
			// 
			this.ShipName.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
			this.ShipName.Location = new System.Drawing.Point(132, 78);
			this.ShipName.Name = "ShipName";
			this.ShipName.TabIndex = 256;
			this.ShipName.Click += new System.EventHandler(this.Item_Click);
			// 
			// ShipCity
			// 
			this.ShipCity.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
			this.ShipCity.Location = new System.Drawing.Point(132, 126);
			this.ShipCity.Name = "ShipCity";
			this.ShipCity.Size = new System.Drawing.Size(168, 23);
			this.ShipCity.TabIndex = 255;
			this.ShipCity.Click += new System.EventHandler(this.Item_Click);
			// 
			// lblOrderDetailsError
			// 
			this.lblOrderDetailsError.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.lblOrderDetailsError.Location = new System.Drawing.Point(356, 126);
			this.lblOrderDetailsError.Name = "lblOrderDetailsError";
			this.lblOrderDetailsError.Size = new System.Drawing.Size(376, 48);
			this.lblOrderDetailsError.TabIndex = 254;
			// 
			// lblOrderDetailsNav
			// 
			this.lblOrderDetailsNav.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.lblOrderDetailsNav.Location = new System.Drawing.Point(404, 190);
			this.lblOrderDetailsNav.Name = "lblOrderDetailsNav";
			this.lblOrderDetailsNav.Size = new System.Drawing.Size(40, 16);
			this.lblOrderDetailsNav.TabIndex = 253;
			this.lblOrderDetailsNav.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
			// 
			// lblOrderNav
			// 
			this.lblOrderNav.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.lblOrderNav.Location = new System.Drawing.Point(60, 46);
			this.lblOrderNav.Name = "lblOrderNav";
			this.lblOrderNav.Size = new System.Drawing.Size(40, 16);
			this.lblOrderNav.TabIndex = 252;
			this.lblOrderNav.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
			// 
			// lblOrderError
			// 
			this.lblOrderError.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.lblOrderError.Location = new System.Drawing.Point(228, 14);
			this.lblOrderError.Name = "lblOrderError";
			this.lblOrderError.Size = new System.Drawing.Size(512, 56);
			this.lblOrderError.TabIndex = 251;
			// 
			// lblOrderNumber
			// 
			this.lblOrderNumber.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.lblOrderNumber.Location = new System.Drawing.Point(116, 14);
			this.lblOrderNumber.Name = "lblOrderNumber";
			this.lblOrderNumber.Size = new System.Drawing.Size(80, 23);
			this.lblOrderNumber.TabIndex = 250;
			// 
			// Label3
			// 
			this.Label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.Label3.Location = new System.Drawing.Point(12, 14);
			this.Label3.Name = "Label3";
			this.Label3.Size = new System.Drawing.Size(104, 23);
			this.Label3.TabIndex = 249;
			this.Label3.Text = "Order Number";
			// 
			// Label1
			// 
			this.Label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.Label1.Location = new System.Drawing.Point(356, 102);
			this.Label1.Name = "Label1";
			this.Label1.Size = new System.Drawing.Size(96, 23);
			this.Label1.TabIndex = 248;
			this.Label1.Text = "Order Details";
			// 
			// lblShipName
			// 
			this.lblShipName.Location = new System.Drawing.Point(20, 78);
			this.lblShipName.Name = "lblShipName";
			this.lblShipName.TabIndex = 243;
			this.lblShipName.Text = "ShipName";
			// 
			// lblShipAddress
			// 
			this.lblShipAddress.Location = new System.Drawing.Point(20, 102);
			this.lblShipAddress.Name = "lblShipAddress";
			this.lblShipAddress.TabIndex = 244;
			this.lblShipAddress.Text = "Address";
			// 
			// lblShipCity
			// 
			this.lblShipCity.Location = new System.Drawing.Point(20, 126);
			this.lblShipCity.Name = "lblShipCity";
			this.lblShipCity.TabIndex = 245;
			this.lblShipCity.Text = "City";
			// 
			// lblShipCountry
			// 
			this.lblShipCountry.Location = new System.Drawing.Point(20, 174);
			this.lblShipCountry.Name = "lblShipCountry";
			this.lblShipCountry.TabIndex = 247;
			this.lblShipCountry.Text = "Country";
			// 
			// lblShipPostalCode
			// 
			this.lblShipPostalCode.Location = new System.Drawing.Point(20, 150);
			this.lblShipPostalCode.Name = "lblShipPostalCode";
			this.lblShipPostalCode.TabIndex = 246;
			this.lblShipPostalCode.Text = "Postal Code";
			// 
			// lblRequiredDate
			// 
			this.lblRequiredDate.Location = new System.Drawing.Point(20, 230);
			this.lblRequiredDate.Name = "lblRequiredDate";
			this.lblRequiredDate.TabIndex = 240;
			this.lblRequiredDate.Text = "Required Date";
			// 
			// Label2
			// 
			this.Label2.Location = new System.Drawing.Point(20, 206);
			this.Label2.Name = "Label2";
			this.Label2.TabIndex = 242;
			this.Label2.Text = "Order Date";
			// 
			// lblShippedDate
			// 
			this.lblShippedDate.Location = new System.Drawing.Point(20, 254);
			this.lblShippedDate.Name = "lblShippedDate";
			this.lblShippedDate.TabIndex = 241;
			this.lblShippedDate.Text = "Shipped Date";
			// 
			// lblShipVia
			// 
			this.lblShipVia.Location = new System.Drawing.Point(20, 286);
			this.lblShipVia.Name = "lblShipVia";
			this.lblShipVia.TabIndex = 238;
			this.lblShipVia.Text = "Shipper";
			// 
			// lblFreight
			// 
			this.lblFreight.Location = new System.Drawing.Point(20, 310);
			this.lblFreight.Name = "lblFreight";
			this.lblFreight.TabIndex = 239;
			this.lblFreight.Text = "Freight";
			// 
			// Label19
			// 
			this.Label19.Location = new System.Drawing.Point(356, 302);
			this.Label19.Name = "Label19";
			this.Label19.TabIndex = 237;
			this.Label19.Text = "Discount";
			// 
			// Label18
			// 
			this.Label18.Location = new System.Drawing.Point(356, 278);
			this.Label18.Name = "Label18";
			this.Label18.TabIndex = 236;
			this.Label18.Text = "Quantity";
			// 
			// Label17
			// 
			this.Label17.Location = new System.Drawing.Point(356, 254);
			this.Label17.Name = "Label17";
			this.Label17.TabIndex = 235;
			this.Label17.Text = "Unit Price";
			// 
			// Label16
			// 
			this.Label16.Location = new System.Drawing.Point(356, 230);
			this.Label16.Name = "Label16";
			this.Label16.TabIndex = 234;
			this.Label16.Text = "Product";
			// 
			// btnSave
			// 
			this.btnSave.Location = new System.Drawing.Point(612, 422);
			this.btnSave.Name = "btnSave";
			this.btnSave.Size = new System.Drawing.Size(120, 23);
			this.btnSave.TabIndex = 233;
			this.btnSave.Text = "Save All Changes";
			this.btnSave.Click += new System.EventHandler(this.btnSave_Click);
			// 
			// btnMoveFirstDetail
			// 
			this.btnMoveFirstDetail.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.btnMoveFirstDetail.Location = new System.Drawing.Point(356, 182);
			this.btnMoveFirstDetail.Name = "btnMoveFirstDetail";
			this.btnMoveFirstDetail.Size = new System.Drawing.Size(24, 24);
			this.btnMoveFirstDetail.TabIndex = 229;
			this.btnMoveFirstDetail.Text = "|<";
			this.btnMoveFirstDetail.Click += new System.EventHandler(this.btnMoveFirstDetail_Click);
			// 
			// btnMovePrevDetail
			// 
			this.btnMovePrevDetail.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.btnMovePrevDetail.Location = new System.Drawing.Point(380, 182);
			this.btnMovePrevDetail.Name = "btnMovePrevDetail";
			this.btnMovePrevDetail.Size = new System.Drawing.Size(24, 24);
			this.btnMovePrevDetail.TabIndex = 230;
			this.btnMovePrevDetail.Text = "<";
			this.btnMovePrevDetail.Click += new System.EventHandler(this.btnMovePrevDetail_Click);
			// 
			// btnMoveNextDetail
			// 
			this.btnMoveNextDetail.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.btnMoveNextDetail.Location = new System.Drawing.Point(444, 182);
			this.btnMoveNextDetail.Name = "btnMoveNextDetail";
			this.btnMoveNextDetail.Size = new System.Drawing.Size(24, 24);
			this.btnMoveNextDetail.TabIndex = 231;
			this.btnMoveNextDetail.Text = ">";
			this.btnMoveNextDetail.Click += new System.EventHandler(this.btnMoveNextDetail_Click);
			// 
			// btnMoveLastDetail
			// 
			this.btnMoveLastDetail.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.btnMoveLastDetail.Location = new System.Drawing.Point(468, 182);
			this.btnMoveLastDetail.Name = "btnMoveLastDetail";
			this.btnMoveLastDetail.Size = new System.Drawing.Size(24, 24);
			this.btnMoveLastDetail.TabIndex = 232;
			this.btnMoveLastDetail.Text = ">|";
			this.btnMoveLastDetail.Click += new System.EventHandler(this.btnMoveLastDetail_Click);
			// 
			// btnMoveFirst
			// 
			this.btnMoveFirst.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.btnMoveFirst.Location = new System.Drawing.Point(12, 38);
			this.btnMoveFirst.Name = "btnMoveFirst";
			this.btnMoveFirst.Size = new System.Drawing.Size(24, 24);
			this.btnMoveFirst.TabIndex = 225;
			this.btnMoveFirst.Text = "|<";
			this.btnMoveFirst.Click += new System.EventHandler(this.btnMoveFirst_Click);
			// 
			// btnMovePrev
			// 
			this.btnMovePrev.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.btnMovePrev.Location = new System.Drawing.Point(36, 38);
			this.btnMovePrev.Name = "btnMovePrev";
			this.btnMovePrev.Size = new System.Drawing.Size(24, 24);
			this.btnMovePrev.TabIndex = 226;
			this.btnMovePrev.Text = "<";
			this.btnMovePrev.Click += new System.EventHandler(this.btnMovePrev_Click);
			// 
			// btnMoveNext
			// 
			this.btnMoveNext.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.btnMoveNext.Location = new System.Drawing.Point(100, 38);
			this.btnMoveNext.Name = "btnMoveNext";
			this.btnMoveNext.Size = new System.Drawing.Size(24, 24);
			this.btnMoveNext.TabIndex = 227;
			this.btnMoveNext.Text = ">";
			this.btnMoveNext.Click += new System.EventHandler(this.btnMoveNext_Click);
			// 
			// btnMoveLast
			// 
			this.btnMoveLast.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.btnMoveLast.Location = new System.Drawing.Point(124, 38);
			this.btnMoveLast.Name = "btnMoveLast";
			this.btnMoveLast.Size = new System.Drawing.Size(24, 24);
			this.btnMoveLast.TabIndex = 228;
			this.btnMoveLast.Text = ">|";
			this.btnMoveLast.Click += new System.EventHandler(this.btnMoveLast_Click);
			// 
			// ErrorsForm
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.BackColor = System.Drawing.Color.OldLace;
			this.ClientSize = new System.Drawing.Size(752, 459);
			this.Controls.AddRange(new System.Windows.Forms.Control[] {
																		  this.lblStatus,
																		  this.ProductName,
																		  this.panDeleted,
																		  this.ProductID,
																		  this.panOriginal,
																		  this.Quantity,
																		  this.UnitPrice,
																		  this.Freight,
																		  this.ShipperName,
																		  this.ShippedDate,
																		  this.RequiredDate,
																		  this.OrderDate,
																		  this.ShipCountry,
																		  this.ShipPostalCode,
																		  this.ShipAddress,
																		  this.ShipName,
																		  this.ShipCity,
																		  this.lblOrderDetailsError,
																		  this.lblOrderDetailsNav,
																		  this.lblOrderNav,
																		  this.lblOrderError,
																		  this.lblOrderNumber,
																		  this.Label3,
																		  this.Label1,
																		  this.lblShipName,
																		  this.lblShipAddress,
																		  this.lblShipCity,
																		  this.lblShipCountry,
																		  this.lblShipPostalCode,
																		  this.lblRequiredDate,
																		  this.Label2,
																		  this.lblShippedDate,
																		  this.lblShipVia,
																		  this.lblFreight,
																		  this.Label19,
																		  this.Label18,
																		  this.Label17,
																		  this.Label16,
																		  this.btnSave,
																		  this.btnMoveFirstDetail,
																		  this.btnMovePrevDetail,
																		  this.btnMoveNextDetail,
																		  this.btnMoveLastDetail,
																		  this.btnMoveFirst,
																		  this.btnMovePrev,
																		  this.btnMoveNext,
																		  this.btnMoveLast,
																		  this.Discount,
																		  this.btnCancel});
			this.Name = "ErrorsForm";
			this.Text = "Errors";
			this.Closing += new System.ComponentModel.CancelEventHandler(this.ErrorsForm_Closing);
			this.panDeletedDetails.ResumeLayout(false);
			this.panDeleted.ResumeLayout(false);
			this.panOriginal.ResumeLayout(false);
			this.ResumeLayout(false);

		}
		#endregion

		private void btnSave_Click(object sender, System.EventArgs e)
		{
			// Clear all old before  we attempt to save
			ClearAllErrors();

			DataSet dsChanges = _dsOrders.GetChanges();

			// are there any changes
			if (dsChanges != null)
			{
				// post changes back to the web service
				Orders.OrdersService.RemotingOrders OrdersService = new Orders.OrdersService.RemotingOrders();
				DataSet dsUpdate = OrdersService.UpdateOrders(_CustID, dsChanges);

				// if there are still errors
				if (dsUpdate.HasErrors)
				{
					lblStatus.Text = "There are still errors with the data.";
					ClearBindings();
					ShowData(dsUpdate);
				}
				else
					this.Close();
			}
			else
				this.Close();
		}

		private void Item_Click(object sender, System.EventArgs e)
		{
			Label ctl = (Label)sender;
			string TableName = ctl.DataBindings["Text"].BindingMemberInfo.BindingPath;
			int CurrentRowNumber = ((CurrencyManager)this.BindingContext[_dsOrders, TableName]).Position;

			if (CurrentRowNumber < 0)
				return;


			DataRow CurrentRow = ((DataRowView)this.BindingContext[_dsOrders, TableName].Current).Row;
			string value = GetOriginalRowValue(CurrentRow, ctl.Name);

			// only allow correction if the values are different
			// and they haven//t already been corrected
			// - for cases where we keep the database version we overwrite the current value
			//   with the origin value, but for cases where we keep the current value the
			//   two values remain different, so we use the error message to determine whether
			//   the error has already been corrected.
			if (!(value == null) && (value != CurrentRow[ctl.Name].ToString()))
			{
				string err = CurrentRow.GetColumnError(ctl.Name);
				if (err != "")
				{
					panOriginal.Visible = true;
					lblOriginalValue.Text = value;
					lblOriginalValue.Tag = ctl;
				}
			}
			else
				panOriginal.Visible = false;
		}

		#region "Move Buttons"
		// move buttons for orders
		private void btnMoveFirst_Click(object sender, System.EventArgs e)
		{
			MoveToRow("Orders", MovePosition.FirstRow);
		}

		private void btnMovePrev_Click(object sender, System.EventArgs e)
		{
			MoveToRow("Orders", MovePosition.PreviousRow);
		}

		private void btnMoveNext_Click(object sender, System.EventArgs e)
		{
		    MoveToRow("Orders", MovePosition.NextRow);
		}

		private void btnMoveLast_Click(object sender, System.EventArgs e)
		{
		    MoveToRow("Orders", MovePosition.LastRow);
		}

		// move buttons for order details
		private void btnMoveFirstDetail_Click(object sender, System.EventArgs e)
		{
		    MoveToRow("Orders.CustOrders", MovePosition.FirstRow);
		}

		private void btnMovePrevDetail_Click(object sender, System.EventArgs e)
		{
		    MoveToRow("Orders.CustOrders", MovePosition.PreviousRow);
		}

		private void btnMoveNextDetail_Click(object sender, System.EventArgs e)
		{
		    MoveToRow("Orders.CustOrders", MovePosition.NextRow);
		}

		private void btnMoveLastDetail_Click(object sender, System.EventArgs e)
		{
		    MoveToRow("Orders.CustOrders", MovePosition.LastRow);
		}

		
		private void MoveToRow(string BindingTable, MovePosition MoveTo)
		{
			BindingManagerBase ccyManager  = this.BindingContext[_dsOrders, BindingTable];
			int MaxRows = ccyManager.Count;

			switch (MoveTo)
			{
				case MovePosition.FirstRow:
					ccyManager.Position = 0;
					break;

				case MovePosition.LastRow:
					ccyManager.Position = MaxRows - 1;
					break;

				case MovePosition.NextRow:
					if (ccyManager.Position < MaxRows - 1)
						ccyManager.Position += 1;
					break;

				case MovePosition.PreviousRow:
					if (ccyManager.Position > 0)
						ccyManager.Position -= 1;
					break;
			}
			UpdateParentView();
		}
		#endregion


		private void OrdersRowPosition_Changed(Object sender, EventArgs e)
		{
			UpdateParentView();
		}


		private void btnKeepMine_Click(object sender, System.EventArgs e)
		{
			// keep the current value
			CorrectValue(DataRowVersion.Current);
		}

		private void btnKeepTheirs_Click(object sender, System.EventArgs e)
		{
		    // keep the original (database) value
			CorrectValue(DataRowVersion.Original);
		}


		// correct the calue in the row
		private void CorrectValue(DataRowVersion version)
		{
			// get the control row and column details
			Control ctl = (Label)lblOriginalValue.Tag;
			string TableName = ctl.DataBindings["Text"].BindingMemberInfo.BindingPath;
			CurrencyManager Manager = ((CurrencyManager)this.BindingContext[_dsOrders, TableName]);
			int CurrentRowNumber = Manager.Position;
			DataRow CurrentRow = ((DataRowView)Manager.Current).Row;
			string ControlName = ctl.Name;


			// overwrite the value with the original if requested
			if (version == DataRowVersion.Original)
			{
				// for lookup values, the text labels have the column name of their
				// key values stored in the Tag property. This allows us to check here
				// whether to just replace the value, or to lookup the key value from
				// the lookup table. The tag stores the TableName;PrimaryKeyField;ValueField;ForeignKeyField
				if (ctl.Tag != null)
				{
					string[] LookupDetails = ((string)ctl.Tag).Split(';');
					DataRow[] dr;
					dr = _dsLookups.Tables[LookupDetails[0]].Select(LookupDetails[2] + "=//" + lblOriginalValue.Text + "//");
					CurrentRow[LookupDetails[3]] = dr[0][LookupDetails[1]];
				}
				else
					CurrentRow[ControlName] = lblOriginalValue.Text;
			}

			// clear the error message for this control
			// note that SetColumError doesn//t clear the error (there//s no way
			// to clear an individual column error), but it allows us to see which
			// errors have been resolved
			CurrentRow.SetColumnError(ControlName, "");
			if (TableName == "Orders")
				ErrorProvider1.SetError(ctl, "");
			else
				ErrorProvider2.SetError(ctl, "");

			// hide the selection panel
			panOriginal.Visible = false;

			UpdateParentView();
		}


		// set the errors on each column with a conflict
		// Use of SetColumnError means that the ErrorProviders automatically highlight errors
		private void SetColumnErrors(ref DataSet dsChanges)
		{
			DataRow parentRow;

			// loop through the tables, rows, and columns (in rows with errors)
			foreach (DataTable dt in dsChanges.Tables)
			{
				foreach (DataRow dr in dt.Rows)
				{
					if (dr.HasErrors)
					{
						// ensure that parent row has an error set, so that
						// the ErrorProvider highlights the parent row in the grid.
						// otherwise you can//t tell that child rows have errors
						parentRow = dr.GetParentRow("CustOrders");
						if (!(parentRow == null) && !parentRow.HasErrors)
							if (parentRow.RowError == "")
								parentRow.RowError = "Error occured in Order Details";

						foreach (DataColumn dc in dr.Table.Columns)
						{
							// Only set error for non-calculated fields
							if (dc.Expression == "")
							{
								// what conflict was it?
								switch(dr.RowState)
								{
									case DataRowState.Modified:
										bool cvNull = dr.IsNull(dc, DataRowVersion.Current);
										bool ovNull = dr.IsNull(dc, DataRowVersion.Original);
										
										if (!((dr.IsNull(dc, DataRowVersion.Current) || dr.IsNull(dc, DataRowVersion.Original))
											|| (dr[dc, DataRowVersion.Current].ToString() == dr[dc, DataRowVersion.Original].ToString())))
										{
											string val = dr[dc, DataRowVersion.Original].ToString();
											dr.SetColumnError(dc, "Column was modified by another user. Their value is: " + val);
										}
										break;

									case DataRowState.Added:
										dr.SetColumnError(dc, "Row has been added");
										break;

									case DataRowState.Deleted:
										dr.SetColumnError(dc, "This row has been deleted by another user");
										break;
								}
							}
						}
					}
				}
			}
		}



		// we want to warn the user of they try to close the form
		// with unresolved errors
		private void ErrorsForm_Closing(object sender, System.ComponentModel.CancelEventArgs e)
		{
			if (_dsOrders.HasErrors)
			{
				string err = "There are still outstanding errors. "
					+ "Closing this form without resolving them means that you will loose your changes. "
					+ "Are you sure you wish to close the form?";
				if (MessageBox.Show(err, "Unresolved errors", MessageBoxButtons.YesNo,
					MessageBoxIcon.Warning, MessageBoxDefaultButton.Button2) == DialogResult.No)
					e.Cancel = true;
			}
		}


		// clear any databindings on the controls
		private void ClearBindings()
		{
			foreach (Control ctl in this.Controls)
				ctl.DataBindings.Clear();
			
			this.DataBindings.Clear();
		}
    
		
		private void ClearAllErrors()
		{
			foreach (DataTable dt in _dsOrders.Tables)
				foreach (DataRow dr in dt.Rows)
					dr.ClearErrors();
		}

		private void btnCancel_Click(object sender, System.EventArgs e)
		{
			this.Close();
		}



		private void btnDeletedDelete_Click(object sender, System.EventArgs e)
		{
			ProcessDeleted("Orders", DataRowVersion.Current);
		}

		private void btnDeletedLeaveIn_Click(object sender, System.EventArgs e)
		{
			ProcessDeleted("Orders", DataRowVersion.Original);
		}

		private void btnDeletedDetailsDelete_Click(object sender, System.EventArgs e)
		{
		     ProcessDeleted("Order Details", DataRowVersion.Current);
		}

		private void btnDeletedDetailsLeave_Click(object sender, System.EventArgs e)
		{
		    ProcessDeleted("Order Details", DataRowVersion.Original);
		}

		// process deleted rows that we've re-inserted to allow binding
		private void ProcessDeleted(string TableName, DataRowVersion Version)
		{
			CurrencyManager Manager = ((CurrencyManager)this.BindingContext[_dsOrders, TableName]);
			DataRow CurrentRow = ((DataRowView)Manager.Current).Row;

			if (Version == DataRowVersion.Original)
			{
				// Original means keep the database version, which is the version
				// someone else has modified but that we deleted
				CurrentRow.AcceptChanges();
				CurrentRow.ClearErrors();
			}
			else
			{
				// to keep the row as deleted just re-delete it
				CurrentRow.Delete();
			}

			panDeleted.Visible = false;
		}
	}
}
