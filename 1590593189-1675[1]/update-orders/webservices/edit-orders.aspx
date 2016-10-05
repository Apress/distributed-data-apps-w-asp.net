<%@Page Language="C#"%>

<html>
<head>

<title>Edit Customer Orders</title>
<!-- #include file="../../global/style.inc" -->

<!-------------- Client-side Script Section ---------------->

<script language="JScript">
<!--

var objXMLData;      // XML parser to hold order data
var objXMLProducts;  // XML parser to hold products list
var objXMLShippers;  // XML parser to hold shippers list
var objXMLInstance;  // reference to current parser instance

var strCustID;       // ID of the customer to edit orders for
var intOrderID;      // ID of currently selected order
var blnRefreshDetails = false;  // flag set when sending updates

// variables to hold Web Service method name and data set name
var strDataName;
var strMethodName;

// variable to hold ID of last inserted order row
var intLastNewID = 99000;

// flag to indicate if updates have been saved to server
var blnIsDirty = false;

//----------------------------------------------------

function openWebService() {
// runs when the page is first loaded to open the Web Service

  // establish the "friendly name" for the Web Service
  htcWService.useService("order-data.asmx?WSDL", "UpdateOrders");

  // get the customer ID from the query string
  strID = new String(window.location.search);
  strCustID = strID.substring(strID.indexOf('=') + 1, strID.length);
  if (strCustID == '') {

    // display error message
    strURL = '../../customer-orders/webservices/customer-list.aspx';
    document.all('lblStatus').innerHTML =
      '* ERROR: no Customer ID provided.<br />You must '
      + '<a href="' + strURL + '"><b>select a customer</b></a> first.';
  }
  else {

    // create the XML parser instances we'll need
    objXMLData = new ActiveXObject('MSXML2.FreeThreadedDOMDocument');
    objXMLProducts = new ActiveXObject('MSXML2.FreeThreadedDOMDocument');
    objXMLShippers = new ActiveXObject('MSXML2.FreeThreadedDOMDocument');

    // set current parser instance to load shippers data first
    // and set method name and data set name
    strMethodName = 'GetShippersDataSet';
    strDataName = 'Shippers';
    objXMLInstance = objXMLShippers;

    // call function to load orders data
    loadServiceData();
  }
}
//----------------------------------------------------

function loadServiceData() {
// loads data from Web Service using current page-level method name

  document.all('lblStatus').innerHTML = 'Accessing ' + strDataName
     + ' data via<br />Web Service - please wait ...';

  // call the Web Service to get the data. At the same time set up
  // the callback handler named "dataLoaded" to handle the results
  // we want a list of all orders for this specific customer, so
  // the CustID is provided for the single method parameter
  // the method name is stored in a page-level variable
  var iCallID = htcWService.UpdateOrders.callService(dataLoaded, strMethodName, strCustID);
}
//----------------------------------------------------

function dataLoaded(objResult) {
// runs once the Web Service has loaded the data from the server

  // see if there was an error
  if (objResult.error) {

    // get error details from errorDetail properties
    // of the objResult object passed to the function
    var strErrorCode = objResult.errorDetail.code;
    var strErrorMsg = objResult.errorDetail.string;
    var strErrorRaw = objResult.errorDetail.raw;

    // and display it
    document.all('lblStatus').innerHTML = '<b>* ERROR:</b> '
      + 'could not load ' + strDataName + ' data.<br />' + strErrorMsg;
  }
  else {

    document.all('lblStatus').innerHTML = 'Loading ' + strDataName
      + ' data from<br />Web Service - please wait ...';

    // there was no error so ready to use XML to fill MSXML parser
    // connect event with function to check when loading completes
    objXMLInstance.onreadystatechange = changeFunction;

    //set properties to load asynchronously
    objXMLInstance.validateOnParse = true;
    objXMLInstance.async = true;

    // load SOAP document (the results) from the Web Service
    objXMLInstance.loadXML(objResult.raw.xml);
  }
}
//----------------------------------------------------

function changeFunction() {
// check value of readyState property of XML parser

  // value 4 indicates loading complete
  if (objXMLInstance.readyState == 4) {

    if (objXMLInstance.parseError.errorCode != 0) {

      // there was an error while loading
      document.all('lblStatus').innerHTML =
        '<b>* ERROR</b> - could not load ' + strDataName + ' list.';
    }
    else {

      // get ready to load next set of data from server
      if (strDataName == 'Shippers') {
        // load products data
        strDataName = 'Products';
        strMethodName = 'GetProductsDataSet';
        objXMLInstance = objXMLProducts;
        loadServiceData();
      }
      else {
        if (strDataName == 'Products') {
          // load orders data
          strDataName = 'Orders';
          strMethodName = 'GetOrdersDataSet';
          objXMLInstance = objXMLData;
          loadServiceData();
        }
        else {

          // finished with current parser variable
          objXMLInstance = null;

          // fill Shippers and Products drop-down lists
          fillShippersList();
          fillProductsList();

          // extract diffgram section from SOAP document
          // because we are posting back just the diffgram
          // if sending updates back to a Web Service you
          // could instead modify the code in this page to
          // update the SOAP document and then submit this
          // to a Web Service method on the server instead
          var objDGNode = objXMLData.selectSingleNode('//diffgr:diffgram');
          var strDiffGram = objDGNode.xml;
          var objTempXML = new ActiveXObject('MSXML2.FreeThreadedDOMDocument');
          objTempXML.validateOnParse = false;
          objTempXML.async = false;
          objTempXML.loadXML(strDiffGram);
          objXMLData = objTempXML;

          // replace "Loading" message with customer ID
          document.all('lblStatus').innerHTML =
            'Orders for customer ID <b>"' + strCustID + '"</b>';

          // display list of matching orders in left-hand table
          showOrderList('OrderID');
        }
      }
    }
  }
}
//----------------------------------------------------

function fillShippersList() {
// fill drop-down list of shipper names and values

  // get collection of Shippers nodes
  var strXPath = '//Shippers';
  var objNodeSet = objXMLShippers.selectNodes(strXPath);

  // get a reference to the ShipName drop-down list
  var objList = document.all('selShipName');
  objList.options.length = 1;

  // add an <option> element for each shipper
  for (var intLoop = 0; intLoop < objNodeSet.length; intLoop++) {
    var strShipID = objNodeSet[intLoop].childNodes[0].text;
    var strShipName = objNodeSet[intLoop].childNodes[1].text;
    objList.options.length += 1;
    objList.options[objList.options.length - 1].value = strShipID;
    objList.options[objList.options.length - 1].text = strShipName;
  }
}
//----------------------------------------------------

