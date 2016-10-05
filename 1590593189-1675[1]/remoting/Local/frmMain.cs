using System;
using System.Data;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;

namespace Local
{
	/// <summary>
	/// Summary description for frmMain.
	/// </summary>
	public class frmMain : System.Windows.Forms.Form
	{
		internal System.Windows.Forms.DataGrid dgCustomers;
		internal System.Windows.Forms.DataGridTableStyle DataGridTableStyle1;
		internal System.Windows.Forms.DataGridTextBoxColumn CustomerID;
		internal System.Windows.Forms.DataGridTextBoxColumn CustomerName;
		internal System.Windows.Forms.DataGridTextBoxColumn CustomerCity;
		internal System.Windows.Forms.GroupBox gpSearch;
		internal System.Windows.Forms.TextBox txtSearch;
		internal System.Windows.Forms.Button btnSearch;
		internal System.Windows.Forms.RadioButton rdName;
		internal System.Windows.Forms.RadioButton rdID;
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.Container components = null;

		[STAThread]
		static void Main() 
		{
			Application.Run(new frmMain());
		}


		public frmMain()
		{
			//
			// Required for Windows Form Designer support
			//
			InitializeComponent();

			//
			// TODO: Add any constructor code after InitializeComponent call
			//
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
			this.dgCustomers = new System.Windows.Forms.DataGrid();
			this.DataGridTableStyle1 = new System.Windows.Forms.DataGridTableStyle();
			this.CustomerID = new System.Windows.Forms.DataGridTextBoxColumn();
			this.CustomerName = new System.Windows.Forms.DataGridTextBoxColumn();
			this.CustomerCity = new System.Windows.Forms.DataGridTextBoxColumn();
			this.gpSearch = new System.Windows.Forms.GroupBox();
			this.txtSearch = new System.Windows.Forms.TextBox();
			this.btnSearch = new System.Windows.Forms.Button();
			this.rdName = new System.Windows.Forms.RadioButton();
			this.rdID = new System.Windows.Forms.RadioButton();
			((System.ComponentModel.ISupportInitialize)(this.dgCustomers)).BeginInit();
			this.gpSearch.SuspendLayout();
			this.SuspendLayout();
			// 
			// dgCustomers
			// 
			this.dgCustomers.AlternatingBackColor = System.Drawing.Color.OldLace;
			this.dgCustomers.Anchor = (((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
				| System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right);
			this.dgCustomers.BackColor = System.Drawing.Color.OldLace;
			this.dgCustomers.BackgroundColor = System.Drawing.Color.Tan;
			this.dgCustomers.BorderStyle = System.Windows.Forms.BorderStyle.None;
			this.dgCustomers.CaptionBackColor = System.Drawing.Color.SaddleBrown;
			this.dgCustomers.CaptionForeColor = System.Drawing.Color.OldLace;
			this.dgCustomers.CaptionText = "Customers";
			this.dgCustomers.CausesValidation = false;
			this.dgCustomers.DataMember = "Customers";
			this.dgCustomers.FlatMode = true;
			this.dgCustomers.Font = new System.Drawing.Font("Tahoma", 8F);
			this.dgCustomers.ForeColor = System.Drawing.Color.DarkSlateGray;
			this.dgCustomers.GridLineColor = System.Drawing.Color.Tan;
			this.dgCustomers.HeaderBackColor = System.Drawing.Color.Wheat;
			this.dgCustomers.HeaderFont = new System.Drawing.Font("Tahoma", 8F, System.Drawing.FontStyle.Bold);
			this.dgCustomers.HeaderForeColor = System.Drawing.Color.SaddleBrown;
			this.dgCustomers.LinkColor = System.Drawing.Color.DarkSlateBlue;
			this.dgCustomers.Location = new System.Drawing.Point(8, 104);
			this.dgCustomers.Name = "dgCustomers";
			this.dgCustomers.ParentRowsBackColor = System.Drawing.Color.OldLace;
			this.dgCustomers.ParentRowsForeColor = System.Drawing.Color.DarkSlateGray;
			this.dgCustomers.ReadOnly = true;
			this.dgCustomers.SelectionBackColor = System.Drawing.Color.SlateGray;
			this.dgCustomers.SelectionForeColor = System.Drawing.Color.White;
			this.dgCustomers.Size = new System.Drawing.Size(432, 352);
			this.dgCustomers.TabIndex = 4;
			this.dgCustomers.TableStyles.AddRange(new System.Windows.Forms.DataGridTableStyle[] {
																									this.DataGridTableStyle1});
			this.dgCustomers.Click += new System.EventHandler(this.dgCustomers_Click);

			// 
			// DataGridTableStyle1
			// 
			this.DataGridTableStyle1.AlternatingBackColor = System.Drawing.Color.OldLace;
			this.DataGridTableStyle1.BackColor = System.Drawing.Color.OldLace;
			this.DataGridTableStyle1.DataGrid = this.dgCustomers;
			this.DataGridTableStyle1.ForeColor = System.Drawing.Color.DarkSlateGray;
			this.DataGridTableStyle1.GridColumnStyles.AddRange(new System.Windows.Forms.DataGridColumnStyle[] {
																												  this.CustomerID,
																												  this.CustomerName,
																												  this.CustomerCity});
			this.DataGridTableStyle1.GridLineColor = System.Drawing.Color.Tan;
			this.DataGridTableStyle1.HeaderBackColor = System.Drawing.Color.Wheat;
			this.DataGridTableStyle1.HeaderForeColor = System.Drawing.Color.SaddleBrown;
			this.DataGridTableStyle1.LinkColor = System.Drawing.Color.DarkSlateBlue;
			this.DataGridTableStyle1.MappingName = "Customers";
			this.DataGridTableStyle1.ReadOnly = true;
			this.DataGridTableStyle1.SelectionBackColor = System.Drawing.Color.SlateGray;
			this.DataGridTableStyle1.SelectionForeColor = System.Drawing.Color.White;
			// 
			// CustomerID
			// 
			this.CustomerID.Format = "";
			this.CustomerID.FormatInfo = null;
			this.CustomerID.HeaderText = "ID";
			this.CustomerID.MappingName = "CustomerID";
			this.CustomerID.ReadOnly = true;
			this.CustomerID.Width = 75;
			// 
			// CustomerName
			// 
			this.CustomerName.Format = "";
			this.CustomerName.FormatInfo = null;
			this.CustomerName.HeaderText = "Name";
			this.CustomerName.MappingName = "CompanyName";
			this.CustomerName.ReadOnly = true;
			this.CustomerName.Width = 150;
			// 
			// CustomerCity
			// 
			this.CustomerCity.Format = "";
			this.CustomerCity.FormatInfo = null;
			this.CustomerCity.HeaderText = "City";
			this.CustomerCity.MappingName = "City";
			this.CustomerCity.ReadOnly = true;
			this.CustomerCity.Width = 75;
			// 
			// gpSearch
			// 
			this.gpSearch.Controls.AddRange(new System.Windows.Forms.Control[] {
																				   this.txtSearch,
																				   this.btnSearch,
																				   this.rdName,
																				   this.rdID});
			this.gpSearch.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.gpSearch.Location = new System.Drawing.Point(8, 8);
			this.gpSearch.Name = "gpSearch";
			this.gpSearch.Size = new System.Drawing.Size(256, 80);
			this.gpSearch.TabIndex = 5;
			this.gpSearch.TabStop = false;
			this.gpSearch.Text = "Search By";
			// 
			// txtSearch
			// 
			this.txtSearch.Location = new System.Drawing.Point(16, 48);
			this.txtSearch.Name = "txtSearch";
			this.txtSearch.Size = new System.Drawing.Size(160, 20);
			this.txtSearch.TabIndex = 3;
			this.txtSearch.Text = "";
			// 
			// btnSearch
			// 
			this.btnSearch.Location = new System.Drawing.Point(192, 48);
			this.btnSearch.Name = "btnSearch";
			this.btnSearch.Size = new System.Drawing.Size(56, 24);
			this.btnSearch.TabIndex = 2;
			this.btnSearch.Text = "Search";
			this.btnSearch.Click += new System.EventHandler(this.btnSearch_Click);
			// 
			// rdName
			// 
			this.rdName.Checked = true;
			this.rdName.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.rdName.Location = new System.Drawing.Point(16, 24);
			this.rdName.Name = "rdName";
			this.rdName.Size = new System.Drawing.Size(64, 16);
			this.rdName.TabIndex = 1;
			this.rdName.TabStop = true;
			this.rdName.Text = "Name";
			// 
			// rdID
			// 
			this.rdID.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.rdID.Location = new System.Drawing.Point(104, 24);
			this.rdID.Name = "rdID";
			this.rdID.Size = new System.Drawing.Size(40, 16);
			this.rdID.TabIndex = 0;
			this.rdID.Text = "ID";
			// 
			// frmMain
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.ClientSize = new System.Drawing.Size(448, 467);
			this.Controls.AddRange(new System.Windows.Forms.Control[] {
																		  this.dgCustomers,
																		  this.gpSearch});
			this.Name = "frmMain";
			this.Text = "frmMain";
			((System.ComponentModel.ISupportInitialize)(this.dgCustomers)).EndInit();
			this.gpSearch.ResumeLayout(false);
			this.ResumeLayout(false);

		}
		#endregion

		
		private DataSet m_dsCustomers;

		private void btnSearch_Click(object sender, System.EventArgs e)
		{
			Customers.CustomerOrders wsCustomers = new Customers.CustomerOrders();

			// get the dataset for the customers
			if (rdID.Checked)
				m_dsCustomers = wsCustomers.GetCustomers(txtSearch.Text, "");
			else
				m_dsCustomers = wsCustomers.GetCustomers("", txtSearch.Text);

			// and bind the dataset to the grid
			dgCustomers.DataSource = m_dsCustomers;
		}

		// open the orders form
		// we could just Show() the form, but we move it so it sits alongside
		// the current one. That way the two don't overlap each other.
		private void dgCustomers_Click(object sender, System.EventArgs e)
		{
			if (dgCustomers.CurrentRowIndex != -1)
			{
				int intOffset;
				DataRow CurrentRow = m_dsCustomers.Tables[0].Rows[dgCustomers.CurrentRowIndex];
				string CustID = CurrentRow["CustomerID"].ToString();
				frmOrders fOrders = new frmOrders(CustID);

				// make this form owned by us
				// - that way it minimises and maximises with us
				// - plus we can use the count of owned forms to position new ones
				this.AddOwnedForm(fOrders);

				// set the caption and get the form to load its grid
				fOrders.Text = CurrentRow["CompanyName"].ToString();

				// Show the form, making it invisible to start with
				fOrders.Visible = false;
				fOrders.Show();

				// Set it's position and make it visible
				// you could calculate the offset accurately, based on border width,
				//   title bar height, etc., but 25 works for standard border/title sizes
				intOffset = (this.OwnedForms.Length - 1) * 25;
				fOrders.Top = this.Top + intOffset;
				fOrders.Left = this.Left + this.Width + intOffset;
				fOrders.Visible = true;
			}
		}
	}
}
