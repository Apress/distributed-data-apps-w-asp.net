Public Class frmOrders
    Inherits System.Windows.Forms.Form

#Region " Windows Form Designer generated code "

    Public Sub New()
        MyBase.New()

        'This call is required by the Windows Form Designer.
        InitializeComponent()

        'Add any initialization after the InitializeComponent() call
    End Sub

    'Form overrides dispose to clean up the component list.
    Protected Overloads Overrides Sub Dispose(ByVal disposing As Boolean)
        If disposing Then
            If Not (components Is Nothing) Then
                components.Dispose()
            End If
        End If
        MyBase.Dispose(disposing)

    End Sub
    Friend WithEvents dgOrders As System.Windows.Forms.DataGrid
    Friend WithEvents Orders As System.Windows.Forms.DataGridTableStyle
    Friend WithEvents OrderID As System.Windows.Forms.DataGridTextBoxColumn
    Friend WithEvents ShipName As System.Windows.Forms.DataGridTextBoxColumn
    Friend WithEvents ShipTo As System.Windows.Forms.DataGridTextBoxColumn
    Friend WithEvents OrderedOn As System.Windows.Forms.DataGridTextBoxColumn
    Friend WithEvents ShippedOn As System.Windows.Forms.DataGridTextBoxColumn
    Friend WithEvents Product As System.Windows.Forms.DataGridTextBoxColumn
    Friend WithEvents QtyPerUnit As System.Windows.Forms.DataGridTextBoxColumn
    Friend WithEvents UnitPrice As System.Windows.Forms.DataGridTextBoxColumn
    Friend WithEvents Quantity As System.Windows.Forms.DataGridTextBoxColumn
    Friend WithEvents Discount As System.Windows.Forms.DataGridTextBoxColumn
    Friend WithEvents CustOrderLines As System.Windows.Forms.DataGridTableStyle

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.dgOrders = New System.Windows.Forms.DataGrid()
        Me.Orders = New System.Windows.Forms.DataGridTableStyle()
        Me.OrderID = New System.Windows.Forms.DataGridTextBoxColumn()
        Me.ShipName = New System.Windows.Forms.DataGridTextBoxColumn()
        Me.ShipTo = New System.Windows.Forms.DataGridTextBoxColumn()
        Me.OrderedOn = New System.Windows.Forms.DataGridTextBoxColumn()
        Me.ShippedOn = New System.Windows.Forms.DataGridTextBoxColumn()
        Me.CustOrderLines = New System.Windows.Forms.DataGridTableStyle()
        Me.Product = New System.Windows.Forms.DataGridTextBoxColumn()
        Me.QtyPerUnit = New System.Windows.Forms.DataGridTextBoxColumn()
        Me.UnitPrice = New System.Windows.Forms.DataGridTextBoxColumn()
        Me.Quantity = New System.Windows.Forms.DataGridTextBoxColumn()
        Me.Discount = New System.Windows.Forms.DataGridTextBoxColumn()
        CType(Me.dgOrders, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'dgOrders
        '
        Me.dgOrders.AlternatingBackColor = System.Drawing.Color.OldLace
        Me.dgOrders.Anchor = (((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
                    Or System.Windows.Forms.AnchorStyles.Left) _
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
        Me.dgOrders.Name = "dgOrders"
        Me.dgOrders.ParentRowsBackColor = System.Drawing.Color.OldLace
        Me.dgOrders.ParentRowsForeColor = System.Drawing.Color.DarkSlateGray
        Me.dgOrders.ReadOnly = True
        Me.dgOrders.SelectionBackColor = System.Drawing.Color.SlateGray
        Me.dgOrders.SelectionForeColor = System.Drawing.Color.White
        Me.dgOrders.Size = New System.Drawing.Size(672, 440)
        Me.dgOrders.TabIndex = 5
        Me.dgOrders.TableStyles.AddRange(New System.Windows.Forms.DataGridTableStyle() {Me.Orders, Me.CustOrderLines})
        '
        'Orders
        '
        Me.Orders.DataGrid = Me.dgOrders
        Me.Orders.GridColumnStyles.AddRange(New System.Windows.Forms.DataGridColumnStyle() {Me.OrderID, Me.ShipName, Me.ShipTo, Me.OrderedOn, Me.ShippedOn})
        Me.Orders.HeaderForeColor = System.Drawing.SystemColors.ControlText
        Me.Orders.MappingName = "Orders"
        Me.Orders.ReadOnly = True
        '
        'OrderID
        '
        Me.OrderID.Format = ""
        Me.OrderID.FormatInfo = Nothing
        Me.OrderID.HeaderText = "Order ID"
        Me.OrderID.MappingName = "OrderID"
        Me.OrderID.Width = 75
        '
        'ShipName
        '
        Me.ShipName.Format = ""
        Me.ShipName.FormatInfo = Nothing
        Me.ShipName.HeaderText = "Ship By"
        Me.ShipName.MappingName = "ShipName"
        Me.ShipName.Width = 75
        '
        'ShipTo
        '
        Me.ShipTo.Format = ""
        Me.ShipTo.FormatInfo = Nothing
        Me.ShipTo.HeaderText = "Ship To"
        Me.ShipTo.MappingName = "OrderAddress"
        Me.ShipTo.Width = 75
        '
        'OrderedOn
        '
        Me.OrderedOn.Format = ""
        Me.OrderedOn.FormatInfo = Nothing
        Me.OrderedOn.HeaderText = "Ordered On"
        Me.OrderedOn.MappingName = "OrderDate"
        Me.OrderedOn.Width = 75
        '
        'ShippedOn
        '
        Me.ShippedOn.Format = ""
        Me.ShippedOn.FormatInfo = Nothing
        Me.ShippedOn.HeaderText = "Shipped on"
        Me.ShippedOn.MappingName = "ShippedDate"
        Me.ShippedOn.NullText = "not yet shipped"
        Me.ShippedOn.Width = 75
        '
        'CustOrderLines
        '
        Me.CustOrderLines.DataGrid = Me.dgOrders
        Me.CustOrderLines.GridColumnStyles.AddRange(New System.Windows.Forms.DataGridColumnStyle() {Me.Product, Me.QtyPerUnit, Me.UnitPrice, Me.Quantity, Me.Discount})
        Me.CustOrderLines.HeaderForeColor = System.Drawing.SystemColors.ControlText
        Me.CustOrderLines.MappingName = "CustOrderLines"
        Me.CustOrderLines.ReadOnly = True
        '
        'Product
        '
        Me.Product.Format = ""
        Me.Product.FormatInfo = Nothing
        Me.Product.HeaderText = "Product"
        Me.Product.MappingName = "ProductName"
        Me.Product.Width = 75
        '
        'QtyPerUnit
        '
        Me.QtyPerUnit.Format = ""
        Me.QtyPerUnit.FormatInfo = Nothing
        Me.QtyPerUnit.HeaderText = "Qty Per Unit"
        Me.QtyPerUnit.MappingName = "QuantityPerUnit"
        Me.QtyPerUnit.Width = 75
        '
        'UnitPrice
        '
        Me.UnitPrice.Format = ""
        Me.UnitPrice.FormatInfo = Nothing
        Me.UnitPrice.HeaderText = "unit Price"
        Me.UnitPrice.MappingName = "UnitPrice"
        Me.UnitPrice.Width = 75
        '
        'Quantity
        '
        Me.Quantity.Format = ""
        Me.Quantity.FormatInfo = Nothing
        Me.Quantity.HeaderText = "Quantity"
        Me.Quantity.MappingName = "Quantity"
        Me.Quantity.Width = 75
        '
        'Discount
        '
        Me.Discount.Format = ""
        Me.Discount.FormatInfo = Nothing
        Me.Discount.HeaderText = "Discount"
        Me.Discount.MappingName = "Discount"
        Me.Discount.Width = 75
        '
        'frmOrders
        '
        Me.AutoScaleBaseSize = New System.Drawing.Size(5, 13)
        Me.BackColor = System.Drawing.Color.OldLace
        Me.ClientSize = New System.Drawing.Size(672, 487)
        Me.Controls.AddRange(New System.Windows.Forms.Control() {Me.dgOrders})
        Me.Name = "frmOrders"
        Me.Text = "Orders"
        CType(Me.dgOrders, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)

    End Sub

#End Region


    Public Sub New(ByVal CustID As String)

        Me.New()

        Dim wsOrders As New Orders.RemotingOrders()

        ' and bind the orders grid to the orders for that customer
        dgOrders.DataSource = wsOrders.Orders(CustID)

    End Sub

End Class