function fillProductsList() {
// fill drop-down list of product names and values

  // get collection of Products nodes
  var strXPath = '//Products';
  var objNodeSet = objXMLProducts.selectNodes(strXPath);

  // get a reference to the AddProduct drop-down list
  var objList = document.all('selProducts');
  objList.options.length = 1;

  // add an <option> element for each product
  for (var intLoop = 0; intLoop < objNodeSet.length; intLoop++) {
    var strProductID = objNodeSet[intLoop].childNodes[0].text;
    var strProductName = objNodeSet[intLoop].childNodes[1].text;
    objList.options.length += 1;
    objList.options[objList.options.length - 1].value = strProductID;
    objList.options[objList.options.length - 1].text = strProductName;
  }
}
//----------------------------------------------------

function showOrderList(strSortOrder) {
// display the list of orders in the left-hand table

  // get result of transforming XML into a string for display
  var strResult = getStyledResult(false, '', strSortOrder);

  strURL = '../../customer-orders/webservices/customer-list.aspx';
  if (strResult.length > 0) {
    document.all('divOrderList').innerHTML = strResult;
    var msg = 'Click an <b>Order ID</b> in the grid above<br />'
            + 'to edit details of that order. Click<br />'
            + 'a <b>column heading</b> to sort orders<br />'
            + 'by the values in that column ...<br />'
            + 'or <a href="' + strURL + '"><b>select a different customer</b></a>.'
  }
  else
    var msg = 'No orders found for this customer ...<br />'
            + '<a href="' + strURL + '"><b>Select a different customer</b></a>';
  document.all('lblMessage').innerHTML = msg;
}
//----------------------------------------------------

function showOrderDetail(strOrderID) {
// display the order details and right-hand table of order lines

  // remove any existing update result message
  document.all('lblUpdateStatus').innerHTML = '';

  // get the details of the order to display above table
  // using DOM methods from the current XML parser object
  var strXPath = '//NewDataSet/Orders[OrderID="' + strOrderID + '"]'
  var objOrderNode = objXMLData.selectSingleNode(strXPath);

  // if order was deleted, we can't display details
  if (objOrderNode == null) return;

  var strThisOrderID = objOrderNode.childNodes[0].text;
  intOrderID = parseInt(strThisOrderID);
  var strThisOrdered = objOrderNode.childNodes[2].text;
  var strThisRequired = objOrderNode.childNodes[3].text;

  // if ShippedDate is null in database, node will not
  // appear in XML so check next node name
  if (objOrderNode.childNodes[4].nodeName == 'ShippedDate') {
    var strThisShipped = objOrderNode.childNodes[4].text;
    var strThisVia = objOrderNode.childNodes[5].text;
    var strThisFreight = formatDecimal(objOrderNode.childNodes[6].text);
    var strThisCustName = objOrderNode.childNodes[7].text;
    var strThisAddress = objOrderNode.childNodes[8].text;
    var strThisCity = objOrderNode.childNodes[9].text;
    var strThisPostCode = objOrderNode.childNodes[10].text;
    var strThisCountry = objOrderNode.childNodes[11].text;
  }
  else {
    var strThisShipped = '';
    var strThisVia = objOrderNode.childNodes[4].text;
    var strThisFreight = formatDecimal(objOrderNode.childNodes[5].text);
    var strThisCustName = objOrderNode.childNodes[6].text;
    var strThisAddress = objOrderNode.childNodes[7].text;
    var strThisCity = objOrderNode.childNodes[8].text;
    var strThisPostCode = objOrderNode.childNodes[9].text;
    var strThisCountry = objOrderNode.childNodes[10].text;
  }

  // fill in order details on page
  document.all('lblOrderID').innerHTML = 'Order ID: <b>'
      + strThisOrderID + '</b> &nbsp; '
      + 'Ordered: ' + strThisOrdered.substring(0, 10);
  document.all('txtShipName').value = strThisCustName;
  document.all('txtShipAddress').value = strThisAddress;
  document.all('txtShipCity').value = strThisCity;
  document.all('txtShipPostCode').value = strThisPostCode;
  document.all('txtShipCountry').value = strThisCountry;
  document.all('txtRequiredDate').value = strThisRequired.substring(0, 10);
  document.all('txtShippedDate').value = strThisShipped.substring(0, 10);
  document.all('txtFreight').value = strThisFreight;
  document.all('selShipName').value = strThisVia;

  // show table containing order details and select Name
  document.all('tblOrderDetail').style.display = '';
  document.all('txtShipName').select();

  // get result of transforming Order Details XML into
  // a string and display it, and show update buttons
  var strResult = getStyledResult(true, strOrderID, '');
  document.all('divOrderLines').innerHTML = strResult;
  document.all('divOrderLines').style.display = '';
  document.all('divAddline').style.display = '';

  // get the order total by iterating the OrderLines nodes
  strXPath = '//NewDataSet/Order_x0020_Details[OrderID="' + strOrderID + '"]'
  var objOrderLines = objOrderNode.selectNodes(strXPath);
  var dblTotal = new Number(0);
  for (i = 0; i < objOrderLines.length; i++) {
    dblTotal += parseFloat(objOrderLines[i].childNodes[7].text);
  }

  // format it with two decimal places and display it
  var strTotal = formatDecimal(dblTotal.toString());
  var msg = 'Total order value: <b>$' + strTotal + '</b> &nbsp;';
  document.all('lblOrderTotal').innerHTML = msg;
  document.all('lblOrderTotal').style.display = '';
}
//----------------------------------------------------

function getStyledResult(blnOrderDetail, strOrderID, strSortOrder) {
// returns the result of applying an XSLT transformation to the
// orders list as a string containing the HTML to display

  if (blnOrderDetail == false)
    var strStyle = getOrdersStyleSheet(strSortOrder)
  else
    var strStyle = getOrderLinesStyleSheet(strOrderID);

  // create a new parser object instance
  var objXMLStyle = new ActiveXObject('MSXML2.FreeThreadedDOMDocument');

  // load the stylesheet as a string
  objXMLStyle.loadXML(strStyle);

  // create a new XSLTemplate object and set stylesheet
  var objTemplate = new ActiveXObject('MSXML2.XSLTemplate');
  objTemplate.stylesheet = objXMLStyle;

  // create a processor to handle the parameters
  var objProc = objTemplate.createProcessor();

  // specify the XML parser to use
  objProc.input = objXMLData;

  // set the parameter value
  objProc.addParameter('orderid', strOrderID);

  // perform transformation and set value of string to return
  if (objProc.transform() == true)
    var strResult = objProc.output
  else
    var strResult = '';
  return strResult;
}
//----------------------------------------------------

