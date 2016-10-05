Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Reflection
Imports System.ComponentModel
Imports System.Configuration
Imports System.Security.Permissions

Public Class frmMain
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
    Friend WithEvents DataGridTextBoxColumn1 As System.Windows.Forms.DataGridTextBoxColumn
    Friend WithEvents DataGridTextBoxColumn2 As System.Windows.Forms.DataGridTextBoxColumn
    Friend WithEvents dgCustomers As System.Windows.Forms.DataGrid
    Friend WithEvents DataGridTableStyle1 As System.Windows.Forms.DataGridTableStyle
    Friend WithEvents DataGridTextBoxColumn3 As System.Windows.Forms.DataGridTextBoxColumn
    Friend WithEvents gpSearch As System.Windows.Forms.GroupBox
    Friend WithEvents txtSearch As System.Windows.Forms.TextBox
    Friend WithEvents btnSearch As System.Windows.Forms.Button
    Friend WithEvents rdName As System.Windows.Forms.RadioButton
    Friend WithEvents rdID As System.Windows.Forms.RadioButton
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.DataGridTextBoxColumn1 = New System.Windows.Forms.DataGridTextBoxColumn()
        Me.DataGridTextBoxColumn2 = New System.Windows.Forms.DataGridTextBoxColumn()
        Me.dgCustomers = New System.Windows.Forms.DataGrid()
        Me.DataGridTableStyle1 = New System.Windows.Forms.DataGridTableStyle()
        Me.DataGridTextBoxColumn3 = New System.Windows.Forms.DataGridTextBoxColumn()
        Me.gpSearch = New System.Windows.Forms.GroupBox()
        Me.txtSearch = New System.Windows.Forms.TextBox()
        Me.btnSearch = New System.Windows.Forms.Button()
        Me.rdName = New System.Windows.Forms.RadioButton()
        Me.rdID = New System.Windows.Forms.RadioButton()
        CType(Me.dgCustomers, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.gpSearch.SuspendLayout()
        Me.SuspendLayout()
        '
        'DataGridTextBoxColumn1
        '
        Me.DataGridTextBoxColumn1.Format = ""
        Me.DataGridTextBoxColumn1.FormatInfo = Nothing
        Me.DataGridTextBoxColumn1.HeaderText = "ID"
        Me.DataGridTextBoxColumn1.MappingName = "CustomerID"
        Me.DataGridTextBoxColumn1.ReadOnly = True
        Me.DataGridTextBoxColumn1.Width = 75
        '
        'DataGridTextBoxColumn2
        '
        Me.DataGridTextBoxColumn2.Format = ""
        Me.DataGridTextBoxColumn2.FormatInfo = Nothing
        Me.DataGridTextBoxColumn2.HeaderText = "Name"
        Me.DataGridTextBoxColumn2.MappingName = "CompanyName"
        Me.DataGridTextBoxColumn2.ReadOnly = True
        Me.DataGridTextBoxColumn2.Width = 150
        '
        'dgCustomers
        '
        Me.dgCustomers.AllowNavigation = False
        Me.dgCustomers.AlternatingBackColor = System.Drawing.Color.OldLace
        Me.dgCustomers.Anchor = ((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left) _
                    Or System.Windows.Forms.AnchorStyles.Right)
        Me.dgCustomers.BackColor = System.Drawing.Color.OldLace
        Me.dgCustomers.BackgroundColor = System.Drawing.Color.Tan
        Me.dgCustomers.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.dgCustomers.CaptionBackColor = System.Drawing.Color.SaddleBrown
        Me.dgCustomers.CaptionForeColor = System.Drawing.Color.OldLace
        Me.dgCustomers.CaptionText = "Customers"
        Me.dgCustomers.CausesValidation = False
        Me.dgCustomers.DataMember = "Customers"
        Me.dgCustomers.FlatMode = True
        Me.dgCustomers.Font = New System.Drawing.Font("Tahoma", 8.0!)
        Me.dgCustomers.ForeColor = System.Drawing.Color.DarkSlateGray
        Me.dgCustomers.GridLineColor = System.Drawing.Color.Tan
        Me.dgCustomers.HeaderBackColor = System.Drawing.Color.Wheat
        Me.dgCustomers.HeaderFont = New System.Drawing.Font("Tahoma", 8.0!, System.Drawing.FontStyle.Bold)
        Me.dgCustomers.HeaderForeColor = System.Drawing.Color.SaddleBrown
        Me.dgCustomers.LinkColor = System.Drawing.Color.DarkSlateBlue
        Me.dgCustomers.Location = New System.Drawing.Point(8, 94)
        Me.dgCustomers.Name = "dgCustomers"
        Me.dgCustomers.ParentRowsBackColor = System.Drawing.Color.OldLace
        Me.dgCustomers.ParentRowsForeColor = System.Drawing.Color.DarkSlateGray
        Me.dgCustomers.ReadOnly = True
        Me.dgCustomers.SelectionBackColor = System.Drawing.Color.SlateGray
        Me.dgCustomers.SelectionForeColor = System.Drawing.Color.White
        Me.dgCustomers.Size = New System.Drawing.Size(432, 482)
        Me.dgCustomers.TabIndex = 6
        Me.dgCustomers.TableStyles.AddRange(New System.Windows.Forms.DataGridTableStyle() {Me.DataGridTableStyle1})
        '
        'DataGridTableStyle1
        '
        Me.DataGridTableStyle1.AlternatingBackColor = System.Drawing.Color.OldLace
        Me.DataGridTableStyle1.BackColor = System.Drawing.Color.OldLace
        Me.DataGridTableStyle1.DataGrid = Me.dgCustomers
        Me.DataGridTableStyle1.ForeColor = System.Drawing.Color.DarkSlateGray
        Me.DataGridTableStyle1.GridColumnStyles.AddRange(New System.Windows.Forms.DataGridColumnStyle() {Me.DataGridTextBoxColumn1, Me.DataGridTextBoxColumn2, Me.DataGridTextBoxColumn3})
        Me.DataGridTableStyle1.GridLineColor = System.Drawing.Color.Tan
        Me.DataGridTableStyle1.HeaderBackColor = System.Drawing.Color.Wheat
        Me.DataGridTableStyle1.HeaderForeColor = System.Drawing.Color.SaddleBrown
        Me.DataGridTableStyle1.LinkColor = System.Drawing.Color.DarkSlateBlue
        Me.DataGridTableStyle1.MappingName = "Customers"
        Me.DataGridTableStyle1.ReadOnly = True
        Me.DataGridTableStyle1.SelectionBackColor = System.Drawing.Color.SlateGray
        Me.DataGridTableStyle1.SelectionForeColor = System.Drawing.Color.White
        '
        'DataGridTextBoxColumn3
        '
        Me.DataGridTextBoxColumn3.Format = ""
        Me.DataGridTextBoxColumn3.FormatInfo = Nothing
        Me.DataGridTextBoxColumn3.HeaderText = "City"
        Me.DataGridTextBoxColumn3.MappingName = "City"
        Me.DataGridTextBoxColumn3.ReadOnly = True
        Me.DataGridTextBoxColumn3.Width = 75
        '
        'gpSearch
        '
        Me.gpSearch.Controls.AddRange(New System.Windows.Forms.Control() {Me.txtSearch, Me.btnSearch, Me.rdName, Me.rdID})
        Me.gpSearch.FlatStyle = System.Windows.Forms.FlatStyle.System
        Me.gpSearch.Location = New System.Drawing.Point(12, 7)
        Me.gpSearch.Name = "gpSearch"
        Me.gpSearch.Size = New System.Drawing.Size(256, 80)
        Me.gpSearch.TabIndex = 7
        Me.gpSearch.TabStop = False
        Me.gpSearch.Text = "Search By"
        '
        'txtSearch
        '
        Me.txtSearch.Location = New System.Drawing.Point(16, 48)
        Me.txtSearch.Name = "txtSearch"
        Me.txtSearch.Size = New System.Drawing.Size(160, 20)
        Me.txtSearch.TabIndex = 3
        Me.txtSearch.Text = ""
        '
        'btnSearch
        '
        Me.btnSearch.Location = New System.Drawing.Point(192, 48)
        Me.btnSearch.Name = "btnSearch"
        Me.btnSearch.Size = New System.Drawing.Size(56, 24)
        Me.btnSearch.TabIndex = 2
        Me.btnSearch.Text = "Search"
        '
        'rdName
        '
        Me.rdName.Checked = True
        Me.rdName.FlatStyle = System.Windows.Forms.FlatStyle.System
        Me.rdName.Location = New System.Drawing.Point(16, 24)
        Me.rdName.Name = "rdName"
        Me.rdName.Size = New System.Drawing.Size(64, 16)
        Me.rdName.TabIndex = 1
        Me.rdName.TabStop = True
        Me.rdName.Text = "Name"
        '
        'rdID
        '
        Me.rdID.FlatStyle = System.Windows.Forms.FlatStyle.System
        Me.rdID.Location = New System.Drawing.Point(104, 24)
        Me.rdID.Name = "rdID"
        Me.rdID.Size = New System.Drawing.Size(40, 16)
        Me.rdID.TabIndex = 0
        Me.rdID.Text = "ID"
        '
        'frmMain
        '
        Me.AutoScaleBaseSize = New System.Drawing.Size(5, 13)
        Me.BackColor = System.Drawing.Color.OldLace
        Me.ClientSize = New System.Drawing.Size(448, 579)
        Me.Controls.AddRange(New System.Windows.Forms.Control() {Me.dgCustomers, Me.gpSearch})
        Me.ForeColor = System.Drawing.Color.DarkSlateGray
        Me.Name = "frmMain"
        Me.Text = "View Customer Orders"
        CType(Me.dgCustomers, System.ComponentModel.ISupportInitialize).EndInit()
        Me.gpSearch.ResumeLayout(False)
        Me.ResumeLayout(False)

    End Sub

#End Region

    Private m_dsCustomers As DataSet

    Private Sub btnSearch_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSearch.Click

        ' create an instance of the Customers Web Service
        Dim wsCustomers As New CustomersService.CustomerOrders()

        ' get the dataset for the customers
        If rdID.Checked Then
            m_dsCustomers = wsCustomers.GetCustomers(txtSearch.Text, "")
        Else
            m_dsCustomers = wsCustomers.GetCustomers("", txtSearch.Text)
        End If

        ' and bind the dataset to the grid
        dgCustomers.DataSource = m_dsCustomers

    End Sub

    Private Sub dgCustomers_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles dgCustomers.Click

        If dgCustomers.CurrentRowIndex <> -1 Then

            Dim intOffset As Integer
            Dim CurrentRow As DataRow = m_dsCustomers.Tables(0).Rows(dgCustomers.CurrentRowIndex)
            Dim CustID As String = CurrentRow.Item("CustomerID")
            Dim fOrders As Form = LoadForm(CustID)

            ' make this form owned by us
            ' - that way it minimises and maximises with us
            ' - plus we can use the count of owned forms to position new ones
            Me.AddOwnedForm(fOrders)

            ' find the customer ID from the selected row

            ' set the caption and get the form to load its grid
            fOrders.Text = CurrentRow.Item("CompanyName")

            ' Show the form, making it invisible to start with
            fOrders.Visible = False
            fOrders.Show()

            ' Set it's position and make it visible
            ' you could calculate the offset accurately, based on border width,
            '   title bar height, etc., but 25 works for standard border/title sizes
            intOffset = (Me.OwnedForms.Length - 1) * 25
            fOrders.Top = Me.Top + intOffset
            fOrders.Left = Me.Left + Me.Width + intOffset
            fOrders.Visible = True

        End If

    End Sub

    ' load the form from a remote location
    Private Function LoadForm(ByVal CustID As String) As Form

        'Dim FormLocation As String = ConfigurationSettings.AppSettings("FormsURL") & "Orders.dll"
        Dim FormLocation As String = "http://localhost/4923/remoting/UpdateableRemoteFormsApplication/Forms/Orders.dll"
        Dim asm As [Assembly] = [Assembly].LoadFrom(FormLocation)
        Dim typ As Type = asm.GetType("Orders.OrdersForm", True, True)
        Dim obj As Object
        Dim args As Object() = {CustID}

        obj = Activator.CreateInstance(typ, args)

        Dim frmOrders As Form = CType(obj, Form)

        Return frmOrders

    End Function

End Class
