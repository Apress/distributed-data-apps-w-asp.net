Public Class ErrorsForm
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

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    Friend WithEvents btnMoveFirst As System.Windows.Forms.Button
    Friend WithEvents btnMovePrev As System.Windows.Forms.Button
    Friend WithEvents btnMoveNext As System.Windows.Forms.Button
    Friend WithEvents btnMoveLast As System.Windows.Forms.Button
    Friend WithEvents btnMoveFirstDetail As System.Windows.Forms.Button
    Friend WithEvents btnMovePrevDetail As System.Windows.Forms.Button
    Friend WithEvents btnMoveNextDetail As System.Windows.Forms.Button
    Friend WithEvents btnMoveLastDetail As System.Windows.Forms.Button
    Friend WithEvents btnSave As System.Windows.Forms.Button
    Friend WithEvents ErrorProvider1 As System.Windows.Forms.ErrorProvider
    Friend WithEvents Label19 As System.Windows.Forms.Label
    Friend WithEvents Label18 As System.Windows.Forms.Label
    Friend WithEvents Label17 As System.Windows.Forms.Label
    Friend WithEvents Label16 As System.Windows.Forms.Label
    Friend WithEvents lblShipVia As System.Windows.Forms.Label
    Friend WithEvents lblFreight As System.Windows.Forms.Label
    Friend WithEvents lblRequiredDate As System.Windows.Forms.Label
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents lblShippedDate As System.Windows.Forms.Label
    Friend WithEvents lblShipName As System.Windows.Forms.Label
    Friend WithEvents lblShipAddress As System.Windows.Forms.Label
    Friend WithEvents lblShipCity As System.Windows.Forms.Label
    Friend WithEvents lblShipCountry As System.Windows.Forms.Label
    Friend WithEvents lblShipPostalCode As System.Windows.Forms.Label
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents lblOrderNumber As System.Windows.Forms.Label
    Friend WithEvents lblOrderError As System.Windows.Forms.Label
    Friend WithEvents lblOrderNav As System.Windows.Forms.Label
    Friend WithEvents lblOrderDetailsNav As System.Windows.Forms.Label
    Friend WithEvents lblOrderDetailsError As System.Windows.Forms.Label
    Friend WithEvents ShipCity As System.Windows.Forms.Label
    Friend WithEvents ShipName As System.Windows.Forms.Label
    Friend WithEvents ShipAddress As System.Windows.Forms.Label
    Friend WithEvents ShipPostalCode As System.Windows.Forms.Label
    Friend WithEvents ShipCountry As System.Windows.Forms.Label
    Friend WithEvents OrderDate As System.Windows.Forms.Label
    Friend WithEvents RequiredDate As System.Windows.Forms.Label
    Friend WithEvents ShippedDate As System.Windows.Forms.Label
    Friend WithEvents Freight As System.Windows.Forms.Label
    Friend WithEvents ShipperName As System.Windows.Forms.Label
    Friend WithEvents Discount As System.Windows.Forms.Label
    Friend WithEvents Quantity As System.Windows.Forms.Label
    Friend WithEvents UnitPrice As System.Windows.Forms.Label
    Friend Shadows WithEvents ProductName As System.Windows.Forms.Label
    Friend WithEvents ErrorProvider2 As System.Windows.Forms.ErrorProvider
    Friend WithEvents Label4 As System.Windows.Forms.Label
    Friend WithEvents lblOriginalValue As System.Windows.Forms.Label
    Friend WithEvents btnKeepMine As System.Windows.Forms.Button
    Friend WithEvents btnKeepTheirs As System.Windows.Forms.Button
    Friend WithEvents panOriginal As System.Windows.Forms.Panel
    Friend WithEvents lblStatus As System.Windows.Forms.Label
    Friend WithEvents btnCancel As System.Windows.Forms.Button
    Friend WithEvents ProductID As System.Windows.Forms.Label
    Friend WithEvents btnDeletedDelete As System.Windows.Forms.Button
    Friend WithEvents btnDeletedLeaveIn As System.Windows.Forms.Button
    Friend WithEvents panDeleted As System.Windows.Forms.Panel
    Friend WithEvents panDeletedDetails As System.Windows.Forms.Panel
    Friend WithEvents btnDeletedDetailsLeave As System.Windows.Forms.Button
    Friend WithEvents btnDeletedDetailsDelete As System.Windows.Forms.Button
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.btnMoveFirst = New System.Windows.Forms.Button()
        Me.btnMovePrev = New System.Windows.Forms.Button()
        Me.btnMoveNext = New System.Windows.Forms.Button()
        Me.btnMoveLast = New System.Windows.Forms.Button()
        Me.btnMoveFirstDetail = New System.Windows.Forms.Button()
        Me.btnMovePrevDetail = New System.Windows.Forms.Button()
        Me.btnMoveNextDetail = New System.Windows.Forms.Button()
        Me.btnMoveLastDetail = New System.Windows.Forms.Button()
        Me.btnSave = New System.Windows.Forms.Button()
        Me.ErrorProvider1 = New System.Windows.Forms.ErrorProvider()
        Me.Label19 = New System.Windows.Forms.Label()
        Me.Label18 = New System.Windows.Forms.Label()
        Me.Label17 = New System.Windows.Forms.Label()
        Me.Label16 = New System.Windows.Forms.Label()
        Me.lblShipVia = New System.Windows.Forms.Label()
        Me.lblFreight = New System.Windows.Forms.Label()
        Me.lblRequiredDate = New System.Windows.Forms.Label()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.lblShippedDate = New System.Windows.Forms.Label()
        Me.lblShipName = New System.Windows.Forms.Label()
        Me.lblShipAddress = New System.Windows.Forms.Label()
        Me.lblShipCity = New System.Windows.Forms.Label()
        Me.lblShipCountry = New System.Windows.Forms.Label()
        Me.lblShipPostalCode = New System.Windows.Forms.Label()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.Label3 = New System.Windows.Forms.Label()
        Me.lblOrderNumber = New System.Windows.Forms.Label()
        Me.lblOrderError = New System.Windows.Forms.Label()
        Me.lblOrderNav = New System.Windows.Forms.Label()
        Me.lblOrderDetailsNav = New System.Windows.Forms.Label()
        Me.lblOrderDetailsError = New System.Windows.Forms.Label()
        Me.ShipCity = New System.Windows.Forms.Label()
        Me.ShipName = New System.Windows.Forms.Label()
        Me.ShipAddress = New System.Windows.Forms.Label()
        Me.ShipPostalCode = New System.Windows.Forms.Label()
        Me.ShipCountry = New System.Windows.Forms.Label()
        Me.OrderDate = New System.Windows.Forms.Label()
        Me.RequiredDate = New System.Windows.Forms.Label()
        Me.ShippedDate = New System.Windows.Forms.Label()
        Me.Freight = New System.Windows.Forms.Label()
        Me.ShipperName = New System.Windows.Forms.Label()
        Me.Discount = New System.Windows.Forms.Label()
        Me.Quantity = New System.Windows.Forms.Label()
        Me.UnitPrice = New System.Windows.Forms.Label()
        Me.ProductName = New System.Windows.Forms.Label()
        Me.ErrorProvider2 = New System.Windows.Forms.ErrorProvider()
        Me.panOriginal = New System.Windows.Forms.Panel()
        Me.btnKeepTheirs = New System.Windows.Forms.Button()
        Me.btnKeepMine = New System.Windows.Forms.Button()
        Me.lblOriginalValue = New System.Windows.Forms.Label()
        Me.Label4 = New System.Windows.Forms.Label()
        Me.lblStatus = New System.Windows.Forms.Label()
        Me.btnCancel = New System.Windows.Forms.Button()
        Me.ProductID = New System.Windows.Forms.Label()
        Me.panDeleted = New System.Windows.Forms.Panel()
        Me.btnDeletedLeaveIn = New System.Windows.Forms.Button()
        Me.btnDeletedDelete = New System.Windows.Forms.Button()
        Me.panDeletedDetails = New System.Windows.Forms.Panel()
        Me.btnDeletedDetailsLeave = New System.Windows.Forms.Button()
        Me.btnDeletedDetailsDelete = New System.Windows.Forms.Button()
        Me.panOriginal.SuspendLayout()
        Me.panDeleted.SuspendLayout()
        Me.panDeletedDetails.SuspendLayout()
        Me.SuspendLayout()
        '
        'btnMoveFirst
        '
        Me.btnMoveFirst.FlatStyle = System.Windows.Forms.FlatStyle.System
        Me.btnMoveFirst.Location = New System.Drawing.Point(8, 32)
        Me.btnMoveFirst.Name = "btnMoveFirst"
        Me.btnMoveFirst.Size = New System.Drawing.Size(24, 24)
        Me.btnMoveFirst.TabIndex = 130
        Me.btnMoveFirst.Text = "|<"
        '
        'btnMovePrev
        '
        Me.btnMovePrev.FlatStyle = System.Windows.Forms.FlatStyle.System
        Me.btnMovePrev.Location = New System.Drawing.Point(32, 32)
        Me.btnMovePrev.Name = "btnMovePrev"
        Me.btnMovePrev.Size = New System.Drawing.Size(24, 24)
        Me.btnMovePrev.TabIndex = 131
        Me.btnMovePrev.Text = "<"
        '
        'btnMoveNext
        '
        Me.btnMoveNext.FlatStyle = System.Windows.Forms.FlatStyle.System
        Me.btnMoveNext.Location = New System.Drawing.Point(96, 32)
        Me.btnMoveNext.Name = "btnMoveNext"
        Me.btnMoveNext.Size = New System.Drawing.Size(24, 24)
        Me.btnMoveNext.TabIndex = 132
        Me.btnMoveNext.Text = ">"
        '
        'btnMoveLast
        '
        Me.btnMoveLast.FlatStyle = System.Windows.Forms.FlatStyle.System
        Me.btnMoveLast.Location = New System.Drawing.Point(120, 32)
        Me.btnMoveLast.Name = "btnMoveLast"
        Me.btnMoveLast.Size = New System.Drawing.Size(24, 24)
        Me.btnMoveLast.TabIndex = 133
        Me.btnMoveLast.Text = ">|"
        '
        'btnMoveFirstDetail
        '
        Me.btnMoveFirstDetail.FlatStyle = System.Windows.Forms.FlatStyle.System
        Me.btnMoveFirstDetail.Location = New System.Drawing.Point(352, 176)
        Me.btnMoveFirstDetail.Name = "btnMoveFirstDetail"
        Me.btnMoveFirstDetail.Size = New System.Drawing.Size(24, 24)
        Me.btnMoveFirstDetail.TabIndex = 134
        Me.btnMoveFirstDetail.Text = "|<"
        '
        'btnMovePrevDetail
        '
        Me.btnMovePrevDetail.FlatStyle = System.Windows.Forms.FlatStyle.System
        Me.btnMovePrevDetail.Location = New System.Drawing.Point(376, 176)
        Me.btnMovePrevDetail.Name = "btnMovePrevDetail"
        Me.btnMovePrevDetail.Size = New System.Drawing.Size(24, 24)
        Me.btnMovePrevDetail.TabIndex = 135
        Me.btnMovePrevDetail.Text = "<"
        '
        'btnMoveNextDetail
        '
        Me.btnMoveNextDetail.FlatStyle = System.Windows.Forms.FlatStyle.System
        Me.btnMoveNextDetail.Location = New System.Drawing.Point(440, 176)
        Me.btnMoveNextDetail.Name = "btnMoveNextDetail"
        Me.btnMoveNextDetail.Size = New System.Drawing.Size(24, 24)
        Me.btnMoveNextDetail.TabIndex = 136
        Me.btnMoveNextDetail.Text = ">"
        '
        'btnMoveLastDetail
        '
        Me.btnMoveLastDetail.FlatStyle = System.Windows.Forms.FlatStyle.System
        Me.btnMoveLastDetail.Location = New System.Drawing.Point(464, 176)
        Me.btnMoveLastDetail.Name = "btnMoveLastDetail"
        Me.btnMoveLastDetail.Size = New System.Drawing.Size(24, 24)
        Me.btnMoveLastDetail.TabIndex = 137
        Me.btnMoveLastDetail.Text = ">|"
        '
        'btnSave
        '
        Me.btnSave.Location = New System.Drawing.Point(608, 416)
        Me.btnSave.Name = "btnSave"
        Me.btnSave.Size = New System.Drawing.Size(120, 23)
        Me.btnSave.TabIndex = 138
        Me.btnSave.Text = "Save All Changes"
        '
        'ErrorProvider1
        '
        Me.ErrorProvider1.BlinkStyle = System.Windows.Forms.ErrorBlinkStyle.NeverBlink
        Me.ErrorProvider1.DataMember = Nothing
        '
        'Label19
        '
        Me.Label19.Location = New System.Drawing.Point(352, 296)
        Me.Label19.Name = "Label19"
        Me.Label19.TabIndex = 146
        Me.Label19.Text = "Discount"
        '
        'Label18
        '
        Me.Label18.Location = New System.Drawing.Point(352, 272)
        Me.Label18.Name = "Label18"
        Me.Label18.TabIndex = 145
        Me.Label18.Text = "Quantity"
        '
        'Label17
        '
        Me.Label17.Location = New System.Drawing.Point(352, 248)
        Me.Label17.Name = "Label17"
        Me.Label17.TabIndex = 144
        Me.Label17.Text = "Unit Price"
        '
        'Label16
        '
        Me.Label16.Location = New System.Drawing.Point(352, 224)
        Me.Label16.Name = "Label16"
        Me.Label16.TabIndex = 143
        Me.Label16.Text = "Product"
        '
        'lblShipVia
        '
        Me.lblShipVia.Location = New System.Drawing.Point(16, 280)
        Me.lblShipVia.Name = "lblShipVia"
        Me.lblShipVia.TabIndex = 155
        Me.lblShipVia.Text = "Shipper"
        '
        'lblFreight
        '
        Me.lblFreight.Location = New System.Drawing.Point(16, 304)
        Me.lblFreight.Name = "lblFreight"
        Me.lblFreight.TabIndex = 156
        Me.lblFreight.Text = "Freight"
        '
        'lblRequiredDate
        '
        Me.lblRequiredDate.Location = New System.Drawing.Point(16, 224)
        Me.lblRequiredDate.Name = "lblRequiredDate"
        Me.lblRequiredDate.TabIndex = 163
        Me.lblRequiredDate.Text = "Required Date"
        '
        'Label2
        '
        Me.Label2.Location = New System.Drawing.Point(16, 200)
        Me.Label2.Name = "Label2"
        Me.Label2.TabIndex = 168
        Me.Label2.Text = "Order Date"
        '
        'lblShippedDate
        '
        Me.lblShippedDate.Location = New System.Drawing.Point(16, 248)
        Me.lblShippedDate.Name = "lblShippedDate"
        Me.lblShippedDate.TabIndex = 164
        Me.lblShippedDate.Text = "Shipped Date"
        '
        'lblShipName
        '
        Me.lblShipName.Location = New System.Drawing.Point(16, 72)
        Me.lblShipName.Name = "lblShipName"
        Me.lblShipName.TabIndex = 185
        Me.lblShipName.Text = "ShipName"
        '
        'lblShipAddress
        '
        Me.lblShipAddress.Location = New System.Drawing.Point(16, 96)
        Me.lblShipAddress.Name = "lblShipAddress"
        Me.lblShipAddress.TabIndex = 186
        Me.lblShipAddress.Text = "Address"
        '
        'lblShipCity
        '
        Me.lblShipCity.Location = New System.Drawing.Point(16, 120)
        Me.lblShipCity.Name = "lblShipCity"
        Me.lblShipCity.TabIndex = 187
        Me.lblShipCity.Text = "City"
        '
        'lblShipCountry
        '
        Me.lblShipCountry.Location = New System.Drawing.Point(16, 168)
        Me.lblShipCountry.Name = "lblShipCountry"
        Me.lblShipCountry.TabIndex = 189
        Me.lblShipCountry.Text = "Country"
        '
        'lblShipPostalCode
        '
        Me.lblShipPostalCode.Location = New System.Drawing.Point(16, 144)
        Me.lblShipPostalCode.Name = "lblShipPostalCode"
        Me.lblShipPostalCode.TabIndex = 188
        Me.lblShipPostalCode.Text = "Postal Code"
        '
        'Label1
        '
        Me.Label1.Font = New System.Drawing.Font("Microsoft Sans Serif", 10.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label1.Location = New System.Drawing.Point(352, 96)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(96, 23)
        Me.Label1.TabIndex = 195
        Me.Label1.Text = "Order Details"
        '
        'Label3
        '
        Me.Label3.Font = New System.Drawing.Font("Microsoft Sans Serif", 10.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label3.Location = New System.Drawing.Point(8, 8)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(104, 23)
        Me.Label3.TabIndex = 196
        Me.Label3.Text = "Order Number"
        '
        'lblOrderNumber
        '
        Me.lblOrderNumber.Font = New System.Drawing.Font("Microsoft Sans Serif", 10.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblOrderNumber.Location = New System.Drawing.Point(112, 8)
        Me.lblOrderNumber.Name = "lblOrderNumber"
        Me.lblOrderNumber.Size = New System.Drawing.Size(80, 23)
        Me.lblOrderNumber.TabIndex = 197
        '
        'lblOrderError
        '
        Me.lblOrderError.Font = New System.Drawing.Font("Microsoft Sans Serif", 9.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblOrderError.Location = New System.Drawing.Point(224, 8)
        Me.lblOrderError.Name = "lblOrderError"
        Me.lblOrderError.Size = New System.Drawing.Size(512, 56)
        Me.lblOrderError.TabIndex = 198
        '
        'lblOrderNav
        '
        Me.lblOrderNav.FlatStyle = System.Windows.Forms.FlatStyle.System
        Me.lblOrderNav.Location = New System.Drawing.Point(56, 40)
        Me.lblOrderNav.Name = "lblOrderNav"
        Me.lblOrderNav.Size = New System.Drawing.Size(40, 16)
        Me.lblOrderNav.TabIndex = 200
        Me.lblOrderNav.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        'lblOrderDetailsNav
        '
        Me.lblOrderDetailsNav.FlatStyle = System.Windows.Forms.FlatStyle.System
        Me.lblOrderDetailsNav.Location = New System.Drawing.Point(400, 184)
        Me.lblOrderDetailsNav.Name = "lblOrderDetailsNav"
        Me.lblOrderDetailsNav.Size = New System.Drawing.Size(40, 16)
        Me.lblOrderDetailsNav.TabIndex = 201
        Me.lblOrderDetailsNav.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        'lblOrderDetailsError
        '
        Me.lblOrderDetailsError.Font = New System.Drawing.Font("Microsoft Sans Serif", 9.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblOrderDetailsError.Location = New System.Drawing.Point(352, 120)
        Me.lblOrderDetailsError.Name = "lblOrderDetailsError"
        Me.lblOrderDetailsError.Size = New System.Drawing.Size(376, 48)
        Me.lblOrderDetailsError.TabIndex = 202
        '
        'ShipCity
        '
        Me.ShipCity.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.ShipCity.Location = New System.Drawing.Point(128, 120)
        Me.ShipCity.Name = "ShipCity"
        Me.ShipCity.Size = New System.Drawing.Size(168, 23)
        Me.ShipCity.TabIndex = 203
        '
        'ShipName
        '
        Me.ShipName.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.ShipName.Location = New System.Drawing.Point(128, 72)
        Me.ShipName.Name = "ShipName"
        Me.ShipName.TabIndex = 206
        '
        'ShipAddress
        '
        Me.ShipAddress.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.ShipAddress.Location = New System.Drawing.Point(128, 96)
        Me.ShipAddress.Name = "ShipAddress"
        Me.ShipAddress.Size = New System.Drawing.Size(168, 23)
        Me.ShipAddress.TabIndex = 207
        '
        'ShipPostalCode
        '
        Me.ShipPostalCode.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.ShipPostalCode.Location = New System.Drawing.Point(128, 144)
        Me.ShipPostalCode.Name = "ShipPostalCode"
        Me.ShipPostalCode.Size = New System.Drawing.Size(96, 23)
        Me.ShipPostalCode.TabIndex = 208
        '
        'ShipCountry
        '
        Me.ShipCountry.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.ShipCountry.Location = New System.Drawing.Point(128, 168)
        Me.ShipCountry.Name = "ShipCountry"
        Me.ShipCountry.Size = New System.Drawing.Size(96, 23)
        Me.ShipCountry.TabIndex = 209
        '
        'OrderDate
        '
        Me.OrderDate.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.OrderDate.Location = New System.Drawing.Point(128, 192)
        Me.OrderDate.Name = "OrderDate"
        Me.OrderDate.Size = New System.Drawing.Size(136, 23)
        Me.OrderDate.TabIndex = 210
        '
        'RequiredDate
        '
        Me.RequiredDate.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.RequiredDate.Location = New System.Drawing.Point(128, 216)
        Me.RequiredDate.Name = "RequiredDate"
        Me.RequiredDate.Size = New System.Drawing.Size(136, 23)
        Me.RequiredDate.TabIndex = 211
        '
        'ShippedDate
        '
        Me.ShippedDate.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.ShippedDate.Location = New System.Drawing.Point(128, 240)
        Me.ShippedDate.Name = "ShippedDate"
        Me.ShippedDate.Size = New System.Drawing.Size(136, 23)
        Me.ShippedDate.TabIndex = 212
        '
        'Freight
        '
        Me.Freight.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.Freight.Location = New System.Drawing.Point(128, 304)
        Me.Freight.Name = "Freight"
        Me.Freight.Size = New System.Drawing.Size(96, 23)
        Me.Freight.TabIndex = 214
        '
        'ShipperName
        '
        Me.ShipperName.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.ShipperName.Location = New System.Drawing.Point(128, 280)
        Me.ShipperName.Name = "ShipperName"
        Me.ShipperName.Size = New System.Drawing.Size(96, 23)
        Me.ShipperName.TabIndex = 213
        Me.ShipperName.Tag = "Shippers;ShipperID;ShipperName;ShipVia"
        '
        'Discount
        '
        Me.Discount.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.Discount.Location = New System.Drawing.Point(464, 296)
        Me.Discount.Name = "Discount"
        Me.Discount.Size = New System.Drawing.Size(96, 23)
        Me.Discount.TabIndex = 217
        '
        'Quantity
        '
        Me.Quantity.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.Quantity.Location = New System.Drawing.Point(464, 272)
        Me.Quantity.Name = "Quantity"
        Me.Quantity.Size = New System.Drawing.Size(96, 23)
        Me.Quantity.TabIndex = 216
        '
        'UnitPrice
        '
        Me.UnitPrice.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.UnitPrice.Location = New System.Drawing.Point(464, 248)
        Me.UnitPrice.Name = "UnitPrice"
        Me.UnitPrice.Size = New System.Drawing.Size(96, 23)
        Me.UnitPrice.TabIndex = 215
        '
        'ProductName
        '
        Me.ProductName.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.ProductName.Location = New System.Drawing.Point(464, 224)
        Me.ProductName.Name = "ProductName"
        Me.ProductName.Size = New System.Drawing.Size(200, 23)
        Me.ProductName.TabIndex = 218
        Me.ProductName.Tag = "Products;ProductID;ProductName;ProductID"
        '
        'ErrorProvider2
        '
        Me.ErrorProvider2.BlinkStyle = System.Windows.Forms.ErrorBlinkStyle.NeverBlink
        '
        'panOriginal
        '
        Me.panOriginal.Controls.AddRange(New System.Windows.Forms.Control() {Me.btnKeepTheirs, Me.btnKeepMine, Me.lblOriginalValue, Me.Label4})
        Me.panOriginal.Location = New System.Drawing.Point(8, 336)
        Me.panOriginal.Name = "panOriginal"
        Me.panOriginal.Size = New System.Drawing.Size(728, 72)
        Me.panOriginal.TabIndex = 219
        Me.panOriginal.Visible = False
        '
        'btnKeepTheirs
        '
        Me.btnKeepTheirs.Location = New System.Drawing.Point(600, 8)
        Me.btnKeepTheirs.Name = "btnKeepTheirs"
        Me.btnKeepTheirs.Size = New System.Drawing.Size(120, 23)
        Me.btnKeepTheirs.TabIndex = 3
        Me.btnKeepTheirs.Text = "Keep database value"
        '
        'btnKeepMine
        '
        Me.btnKeepMine.Location = New System.Drawing.Point(472, 8)
        Me.btnKeepMine.Name = "btnKeepMine"
        Me.btnKeepMine.Size = New System.Drawing.Size(120, 23)
        Me.btnKeepMine.TabIndex = 2
        Me.btnKeepMine.Text = "Keep my value"
        '
        'lblOriginalValue
        '
        Me.lblOriginalValue.Location = New System.Drawing.Point(104, 8)
        Me.lblOriginalValue.Name = "lblOriginalValue"
        Me.lblOriginalValue.Size = New System.Drawing.Size(360, 23)
        Me.lblOriginalValue.TabIndex = 1
        '
        'Label4
        '
        Me.Label4.Location = New System.Drawing.Point(8, 8)
        Me.Label4.Name = "Label4"
        Me.Label4.Size = New System.Drawing.Size(88, 23)
        Me.Label4.TabIndex = 0
        Me.Label4.Text = "Database value:"
        '
        'lblStatus
        '
        Me.lblStatus.Location = New System.Drawing.Point(8, 416)
        Me.lblStatus.Name = "lblStatus"
        Me.lblStatus.Size = New System.Drawing.Size(456, 23)
        Me.lblStatus.TabIndex = 220
        '
        'btnCancel
        '
        Me.btnCancel.Location = New System.Drawing.Point(480, 416)
        Me.btnCancel.Name = "btnCancel"
        Me.btnCancel.Size = New System.Drawing.Size(120, 23)
        Me.btnCancel.TabIndex = 221
        Me.btnCancel.Text = "Cancel All Changes"
        '
        'ProductID
        '
        Me.ProductID.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.ProductID.Location = New System.Drawing.Point(680, 224)
        Me.ProductID.Name = "ProductID"
        Me.ProductID.Size = New System.Drawing.Size(28, 23)
        Me.ProductID.TabIndex = 222
        Me.ProductID.Tag = ""
        Me.ProductID.Visible = False
        '
        'panDeleted
        '
        Me.panDeleted.Controls.AddRange(New System.Windows.Forms.Control() {Me.btnDeletedLeaveIn, Me.btnDeletedDelete})
        Me.panDeleted.Location = New System.Drawing.Point(8, 336)
        Me.panDeleted.Name = "panDeleted"
        Me.panDeleted.Size = New System.Drawing.Size(296, 40)
        Me.panDeleted.TabIndex = 223
        Me.panDeleted.Visible = False
        '
        'btnDeletedLeaveIn
        '
        Me.btnDeletedLeaveIn.Location = New System.Drawing.Point(152, 8)
        Me.btnDeletedLeaveIn.Name = "btnDeletedLeaveIn"
        Me.btnDeletedLeaveIn.Size = New System.Drawing.Size(136, 23)
        Me.btnDeletedLeaveIn.TabIndex = 1
        Me.btnDeletedLeaveIn.Text = "Leave Row In Database"
        '
        'btnDeletedDelete
        '
        Me.btnDeletedDelete.Location = New System.Drawing.Point(8, 8)
        Me.btnDeletedDelete.Name = "btnDeletedDelete"
        Me.btnDeletedDelete.Size = New System.Drawing.Size(136, 23)
        Me.btnDeletedDelete.TabIndex = 0
        Me.btnDeletedDelete.Text = "Keep Row As Deleted"
        '
        'panDeletedDetails
        '
        Me.panDeletedDetails.Controls.AddRange(New System.Windows.Forms.Control() {Me.btnDeletedDetailsLeave, Me.btnDeletedDetailsDelete})
        Me.panDeletedDetails.Location = New System.Drawing.Point(440, 336)
        Me.panDeletedDetails.Name = "panDeletedDetails"
        Me.panDeletedDetails.Size = New System.Drawing.Size(296, 40)
        Me.panDeletedDetails.TabIndex = 224
        Me.panDeletedDetails.Visible = False
        '
        'btnDeletedDetailsLeave
        '
        Me.btnDeletedDetailsLeave.Location = New System.Drawing.Point(152, 8)
        Me.btnDeletedDetailsLeave.Name = "btnDeletedDetailsLeave"
        Me.btnDeletedDetailsLeave.Size = New System.Drawing.Size(136, 23)
        Me.btnDeletedDetailsLeave.TabIndex = 1
        Me.btnDeletedDetailsLeave.Text = "Leave Row In Database"
        '
        'btnDeletedDetailsDelete
        '
        Me.btnDeletedDetailsDelete.Location = New System.Drawing.Point(8, 8)
        Me.btnDeletedDetailsDelete.Name = "btnDeletedDetailsDelete"
        Me.btnDeletedDetailsDelete.Size = New System.Drawing.Size(136, 23)
        Me.btnDeletedDetailsDelete.TabIndex = 0
        Me.btnDeletedDetailsDelete.Text = "Keep Row As Deleted"
        '
        'ErrorsForm
        '
        Me.AutoScaleBaseSize = New System.Drawing.Size(5, 13)
        Me.BackColor = System.Drawing.Color.OldLace
        Me.ClientSize = New System.Drawing.Size(752, 459)
        Me.Controls.AddRange(New System.Windows.Forms.Control() {Me.panDeletedDetails, Me.panDeleted, Me.ProductID, Me.btnCancel, Me.lblStatus, Me.panOriginal, Me.ProductName, Me.Discount, Me.Quantity, Me.UnitPrice, Me.Freight, Me.ShipperName, Me.ShippedDate, Me.RequiredDate, Me.OrderDate, Me.ShipCountry, Me.ShipPostalCode, Me.ShipAddress, Me.ShipName, Me.ShipCity, Me.lblOrderDetailsError, Me.lblOrderDetailsNav, Me.lblOrderNav, Me.lblOrderError, Me.lblOrderNumber, Me.Label3, Me.Label1, Me.lblShipName, Me.lblShipAddress, Me.lblShipCity, Me.lblShipCountry, Me.lblShipPostalCode, Me.lblRequiredDate, Me.Label2, Me.lblShippedDate, Me.lblShipVia, Me.lblFreight, Me.Label19, Me.Label18, Me.Label17, Me.Label16, Me.btnSave, Me.btnMoveFirstDetail, Me.btnMovePrevDetail, Me.btnMoveNextDetail, Me.btnMoveLastDetail, Me.btnMoveFirst, Me.btnMovePrev, Me.btnMoveNext, Me.btnMoveLast})
        Me.Name = "ErrorsForm"
        Me.Text = "Errors"
        Me.panOriginal.ResumeLayout(False)
        Me.panDeleted.ResumeLayout(False)
        Me.panDeletedDetails.ResumeLayout(False)
        Me.ResumeLayout(False)

    End Sub

#End Region

    Private _CustID As String
    Private _dsOrders As DataSet
    Private _dsLookups As DataSet

    Private Enum MovePosition
        FirstRow
        PreviousRow
        NextRow
        LastRow
    End Enum


    Public Sub New(ByVal CustID As String, ByVal dsChanges As DataSet, ByVal dsLookups As DataSet)

        Me.New()

        _CustID = CustID
        _dsLookups = dsLookups

        ' clone the dataset - this ensure we have the correct schema
        _dsOrders = dsChanges.Clone()

        ShowData(dsChanges)

    End Sub


    ' bind the data
    Private Sub ShowData(ByVal dsChanges As DataSet)

        Dim drOrders As DataRow()
        Dim drOrderDetails As DataRow()

        ' set the column error details
        ' this also ensures that parent rows have errors so we
        ' don't get orphaned children
        SetColumnErrors(dsChanges)

        ' clear any existing data before merging
        _dsOrders.Clear()

        ' get the error rows and merge into our emtpy dataset
        ' this way we can have a dataset of just errors
        drOrders = dsChanges.Tables("Orders").GetErrors()
        _dsOrders.Merge(drOrders)

        ' If there are child rows, then merge in the chilren.
        ' For occasions where errors only occur in child rows, we
        ' know that the parent exists, because our calling routine
        ' set a row error on the parent, even if one didn't exist
        If dsChanges.Tables("Order Details").HasErrors Then
            drOrderDetails = dsChanges.Tables("Order Details").GetErrors()
            _dsOrders.Merge(drOrderDetails)

            ' create the relationship if it doesn't already exist
            ' (which will be the first time this is opened)
            If _dsOrders.Relations.Count = 0 Then
                Dim ParentCol, ChildCol As DataColumn
                ParentCol = _dsOrders.Tables("Orders").Columns("OrderID")
                ChildCol = _dsOrders.Tables("Order Details").Columns("OrderID")
                Dim objRelation As New DataRelation("CustOrders", ParentCol, ChildCol)
                _dsOrders.Relations.Add(objRelation)
            End If
        End If

        ' and bind the textboxes for the orders
        lblOrderNumber.DataBindings.Add("Text", _dsOrders, "Orders.OrderID")
        ShipPostalCode.DataBindings.Add("Text", _dsOrders, "Orders.ShipPostalCode")
        ShipCountry.DataBindings.Add("Text", _dsOrders, "Orders.ShipCountry")
        ShipCity.DataBindings.Add("Text", _dsOrders, "Orders.ShipCity")
        ShipAddress.DataBindings.Add("Text", _dsOrders, "Orders.ShipAddress")
        ShipName.DataBindings.Add("Text", _dsOrders, "Orders.ShipName")
        Freight.DataBindings.Add("Text", _dsOrders, "Orders.Freight")
        ShippedDate.DataBindings.Add("Text", _dsOrders, "Orders.ShippedDate")
        RequiredDate.DataBindings.Add("Text", _dsOrders, "Orders.RequiredDate")
        OrderDate.DataBindings.Add("Text", _dsOrders, "Orders.OrderDate")
        ShipperName.DataBindings.Add("Text", _dsOrders, "Orders.ShipperName")

        ' bind error provider
        ' this gives us automatic notification of errors on the text boxes
        ErrorProvider1.DataSource = _dsOrders
        ErrorProvider1.DataMember = "Orders"
        ErrorProvider1.ContainerControl = Me

        ' only bind to order details if there are errors in the order details
        If Not (drOrderDetails Is Nothing) Then
            ' bind the textboxes for the order details
            ProductID.DataBindings.Add("Text", _dsOrders, "Orders.CustOrders.ProductID")
            ProductName.DataBindings.Add("Text", _dsOrders, "Orders.CustOrders.ProductName")
            UnitPrice.DataBindings.Add("Text", _dsOrders, "Orders.CustOrders.UnitPrice")
            Quantity.DataBindings.Add("Text", _dsOrders, "Orders.CustOrders.Quantity")
            Discount.DataBindings.Add("Text", _dsOrders, "Orders.CustOrders.Discount")

            ' bind error provider
            ' this gives us automatic notification of errors on the text boxes
            ErrorProvider2.DataSource = _dsOrders
            ErrorProvider2.DataMember = "Orders.CustOrders"
            ErrorProvider2.ContainerControl = Me
        End If

        ' update controls for current row
        AddHandler Me.BindingContext(_dsOrders, "Orders").PositionChanged, AddressOf OrdersRowPosition_Changed

        ' check for deleted rows
        CheckForDeleted()

        ' now update the UI
        UpdateParentView()

    End Sub

    Private Sub CheckForDeleted()

        ' if the number of rows bound differs from the number of rows in the table
        ' then there must be deleted rows
        If _dsOrders.Tables("Orders").Rows.Count <> Me.BindingContext(_dsOrders, "Orders").Count _
            Or _dsOrders.Tables("Order Details").Rows.Count <> Me.BindingContext(_dsOrders, "Order Details").Count Then

            Dim dt As DataTable
            Dim dr As DataRow
            Dim i As Integer

            For Each dt In _dsOrders.Tables
                For i = 0 To dt.Rows.Count - 1
                    dr = dt.Rows(i)
                    If dr.RowState = DataRowState.Deleted Then
                        dr.RejectChanges()
                        dr.RowError = "Deleted"
                    End If
                Next
            Next

        End If

    End Sub

    ' set the navigation controls
    Private Sub UpdateParentView()

        Dim CurrentRowNumber As Integer = Me.BindingContext(_dsOrders, "Orders").Position
        Dim CurrentRow As DataRow = CType(Me.BindingContext(_dsOrders, "Orders").Current, DataRowView).Row

        ' set the error label
        lblOrderError.Text = CurrentRow.RowError
        lblOrderNav.Text = (CurrentRowNumber + 1).ToString _
            & " of  " & _dsOrders.Tables("Orders").Rows.Count.ToString()

        ' if deleted show different buttons
        If CurrentRow.RowError = "Deleted" Then
            panDeleted.Visible = True
        Else
            panDeleted.Visible = False
        End If


        ' enable or disable children, depending on whether there are child rows
        Dim EnableChild As Boolean = (CurrentRow.GetChildRows("CustOrders").Length > 0)
        btnMoveFirstDetail.Enabled = EnableChild
        btnMoveLastDetail.Enabled = EnableChild
        btnMoveNextDetail.Enabled = EnableChild
        btnMovePrevDetail.Enabled = EnableChild
        ProductName.Enabled = EnableChild
        UnitPrice.Enabled = EnableChild
        Quantity.Enabled = EnableChild
        Discount.Enabled = EnableChild


        If EnableChild Then
            UpdateChildView()
        End If


        panOriginal.Visible = False

        ' set any error messages (try/catch just eliminates indexing errors
        ' for controls that don't exist in the data. This is easier than looping
        ' through the DataColumns since you can't index into the Form.Controls 
        ' collection by name.
        Dim ctl As Control
        For Each ctl In Me.Controls
            If CurrentRow.Table.Columns.Contains(ctl.Name) Then
                ErrorProvider1.SetError(ctl, CurrentRow.GetColumnError(ctl.Name))
            End If
        Next

    End Sub


    Private Sub UpdateChildView()

        Dim CurrentRowNumber As Integer = Me.BindingContext(_dsOrders, "Orders.CustOrders").Position
        Dim CurrentRow As DataRow = CType(Me.BindingContext(_dsOrders, "Orders.CustOrders").Current, DataRowView).Row

        ' set the error label
        lblOrderDetailsError.Text = CurrentRow.RowError
        lblOrderDetailsNav.Text = (CurrentRowNumber + 1).ToString _
            & " of  " & _dsOrders.Tables("Order Details").Rows.Count.ToString()

        ' if deleted show different buttons
        If CurrentRow.RowError = "Deleted" Then
            panDeletedDetails.Visible = True
        Else
            panDeletedDetails.Visible = False
        End If

        panOriginal.Visible = False

        ' set any error messages (try/catch just eliminates indexing errors
        ' for controls that don't exist in the data. This is easier than looping
        ' through the DataColumns since you can't index into the Form.Controls 
        ' collection by name.
        Dim ctl As Control
        For Each ctl In Me.Controls
            If CurrentRow.Table.Columns.Contains(ctl.Name) Then
                ErrorProvider2.SetError(ctl, CurrentRow.GetColumnError(ctl.Name))
            End If
        Next

    End Sub


    ' return the original value for a given column
    Private Function GetOriginalRowValue(ByVal CurrentRow As DataRow, ByVal ColumnName As String) As String

        Dim dc As DataColumn = CurrentRow.Table.Columns(ColumnName)

        Select Case CurrentRow.RowState
            Case DataRowState.Modified
                If Not ((CurrentRow.IsNull(dc, DataRowVersion.Current) AndAlso CurrentRow.IsNull(dc, DataRowVersion.Original)) _
                    OrElse (CurrentRow(dc, DataRowVersion.Current) = CurrentRow(dc, DataRowVersion.Original))) Then
                    Return CurrentRow(dc, DataRowVersion.Original).ToString()
                End If

            Case DataRowState.Added
                Return Nothing

            Case DataRowState.Deleted
                Return CurrentRow(dc, DataRowVersion.Original).ToString()
        End Select

    End Function


    Private Sub btnSave_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSave.Click

        ' Clear all old before  we attempt to save
        ClearAllErrors()

        Dim dsChanges As DataSet = _dsOrders.GetChanges()

        ' are there any changes
        If Not (dsChanges Is Nothing) Then

            ' post changes back to the web service
            Dim OrdersService As New Orders.OrdersService.RemotingOrders()
            Dim dsUpdate As DataSet = OrdersService.UpdateOrders(_CustID, dsChanges)

            ' if there are still errors
            If dsUpdate.HasErrors Then
                lblStatus.Text = "There are still errors with the data."
                ClearBindings()
                ShowData(dsUpdate)
            Else
                Me.Close()
            End If
        Else
            Me.Close()
        End If

    End Sub


    ' decide whether there was an error on this field, 
    ' and show the error details accordingly
    Private Sub Item_Click(ByVal sender As Object, ByVal e As System.EventArgs) _
            Handles ShipperName.Click, ShipAddress.Click, ShipCity.Click, ShipPostalCode.Click _
            , ShipCountry.Click, OrderDate.Click, RequiredDate.Click, ShippedDate.Click _
            , ProductName.Click, UnitPrice.Click, Quantity.Click, Discount.Click

        Dim ctl As Label = CType(sender, Label)
        Dim TableName As String = ctl.DataBindings("Text").BindingMemberInfo.BindingPath
        Dim CurrentRowNumber As Integer = CType(Me.BindingContext(_dsOrders, TableName), CurrencyManager).Position

        If CurrentRowNumber < 0 Then
            Exit Sub
        End If


        Dim CurrentRow As DataRow = CType(Me.BindingContext(_dsOrders, TableName).Current, DataRowView).Row
        Dim value As String = GetOriginalRowValue(CurrentRow, ctl.Name)

        ' only allow correction if the values are different
        ' and they haven't already been corrected
        ' - for cases where we keep the database version we overwrite the current value
        '   with the origin value, but for cases where we keep the current value the
        '   two values remain different, so we use the error message to determine whether
        '   the error has already been corrected.
        If Not (value Is Nothing) AndAlso (value <> CurrentRow(ctl.Name)) Then
            Dim err As String = CurrentRow.GetColumnError(ctl.Name)
            If err <> "" Then
                panOriginal.Visible = True
                lblOriginalValue.Text = value
                lblOriginalValue.Tag = ctl
            End If
        Else
            panOriginal.Visible = False
        End If

    End Sub


#Region "Move Buttons"
    ' move buttons for orders
    Protected Sub btnMoveFirst_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnMoveFirst.Click
        MoveToRow("Orders", MovePosition.FirstRow)
    End Sub

    Protected Sub btnMoveLast_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnMoveLast.Click
        MoveToRow("Orders", MovePosition.LastRow)
    End Sub

    Protected Sub btnMoveNext_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnMoveNext.Click
        MoveToRow("Orders", MovePosition.NextRow)
    End Sub

    Protected Sub btnMovePrev_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnMovePrev.Click
        MoveToRow("Orders", MovePosition.PreviousRow)
    End Sub


    ' move buttons for order details
    Protected Sub btnMoveFirstDetail_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnMoveFirstDetail.Click
        MoveToRow("Orders.CustOrders", MovePosition.FirstRow)
    End Sub

    Protected Sub btnMoveLastDetail_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnMoveLastDetail.Click
        MoveToRow("Orders.CustOrders", MovePosition.LastRow)
    End Sub

    Protected Sub btnMoveNextDetail_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnMoveNextDetail.Click
        MoveToRow("Orders.CustOrders", MovePosition.NextRow)
    End Sub

    Protected Sub btnMovePrevDetail_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnMovePrevDetail.Click
        MoveToRow("Orders.CustOrders", MovePosition.PreviousRow)
    End Sub


    Private Sub MoveToRow(ByVal BindingTable As String, ByVal MoveTo As MovePosition)

        Dim ccyManager As BindingManagerBase = Me.BindingContext(_dsOrders, BindingTable)
        Dim MaxRows As Integer = ccyManager.Count

        Select Case MoveTo
            Case MovePosition.FirstRow
                ccyManager.Position = 0

            Case MovePosition.LastRow
                ccyManager.Position = MaxRows - 1

            Case MovePosition.NextRow
                If ccyManager.Position < MaxRows - 1 Then
                    ccyManager.Position += 1
                End If

            Case MovePosition.PreviousRow
                If ccyManager.Position > 0 Then
                    ccyManager.Position -= 1
                End If
        End Select

        UpdateParentView()

    End Sub

#End Region


    Private Sub OrdersRowPosition_Changed(ByVal sender As Object, ByVal e As EventArgs)

        UpdateParentView()

    End Sub


    Private Sub btnKeepMine_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnKeepMine.Click

        ' keep the current value
        CorrectValue(DataRowVersion.Current)

    End Sub


    Private Sub btnKeepTheirs_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnKeepTheirs.Click

        ' keep the original (database) value
        CorrectValue(DataRowVersion.Original)

    End Sub


    ' correct the calue in the row
    Private Sub CorrectValue(ByVal Version As DataRowVersion)

        ' get the control row and column details
        Dim ctl As Control = CType(lblOriginalValue.Tag, Label)
        Dim TableName As String = ctl.DataBindings("Text").BindingMemberInfo.BindingPath
        Dim Manager As CurrencyManager = CType(Me.BindingContext(_dsOrders, TableName), CurrencyManager)
        Dim CurrentRowNumber As Integer = Manager.Position
        Dim CurrentRow As DataRow = CType(Manager.Current, DataRowView).Row
        Dim ControlName As String = ctl.Name


        ' overwrite the value with the original if requested
        If Version = DataRowVersion.Original Then
            ' for lookup values, the text labels have the column name of their
            ' key values stored in the Tag property. This allows us to check here
            ' whether to just replace the value, or to lookup the key value from
            ' the lookup table. The tag stores the TableName;PrimaryKeyField;ValueField;ForeignKeyField
            If ctl.Tag <> "" Then
                Dim LookupDetails As String() = CType(ctl.Tag, String).Split(";")
                Dim dr As DataRow()
                dr = _dsLookups.Tables(LookupDetails(0)).Select(LookupDetails(2) & "='" & lblOriginalValue.Text & "'")
                CurrentRow(LookupDetails(3)) = dr(0).Item(LookupDetails(1))
            Else
                CurrentRow(ControlName) = lblOriginalValue.Text
            End If
        End If

        ' clear the error message for this control
        ' note that SetColumError doesn't clear the error (there's no way
        ' to clear an individual column error), but it allows us to see which
        ' errors have been resolved
        CurrentRow.SetColumnError(ControlName, "")
        If TableName = "Orders" Then
            ErrorProvider1.SetError(ctl, "")
        Else
            ErrorProvider2.SetError(ctl, "")
        End If

        ' hide the selection panel
        panOriginal.Visible = False

        UpdateParentView()

    End Sub



    ' set the errors on each column with a conflict
    ' Use of SetColumnError means that the ErrorProviders automatically highlight errors
    Private Sub SetColumnErrors(ByRef dsChanges As DataSet)

        Dim dt As DataTable
        Dim dr As DataRow
        Dim dc As DataColumn
        Dim parentRow As DataRow

        ' loop through the tables, rows, and columns (in rows with errors)
        For Each dt In dsChanges.Tables

            For Each dr In dt.Rows

                If dr.HasErrors Then
                    ' ensure that parent row has an error set, so that
                    ' the ErrorProvider highlights the parent row in the grid.
                    ' otherwise you can't tell that child rows have errors
                    parentRow = dr.GetParentRow("CustOrders")
                    If Not (parentRow Is Nothing) AndAlso Not parentRow.HasErrors Then
                        If parentRow.RowError = "" Then
                            parentRow.RowError = "Error occured in Order Details"
                        End If
                    End If


                    For Each dc In dr.Table.Columns

                        ' Only set error for non-calculated fields
                        If dc.Expression = "" Then

                            ' what conflict was it?
                            Select Case dr.RowState
                                Case DataRowState.Modified
                                    If Not ((dr.IsNull(dc, DataRowVersion.Current) OrElse dr.IsNull(dc, DataRowVersion.Original)) _
                                        OrElse (dr(dc, DataRowVersion.Current) = dr(dc, DataRowVersion.Original))) Then

                                        Dim val As String = dr(dc, DataRowVersion.Original).ToString()
                                        dr.SetColumnError(dc, "Column was modified by another user. Their value is: " & val)
                                    End If

                                Case DataRowState.Added
                                    dr.SetColumnError(dc, "Row has been added")

                                Case DataRowState.Deleted
                                    dr.SetColumnError(dc, "This row has been deleted by another user")

                            End Select
                        End If
                    Next
                End If
            Next
        Next

    End Sub


    ' we want to warn the user of they try to close the form
    ' with unresolved errors
    Protected Overrides Sub OnClosing(ByVal e As System.ComponentModel.CancelEventArgs)

        If _dsOrders.HasErrors Then
            Dim err As String = "There are still outstanding errors. " _
                        & "Closing this form without resolving them means that you will loose your changes. " _
                        & "Are you sure you wish to close the form?"
            If MessageBox.Show(err, "Unresolved errors", MessageBoxButtons.YesNo, _
                                MessageBoxIcon.Warning, MessageBoxDefaultButton.Button2) = DialogResult.No Then
                e.Cancel = True
            End If
        End If

    End Sub


    ' clear any databindings on the controls
    Private Sub ClearBindings()

        Dim ctl As Control

        For Each ctl In Me.Controls
            ctl.DataBindings.Clear()
        Next
        Me.DataBindings.Clear()

    End Sub


    Private Sub ClearAllErrors()

        Dim dt As DataTable
        Dim dr As DataRow
        For Each dt In _dsOrders.Tables
            For Each dr In dt.Rows
                dr.ClearErrors()
            Next
        Next

    End Sub

    Private Sub btnCancel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCancel.Click

        Me.Close()

    End Sub

    Private Sub btnDeletedDelete_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnDeletedDelete.Click

        ProcessDeleted("Orders", DataRowVersion.Current)

    End Sub

    Private Sub btnDeletedLeaveIn_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnDeletedLeaveIn.Click

        ProcessDeleted("Orders", DataRowVersion.Original)

    End Sub

    ' process deleted rows that we've re-inserted to allow binding
    Private Sub ProcessDeleted(ByVal TableName As String, ByVal Version As DataRowVersion)

        Dim Manager As CurrencyManager = CType(Me.BindingContext(_dsOrders, TableName), CurrencyManager)
        Dim CurrentRow As DataRow = CType(Manager.Current, DataRowView).Row

        If Version = DataRowVersion.Original Then
            ' Original means keep the database version, which is the version
            ' someone else has modified but that we deleted
            CurrentRow.AcceptChanges()
            CurrentRow.ClearErrors()
        Else
            ' to keep the row as deleted just re-delete it
            CurrentRow.Delete()
        End If

        panDeleted.Visible = False

    End Sub

    Private Sub btnDeletedDetailsDelete_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnDeletedDetailsDelete.Click

        ProcessDeleted("Order Details", DataRowVersion.Current)

    End Sub

    Private Sub btnDeletedDetailsLeave_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnDeletedDetailsLeave.Click

        ProcessDeleted("Order Details", DataRowVersion.Original)

    End Sub

End Class