function getOrdersStyleSheet(strSortOrder) {
  // build a style sheet that transforms the XML document
  // to display a list of orders

  // decide how to sort the values
  if (strSortOrder == 'OrderID') {
    strDataType = 'number';
    strAscDesc = 'ascending';
  }
  else {
    strDataType = 'text';
    strAscDesc = 'descending';
  }

  return '<?xml version="1.0" ?>\n'
    + '<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">\n'
    + ' <xsl:template match="/">\n'
    + '  <table id="tblOrders" cellspacing="0" cellpadding="5"\n'
    + '         rules="cols" border="1" style="border-collapse:collapse;">\n'
    + '   <tr style="background-color:silver;">\n'
    + '    <td align="center" nowrap="nowrap">\n'
    + '      <a href="javascript:showOrderList(\'OrderID\')"><b>ID</b></a>\n'
    + '    </td>\n'
    + '    <td align="center" nowrap="nowrap">\n'
    + '      <a href="javascript:showOrderList(\'OrderDate\')"><b>Order Date</b></a>\n'
    + '    </td>\n'
    + '    <td align="center" nowrap="nowrap">\n'
    + '      <a href="javascript:showOrderList(\'ShippedDate\')"><b>Shipped</b></a>\n'
    + '    </td>\n'
    + '   </tr>\n'
    + '   <xsl:for-each select="//NewDataSet/Orders">\n'
    + '   <xsl:sort select="' + strSortOrder + '" order="' + strAscDesc + '" data-type="' + strDataType + '" />\n'
    + '    <tr>\n'
    + '     <td align="center" nowrap="nowrap" style="background-color:#add8e6;">\n'
    + '      <a>\n'
    + '        <xsl:attribute name="href">\n'
    + '         javascript:showOrderDetail(<xsl:value-of select="OrderID" />);\n'
    + '        </xsl:attribute>\n'
    + '        <xsl:value-of select="OrderID" />\n'
    + '      </a>\n'
    + '     </td>\n'
    + '     <td align="left" nowrap="nowrap" style="background-color:#ffffff;">\n'
    + '      <xsl:value-of select="substring(OrderDate,1,10)" />\n'
    + '     </td>\n'
    + '     <td align="left" nowrap="nowrap" style="background-color:#ffffff;">\n'
    + '      <xsl:value-of select="substring(ShippedDate,1,10)" />\n'
    + '     </td>\n'
    + '    </tr>\n'
    + '   </xsl:for-each>\n'
    + '   <tr style="background-color:silver;">\n'
    + '    <td colspan="3" align="right">\n'
    + '     <input type="button" id="btnNewOrder" value="New Order" tabindex="21"\n'
    + '            onclick="newOrder()" />\n'
    + '    </td>\n'
    + '   </tr>\n'
    + '  </table>\n'
    + ' </xsl:template>\n'
    + '</xsl:stylesheet>';
}
//----------------------------------------------------

function getOrderLinesStyleSheet(strOrderID) {
  // build a style sheet that transforms the XML document
  // to display a list of order lines given the OrderID

  // create the XPath required by the style sheet
  var strXPath = 'descendant::NewDataSet/Order_x0020_Details[descendant::OrderID=$orderid]';

  return '<?xml version="1.0" ?>\n'
    + '<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">\n'
    + ' <xsl:param name="orderid" />\n'
    + ' <xsl:template match="/">\n'
    + '  <table id="tblOrderLines" cellspacing="0" cellpadding="5"\n'
    + '         border="1" style="border-collapse:collapse;">\n'
    + '   <tr style="background-color:silver;">\n'
    + '    <td align="center"><b>Qty</b></td>\n'
    + '    <td align="center"><b>Product</b></td>\n'
    + '    <td align="center"><b>Packs</b></td>\n'
    + '    <td align="center"><b>Each</b></td>\n'
    + '    <td align="center"><b>Discount</b></td>\n'
    + '    <td align="center"><b>Total</b></td>\n'
    + '    <td align="center"></td>\n'
    + '    <td align="center"></td>\n'
    + '   </tr>\n'
    + '   <xsl:for-each select="' + strXPath + '">\n'
    + '   <xsl:sort select="ProductName" order="ascending" data-type="text" />\n'
    + '    <tr>\n'
    + '     <td align="center">\n'
    + '      <input type="text" size="1"> \n'
    + '       <xsl:attribute name="id">txtQuantity-<xsl:value-of select="ProductID" /></xsl:attribute>\n'
    + '       <xsl:attribute name="value"><xsl:value-of select="Quantity" /></xsl:attribute>\n'
    + '      </input>\n'
    + '     </td>\n'
    + '     <td align="left">\n'
    + '      <xsl:value-of select="ProductName" />\n'
    + '     </td>\n'
    + '     <td align="left">\n'
    + '      <xsl:value-of select="QtyPerUnit" />\n'
    + '     </td>\n'
    + '     <td align="right" nowrap="nowrap">\n'
    + '      $<input type="text" size="4"> \n'
    + '        <xsl:attribute name="id">txtPrice-<xsl:value-of select="ProductID" /></xsl:attribute>\n'
    + '        <xsl:attribute name="value"><xsl:value-of select="format-number(UnitPrice,\'#,##0.00\')" /></xsl:attribute>\n'
    + '       </input>\n'
    + '     </td>\n'
    + '     <td align="right" nowrap="nowrap">\n'
    + '      <input type="text" size="5"> \n'
    + '       <xsl:attribute name="id">txtDiscount-<xsl:value-of select="ProductID" /></xsl:attribute>\n'
    + '       <xsl:attribute name="value"><xsl:value-of select="format-number(Discount,\'#0.00%\')" /></xsl:attribute>\n'
    + '      </input>\n'
    + '     </td>\n'
    + '     <td align="right" nowrap="nowrap">\n'
    + '      $<xsl:value-of select="format-number(LineTotal,\'#,##0.00\')" />\n'
    + '     </td>\n'
    + '     <td align="center" nowrap="nowrap">\n'
    + '      <input type="button" value="Update" style="font-size:11px">\n'
    + '       <xsl:attribute name="onclick">updateOrderLine(<xsl:value-of select="ProductID" />)</xsl:attribute>\n'
    + '      </input>\n'
    + '     </td>\n'
    + '     <td align="center" nowrap="nowrap">\n'
    + '      <input type="button" value="Delete" style="font-size:11px">\n'
    + '       <xsl:attribute name="onclick">deleteOrderLine(<xsl:value-of select="ProductID" />)</xsl:attribute>\n'
    + '      </input>\n'
    + '     </td>\n'
    + '    </tr>\n'
    + '   </xsl:for-each>\n'
    + '  </table>\n'
    + ' </xsl:template>\n'
    + '</xsl:stylesheet>';
}

