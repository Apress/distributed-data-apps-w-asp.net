﻿'------------------------------------------------------------------------------
' <autogenerated>
'     This code was generated by a tool.
'     Runtime Version: 1.0.3705.0
'
'     Changes to this file may cause incorrect behavior and will be lost if 
'     the code is regenerated.
' </autogenerated>
'------------------------------------------------------------------------------

Option Strict Off
Option Explicit On

Imports System
Imports System.ComponentModel
Imports System.Diagnostics
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.Xml.Serialization

'
'This source code was auto-generated by Microsoft.VSDesigner, Version 1.0.3705.0.
'
Namespace OrdersService
    
    '<remarks/>
    <System.Diagnostics.DebuggerStepThroughAttribute(),  _
     System.ComponentModel.DesignerCategoryAttribute("code"),  _
     System.Web.Services.WebServiceBindingAttribute(Name:="RemotingOrdersSoap", [Namespace]:="http://www.wrox.com/webservices/4923/remoting")>  _
    Public Class RemotingOrders
        Inherits System.Web.Services.Protocols.SoapHttpClientProtocol
        
        '<remarks/>
        Public Sub New()
            MyBase.New
            Me.Url = "http://localhost/4923/remoting/webservices/order-details.asmx"
        End Sub
        
        '<remarks/>
        <System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://www.wrox.com/webservices/4923/remoting/Orders", RequestNamespace:="http://www.wrox.com/webservices/4923/remoting", ResponseNamespace:="http://www.wrox.com/webservices/4923/remoting", Use:=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle:=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)>  _
        Public Function Orders(ByVal strCustID As String) As System.Data.DataSet
            Dim results() As Object = Me.Invoke("Orders", New Object() {strCustID})
            Return CType(results(0),System.Data.DataSet)
        End Function
        
        '<remarks/>
        Public Function BeginOrders(ByVal strCustID As String, ByVal callback As System.AsyncCallback, ByVal asyncState As Object) As System.IAsyncResult
            Return Me.BeginInvoke("Orders", New Object() {strCustID}, callback, asyncState)
        End Function
        
        '<remarks/>
        Public Function EndOrders(ByVal asyncResult As System.IAsyncResult) As System.Data.DataSet
            Dim results() As Object = Me.EndInvoke(asyncResult)
            Return CType(results(0),System.Data.DataSet)
        End Function
        
        '<remarks/>
        <System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://www.wrox.com/webservices/4923/remoting/Lookups", RequestNamespace:="http://www.wrox.com/webservices/4923/remoting", ResponseNamespace:="http://www.wrox.com/webservices/4923/remoting", Use:=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle:=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)>  _
        Public Function Lookups() As System.Data.DataSet
            Dim results() As Object = Me.Invoke("Lookups", New Object(-1) {})
            Return CType(results(0),System.Data.DataSet)
        End Function
        
        '<remarks/>
        Public Function BeginLookups(ByVal callback As System.AsyncCallback, ByVal asyncState As Object) As System.IAsyncResult
            Return Me.BeginInvoke("Lookups", New Object(-1) {}, callback, asyncState)
        End Function
        
        '<remarks/>
        Public Function EndLookups(ByVal asyncResult As System.IAsyncResult) As System.Data.DataSet
            Dim results() As Object = Me.EndInvoke(asyncResult)
            Return CType(results(0),System.Data.DataSet)
        End Function
        
        '<remarks/>
        <System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://www.wrox.com/webservices/4923/remoting/UpdateOrders", RequestNamespace:="http://www.wrox.com/webservices/4923/remoting", ResponseNamespace:="http://www.wrox.com/webservices/4923/remoting", Use:=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle:=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)>  _
        Public Function UpdateOrders(ByVal strCustID As String, ByVal objDataSet As System.Data.DataSet) As System.Data.DataSet
            Dim results() As Object = Me.Invoke("UpdateOrders", New Object() {strCustID, objDataSet})
            Return CType(results(0),System.Data.DataSet)
        End Function
        
        '<remarks/>
        Public Function BeginUpdateOrders(ByVal strCustID As String, ByVal objDataSet As System.Data.DataSet, ByVal callback As System.AsyncCallback, ByVal asyncState As Object) As System.IAsyncResult
            Return Me.BeginInvoke("UpdateOrders", New Object() {strCustID, objDataSet}, callback, asyncState)
        End Function
        
        '<remarks/>
        Public Function EndUpdateOrders(ByVal asyncResult As System.IAsyncResult) As System.Data.DataSet
            Dim results() As Object = Me.EndInvoke(asyncResult)
            Return CType(results(0),System.Data.DataSet)
        End Function
    End Class
End Namespace
