﻿//------------------------------------------------------------------------------
// <autogenerated>
//     This code was generated by a tool.
//     Runtime Version: 1.0.3705.0
//
//     Changes to this file may cause incorrect behavior and will be lost if 
//     the code is regenerated.
// </autogenerated>
//------------------------------------------------------------------------------

// 
// This source code was auto-generated by Microsoft.VSDesigner, Version 1.0.3705.0.
// 
namespace Orders.OrdersService {
    using System.Diagnostics;
    using System.Xml.Serialization;
    using System;
    using System.Web.Services.Protocols;
    using System.ComponentModel;
    using System.Web.Services;
    
    
    /// <remarks/>
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Web.Services.WebServiceBindingAttribute(Name="RemotingOrdersSoap", Namespace="http://www.wrox.com/webservices/4923/remoting")]
    public class RemotingOrders : System.Web.Services.Protocols.SoapHttpClientProtocol {
        
        /// <remarks/>
        public RemotingOrders() {
            this.Url = "http://localhost/4923/remoting/webservices/order-details.asmx";
        }
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://www.wrox.com/webservices/4923/remoting/Orders", RequestNamespace="http://www.wrox.com/webservices/4923/remoting", ResponseNamespace="http://www.wrox.com/webservices/4923/remoting", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
        public System.Data.DataSet Orders(string strCustID) {
            object[] results = this.Invoke("Orders", new object[] {
                        strCustID});
            return ((System.Data.DataSet)(results[0]));
        }
        
        /// <remarks/>
        public System.IAsyncResult BeginOrders(string strCustID, System.AsyncCallback callback, object asyncState) {
            return this.BeginInvoke("Orders", new object[] {
                        strCustID}, callback, asyncState);
        }
        
        /// <remarks/>
        public System.Data.DataSet EndOrders(System.IAsyncResult asyncResult) {
            object[] results = this.EndInvoke(asyncResult);
            return ((System.Data.DataSet)(results[0]));
        }
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://www.wrox.com/webservices/4923/remoting/Lookups", RequestNamespace="http://www.wrox.com/webservices/4923/remoting", ResponseNamespace="http://www.wrox.com/webservices/4923/remoting", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
        public System.Data.DataSet Lookups() {
            object[] results = this.Invoke("Lookups", new object[0]);
            return ((System.Data.DataSet)(results[0]));
        }
        
        /// <remarks/>
        public System.IAsyncResult BeginLookups(System.AsyncCallback callback, object asyncState) {
            return this.BeginInvoke("Lookups", new object[0], callback, asyncState);
        }
        
        /// <remarks/>
        public System.Data.DataSet EndLookups(System.IAsyncResult asyncResult) {
            object[] results = this.EndInvoke(asyncResult);
            return ((System.Data.DataSet)(results[0]));
        }
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://www.wrox.com/webservices/4923/remoting/UpdateOrders", RequestNamespace="http://www.wrox.com/webservices/4923/remoting", ResponseNamespace="http://www.wrox.com/webservices/4923/remoting", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
        public System.Data.DataSet UpdateOrders(string strCustID, System.Data.DataSet objDataSet) {
            object[] results = this.Invoke("UpdateOrders", new object[] {
                        strCustID,
                        objDataSet});
            return ((System.Data.DataSet)(results[0]));
        }
        
        /// <remarks/>
        public System.IAsyncResult BeginUpdateOrders(string strCustID, System.Data.DataSet objDataSet, System.AsyncCallback callback, object asyncState) {
            return this.BeginInvoke("UpdateOrders", new object[] {
                        strCustID,
                        objDataSet}, callback, asyncState);
        }
        
        /// <remarks/>
        public System.Data.DataSet EndUpdateOrders(System.IAsyncResult asyncResult) {
            object[] results = this.EndInvoke(asyncResult);
            return ((System.Data.DataSet)(results[0]));
        }
    }
}