//----------------------------------------------------

function selectProduct(objList) {
  // enable or disable "Add" button
  document.all('btnAddLine').disabled = (objList.selectedIndex == 0);
}

//----------------------------------------------------

function viewDiffgram(sVersion) {
  // send XML DiffGram to page that shows contents

  // clear "dirty" flag to allow new page to load
  blnIsDirty = false;

  // set different "action" for form
  document.all('frmPostXML').action = 'view-diffgram-' + sVersion + '.aspx';

  // insert XML into hidden control and submit form
  document.all('hidPostXML').value = objXMLData.xml;
  document.all('frmPostXML').submit();
}

//----------------------------------------------------

function sendToServer() {
  // send XML DiffGram to server via Web Service

  // disable "Save Changes" button
  document.all('btnSaveChanges').disabled = true;

  // show message in status label and clear "Errors" lable
  document.all('lblStatus').innerHTML = 'Sending order updates...'
  document.all('lblUpdateStatus').innerHTML = '';

  // remove any row errors that might be in diffgram
  // will be there if reconciling a previous error
  var strXPath = '//diffgr:errors';
  var objErrorsNode = objXMLData.selectSingleNode(strXPath);
  if (objErrorsNode != null) {
    objErrorsNode.parentNode.removeChild(objErrorsNode);
  }

  // get XML string to send to server as method parameter
  // cannot send an XML document directly, so HTMLEncode it
  // using custom function defined below in this page
  var strDiffGram = htmlEncode(objXMLData.xml);

  // call the Web Service to send the data. At the same time set up
  // the callback handler named "dataSent" to handle the results
  var iCallID = htcWService.UpdateOrders.callService(dataSent, "UpdateAllOrders", strCustID, strDiffGram);
}

//----------------------------------------------------

function htmlEncode(strInput) {
// returns the HTML-encoded version of the string
// assuming that ampersands are already converted
// by the properties of the MSXML parser

  // replace characters with ASCII code over 127
  // with the HTML-encoded equivalent of "&#xxx"
  var intCharCode;
  for (index = 0; index < strInput.length; index++) {
    intCharCode = strInput.charCodeAt(index);
    if (intCharCode > 127) {
    strInput = strInput.substring(0, index) + '&#' + intCharCode.toString() + ';'
      + strInput.substring(index + 1, strInput.length + 1);
    }
  }

  // replace all double quotes with "&quot;"
  //var index = strInput.indexOf('"');
  while (index >= 0) {
    strInput = strInput.substring(0, index) + '&quot;'
      + strInput.substring(index + 1, strInput.length + 1);
    index = strInput.indexOf('"', index + 1);
  }

  // replace all single quotes with "&apos;"
  var index = strInput.indexOf("'");
  while (index >= 0) {
    strInput = strInput.substring(0, index) + '&apos;'
      + strInput.substring(index + 1, strInput.length + 1);
    index = strInput.indexOf("'", index + 1);
  }

  // replace all "<" and ">" with "&lt;" and "&gt;"
  var index = strInput.indexOf('<');
  while (index >= 0) {
    strInput = strInput.substring(0, index) + '&lt;'
      + strInput.substring(index + 1, strInput.length + 1);
    index = strInput.indexOf('<', index + 1);
  }
  index = strInput.indexOf('>');
  while (index >= 0) {
    strInput = strInput.substring(0, index) + '&gt;'
      + strInput.substring(index + 1, strInput.length + 1);
    index = strInput.indexOf('>', index + 1);
  }

  return strInput;
}
//----------------------------------------------------

function dataSent(objResult) {
// runs once the Web Service has sent the data to the server

  // see if there was an error
  if (objResult.error) {

    // get error details from errorDetail properties
    // of the objResult object passed to the function
    var strErrorCode = objResult.errorDetail.code;
    var strErrorMsg = objResult.errorDetail.string;
    var strErrorRaw = objResult.errorDetail.raw;

    // and display it
    document.all('lblStatus').innerHTML = '<b>* ERROR:</b> '
      + 'could not send data.<br />' + strErrorMsg;
  }
  else {

    // clear "dirty" flag and update status
    blnIsDirty = false;
    document.all('lblStatus').innerHTML =
      'Orders for customer ID <b>"' + strCustID + '"</b>';

    // load returned diffgram into temporary XML parser
    var objTempXML = new ActiveXObject('MSXML2.FreeThreadedDOMDocument');
    objTempXML.validateOnParse = false;
    objTempXML.async = false;
    objTempXML.loadXML(objResult.raw.xml);

    // extract diffgram section from SOAP document
    var objDGNode = objTempXML.selectSingleNode('//diffgr:diffgram');
    var strDiffGram = objDGNode.xml;
    objXMLData.loadXML(strDiffGram);
    objTempXML = null;   // destroy temporary parser

    // count number of rows with errors
    // create XPath for <diffgr:errors> section
    var strXPath = '//diffgr:errors/*';
    var strResult = '';   // to hold update message

    // count number of rows with errors
    // create XPath for <diffgr:errors> section
    var strXPath = '//diffgr:errors/*';
    var strResult = '';   // to hold update message

    //see how many rows with errors were returned
    var colErrorNodes = objXMLData.selectNodes(strXPath);
    try {
      intErrors = colErrorNodes.length;
    }
    catch(e) {
      intErrors = 0;
    }
    if (intErrors != 0) {

      strResult = '<b>Update errors occurred in '
                +  intErrors.toString() + ' row(s)</b>:<p />';

      var strErrorID;        // to hold diffgr:id value from node
      var objOriginalNode;   // to hold <NewDataSet> node

      // iterate through all the <diffgr:errors> nodes
      for (var intLoop = 0; intLoop < intErrors; intLoop++) {

        // get the diffgr:id attribute value
        strErrorID = colErrorNodes[intLoop].getAttribute('diffgr:id');

        // create XPath to find this node anywhere in the
        // <NewDataSet> or <diffgr:before> sections of diffgram
        if (strErrorID.indexOf('Order Details') == -1)
          strXPath = '//Orders[@diffgr:id="' + strErrorID + '"]'
        else
          strXPath = '//Order_x0020_Details[@diffgr:id="' + strErrorID + '"]';
        objOriginalNode = objXMLData.selectSingleNode(strXPath);

        // extract the OrderID value
        strResult += 'Order ID: <b>' + objOriginalNode.childNodes[0].text + '</b>';

        // if it's an order line, extract the product name as well
        if (strErrorID.indexOf('Order Details') != -1) {
          strResult += ', Product: <b>' + objOriginalNode.childNodes[5].text + '</b>';
        }

        // extract the error message from node in the diffgr:errors section
        strResult +=  ' - ' + colErrorNodes[intLoop].getAttribute('diffgr:Error') + '<p />';
      }
    }
    else
      strResult = '<b>All your updates were successfully applied.</b>';

    // hide order details section
    document.all('divAddLine').style.display = 'none';
    document.all('lblOrderTotal').innerHTML = '';
    document.all('divOrderLines').style.display = 'none';
    document.all('tblOrderDetail').style.display = 'none';

    // show list of orders and result message
    showOrderList('OrderID');
    document.all('lblUpdateStatus').innerHTML = strResult + '<p />';
  }
}
//----------------------------------------------------

