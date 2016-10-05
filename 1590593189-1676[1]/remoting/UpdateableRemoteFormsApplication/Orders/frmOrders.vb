Imports System.Configuration

Public Class OrdersForm
    Inherits System.Windows.Forms.Form

#Region " Windows Form Designer generated code "

    Public Sub New()
        MyBase.New()

        'This call is required by the Windows Form Designer.
        InitializeComponent()

        'Add any initialization after the InitializeComponent() call

    End Sub

    'UserControl1 overrides dispose to clean up the component list.
    Protected Overloads Overrides Sub Dispose(ByVal disposing As Boolean)
        If disposing Then
            If Not (components Is Nothing) Then
                components.Dispose()
            End If
        End If
        MyBase.Dispose(disposing)
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    Friend WithEvents dgOrders As System.Windows.Forms.DataGrid
    Friend WithEvents ShippedOrderStyle As System.Windows.Forms.DataGridTableStyle
    Friend WithEvents btnNew As System.Windows.Forms.Button
    Friend WithEvents btnCancelAll As System.Windows.Forms.Button
    Friend WithEvents dgOrderDetails As System.Windows.Forms.DataGrid
    Friend WithEvents Product As System.Windows.Forms.DataGridTextBoxColumn
    Friend WithEvents UnitPrice As System.Windows.Forms.DataGridTextBoxColumn
    Friend WithEvents Quantity As System.Windows.Forms.DataGridTextBoxColumn
    Friend WithEvents Discount As System.Windows.Forms.DataGridTextBoxColumn
    Friend WithEvents QtyPerUnit As System.Windows.Forms.DataGridTextBoxColumn
    Friend WithEvents LineTotal As System.Windows.Forms.DataGridTextBoxColumn
    Friend WithEvents btnUpdate As System.Windows.Forms.Button
    Friend WithEvents btnCancel As System.Windows.Forms.Button
    Friend WithEvents OrderDetailsStyle As System.Windows.Forms.DataGridTableStyle
    Friend WithEvents btnDelete As System.Windows.Forms.Button
    Friend WithEvents lblStatus As System.Windows.Forms.Label
    Friend WithEvents panShipper As System.Windows.Forms.Panel
    Friend WithEvents lblShipVia As System.Windows.Forms.Label
    Friend WithEvents lblFreight As System.Windows.Forms.Label
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents panDates As System.Windows.Forms.Panel
    Friend WithEvents lblRequiredDate As System.Windows.Forms.Label
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents lblShippedDate As System.Windows.Forms.Label
    Friend WithEvents panShipAddress As System.Windows.Forms.Panel
    Friend WithEvents lblShipName As System.Windows.Forms.Label
    Friend WithEvents lblShipAddress As System.Windows.Forms.Label
    Friend WithEvents lblShipCity As System.Windows.Forms.Label
    Friend WithEvents lblShipCountry As System.Windows.Forms.Label
    Friend WithEvents lblShipPostalCode As System.Windows.Forms.Label
    Friend WithEvents gcOrderID As System.Windows.Forms.DataGridTextBoxColumn
    Friend WithEvents gcOrderDate As System.Windows.Forms.DataGridTextBoxColumn
    Friend WithEvents gcRequiredDate As System.Windows.Forms.DataGridTextBoxColumn
    Friend WithEvents gcShippedDate As System.Windows.Forms.DataGridTextBoxColumn
    Friend WithEvents ShipperID As System.Windows.Forms.ComboBox
    Friend WithEvents Freight As System.Windows.Forms.TextBox
    Friend WithEvents OrderDate As System.Windows.Forms.TextBox
    Friend WithEvents RequiredDate As System.Windows.Forms.TextBox
    Friend WithEvents ShippedDate As System.Windows.Forms.TextBox
    Friend WithEvents ShipAddress As System.Windows.Forms.TextBox
    Friend WithEvents ShipCountry As System.Windows.Forms.TextBox
    Friend WithEvents ShipPostalCode As System.Windows.Forms.TextBox
    Friend WithEvents ShipCity As System.Windows.Forms.TextBox
    Friend WithEvents ShipName As System.Windows.Forms.TextBox
    Friend WithEvents btnDeleteOrderDetails As System.Windows.Forms.Button
    Friend WithEvents btnNewOrderDetails As System.Windows.Forms.Button
    Friend WithEvents btnCancelOrderDetails As System.Windows.Forms.Button
    Friend WithEvents DataGridTextBoxColumn1 As System.Windows.Forms.DataGridTextBoxColumn
    Friend WithEvents ProductID As System.Windows.Forms.DataGridTextBoxColumn
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.dgOrders = New System.Windows.Forms.DataGrid()
        Me.ShippedOrderStyle = New System.Windows.Forms.DataGridTableStyle()
        Me.gcOrderID = New System.Windows.Forms.DataGridTextBoxColumn()
        Me.gcOrderDate = New System.Windows.Forms.DataGridTextBoxColumn()
        Me.gcRequiredDate = New System.Windows.Forms.DataGridTextBoxColumn()
        Me.gcShippedDate = New System.Windows.Forms.DataGridTextBoxColumn()
        Me.btnNew = New System.Windows.Forms.Button()
        Me.btnDelete = New System.Windows.Forms.Button()
        Me.btnCancelAll = New System.Windows.Forms.Button()
        Me.OrderDetailsStyle = New System.Windows.Forms.DataGridTableStyle()
        Me.dgOrderDetails = New System.Windows.Forms.DataGrid()
        Me.ProductID = New System.Windows.Forms.DataGridTextBoxColumn()
        Me.Product = New System.Windows.Forms.DataGridTextBoxColumn()
        Me.UnitPrice = New System.Windows.Forms.DataGridTextBoxColumn()
        Me.Quantity = New System.Windows.Forms.DataGridTextBoxColumn()
        Me.Discount = New System.Windows.Forms.DataGridTextBoxColumn()
        Me.QtyPerUnit = New System.Windows.Forms.DataGridTextBoxColumn()
        Me.LineTotal = New System.Windows.Forms.DataGridTextBoxColumn()
        Me.btnUpdate = New System.Windows.Forms.Button()
        Me.btnCancel = New System.Windows.Forms.Button()
        Me.lblStatus = New System.Windows.Forms.Label()
        Me.panShipper = New System.Windows.Forms.Panel()
        Me.ShipperID = New System.Windows.Forms.ComboBox()
        Me.lblShipVia = New System.Windows.Forms.Label()
        Me.Freight = New System.Windows.Forms.TextBox()
        Me.lblFreight = New System.Windows.Forms.Label()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.panDates = New System.Windows.Forms.Panel()
        Me.lblRequiredDate = New System.Windows.Forms.Label()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.lblShippedDate = New System.Windows.Forms.Label()
        Me.OrderDate = New System.Windows.Forms.TextBox()
        Me.RequiredDate = New System.Windows.Forms.TextBox()
        Me.ShippedDate = New System.Windows.Forms.TextBox()
        Me.panShipAddress = New System.Windows.Forms.Panel()
        Me.ShipAddress = New System.Windows.Forms.TextBox()
        Me.ShipCountry = New System.Windows.Forms.TextBox()
        Me.ShipPostalCode = New System.Windows.Forms.TextBox()
        Me.ShipCity = New System.Windows.Forms.TextBox()
        Me.lblShipName = New System.Windows.Forms.Label()
        Me.lblShipAddress = New System.Windows.Forms.Label()
        Me.lblShipCity = New System.Windows.Forms.Label()
        Me.lblShipCountry = New System.Windows.Forms.Label()
        Me.ShipName = New System.Windows.Forms.TextBox()
        Me.lblShipPostalCode = New System.Windows.Forms.Label()
        Me.btnDeleteOrderDetails = New System.Windows.Forms.Button()
        Me.btnNewOrderDetails = New System.Windows.Forms.Button()
        Me.btnCancelOrderDetails = New System.Windows.Forms.Button()
        Me.DataGridTextBoxColumn1 = New System.Windows.Forms.DataGridTextBoxColumn()
        CType(Me.dgOrders, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.dgOrderDetails, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.panShipper.SuspendLayout()
        Me.panDates.SuspendLayout()
        Me.panShipAddress.SuspendLayout()
        Me.SuspendLayout()
        '
        'dgOrders
        '
        Me.dgOrders.AllowNavigation = False
        Me.dgOrders.AlternatingBackColor = System.Drawing.Color.OldLace
        Me.dgOrders.Anchor = ((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
                    Or System.Windows.Forms.AnchorStyles.Right)
        Me.dgOrders.BackColor = System.Drawing.Color.OldLace
        Me.dgOrders.BackgroundColor = System.Drawing.Color.Tan
        Me.dgOrders.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.dgOrders.CaptionBackColor = System.Drawing.Color.SaddleBrown
        Me.dgOrders.CaptionForeColor = System.Drawing.Color.OldLace
        Me.dgOrders.CaptionText = "Orders"
        Me.dgOrders.DataMember = "Orders"
        Me.dgOrders.FlatMode = True
        Me.dgOrders.Font = New System.Drawing.Font("Tahoma", 8.0!)
        Me.dgOrders.ForeColor = System.Drawing.Color.DarkSlateGray
        Me.dgOrders.GridLineColor = System.Drawing.Color.Tan
        Me.dgOrders.HeaderBackColor = System.Drawing.Color.Wheat
        Me.dgOrders.HeaderFont = New System.Drawing.Font("Tahoma", 8.0!, System.Drawing.FontStyle.Bold)
        Me.dgOrders.HeaderForeColor = System.Drawing.Color.SaddleBrown
        Me.dgOrders.LinkColor = System.Drawing.Color.DarkSlateBlue
        Me.dgOrders.Location = New System.Drawing.Point(8, 8)
        Me.dgOrders.Name = "dgOrders"
        Me.dgOrders.ParentRowsBackColor = System.Drawing.Color.OldLace
        Me.dgOrders.ParentRowsForeColor = System.Drawing.Color.DarkSlateGray
        Me.dgOrders.ReadOnly = True
        Me.dgOrders.SelectionBackColor = System.Drawing.Color.SlateGray
        Me.dgOrders.SelectionForeColor = System.Drawing.Color.White
        Me.dgOrders.Size = New System.Drawing.Size(544, 136)
        Me.dgOrders.TabIndex = 6
        Me.dgOrders.TableStyles.AddRange(New System.Windows.Forms.DataGridTableStyle() {Me.ShippedOrderStyle})
        '
        'ShippedOrderStyle
        '
        Me.ShippedOrderStyle.AlternatingBackColor = System.Drawing.Color.OldLace
        Me.ShippedOrderStyle.BackColor = System.Drawing.Color.OldLace
        Me.ShippedOrderStyle.DataGrid = Me.dgOrders
        Me.ShippedOrderStyle.ForeColor = System.Drawing.Color.DarkSlateGray
        Me.ShippedOrderStyle.GridColumnStyles.AddRange(New System.Windows.Forms.DataGridColumnStyle() {Me.gcOrderID, Me.gcOrderDate, Me.gcRequiredDate, Me.gcShippedDate})
        Me.ShippedOrderStyle.GridLineColor = System.Drawing.Color.Tan
        Me.ShippedOrderStyle.HeaderBackColor = System.Drawing.Color.Wheat
        Me.ShippedOrderStyle.HeaderForeColor = System.Drawing.Color.SaddleBrown
        Me.ShippedOrderStyle.LinkColor = System.Drawing.Color.DarkSlateBlue
        Me.ShippedOrderStyle.MappingName = "Orders"
        Me.ShippedOrderStyle.SelectionBackColor = System.Drawing.Color.SlateGray
        Me.ShippedOrderStyle.SelectionForeColor = System.Drawing.Color.White
        '
        'gcOrderID
        '
        Me.gcOrderID.Format = ""
        Me.gcOrderID.FormatInfo = Nothing
        Me.gcOrderID.HeaderText = "Order ID"
        Me.gcOrderID.MappingName = "OrderID"
        Me.gcOrderID.ReadOnly = True
        Me.gcOrderID.Width = 75
        '
        'gcOrderDate
        '
        Me.gcOrderDate.Format = ""
        Me.gcOrderDate.FormatInfo = Nothing
        Me.gcOrderDate.HeaderText = "Ordered On"
        Me.gcOrderDate.MappingName = "OrderDate"
        Me.gcOrderDate.ReadOnly = True
        Me.gcOrderDate.Width = 75
        '
        'gcRequiredDate
        '
        Me.gcRequiredDate.Format = "d"
        Me.gcRequiredDate.FormatInfo = Nothing
        Me.gcRequiredDate.HeaderText = "Required By"
        Me.gcRequiredDate.MappingName = "RequiredDate"
        Me.gcRequiredDate.NullText = ""
        Me.gcRequiredDate.ReadOnly = True
        Me.gcRequiredDate.Width = 75
        '
        'gcShippedDate
        '
        Me.gcShippedDate.Format = "d"
        Me.gcShippedDate.FormatInfo = Nothing
        Me.gcShippedDate.HeaderText = "Shipped On"
        Me.gcShippedDate.MappingName = "ShippedDate"
        Me.gcShippedDate.NullText = ""
        Me.gcShippedDate.Width = 75
        '
        'btnNew
        '
        Me.btnNew.Location = New System.Drawing.Point(560, 152)
        Me.btnNew.Name = "btnNew"
        Me.btnNew.Size = New System.Drawing.Size(72, 24)
        Me.btnNew.TabIndex = 11
        Me.btnNew.Text = "New"
        '
        'btnDelete
        '
        Me.btnDelete.Location = New System.Drawing.Point(560, 184)
        Me.btnDelete.Name = "btnDelete"
        Me.btnDelete.Size = New System.Drawing.Size(72, 24)
        Me.btnDelete.TabIndex = 12
        Me.btnDelete.Text = "Delete"
        '
        'btnCancelAll
        '
        Me.btnCancelAll.Anchor = ((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left) _
                    Or System.Windows.Forms.AnchorStyles.Right)
        Me.btnCancelAll.Location = New System.Drawing.Point(560, 520)
        Me.btnCancelAll.Name = "btnCancelAll"
        Me.btnCancelAll.Size = New System.Drawing.Size(72, 24)
        Me.btnCancelAll.TabIndex = 83
        Me.btnCancelAll.Text = "Ca&ncel All"
        '
        'OrderDetailsStyle
        '
        Me.OrderDetailsStyle.AlternatingBackColor = System.Drawing.Color.OldLace
        Me.OrderDetailsStyle.BackColor = System.Drawing.Color.OldLace
        Me.OrderDetailsStyle.DataGrid = Me.dgOrderDetails
        Me.OrderDetailsStyle.ForeColor = System.Drawing.Color.DarkSlateGray
        Me.OrderDetailsStyle.GridColumnStyles.AddRange(New System.Windows.Forms.DataGridColumnStyle() {Me.ProductID, Me.Product, Me.UnitPrice, Me.Quantity, Me.Discount, Me.QtyPerUnit, Me.LineTotal})
        Me.OrderDetailsStyle.GridLineColor = System.Drawing.Color.Tan
        Me.OrderDetailsStyle.HeaderBackColor = System.Drawing.Color.Wheat
        Me.OrderDetailsStyle.HeaderForeColor = System.Drawing.Color.SaddleBrown
        Me.OrderDetailsStyle.LinkColor = System.Drawing.Color.DarkSlateBlue
        Me.OrderDetailsStyle.MappingName = "Order Details"
        Me.OrderDetailsStyle.SelectionBackColor = System.Drawing.Color.SlateGray
        Me.OrderDetailsStyle.SelectionForeColor = System.Drawing.Color.White
        '
        'dgOrderDetails
        '
        Me.dgOrderDetails.AlternatingBackColor = System.Drawing.Color.OldLace
        Me.dgOrderDetails.Anchor = ((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left) _
                    Or System.Windows.Forms.AnchorStyles.Right)
        Me.dgOrderDetails.BackColor = System.Drawing.Color.OldLace
        Me.dgOrderDetails.BackgroundColor = System.Drawing.Color.Tan
        Me.dgOrderDetails.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.dgOrderDetails.CaptionBackColor = System.Drawing.Color.SaddleBrown
        Me.dgOrderDetails.CaptionForeColor = System.Drawing.Color.OldLace
        Me.dgOrderDetails.CaptionText = "Orders Details"
        Me.dgOrderDetails.DataMember = ""
        Me.dgOrderDetails.FlatMode = True
        Me.dgOrderDetails.Font = New System.Drawing.Font("Tahoma", 8.0!)
        Me.dgOrderDetails.ForeColor = System.Drawing.Color.DarkSlateGray
        Me.dgOrderDetails.GridLineColor = System.Drawing.Color.Tan
        Me.dgOrderDetails.HeaderBackColor = System.Drawing.Color.Wheat
        Me.dgOrderDetails.HeaderFont = New System.Drawing.Font("Tahoma", 8.0!, System.Drawing.FontStyle.Bold)
        Me.dgOrderDetails.HeaderForeColor = System.Drawing.Color.SaddleBrown
        Me.dgOrderDetails.LinkColor = System.Drawing.Color.DarkSlateBlue
        Me.dgOrderDetails.Location = New System.Drawing.Point(8, 320)
        Me.dgOrderDetails.Name = "dgOrderDetails"
        Me.dgOrderDetails.ParentRowsBackColor = System.Drawing.Color.OldLace
        Me.dgOrderDetails.ParentRowsForeColor = System.Drawing.Color.DarkSlateGray
        Me.dgOrderDetails.ReadOnly = True
        Me.dgOrderDetails.SelectionBackColor = System.Drawing.Color.SlateGray
        Me.dgOrderDetails.SelectionForeColor = System.Drawing.Color.White
        Me.dgOrderDetails.Size = New System.Drawing.Size(544, 192)
        Me.dgOrderDetails.TabIndex = 111
        Me.dgOrderDetails.TableStyles.AddRange(New System.Windows.Forms.DataGridTableStyle() {Me.OrderDetailsStyle})
        '
        'ProductID
        '
        Me.ProductID.Format = ""
        Me.ProductID.FormatInfo = Nothing
        Me.ProductID.MappingName = "ProductID"
        Me.ProductID.Width = 75
        '
        'Product
        '
        Me.Product.Format = ""
        Me.Product.FormatInfo = Nothing
        Me.Product.HeaderText = "Product"
        Me.Product.MappingName = "ProductName"
        Me.Product.Width = 75
        '
        'UnitPrice
        '
        Me.UnitPrice.Alignment = System.Windows.Forms.HorizontalAlignment.Right
        Me.UnitPrice.Format = "C"
        Me.UnitPrice.FormatInfo = Nothing
        Me.UnitPrice.HeaderText = "Price Per Unit"
        Me.UnitPrice.MappingName = "UnitPrice"
        Me.UnitPrice.Width = 75
        '
        'Quantity
        '
        Me.Quantity.Alignment = System.Windows.Forms.HorizontalAlignment.Right
        Me.Quantity.Format = "N"
        Me.Quantity.FormatInfo = Nothing
        Me.Quantity.HeaderText = "Quantity"
        Me.Quantity.MappingName = "Quantity"
        Me.Quantity.Width = 75
        '
        'Discount
        '
        Me.Discount.Alignment = System.Windows.Forms.HorizontalAlignment.Right
        Me.Discount.Format = "P"
        Me.Discount.FormatInfo = Nothing
        Me.Discount.HeaderText = "Discount"
        Me.Discount.MappingName = "Discount"
        Me.Discount.Width = 75
        '
        'QtyPerUnit
        '
        Me.QtyPerUnit.Alignment = System.Windows.Forms.HorizontalAlignment.Right
        Me.QtyPerUnit.Format = "N"
        Me.QtyPerUnit.FormatInfo = Nothing
        Me.QtyPerUnit.HeaderText = "Qty Per Unit"
        Me.QtyPerUnit.MappingName = "QtyPerUnt"
        Me.QtyPerUnit.ReadOnly = True
        Me.QtyPerUnit.Width = 75
        '
        'LineTotal
        '
        Me.LineTotal.Alignment = System.Windows.Forms.HorizontalAlignment.Right
        Me.LineTotal.Format = "C"
        Me.LineTotal.FormatInfo = Nothing
        Me.LineTotal.HeaderText = "Total"
        Me.LineTotal.MappingName = "LineTotal"
        Me.LineTotal.ReadOnly = True
        Me.LineTotal.Width = 75
        '
        'btnUpdate
        '
        Me.btnUpdate.Anchor = ((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left) _
                    Or System.Windows.Forms.AnchorStyles.Right)
        Me.btnUpdate.Location = New System.Drawing.Point(480, 520)
        Me.btnUpdate.Name = "btnUpdate"
        Me.btnUpdate.Size = New System.Drawing.Size(72, 24)
        Me.btnUpdate.TabIndex = 82
        Me.btnUpdate.Text = "&Update All"
        '
        'btnCancel
        '
        Me.btnCancel.Location = New System.Drawing.Point(560, 216)
        Me.btnCancel.Name = "btnCancel"
        Me.btnCancel.Size = New System.Drawing.Size(72, 24)
        Me.btnCancel.TabIndex = 107
        Me.btnCancel.Text = "&Cancel"
        '
        'lblStatus
        '
        Me.lblStatus.Location = New System.Drawing.Point(16, 520)
        Me.lblStatus.Name = "lblStatus"
        Me.lblStatus.Size = New System.Drawing.Size(424, 24)
        Me.lblStatus.TabIndex = 112
        '
        'panShipper
        '
        Me.panShipper.BackColor = System.Drawing.Color.OldLace
        Me.panShipper.Controls.AddRange(New System.Windows.Forms.Control() {Me.ShipperID, Me.lblShipVia, Me.Freight, Me.lblFreight})
        Me.panShipper.Enabled = False
        Me.panShipper.Location = New System.Drawing.Point(320, 248)
        Me.panShipper.Name = "panShipper"
        Me.panShipper.Size = New System.Drawing.Size(232, 64)
        Me.panShipper.TabIndex = 110
        '
        'ShipperID
        '
        Me.ShipperID.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.ShipperID.ItemHeight = 13
        Me.ShipperID.Location = New System.Drawing.Point(120, 8)
        Me.ShipperID.Name = "ShipperID"
        Me.ShipperID.Size = New System.Drawing.Size(104, 21)
        Me.ShipperID.TabIndex = 113
        '
        'lblShipVia
        '
        Me.lblShipVia.BackColor = System.Drawing.Color.OldLace
        Me.lblShipVia.Location = New System.Drawing.Point(8, 8)
        Me.lblShipVia.Name = "lblShipVia"
        Me.lblShipVia.TabIndex = 94
        Me.lblShipVia.Text = "Shipper"
        '
        'Freight
        '
        Me.Freight.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.Freight.Location = New System.Drawing.Point(120, 32)
        Me.Freight.Name = "Freight"
        Me.Freight.Size = New System.Drawing.Size(104, 20)
        Me.Freight.TabIndex = 97
        Me.Freight.Text = ""
        '
        'lblFreight
        '
        Me.lblFreight.BackColor = System.Drawing.Color.OldLace
        Me.lblFreight.Location = New System.Drawing.Point(8, 32)
        Me.lblFreight.Name = "lblFreight"
        Me.lblFreight.TabIndex = 95
        Me.lblFreight.Text = "Freight"
        '
        'Label1
        '
        Me.Label1.BackColor = System.Drawing.Color.OldLace
        Me.Label1.Location = New System.Drawing.Point(-160, -91)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(119, 42)
        Me.Label1.TabIndex = 92
        Me.Label1.Text = "Order Date"
        '
        'panDates
        '
        Me.panDates.BackColor = System.Drawing.Color.OldLace
        Me.panDates.Controls.AddRange(New System.Windows.Forms.Control() {Me.lblRequiredDate, Me.Label2, Me.Label1, Me.lblShippedDate, Me.OrderDate, Me.RequiredDate, Me.ShippedDate})
        Me.panDates.Enabled = False
        Me.panDates.Location = New System.Drawing.Point(320, 152)
        Me.panDates.Name = "panDates"
        Me.panDates.Size = New System.Drawing.Size(232, 88)
        Me.panDates.TabIndex = 109
        '
        'lblRequiredDate
        '
        Me.lblRequiredDate.BackColor = System.Drawing.Color.OldLace
        Me.lblRequiredDate.Location = New System.Drawing.Point(8, 32)
        Me.lblRequiredDate.Name = "lblRequiredDate"
        Me.lblRequiredDate.TabIndex = 93
        Me.lblRequiredDate.Text = "Required Date"
        '
        'Label2
        '
        Me.Label2.BackColor = System.Drawing.Color.OldLace
        Me.Label2.Location = New System.Drawing.Point(8, 8)
        Me.Label2.Name = "Label2"
        Me.Label2.TabIndex = 98
        Me.Label2.Text = "Order Date"
        '
        'lblShippedDate
        '
        Me.lblShippedDate.BackColor = System.Drawing.Color.OldLace
        Me.lblShippedDate.Location = New System.Drawing.Point(8, 56)
        Me.lblShippedDate.Name = "lblShippedDate"
        Me.lblShippedDate.TabIndex = 94
        Me.lblShippedDate.Text = "Shipped Date"
        '
        'OrderDate
        '
        Me.OrderDate.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.OrderDate.Location = New System.Drawing.Point(120, 8)
        Me.OrderDate.Name = "OrderDate"
        Me.OrderDate.Size = New System.Drawing.Size(104, 20)
        Me.OrderDate.TabIndex = 95
        Me.OrderDate.Text = ""
        '
        'RequiredDate
        '
        Me.RequiredDate.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.RequiredDate.Location = New System.Drawing.Point(120, 32)
        Me.RequiredDate.Name = "RequiredDate"
        Me.RequiredDate.Size = New System.Drawing.Size(104, 20)
        Me.RequiredDate.TabIndex = 96
        Me.RequiredDate.Text = ""
        '
        'ShippedDate
        '
        Me.ShippedDate.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.ShippedDate.Location = New System.Drawing.Point(120, 56)
        Me.ShippedDate.Name = "ShippedDate"
        Me.ShippedDate.Size = New System.Drawing.Size(104, 20)
        Me.ShippedDate.TabIndex = 97
        Me.ShippedDate.Text = ""
        '
        'panShipAddress
        '
        Me.panShipAddress.BackColor = System.Drawing.Color.OldLace
        Me.panShipAddress.Controls.AddRange(New System.Windows.Forms.Control() {Me.ShipAddress, Me.ShipCountry, Me.ShipPostalCode, Me.ShipCity, Me.lblShipName, Me.lblShipAddress, Me.lblShipCity, Me.lblShipCountry, Me.ShipName, Me.lblShipPostalCode})
        Me.panShipAddress.Enabled = False
        Me.panShipAddress.Location = New System.Drawing.Point(8, 152)
        Me.panShipAddress.Name = "panShipAddress"
        Me.panShipAddress.Size = New System.Drawing.Size(312, 160)
        Me.panShipAddress.TabIndex = 108
        '
        'ShipAddress
        '
        Me.ShipAddress.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.ShipAddress.Location = New System.Drawing.Point(120, 32)
        Me.ShipAddress.Name = "ShipAddress"
        Me.ShipAddress.Size = New System.Drawing.Size(168, 20)
        Me.ShipAddress.TabIndex = 116
        Me.ShipAddress.Text = ""
        '
        'ShipCountry
        '
        Me.ShipCountry.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.ShipCountry.Location = New System.Drawing.Point(120, 104)
        Me.ShipCountry.Name = "ShipCountry"
        Me.ShipCountry.TabIndex = 115
        Me.ShipCountry.Text = ""
        '
        'ShipPostalCode
        '
        Me.ShipPostalCode.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.ShipPostalCode.Location = New System.Drawing.Point(120, 80)
        Me.ShipPostalCode.Name = "ShipPostalCode"
        Me.ShipPostalCode.TabIndex = 114
        Me.ShipPostalCode.Text = ""
        '
        'ShipCity
        '
        Me.ShipCity.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.ShipCity.Location = New System.Drawing.Point(120, 56)
        Me.ShipCity.Name = "ShipCity"
        Me.ShipCity.Size = New System.Drawing.Size(168, 20)
        Me.ShipCity.TabIndex = 113
        Me.ShipCity.Text = ""
        '
        'lblShipName
        '
        Me.lblShipName.BackColor = System.Drawing.Color.OldLace
        Me.lblShipName.Location = New System.Drawing.Point(8, 8)
        Me.lblShipName.Name = "lblShipName"
        Me.lblShipName.TabIndex = 106
        Me.lblShipName.Text = "ShipName"
        '
        'lblShipAddress
        '
        Me.lblShipAddress.BackColor = System.Drawing.Color.OldLace
        Me.lblShipAddress.Location = New System.Drawing.Point(8, 32)
        Me.lblShipAddress.Name = "lblShipAddress"
        Me.lblShipAddress.TabIndex = 107
        Me.lblShipAddress.Text = "Address"
        '
        'lblShipCity
        '
        Me.lblShipCity.BackColor = System.Drawing.Color.OldLace
        Me.lblShipCity.Location = New System.Drawing.Point(8, 56)
        Me.lblShipCity.Name = "lblShipCity"
        Me.lblShipCity.TabIndex = 108
        Me.lblShipCity.Text = "City"
        '
        'lblShipCountry
        '
        Me.lblShipCountry.BackColor = System.Drawing.Color.OldLace
        Me.lblShipCountry.Location = New System.Drawing.Point(8, 104)
        Me.lblShipCountry.Name = "lblShipCountry"
        Me.lblShipCountry.TabIndex = 111
        Me.lblShipCountry.Text = "Country"
        '
        'ShipName
        '
        Me.ShipName.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.ShipName.Location = New System.Drawing.Point(120, 8)
        Me.ShipName.Name = "ShipName"
        Me.ShipName.TabIndex = 112
        Me.ShipName.Text = ""
        '
        'lblShipPostalCode
        '
        Me.lblShipPostalCode.BackColor = System.Drawing.Color.OldLace
        Me.lblShipPostalCode.Location = New System.Drawing.Point(8, 80)
        Me.lblShipPostalCode.Name = "lblShipPostalCode"
        Me.lblShipPostalCode.TabIndex = 110
        Me.lblShipPostalCode.Text = "Postal Code"
        '
        'btnDeleteOrderDetails
        '
        Me.btnDeleteOrderDetails.Location = New System.Drawing.Point(560, 352)
        Me.btnDeleteOrderDetails.Name = "btnDeleteOrderDetails"
        Me.btnDeleteOrderDetails.Size = New System.Drawing.Size(72, 24)
        Me.btnDeleteOrderDetails.TabIndex = 114
        Me.btnDeleteOrderDetails.Text = "Delete"
        '
        'btnNewOrderDetails
        '
        Me.btnNewOrderDetails.Location = New System.Drawing.Point(560, 320)
        Me.btnNewOrderDetails.Name = "btnNewOrderDetails"
        Me.btnNewOrderDetails.Size = New System.Drawing.Size(72, 24)
        Me.btnNewOrderDetails.TabIndex = 113
        Me.btnNewOrderDetails.Text = "New"
        '
        'btnCancelOrderDetails
        '
        Me.btnCancelOrderDetails.Location = New System.Drawing.Point(560, 384)
        Me.btnCancelOrderDetails.Name = "btnCancelOrderDetails"
        Me.btnCancelOrderDetails.Size = New System.Drawing.Size(72, 24)
        Me.btnCancelOrderDetails.TabIndex = 115
        Me.btnCancelOrderDetails.Text = "&Cancel"
        '
        'DataGridTextBoxColumn1
        '
        Me.DataGridTextBoxColumn1.Format = ""
        Me.DataGridTextBoxColumn1.FormatInfo = Nothing
        Me.DataGridTextBoxColumn1.MappingName = "OrderID"
        Me.DataGridTextBoxColumn1.Width = 75
        '
        'OrdersForm
        '
        Me.AutoScaleBaseSize = New System.Drawing.Size(5, 13)
        Me.BackColor = System.Drawing.Color.OldLace
        Me.ClientSize = New System.Drawing.Size(640, 555)
        Me.Controls.AddRange(New System.Windows.Forms.Control() {Me.btnCancelOrderDetails, Me.btnDeleteOrderDetails, Me.btnNewOrderDetails, Me.lblStatus, Me.btnCancelAll, Me.dgOrderDetails, Me.btnUpdate, Me.btnCancel, Me.panShipAddress, Me.panDates, Me.panShipper, Me.btnDelete, Me.btnNew, Me.dgOrders})
        Me.Name = "OrdersForm"
        CType(Me.dgOrders, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.dgOrderDetails, System.ComponentModel.ISupportInitialize).EndInit()
        Me.panShipper.ResumeLayout(False)
        Me.panDates.ResumeLayout(False)
        Me.panShipAddress.ResumeLayout(False)
        Me.ResumeLayout(False)

    End Sub

#End Region

    Private _CustID As String
    Private _dsOrders As DataSet
    Private _dsLookups As DataSet

    Public Sub New(ByVal CustID As String)

        Me.New()

        _CustID = CustID

        ' create an instance of the orders Web Service
        ' and fetch the data
        Dim wsOrders As New OrdersService.RemotingOrders()
        _dsOrders = wsOrders.Orders(CustID)
        _dsLookups = wsOrders.Lookups()

        BindData()

        ' set some default values for new rows
        _dsOrders.Tables("Orders").Columns("CustomerID").DefaultValue = _CustID
        _dsOrders.Tables("Orders").Columns("ShipVia").DefaultValue = _dsLookups.Tables("Shippers").Rows(0)("ShipperID")

        ' set the position for the first row
        ' this ensures that the buttons/textboxes are enabled or disabled according to the data
        OrdersRowPosition_Changed(Me.BindingContext(_dsOrders, "Orders"), CType(Nothing, EventArgs))



    End Sub


    Private Sub BindData()

        ' Add the delegate for the PositionChanged event.
        AddHandler Me.BindingContext(_dsOrders, "Orders").PositionChanged, AddressOf OrdersRowPosition_Changed

        ' bind the orders grid to the orders for that customer
        dgOrders.SetDataBinding(_dsOrders, "Orders")

        ' and bind the order details grid to the relation in the dataset
        ' this keeps them in sync
        dgOrderDetails.SetDataBinding(_dsOrders, "Orders.CustOrders")
        dgOrderDetails.ReadOnly = False

        ' and bind the textboxes
        ShipPostalCode.DataBindings.Add("Text", _dsOrders, "Orders.ShipPostalCode")
        ShipCountry.DataBindings.Add("Text", _dsOrders, "Orders.ShipCountry")
        ShipCity.DataBindings.Add("Text", _dsOrders, "Orders.ShipCity")
        ShipAddress.DataBindings.Add("Text", _dsOrders, "Orders.ShipAddress")
        ShipName.DataBindings.Add("Text", _dsOrders, "Orders.ShipName")
        Freight.DataBindings.Add("Text", _dsOrders, "Orders.Freight")
        ShippedDate.DataBindings.Add("Text", _dsOrders, "Orders.ShippedDate")
        RequiredDate.DataBindings.Add("Text", _dsOrders, "Orders.RequiredDate")
        OrderDate.DataBindings.Add("Text", _dsOrders, "Orders.OrderDate")

        ' load and bind shipper details
        ShipperID.DataSource = _dsLookups.Tables("Shippers")
        ShipperID.DisplayMember = "ShipperName"
        ShipperID.ValueMember = "ShipperID"
        ShipperID.DataBindings.Add("SelectedValue", _dsOrders, "Orders.ShipVia")

    End Sub


    ' add a new order
    Private Sub btnNew_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnNew.Click

        ' Clear out the current edits
        Me.BindingContext(_dsOrders, "Orders").EndCurrentEdit()
        Me.BindingContext(_dsOrders, "Orders").AddNew()

        SetButtonUsability(True)

    End Sub


    ' delete the current order
    Private Sub btnDelete_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnDelete.Click

        Dim cmgr As CurrencyManager = Me.BindingContext(_dsOrders, "Orders")

        If MessageBox.Show("Are you sure you wish to delete this order?", "Delete Order", _
                    MessageBoxButtons.YesNo, MessageBoxIcon.Question) = DialogResult.Yes Then

            ' now we can delete the parent row
            cmgr.RemoveAt(cmgr.Position)

        End If

    End Sub


    ' the current row has been changed
    Private Sub OrdersRowPosition_Changed(ByVal sender As Object, ByVal e As EventArgs)

        Dim CurrentRowView As DataRowView = CType(sender, CurrencyManager).Current

        ' change enabled state of editable controls based
        ' on whether the order has been shipped or not
        Dim AllowEdit = CurrentRowView.Item("ShippedDate").ToString() = ""
        SetButtonUsability(AllowEdit)

    End Sub


    Private Sub SetButtonUsability(ByVal Allowed As Boolean)

        btnDelete.Enabled = Allowed
        btnDeleteOrderDetails.Enabled = Allowed
        btnNewOrderDetails.Enabled = Allowed
        btnCancelOrderDetails.Enabled = Allowed
        btnCancel.Enabled = Allowed
        panDates.Enabled = Allowed
        panShipAddress.Enabled = Allowed
        panShipper.Enabled = Allowed
        dgOrderDetails.Enabled = Allowed

    End Sub


    Private Sub btnCancelAll_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCancelAll.Click

        ' cancel any current edits
        Me.BindingContext(_dsOrders, "Orders.CustOrders").CancelCurrentEdit()
        Me.BindingContext(_dsOrders, "Orders").CancelCurrentEdit()

        ' reject all changes
        Me._dsOrders.RejectChanges()

        ' clear the errors
        ClearAllErrors()

    End Sub


    ' cancel changes to the current order
    Private Sub btnCancel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCancel.Click

        Me.BindingContext(_dsOrders, "Orders").CancelCurrentEdit()

    End Sub


    ' process all of the updates
    Private Sub btnUpdate_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnUpdate.Click

        Dim OrdersService As OrdersService.RemotingOrders

        ' Stop any current edits.
        Me.BindingContext(_dsOrders, "Orders").EndCurrentEdit()
        Me.BindingContext(_dsOrders, "Orders.CustOrders").EndCurrentEdit()

        ' Check to see if any changes have been made.
        If _dsOrders.HasChanges Then

            Dim dsUpdate As DataSet
            Dim dsChanges As DataSet

            ' Clear all old errors in the Customers table before
            ' we attempt to save
            ClearAllErrors()

            ' Get the changes that have been made to the main dataset.
            dsChanges = _dsOrders.GetChanges()

            If Not (dsChanges Is Nothing) Then
                
                ' update the data source
                OrdersService = New OrdersService.RemotingOrders()
                dsUpdate = OrdersService.UpdateOrders(_CustID, dsChanges)

                ' clear the current data
                ' it will be reloaded with the full data returned from the web service
                _dsOrders.Clear()

                ' merge the changed rows back into the original data
                _dsOrders.Merge(dsUpdate, False)

                ' If there are errors show the error form
                If _dsOrders.HasErrors Then
                    Dim f As New ErrorsForm(_CustID, dsUpdate, _dsLookups)
                    Me.AddOwnedForm(f)
                    f.Show()

                    ' add a handler so that we know when the error form has been closed
                    AddHandler f.Closed, AddressOf ErrorFormClosed
                Else
                    ' no errors, so just accept the changes
                    _dsOrders.AcceptChanges()
                End If
            End If
        End If

    End Sub


    ' clear all existing error details
    Private Sub ClearAllErrors()

        Dim dt As DataTable
        Dim dr As DataRow
        For Each dt In _dsOrders.Tables
            For Each dr In dt.Rows
                dr.ClearErrors()
            Next
        Next

    End Sub


    ' the errors form has been closed so refresh the data
    Private Sub ErrorFormClosed(ByVal sender As Object, ByVal e As EventArgs)

        Dim wsOrders As New OrdersService.RemotingOrders()
        Dim dsOrders As DataSet = wsOrders.Orders(_CustID)

        _dsOrders.Merge(dsOrders, False)
        _dsOrders.AcceptChanges()

    End Sub


    ' add a new order detail row
    Private Sub btnNewOrderDetails_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnNewOrderDetails.Click

        Me.BindingContext(_dsOrders, "Orders.CustOrders").EndCurrentEdit()
        Me.BindingContext(_dsOrders, "Orders.CustOrders").AddNew()

    End Sub


    ' delete the current order detail row
    Private Sub btnDeleteOrderDetails_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnDeleteOrderDetails.Click

        Dim cmgr As CurrencyManager = Me.BindingContext(_dsOrders, "Orders.CustOrders")

        If (cmgr.Count > 0) Then

            If MessageBox.Show("Are you sure you wish to delete this order line?", "Delete Order Line", _
                        MessageBoxButtons.YesNo, MessageBoxIcon.Question) = DialogResult.Yes Then

                ' now we can delete the row
                cmgr.RemoveAt(cmgr.Position)

            End If
        End If

    End Sub

    ' cancel changes to the current order line
    Private Sub btnCancelOrderDetails_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCancelOrderDetails.Click

        Me.BindingContext(_dsOrders, "Orders.CustOrders").CancelCurrentEdit()

    End Sub

End Class
