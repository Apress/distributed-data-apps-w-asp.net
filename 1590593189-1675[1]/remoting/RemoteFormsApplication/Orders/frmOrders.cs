using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;


namespace Orders
{
	/// <summary>
	/// Summary description for frmOrders.
	/// </summary>
	public class frmOrders : System.Windows.Forms.Form
	{
		private System.Windows.Forms.DataGridTableStyle dataGridTableStyle1;
		private System.Windows.Forms.DataGridTextBoxColumn dataGridTextBoxColumn1;
		private System.Windows.Forms.DataGridTextBoxColumn dataGridTextBoxColumn2;
		private System.Windows.Forms.DataGridTextBoxColumn dataGridTextBoxColumn3;
		private System.Windows.Forms.DataGridTextBoxColumn dataGridTextBoxColumn4;
		private System.Windows.Forms.DataGridTextBoxColumn dataGridTextBoxColumn5;
		internal System.Windows.Forms.DataGrid dgOrders;
		internal System.Windows.Forms.DataGridTableStyle CustOrderLines;
		internal System.Windows.Forms.DataGridTextBoxColumn QtyPerUnit;
		internal System.Windows.Forms.DataGridTextBoxColumn ShipName;
		internal System.Windows.Forms.DataGridTextBoxColumn ShipTo;
		internal System.Windows.Forms.DataGridTextBoxColumn OrderedOn;
		internal System.Windows.Forms.DataGridTextBoxColumn ShippedOn;
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.Container components = null;

		public frmOrders()
		{
			//
			// Required for Windows Form Designer support
			//
			InitializeComponent();

		}