function checkIfDirty() {
  // see if data has been changed before page is unloaded
  if (blnIsDirty) {

    // prompt user to save changes to server
    var strConfirm = 'The order details for this customer have been changed.\n'
                   + 'Do you want to save these changes to the server?';
    if (confirm(strConfirm)) sendToServer();
  }
}
//----------------------------------------------------

function getCurrentDateString() {
  // creates a string in format yyyy-mm-dd for current date

  var objToday = new Date();
  var strMonth = '0' + (objToday.getMonth() + 1).toString();
  var strDay = '0' + objToday.getDate().toString();
  return objToday.getYear().toString() + '-'
    + strMonth.substring(strMonth.length - 2, strMonth.length)
    + '-' + strDay.substring(strDay.length - 2, strDay.length);
}

//----------------------------------------------------

function getNodeReference(strTableName, intThisOrder, strThisProduct) {
  // get node in <NewDataSet> from named table
  // optionally with specified OrderID and ProductID

  // create appropriate XPath
  var strXPath = '//NewDataSet/' + strTableName
               + '[OrderID="' + intThisOrder.toString() + '"'
  if (strTableName != 'Orders')
    strXPath += ' and ProductID="' + strThisProduct + '"';
  strXPath += ']';

  // select and return the matching node
  return objXMLData.selectSingleNode(strXPath);
}

//----------------------------------------------------

function copyToDiffgrBefore(objNode) {
  // copy node to <diffgr:before> section if not already there

  // see if it has already been modified or inserted
  if (objNode.getAttribute('diffgr:hasChanges') != null) return;

  // get node name and "rowOrder" attribute value
  var strElemName = objNode.nodeName;
  var strRowOrder = objNode.getAttribute('msdata:rowOrder');

  // create appropriate XPath
  var strXPath = '//diffgr:before/' + strElemName
               + '[@msdata:rowOrder="' + strRowOrder + '"]';

  // see if node is already in <diffgr:before> section
  var colNodeSet = objXMLData.selectNodes(strXPath);
  if (colNodeSet.length == 0) {

    // copy node to <diffgr:before> section
    // see if there actually is a <diffgr:before> section
    var colBeforeNodes = objXMLData.selectNodes('//diffgr:before');
    if (colBeforeNodes.length == 0) {

      // create <diffgr:before> section and get reference to it
      var objNewNode = objXMLData.createElement('diffgr:before');
      objXMLData.documentElement.appendChild(objNewNode);
      colBeforeNodes = objXMLData.selectNodes('//diffgr:before');
    }

    // make copy of node and put into <diffgr:before> section
    colBeforeNodes[0].appendChild(objNode.cloneNode(true));
  }
}

//----------------------------------------------------

function getEditedValuesNode(objNode, strTableName, strProductID) {
  // gets values in page controls and puts into
  // supplied node, depending on table name

  if (strTableName == 'Orders') {

    // set RequiredDate - use today if no value provided
    var strRequired = document.all('txtRequiredDate').value;
    if (strRequired == '') {
      strRequired = getCurrentDateString();
      document.all('txtRequiredDate').value = strRequired;
    }
    objNode.childNodes[3].text = strRequired;

    // set ShippedDate if provided
    // create or remove node in XML as appropriate
    var strShipped = document.all('txtShippedDate').value;
    if (strShipped == '') {

      // remove ShippedDate child node if it exists
      if (objNode.childNodes[4].nodeName == 'ShippedDate')
        objNode.removeChild(objNode.childNodes[4]);
    }
    else {

      // add ShippedDate child node if not already there
      if (objNode.childNodes[4].nodeName != 'ShippedDate') {
        objNewNode = objXMLData.createElement('ShippedDate');
        objNode.insertBefore(objNewNode, objNode.childNodes[4]);
      }
      objNode.childNodes[4].text = strShipped;
    }

    // get Shipper values from drop-down list
    var objViaList = document.all('selShipName');
    var strShipVia = objViaList.options[objViaList.selectedIndex].value;
    var strShipper = objViaList.options[objViaList.selectedIndex].text;

    // now set following nodes in XML
    if (objNode.childNodes[4].nodeName == 'ShippedDate') {
      objNode.childNodes[5].text = strShipVia;
      objNode.childNodes[6].text = document.all('txtFreight').value;
      objNode.childNodes[7].text = document.all('txtShipName').value;
      objNode.childNodes[8].text = document.all('txtShipAddress').value;
      objNode.childNodes[9].text = document.all('txtShipCity').value;
      objNode.childNodes[10].text = document.all('txtShipPostCode').value;
      objNode.childNodes[11].text = document.all('txtShipCountry').value;
      objNode.childNodes[12].text = strShipper;
    }
    else {
      objNode.childNodes[4].text = strShipVia;
      objNode.childNodes[5].text = document.all('txtFreight').value;
      objNode.childNodes[6].text = document.all('txtShipName').value;
      objNode.childNodes[7].text = document.all('txtShipAddress').value;
      objNode.childNodes[8].text = document.all('txtShipCity').value;
      objNode.childNodes[9].text = document.all('txtShipPostCode').value;
      objNode.childNodes[10].text = document.all('txtShipCountry').value;
      objNode.childNodes[11].text = strShipper;
    }
  }
  else {    // -- processing Order Details table

    // get values from current order line into strings and validate
    // text box IDs include the product ID allowing direct access
    strQuantity = document.all('txtQuantity-' + strProductID).value;
    strUnitPrice = document.all('txtPrice-' + strProductID).value;
    strDiscount = document.all('txtDiscount-' + strProductID).value;

    // validate input values as numbers
    try {
      var intQty = parseInt(strQuantity);
      var sngPrice = parseFloat(strUnitPrice);
      var sngDisc = parseFloat(strDiscount);
    }
    catch(e) {
    }

    // if Quantity is NaN or less than zero show error message
    if (! intQty > 0) {
      alert('The value you entered for\n"Qty" is not a valid number.');
      return;
    }

    // if UnitPrice is NaN or less than zero assume zero
    if (! sngPrice > 0) sngPrice = 0;

    // if Discount is NaN or less than zero assume zero
    if (sngDisc > 0)
      sngDisc = sngDisc / 100
    else
      sngDisc = 0;

    //calculate LineTotal value
    var dblTotal = intQty * (sngPrice - (sngPrice * sngDisc));

    // update nodes in XML Order Details node
    objNode.childNodes[2].text = sngPrice.toString();
    objNode.childNodes[3].text = intQty.toString();
    objNode.childNodes[4].text = sngDisc.toString();
    objNode.childNodes[7].text = dblTotal.toString();
  }
}

