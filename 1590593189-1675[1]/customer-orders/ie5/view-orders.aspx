<%@Page Language="C#"%>

<html>
<head>

<title>View Customer Orders - Select Order</title>
<!-- #include file="../../global/style.inc" -->

<!-------------- Client-side Script Section ---------------->

<script language="JScript">
<!--

var objXMLData;  // to hold reference to XML parser
var strCustID;   // ID of the customer to view orders for

//----------------------------------------------------

function loadOrderList() {
// load a list of orders for this customer from server

  // get the customer ID from the query string
  strID = new String(window.location.search);

  strCustID = strID.substring(strID.indexOf('=') + 1, strID.length);

  if (strCustID == '') {

    // display error message
    document.all('lblStatus').innerHTML =
      '* ERROR: no Customer ID provided.<br />You must '
      + '<a href="default.aspx"><b>select a customer</b></a> first.';
  }

  else {

    // create URL and query string to load all orders for this customer
    var strURL = 'order-data.aspx?customerid=' + strCustID;

    // create a new parser object instance
    objXMLData = new ActiveXObject('MSXML2.FreeThreadedDOMDocument');

    // connect event with function to check when loading completes
    objXMLData.onreadystatechange = changeFunction;

    //set properties to validate while loading
    objXMLData.validateOnParse = true;
    objXMLData.async = true;

    // and load the document
    objXMLData.load(strURL);
  }
}

//----------------------------------------------------

function changeFunction() {
// check value of readyState property of XML parser
// value 4 indicates loading complete

  if (objXMLData.readyState == 4) {

    if (objXMLData.parseError.errorCode != 0) {

      // there was an error while loading
      // so display message
      document.all('lblStatus').innerHTML =
        '<b>* ERROR</b> - could not load order list.';

    }
    else {

      // replace "Loading" message with customer ID
      document.all('lblStatus').innerHTML =
        'Orders for customer ID <b>"' + strCustID + '"</b>';

      // display list of matching orders in left-hand table
      showOrderList('OrderID');
    }
  }
}

//----------------------------------------------------

function showOrderList(strSortOrder) {
// display the list of orders in the left-hand table

  // get result of transforming XML into a string for display
  var strResult = getStyledResult(false, '', strSortOrder);

  if (strResult.length > 0) {
    document.all('divOrderList').innerHTML = strResult;
    var msg = 'Click an <b>Order ID</b> in the grid above<br />'
            + 'to display details of that order. Click<br />'
            + 'a <b>column heading</b> to sort orders<br />'
            + 'by the values in that column ...<br />'
            + 'or <a href="default.aspx"><b>select a different customer</b></a>.'
  }
  else
    var msg = 'No orders found for this customer ...<br />'
            + '<a href="default.aspx"><b>Select a different customer</b></a>';
  document.all('lblMessage').innerHTML = msg;
}
//----------------------------------------------------

