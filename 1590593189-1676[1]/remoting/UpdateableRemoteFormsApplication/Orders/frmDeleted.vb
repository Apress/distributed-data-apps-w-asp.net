Imports System.Data

Public Class frmDeleted
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
    Friend WithEvents DataGrid1 As System.Windows.Forms.DataGrid
    Friend WithEvents btnLeave As System.Windows.Forms.Button
    Friend WithEvents btnReinsert As System.Windows.Forms.Button
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.DataGrid1 = New System.Windows.Forms.DataGrid()
        Me.btnLeave = New System.Windows.Forms.Button()
        Me.btnReinsert = New System.Windows.Forms.Button()
        CType(Me.DataGrid1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'DataGrid1
        '
        Me.DataGrid1.Anchor = (((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
                    Or System.Windows.Forms.AnchorStyles.Left) _
                    Or System.Windows.Forms.AnchorStyles.Right)
        Me.DataGrid1.DataMember = ""
        Me.DataGrid1.HeaderForeColor = System.Drawing.SystemColors.ControlText
        Me.DataGrid1.Location = New System.Drawing.Point(8, 8)
        Me.DataGrid1.Name = "DataGrid1"
        Me.DataGrid1.Size = New System.Drawing.Size(624, 320)
        Me.DataGrid1.TabIndex = 0
        '
        'btnLeave
        '
        Me.btnLeave.Anchor = (System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right)
        Me.btnLeave.Location = New System.Drawing.Point(496, 336)
        Me.btnLeave.Name = "btnLeave"
        Me.btnLeave.Size = New System.Drawing.Size(128, 23)
        Me.btnLeave.TabIndex = 1
        Me.btnLeave.Text = "Leave Row as Deleted"
        '
        'btnReinsert
        '
        Me.btnReinsert.Anchor = (System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right)
        Me.btnReinsert.Location = New System.Drawing.Point(496, 368)
        Me.btnReinsert.Name = "btnReinsert"
        Me.btnReinsert.Size = New System.Drawing.Size(128, 23)
        Me.btnReinsert.TabIndex = 2
        Me.btnReinsert.Text = "Re-insert row"
        '
        'frmDeleted
        '
        Me.AutoScaleBaseSize = New System.Drawing.Size(5, 13)
        Me.ClientSize = New System.Drawing.Size(640, 403)
        Me.Controls.AddRange(New System.Windows.Forms.Control() {Me.btnReinsert, Me.btnLeave, Me.DataGrid1})
        Me.Name = "frmDeleted"
        Me.Text = "Deleted Rows"
        CType(Me.DataGrid1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)

    End Sub

#End Region


    Public Sub New(ByVal dsOrders As DataSet)

        Me.New()

        ' create a new dataset based on the 
        Dim dsDel As New DataSet()
        dsDel = dsOrders.Clone()

        Dim dt As DataTable
        Dim dr As DataRow

        For Each dt In dsDel.Tables
            For Each dr In dt.Rows
                If dr.RowState = DataRowState.Deleted Then
                    dr.AcceptChanges()
                    dsDel.Tables(dr.Table.TableName).Rows.Add(dr)
                End If
            Next
        Next

        DataGrid1.DataSource = dsDel

    End Sub

End Class