//----------------------------------------------------

function createOrdersNode(intRowOrder) {
  // create a new empty Orders node with default values

  // create <Orders> element node
  var objNode = objXMLData.createElement('Orders');

  // set "id", "rowOrder" and "hasChanges" attributes for new node
  var strRowOrder = intRowOrder.toString();
  intRowOrder++;
  var strID = 'Orders' + intRowOrder.toString();
  objNode.setAttribute('diffgr:id', strID);
  objNode.setAttribute('msdata:rowOrder', strRowOrder);
  objNode.setAttribute('diffgr:hasChanges', 'inserted');

  // add child node for current OrderID
  var objChildNode = objXMLData.createElement('OrderID');
  objChildNode.text = intOrderID.toString();
  objNode.appendChild(objChildNode);

  // add child node for current CustomerID
  objChildNode = objXMLData.createElement('CustomerID');
  objChildNode.text = strCustID;
  objNode.appendChild(objChildNode);

  // add child node for OrderDate (default is today)
  objChildNode = objXMLData.createElement('OrderDate');
  objChildNode.text = getCurrentDateString();
  objNode.appendChild(objChildNode);

  // add child node for RequiredDate (default is today)
  objChildNode = objXMLData.createElement('RequiredDate');
  objChildNode.text = getCurrentDateString();
  objNode.appendChild(objChildNode);

  // add child node for ShipVia (default is 0)
  objChildNode = objXMLData.createElement('ShipVia');
  objChildNode.text = '0';
  objNode.appendChild(objChildNode);

  // add child node for Freight (default is $15.00)
  objChildNode = objXMLData.createElement('Freight');
  objChildNode.text = '15';
  objNode.appendChild(objChildNode);

  // get name and address from existing order if possible
  var strShipName = '[name]';           // default values
  var strShipAddress = '[address]';
  var strShipCity = '[city]';
  var strShipPostCode = '[post code]';
  var strShipCountry = '[country]';

  // get reference to first existing order
  var colAnyOrders = objXMLData.selectNodes('//NewDataSet/Orders');
  if (colAnyOrders.length != 0) {

    // got at least one order node, see where name and address
    // are depending on whether ShippedDate node exists
    if (colAnyOrders[0].childNodes[4].nodeName == 'ShippedDate') {
      strShipName = colAnyOrders[0].childNodes[7].text;
      strShipAddress = colAnyOrders[0].childNodes[8].text;
      strShipCity = colAnyOrders[0].childNodes[9].text;
      strShipPostCode = colAnyOrders[0].childNodes[10].text;
      strShipCountry = colAnyOrders[0].childNodes[11].text;
    }
    else {
      strShipName = colAnyOrders[0].childNodes[6].text;
      strShipAddress = colAnyOrders[0].childNodes[7].text;
      strShipCity = colAnyOrders[0].childNodes[8].text;
      strShipPostCode = colAnyOrders[0].childNodes[9].text;
      strShipCountry = colAnyOrders[0].childNodes[10].text;
    }
  }

  // add child node for ShipName
  objChildNode = objXMLData.createElement('ShipName');
  objChildNode.text = strShipName;
  objNode.appendChild(objChildNode);

  // add child node for ShipAddress
  objChildNode = objXMLData.createElement('ShipAddress');
  objChildNode.text = strShipAddress;
  objNode.appendChild(objChildNode);

  // add child node for ShipCity
  objChildNode = objXMLData.createElement('ShipCity');
  objChildNode.text = strShipCity;
  objNode.appendChild(objChildNode);

  // add child node for ShipPostalCode
  objChildNode = objXMLData.createElement('ShipPostalCode');
  objChildNode.text = strShipPostCode;
  objNode.appendChild(objChildNode);

  // add child node for ShipCountry
  objChildNode = objXMLData.createElement('ShipCountry');
  objChildNode.text = strShipCountry;
  objNode.appendChild(objChildNode);

  // add empty child node for ShipperName
  objChildNode = objXMLData.createElement('ShipperName');
  objNode.appendChild(objChildNode);

  return objNode;
}

//----------------------------------------------------

function createOrderLinesNode(strProductID, intRowOrder) {
  // create a new empty Order Details node with default values

  // get details of selected product
  var strXPath = '//Products[ProductID="' + strProductID + '"]'
  var objProductNode = objXMLProducts.selectSingleNode(strXPath);
  var strProductName = objProductNode.childNodes[1].text;
  var strQtyPerUnit = objProductNode.childNodes[2].text;
  var strUnitPrice = objProductNode.childNodes[3].text;

  // create <Order_x0020_Details> element node
  var objNode = objXMLData.createElement('Order_x0020_Details');

  // set "id", "rowOrder" and "hasChanges" attributes for new node
  var strRowOrder = intRowOrder.toString();
  intRowOrder++;
  var strID = 'Order Details' + intRowOrder.toString();
  objNode.setAttribute('diffgr:id', strID);
  objNode.setAttribute('msdata:rowOrder', strRowOrder);
  objNode.setAttribute('diffgr:hasChanges', 'inserted');

  // add child node for current OrderID
  var objChildNode = objXMLData.createElement('OrderID');
  objChildNode.text = intOrderID.toString();
  objNode.appendChild(objChildNode);

  // add child node for current ProductID
  var objChildNode = objXMLData.createElement('ProductID');
  objChildNode.text = strProductID;
  objNode.appendChild(objChildNode);

  // add child node for current UnitPrice
  var objChildNode = objXMLData.createElement('UnitPrice');
  objChildNode.text = strUnitPrice;
  objNode.appendChild(objChildNode);

  // add child node for current Quantity (default is 1)
  var objChildNode = objXMLData.createElement('Quantity');
  objChildNode.text = '1';
  objNode.appendChild(objChildNode);

  // add child node for current Discount (default is 0)
  var objChildNode = objXMLData.createElement('Discount');
  objChildNode.text = '0';
  objNode.appendChild(objChildNode);

  // add child node for current ProductName
  var objChildNode = objXMLData.createElement('ProductName');
  objChildNode.text = strProductName;
  objNode.appendChild(objChildNode);

  // add child node for current QtyPerUnit
  var objChildNode = objXMLData.createElement('QtyPerUnit');
  objChildNode.text = strQtyPerUnit;
  objNode.appendChild(objChildNode);

  // add child node for current LineTotal
  var objChildNode = objXMLData.createElement('LineTotal');
  objChildNode.text = strUnitPrice;
  objNode.appendChild(objChildNode);

  return objNode;
}