function showOrderDetail(strOrderID) {
// display the order details and right-hand table of order lines

  // get the details of the order to display above table
  // using DOM methods from the current XML parser object
  var strXPath = '//Orders[OrderID="' + strOrderID + '"]'
  var objOrderNode = objXMLData.selectSingleNode(strXPath);
  var strThisOrderID = objOrderNode.childNodes[0].text;
  var strThisCustName = objOrderNode.childNodes[2].text;
  var strThisAddress = objOrderNode.childNodes[3].text;
  var strThisOrdered = objOrderNode.childNodes[4].text;
  // if ShippedDate is null in database, node will not
  // appear in XML so check next node name
  if (objOrderNode.childNodes[5].nodeName == 'ShippedDate') {
    var strThisShipped = objOrderNode.childNodes[5].text;
    var strThisVia = objOrderNode.childNodes[6].text;
  }
  else {
    var strThisShipped = '';
    var strThisVia = objOrderNode.childNodes[5].text;
  }
  var strDetail = 'Order ID: <b>' + strThisOrderID + '</b>'
      + ' &nbsp; Customer Name: <b>' + strThisCustName +  '</b><br />'
      + 'Delivery Address: ' + strThisAddress + '<br />'
      + 'Ordered: ' + strThisOrdered.substring(0, 10) + ' &nbsp; ';
  if (strThisShipped == '')
    strDetail += 'Awaiting shipping'
  else
    strDetail += 'Shipped: ' + strThisShipped.substring(0, 10);
  strDetail += ' via ' + strThisVia;
  document.all('lblOrderDetail').innerHTML = strDetail;

  // get result of transforming XML into a string and display it
  var strResult = getStyledResult(true, strOrderID, '');
  document.all('divOrderLines').innerHTML = strResult;

  // get the order total by iterating the OrderLines nodes
  var objOrderLines = objOrderNode.selectNodes('OrderLines');
  var dblTotal = new Number(0);
  for (i = 0; i < objOrderLines.length; i++) {
    dblTotal += parseFloat(objOrderLines[i].childNodes[6].text);
  }

  // format it with two decimal places and display it
  var strTotal = dblTotal.toString();
  if (strTotal.indexOf('.') < 0) strTotal += '.';
  strTotal += '00';
  var msg = 'Total order value: <b>$'
    + strTotal.substring(0, strTotal.indexOf('.') + 3) + '</b>';
  document.all('lblOrderTotal').innerHTML = msg;
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
    + '    <td align="left" nowrap="nowrap">\n'
    + '      <a href="javascript:showOrderList(\'OrderDate\')"><b>Order Date</b></a>\n'
    + '    </td>\n'
    + '    <td align="left" nowrap="nowrap">\n'
    + '      <a href="javascript:showOrderList(\'ShippedDate\')"><b>Shipped</b></a>\n'
    + '    </td>\n'
    + '   </tr>\n'
    + '   <xsl:for-each select="//Orders">\n'
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
    + '  </table>\n'
    + ' </xsl:template>\n'
    + '</xsl:stylesheet>';
}
//----------------------------------------------------

function getOrderLinesStyleSheet(strOrderID) {
  // build a style sheet that transforms the XML document
  // to display a list of order lines given the OrderID

  // create the XPath required by the style sheet
  var strXPath = 'descendant::OrderLines[descendant::OrderID=$orderid]';

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
    + '   </tr>\n'
    + '   <xsl:for-each select="' + strXPath + '">\n'
    + '    <tr>\n'
    + '     <td align="center">\n'
    + '      <xsl:value-of select="Quantity" />\n'
    + '     </td>\n'
    + '     <td align="left">\n'
    + '      <xsl:value-of select="ProductName" />\n'
    + '     </td>\n'
    + '     <td align="left">\n'
    + '      <xsl:value-of select="QuantityPerUnit" />\n'
    + '     </td>\n'
    + '     <td align="right" nowrap="nowrap">\n'
    + '      $<xsl:value-of select="format-number(UnitPrice,\'#,##0.00\')" />\n'
    + '     </td>\n'
    + '     <td align="right" nowrap="nowrap">\n'
    + '      <xsl:value-of select="format-number(Discount,\'#0.00%\')"/> \n'
    + '     </td>\n'
    + '     <td align="right" nowrap="nowrap">\n'
    + '      $<xsl:value-of select="format-number(LineTotal,\'#,##0.00\')" />\n'
    + '     </td>\n'
    + '    </tr>\n'
    + '   </xsl:for-each>\n'
    + '  </table>\n'
    + ' </xsl:template>\n'
    + '</xsl:stylesheet>';
}

//-->
</script>

<!------------------ HTML page content --------------------->

</head>

<body link="#0000ff" alink="#0000ff" vlink="#0000ff" onload="loadOrderList()">

<div class="heading">View Customer Orders - Select Order</div>

<div align="right" class="cite">
[<a href="../../global/viewsource.aspx?compsrc=order-data.aspx">view page source</a>]
</div><hr />

<table border="0" cellpadding="20"><tr><td valign="top" bgcolor="#fffacd">

  <!-- label to display customer ID -->
  <span id="lblStatus">Loading order data, please wait...</span><p />

  <div id="divOrderList"></div><p />

  <!-- label to display interactive messages -->
  <span id="lblMessage"></span>

</td><td valign="top">

  <!-- controls to display order details -->
  <span id="lblOrderDetail">
    Select an order from the first column in the list shown on
    the left to display the order details.
  </span><p />
  <div id="divOrderLines"></div><p />
  <span id="lblOrderTotal"></span>

</td></tr></table>

<!-- #include file="../../global/foot.inc" -->

</body>
</html>