		public frmOrders(string CustID)
		{
			//
			// Required for Windows Form Designer support
			//
			InitializeComponent();


			Orders.RemotingOrders wsOrders = new Orders.RemotingOrders();

			// and bind the orders grid to the orders for that customer
			dgOrders.DataSource = wsOrders.Orders(CustID);
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
			this.dataGridTableStyle1 = new System.Windows.Forms.DataGridTableStyle();
			this.dataGridTextBoxColumn1 = new System.Windows.Forms.DataGridTextBoxColumn();
			this.dataGridTextBoxColumn2 = new System.Windows.Forms.DataGridTextBoxColumn();
			this.dataGridTextBoxColumn3 = new System.Windows.Forms.DataGridTextBoxColumn();
			this.dataGridTextBoxColumn4 = new System.Windows.Forms.DataGridTextBoxColumn();
			this.dataGridTextBoxColumn5 = new System.Windows.Forms.DataGridTextBoxColumn();
			this.dgOrders = new System.Windows.Forms.DataGrid();
			this.CustOrderLines = new System.Windows.Forms.DataGridTableStyle();
			this.QtyPerUnit = new System.Windows.Forms.DataGridTextBoxColumn();
			this.ShipName = new System.Windows.Forms.DataGridTextBoxColumn();
			this.ShipTo = new System.Windows.Forms.DataGridTextBoxColumn();
			this.OrderedOn = new System.Windows.Forms.DataGridTextBoxColumn();
			this.ShippedOn = new System.Windows.Forms.DataGridTextBoxColumn();
			((System.ComponentModel.ISupportInitialize)(this.dgOrders)).BeginInit();
			this.SuspendLayout();
			// 
			// dataGridTableStyle1
			// 
			this.dataGridTableStyle1.DataGrid = this.dgOrders;
			this.dataGridTableStyle1.GridColumnStyles.AddRange(new System.Windows.Forms.DataGridColumnStyle[] {
																												  this.dataGridTextBoxColumn1,
																												  this.ShipName,
																												  this.ShipTo,
																												  this.OrderedOn,
																												  this.ShippedOn});
			this.dataGridTableStyle1.HeaderForeColor = System.Drawing.SystemColors.ControlText;
			this.dataGridTableStyle1.MappingName = "Orders";
			this.dataGridTableStyle1.ReadOnly = true;
			// 
			// dataGridTextBoxColumn1
			// 
			this.dataGridTextBoxColumn1.Format = "";
			this.dataGridTextBoxColumn1.FormatInfo = null;
			this.dataGridTextBoxColumn1.HeaderText = "Order ID";
			this.dataGridTextBoxColumn1.MappingName = "OrderID";
			this.dataGridTextBoxColumn1.Width = 75;
			// 
			// dataGridTextBoxColumn2
			// 
			this.dataGridTextBoxColumn2.Format = "";
			this.dataGridTextBoxColumn2.FormatInfo = null;
			this.dataGridTextBoxColumn2.HeaderText = "Product";
			this.dataGridTextBoxColumn2.MappingName = "ProductName";
			this.dataGridTextBoxColumn2.Width = 75;
			// 
			// dataGridTextBoxColumn3
			// 
			this.dataGridTextBoxColumn3.Format = "";
			this.dataGridTextBoxColumn3.FormatInfo = null;
			this.dataGridTextBoxColumn3.HeaderText = "unit Price";
			this.dataGridTextBoxColumn3.MappingName = "UnitPrice";
			this.dataGridTextBoxColumn3.Width = 75;
			// 
			// dataGridTextBoxColumn4
			// 
			this.dataGridTextBoxColumn4.Format = "";
			this.dataGridTextBoxColumn4.FormatInfo = null;
			this.dataGridTextBoxColumn4.HeaderText = "Quantity";
			this.dataGridTextBoxColumn4.MappingName = "Quantity";
			this.dataGridTextBoxColumn4.Width = 75;
			// 
			// dataGridTextBoxColumn5
			// 
			this.dataGridTextBoxColumn5.Format = "";
			this.dataGridTextBoxColumn5.FormatInfo = null;
			this.dataGridTextBoxColumn5.HeaderText = "Discount";
			this.dataGridTextBoxColumn5.MappingName = "Discount";
			this.dataGridTextBoxColumn5.Width = 75;
			// 
			// dgOrders
			// 
			this.dgOrders.AlternatingBackColor = System.Drawing.Color.OldLace;
			this.dgOrders.Anchor = (((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
				| System.Windows.Forms.AnchorStyles.Left) 
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
			this.dgOrders.Name = "dgOrders";
			this.dgOrders.ParentRowsBackColor = System.Drawing.Color.OldLace;
			this.dgOrders.ParentRowsForeColor = System.Drawing.Color.DarkSlateGray;
			this.dgOrders.ReadOnly = true;
			this.dgOrders.SelectionBackColor = System.Drawing.Color.SlateGray;
			this.dgOrders.SelectionForeColor = System.Drawing.Color.White;
			this.dgOrders.Size = new System.Drawing.Size(672, 440);
			this.dgOrders.TabIndex = 6;
			this.dgOrders.TableStyles.AddRange(new System.Windows.Forms.DataGridTableStyle[] {
																								 this.dataGridTableStyle1,
																								 this.CustOrderLines});
			// 
			// CustOrderLines
			// 
			this.CustOrderLines.DataGrid = this.dgOrders;
			this.CustOrderLines.GridColumnStyles.AddRange(new System.Windows.Forms.DataGridColumnStyle[] {
																											 this.dataGridTextBoxColumn2,
																											 this.QtyPerUnit,
																											 this.dataGridTextBoxColumn3,
																											 this.dataGridTextBoxColumn4,
																											 this.dataGridTextBoxColumn5});
			this.CustOrderLines.HeaderForeColor = System.Drawing.SystemColors.ControlText;
			this.CustOrderLines.MappingName = "CustOrderLines";
			this.CustOrderLines.ReadOnly = true;
			// 
			// QtyPerUnit
			// 
			this.QtyPerUnit.Format = "";
			this.QtyPerUnit.FormatInfo = null;
			this.QtyPerUnit.HeaderText = "Qty Per Unit";
			this.QtyPerUnit.MappingName = "QuantityPerUnit";
			this.QtyPerUnit.Width = 75;
			// 
			// ShipName
			// 
			this.ShipName.Format = "";
			this.ShipName.FormatInfo = null;
			this.ShipName.HeaderText = "Ship By";
			this.ShipName.MappingName = "ShipName";
			this.ShipName.Width = 75;
			// 
			// ShipTo
			// 
			this.ShipTo.Format = "";
			this.ShipTo.FormatInfo = null;
			this.ShipTo.HeaderText = "Ship To";
			this.ShipTo.MappingName = "ShipAddress";
			this.ShipTo.Width = 75;
			// 
			// OrderedOn
			// 
			this.OrderedOn.Format = "";
			this.OrderedOn.FormatInfo = null;
			this.OrderedOn.HeaderText = "Ordered On";
			this.OrderedOn.MappingName = "OrderDate";
			this.OrderedOn.Width = 75;
			// 
			// ShippedOn
			// 
			this.ShippedOn.Format = "";
			this.ShippedOn.FormatInfo = null;
			this.ShippedOn.HeaderText = "Shipped on";
			this.ShippedOn.MappingName = "ShippedDate";
			this.ShippedOn.NullText = "not yet shipped";
			this.ShippedOn.Width = 75;
			// 
			// frmOrders
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.BackColor = System.Drawing.Color.OldLace;
			this.ClientSize = new System.Drawing.Size(672, 475);
			this.Controls.AddRange(new System.Windows.Forms.Control[] {
																		  this.dgOrders});
			this.Name = "frmOrders";
			this.Text = "frmOrders";
			((System.ComponentModel.ISupportInitialize)(this.dgOrders)).EndInit();
			this.ResumeLayout(false);

		}
		#endregion
	}
}