//----------------------------------------------------

function addOrderLine() {
  // runs when the "Add (Order line) button is clicked

  // get selected ProductID from drop-down list
  var objList = document.all('selProducts');
  var strProductID = objList.options[objList.selectedIndex].value;

  // change list back to "Select product..."
  // and disable "Add" button
  document.all('selProducts').selectedIndex = 0;
  document.all('btnAddLine').disabled = true;

  // see if selected product already exists in this order
  var strXPath = '//NewDataSet/Order_x0020_Details[OrderID="'
               + intOrderID.toString() + '" and ProductID="'
               + strProductID + '"]';
  var objLinesNodes = objXMLData.selectNodes(strXPath);
  if (objLinesNodes.length > 0) {
    var strMsg = 'This product is already on the order.\n'
               + 'Edit the quantity to add more items.'
    alert(strMsg);
    return;
  }

  // need row order number, or zero if no existing Order Lines node
  // get NodeList of <Order Lines> nodes if there are any
  var objOrdersList = objXMLData.selectNodes('//NewDataSet/Order_x0020_Details');
  if (objOrdersList.length > 0) {
    var objLastOrder = objOrdersList[objOrdersList.length - 1];
    var intRowOrder = parseInt(objLastOrder.getAttribute('msdata:rowOrder')) + 1;
  }
  else     // no existing order lines for this customer
    var intRowOrder = 0;

  // create the new Order Details node
  var objNode = createOrderLinesNode(strProductID, intRowOrder);

  // append new node as child of <NewDataSet> element in diffgram
  objOrdersList = objXMLData.selectNodes('//NewDataSet');
  objOrdersList[0].appendChild(objNode);

  // refresh list of order lines in right-hand section of page
  showOrderDetail(intOrderID);

  // select Quantity text box for order added
  document.all('txtQuantity-' + strProductID).select();

  blnIsDirty = true;  // set "dirty" flag

  // enable "Save Changes" button
  document.all('btnSaveChanges').disabled = false;
}

//----------------------------------------------------

function updateOrderLine(strProductID) {
  // runs when the "Update" (Order Lines) button is clicked

  // get reference to existing node
  var objNode = getNodeReference('Order_x0020_Details', intOrderID, strProductID);

  // copy to <diffgr:before> if not already there
  copyToDiffgrBefore(objNode);

  // update values of existing node from page controls
  getEditedValuesNode(objNode, 'Order_x0020_Details', strProductID);

  // add 'modified' attribute to node but not if it
  // is a node that was inserted in this session
  if (objNode.getAttribute('diffgr:hasChanges') != 'inserted')
    objNode.setAttribute('diffgr:hasChanges', 'modified');

  // refresh list of order lines to get actual values used
  showOrderDetail(intOrderID);

  // select Quantity text box for order modified
  document.all('txtQuantity-' + strProductID).select();

  blnIsDirty = true;  // set "dirty" flag

  // enable "Save Changes" button
  document.all('btnSaveChanges').disabled = false;
}

//----------------------------------------------------

function deleteOrderLine(strProductID) {
  // runs when the "Delete" (Order Lines) button is clicked

  // get reference to existing node
  var objNode = getNodeReference('Order_x0020_Details', intOrderID, strProductID);

  // copy to <diffgr:before> if not already there
  copyToDiffgrBefore(objNode);

  // delete this node from XML
  objNode.parentNode.removeChild(objNode);

  // refresh list of order lines in right-hand section of page
  showOrderDetail(intOrderID);

  blnIsDirty = true;  // set "dirty" flag

  // enable "Save Changes" button
  document.all('btnSaveChanges').disabled = false;
}

//----------------------------------------------------

function updateOrder() {
  // runs when the "Update" (Order) button is clicked

  // get reference to existing node
  var objNode = getNodeReference('Orders', intOrderID, 0);

  // copy to <diffgr:before> if not already there
  copyToDiffgrBefore(objNode);

  // update values of existing node from page controls
  getEditedValuesNode(objNode, 'Orders')

  // add 'modified' attribute to node but not if it
  // is a node that was inserted in this session
  if (objNode.getAttribute('diffgr:hasChanges') != 'inserted')
    objNode.setAttribute('diffgr:hasChanges', 'modified');

  // refresh list of orders in left-hand table
  // in case ShippedDate has been changed
  showOrderList('OrderID');

  // refresh order details in right-hand section of page
  // to show formatted values
  showOrderDetail(intOrderID);

  blnIsDirty = true;  // set "dirty" flag

  // enable "Save Changes" button
  document.all('btnSaveChanges').disabled = false;
}

//----------------------------------------------------

function deleteOrder() {
  // runs when the "Delete" (Order) button is clicked

  // get reference to existing node
  var objNode = getNodeReference('Orders', intOrderID);

  // copy to <diffgr:before> if not already there
  copyToDiffgrBefore(objNode);

  // delete this node from XML
  objNode.parentNode.removeChild(objNode);

  // delete all related Order Details nodes from XML
  // required to "cascade deletes" as would happen if
  // we were using a DataSet that has a relation set up

  // create XPath and get NodeList of Order Details nodes
  var strXPath = '//NewDataSet/Order_x0020_Details[OrderID="'
               + intOrderID + '"]';
  var colNodeList = objXMLData.selectNodes(strXPath);

  // iterate through NodeList deleting nodes
  // also need to add these to <diffgr:before> section
  for (var intLoop = colNodeList.length - 1; intLoop >= 0; intLoop--) {
    var objChildNode = colNodeList[intLoop];
    copyToDiffgrBefore(objChildNode);
    objChildNode.parentNode.removeChild(objChildNode);
  }

  // refresh list of orders in left-hand table
  // in case ShippedDate has been changed
  showOrderList('OrderID');

  // hide order details section of page
  document.all('divAddLine').style.display = 'none';
  document.all('lblOrderTotal').innerHTML = '';
  document.all('divOrderLines').style.display = 'none';
  document.all('tblOrderDetail').style.display = 'none';

  blnIsDirty = true;  // set "dirty" flag

  // enable "Save Changes" button
  document.all('btnSaveChanges').disabled = false;
}

//----------------------------------------------------

function newOrder() {
  // runs when the "New Order" button is clicked

  // get temporary new order ID and increment ready for next one
  intOrderID = intLastNewID;
  intLastNewID++;

  // need row order number, or zero if no existing Orders node
  var intRowOrder = 0;  // assume no existing Orders nodes

  // get NodeList of <Orders> nodes
  var objOrdersList = objXMLData.selectNodes('//NewDataSet/Orders');
  if (objOrdersList.length > 0) {
    var objLastOrder = objOrdersList[objOrdersList.length - 1];
    intRowOrder = parseInt(objLastOrder.getAttribute('msdata:rowOrder')) + 1;
  }

  // create the new Order node
  var objNode = createOrdersNode(intRowOrder);

  // get reference to <NewDataSet> node in diffgram
  var objParentNode = objXMLData.selectSingleNode('//NewDataSet');

  // make sure that <NewDataSet> element exists
  if (objParentNode == null) {

     // does not exist, so create <NewDataSet> element node
     var objParentNode = objXMLData.createElement('NewDataSet');

     // get reference to diffgram root node and append it
     var objDGNode = objXMLData.selectSingleNode('//diffgr:diffgram');
     objDGNode.appendChild(objParentNode);
  }

  // append new <Orders> node as child of <NewDataSet> node
  objParentNode.appendChild(objNode);

  // refresh list of orders in left-hand table
  showOrderList('OrderID');

  // show new order in right-hand section of page
  showOrderDetail(intOrderID);

  blnIsDirty = true;  // set "dirty" flag

  // enable "Save Changes" button
  document.all('btnSaveChanges').disabled = false;
}

//----------------------------------------------------

function formatDecimal(strValue) {
  // format a value to two decimal places for display
  if (strValue.indexOf('.') < 0) strValue += '.';
  strValue += '00';
  return strValue.substring(0, strValue.indexOf('.') + 3);
}

//-->
</script>

<!------------------ HTML page content --------------------->

</head>

<body link="#0000ff" alink="#0000ff" vlink="#0000ff" onload="openWebService()" onunload="checkIfDirty()">

<!-- attach the Web Service behavior to an element in the page to get it loaded -->
<!-- this also defines the ID used to refer to it in the script section of page -->
<div class="heading" style="behavior:url(../../global/webservice.htc)" id="htcWService">
  Edit Customer Orders
</div>

<div align="right" class="cite">
[<a href="../../global/viewsource.aspx?compsrc=order-data.asmx">view page source</a>]<br />
[<a href="javascript:viewDiffgram('10')">view updated diffgram v1.0</a>]<br />
[<a href="javascript:viewDiffgram('11')">view updated diffgram v1.1</a>]
</div><hr />

<table border="0" cellpadding="20"><tr><td valign="top" bgcolor="#fffacd">

  <!-- label to display customer ID -->
  <span id="lblStatus">Loading data, please wait...</span><p />

  <div id="divOrderList"></div><p />

  <!-- label to display interactive messages -->
  <span id="lblMessage"></span>

  <div id="divSaveChanges" align="center" style="padding=10">
    <input type="button" id="btnSaveChanges" disabled="true" value="Save Changes" onclick="sendToServer()" />
  </div>
  <span>
     <b>IMPORTANT</b>: After you add or edit<br />
     orders for this customer you must<br />
     save the changes to the server in<br />
     order to update the original data.
  </span>

</td><td valign="top" cellpadding="0">

  <span id="lblUpdateStatus"></span>

  <!-- controls to display order details -->
  <table id="tblOrderDetail" border="0" style="display:none">
  <tr><td colspan="4"><span id="lblOrderID"></span></td></tr>
  <tr>
    <td align="right" nowrap="nowrap"><u>N</u>ame:</td><td align="left" nowrap="nowrap"><input type="text" id="txtShipName" size="40" accesskey="N" tabindex="10" /> &nbsp;</td>
    <td align="right" nowrap="nowrap"><u>R</u>equired:</td><td align="left" nowrap="nowrap"><input type="text" id="txtRequiredDate" size="12" accesskey="R" tabindex="15" /></td>
  </tr>
  <tr>
    <td align="right" nowrap="nowrap"><u>A</u>ddress:</td><td align="left" nowrap="nowrap"><input type="text" id="txtShipAddress" size="40" accesskey="A" tabindex="11" /> &nbsp;</td>
    <td align="right" nowrap="nowrap"><u>S</u>hipped:</td><td align="left" nowrap="nowrap"><input type="text" id="txtShippedDate" size="12" accesskey="S" tabindex="16" /></td>
  </tr>
  <tr>
    <td align="right" nowrap="nowrap"><u>C</u>ity:</td><td align="left" nowrap="nowrap"><input type="text" id="txtShipCity" size="15" accesskey="C" tabindex="12" /> &nbsp;
    Co<u>d</u>e: <input type="text" id="txtShipPostCode" size="10" accesskey="D" tabindex="13" /> &nbsp;</td>
    <td align="right" nowrap="nowrap"><u>V</u>ia:</td><td align="left" nowrap="nowrap">
      <select size="1" id="selShipName" accesskey="V" tabindex="17"><option value="0">Select...</option></select>
    </td>
  </tr>
  <tr>
    <td align="right" nowrap="nowrap">C<u>o</u>untry:</td><td align="left" nowrap="nowrap"><input type="text" id="txtShipCountry" size="20" accesskey="O" tabindex="14" /></td>
    <td align="right" nowrap="nowrap"><u>F</u>reight:</td><td align="left" nowrap="nowrap">$<input type="text" id="txtFreight" size="6" accesskey="F" tabindex="18" /></td>
  </tr>
  <tr><td colspan="4" align="right">
    <input type="button" id="btnUpdateOrder" value="Update" tabindex="19" onclick="updateOrder()" />
    <input type="button" id="btnDeleteOrder" value="Delete" tabindex="20" onclick="deleteOrder()" />
  </td></tr>
  </table><p />
  <div id="divOrderLines" tabindex="22" style="display:none"></div>
  <div align="right" id="lblOrderTotal"></div><p />
  <div id="divAddLine" style="padding:10;background-color:#fff0f5;display:none">
    Add another <u>P</u>roduct to this Order:
    <select size="1" id="selProducts" accesskey="P" tabindex="25" onchange="selectProduct(this)" />
      <option value="-1">Select product...</option>
    </select>
    <input type="button" id="btnAddLine" value="Add" tabindex="25" disabled="true" onclick="addOrderLine()" />
  </div>

</td></tr></table>

<!-- form to submit updated DiffGram to server -->
<form id="frmPostXml" action="view-diffgram.aspx" method="post">
  <input type="hidden" id="hidPostXML" name="hidPostXML" />
</form>

<!-- #include file="../../global/foot.inc" -->

</body>
</html>
