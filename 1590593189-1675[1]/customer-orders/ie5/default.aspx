<%@Page Language="C#" %>

<html>
<head>

<title>View Customer Orders - Select Customer</title>
<!-- #include file="../../global/style.inc" -->

<!-------------- Client-side Script Section ---------------->

<script language="JScript">
<!--

var objXMLData;  // to hold reference to XML parser

//----------------------------------------------------

function setCheck(strName) {
//set radio buttons to correct option as text is typed
  document.forms(0).elements(strName).checked = true;
}

//----------------------------------------------------

function loadCustomerList() {
// load a complete list of customers from server

  // create URL and query string to load all customers
  var strURL = 'customer-data.aspx';

  // create a new parser object instance
  try {
    objXMLData = new ActiveXObject('MSXML2.FreeThreadedDOMDocument');
  }
  catch(e) {}

  // check that the parser object is actually available - if not
  // appropriate version of MSXML may not be installed on client
  // if not, display error message and exit
  if (objXMLData == null) {
    var strError = '* <b>ERROR: Incorrect XML parser version.</b><br />'
      + 'Sorry, you cannot use this version of the application.';
      document.all('lblStatus').innerHTML = strError;
    return;
  }

  // connect event with function to check when loading completes
  objXMLData.onreadystatechange = changeFunction;

  //set properties to validate while loading
  objXMLData.validateOnParse = true;
  objXMLData.async = true;

  // and load the document
  objXMLData.load(strURL);
}

//----------------------------------------------------

function changeFunction() {
// check value of readyState property of XML parser
// value 4 indicates loading complete

  if (objXMLData.readyState == 4) {

    if (objXMLData.parseError.errorCode != 0)

      // there was an error while loading
      // so display message
      document.all('lblStatus').innerHTML =
        '<b>* ERROR</b> - could not load customer list.';

    else {

      // clear "Loading" message
      document.all('lblStatus').innerHTML = '';

      // enable "Search" button
      document.all('btnSearch').disabled = false;

      // show Help details
      showHelp();
    }
  }
}

//----------------------------------------------------

function doSearch(strSortOrder) {
// display the list of matching customers in the page

  var strCustID = '';
  var strCustName = '';

  // get one or other value from text boxes depending on selection
  if (document.all('optByID').checked) {
    strCustID = document.all('txtCustID').value.toUpperCase();
    var msg = "Listing customers with an<br /><b>ID</b> that matches: '<b>"
        + strCustID + "</b>'";
  }
  else {
    strCustName = document.all('txtCustName').value;
    var msg = "Listing customers whose<br /><b>Name</b> contains: '<b>"
        + strCustName + "</b>'";
  }
  document.all('lblStatus').innerHTML = msg;

  // get the result of transforming the XML into a string for display
  // uses customer ID or name as a parameter to select matching nodes
  var strResult = getStyledResult(strCustID, strCustName, strSortOrder);
  if (strResult.length > 0) {
    document.all('divResult').innerHTML = strResult;
    msg = 'Click a <b>Customer Name</b> in the grid above to'
        + '<br /> list all of the orders for that customer ...'
        + '<p /> Click a <b>column heading</b> in the grid above to sort'
        + '<br /> the customers by the values in that column ...'
        + '<p /> Click an <b>Edit Orders</b> link in the grid above to edit'
        + '<br /> the orders for that customer ...';
  }
  else {
    msg = 'No matching customers found in database ...';
  }
  document.all('lblMessage').innerHTML = msg;
}

//----------------------------------------------------

function getStyledResult(strCustID, strCustName, strSortOrder) {
// returns the result of applying an XSLT transformation to the
// customer list as a string containing the HTML to display

  // create the XPath required by the style sheet
  if (strCustID.length > 0)
    var strXPath = 'descendant::Customers[starts-with(child::CustomerID, $custid)]'
  else
    var strXPath = 'descendant::Customers[contains(child::CompanyName, $custname)]';

  // specify the appropriate stylesheet
  var strStyle = '<?xml version="1.0" ?>\n'
    + '<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">\n'
    + ' <xsl:param name="custid" />\n'
    + ' <xsl:param name="custname" />\n'
    + ' <xsl:template match="/">\n'
    + '  <table id="tblCustomers" cellspacing="0" cellpadding="5"\n'
    + '         rules="cols" border="1" style="border-collapse:collapse;">\n'
    + '   <tr style="background-color:silver;">\n'
    + '    <td align="center">\n'
    + '      <a href="javascript:doSearch(\'CustomerID\')"><b>ID</b></a>\n'
    + '    </td>\n'
    + '    <td align="left">\n'
    + '      <a href="javascript:doSearch(\'CompanyName\')"><b>Customer Name</b></a>\n'
    + '    </td>\n'
    + '    <td align="left">\n'
    + '      <a href="javascript:doSearch(\'City\')"><b>City</b></a>\n'
    + '    </td>\n'
    + '    <td></td>\n'
    + '   </tr>\n'
    + '   <xsl:for-each select="' + strXPath + '">\n'
    + '    <xsl:sort select="' + strSortOrder + '" data-type="text" order="ascending" />\n'
    + '     <tr>\n'
    + '      <td align="center" style="background-color:#add8e6;">\n'
    + '       <xsl:value-of select="CustomerID" />\n'
    + '      </td>\n'
    + '      <td align="left">\n'
    + '       <a>\n'
    + '         <xsl:attribute name="href">\n'
    + '          view-orders.aspx?customerid=<xsl:value-of select="CustomerID" />\n'
    + '         </xsl:attribute>\n'
    + '         <xsl:value-of select="CompanyName" />\n'
    + '       </a>\n'
    + '      </td>\n'
    + '      <td align="left">\n'
    + '       <xsl:value-of select="City" />\n'
    + '      </td>\n'
    + '      <td align="left">\n'
    + '       <a>\n'
    + '         <xsl:attribute name="href">\n'
    + '          ../../update-orders/ie5/edit-orders.aspx?customerid=<xsl:value-of select="CustomerID" />\n'
    + '         </xsl:attribute>\n'
    + '         Edit Orders\n'
    + '       </a>\n'
    + '      </td>\n'
    + '     </tr>\n'
    + '   </xsl:for-each>\n'
    + '  </table>\n'
    + ' </xsl:template>\n'
    + '</xsl:stylesheet>';

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

  // set the parameter values
  objProc.addParameter('custid', strCustID);
  objProc.addParameter('custname', strCustName);

  // perform transformation and set value of string to return
  if (objProc.transform() == true)
    var strResult = objProc.output
  else
    var strResult = '';
  return strResult;
}

//----------------------------------------------------

// show help on using page in right-hand part of window
function showHelp() {
  strHelp = '<b>To list customer orders you can</b>:<p />'
    + '&nbsp; * Search for customers using their five-character <b>Customer ID</b>.<br />'
    + '&nbsp; &nbsp; &nbsp; - Enter all or part of a customer identifier in the top text box<br />'
    + '&nbsp; &nbsp; &nbsp; &nbsp; and click the <b>Search</b> button. You can enter a maximum of<br />'
    + '&nbsp; &nbsp; &nbsp; &nbsp; <b>five</b> characters, and the list will show all the customers<br />'
    + '&nbsp; &nbsp; &nbsp; &nbsp; whose ID starts with those characters.<p />'
    + '&nbsp; * Search for customers using their <b>Name</b>.<br />'
    + '&nbsp; &nbsp; &nbsp; - Enter all or part of a customer name in the lower text box<br />'
    + '&nbsp; &nbsp; &nbsp; &nbsp; and click the <b>Search</b> button. You can enter a maximum of<br />'
    + '&nbsp; &nbsp; &nbsp; &nbsp; <b>40</b> characters, and the list will show all the customers<br />'
    + '&nbsp; &nbsp; &nbsp; &nbsp; whose name contains that word or set of characters.<p />';
  document.all('lblMessage').innerHTML = strHelp;
}

//-->
</script>

<!------------------ HTML page content --------------------->

</head>
<body link="#0000ff" alink="#0000ff" vlink="#0000ff" onload="loadCustomerList()">

<div class="heading">View Customer Orders - Select Customer</div>

<div align="right" class="cite">
[<a href="../../global/viewsource.aspx?compsrc=customer-data.aspx">view page source</a>]
</div><hr />

<form action="">
<table border="0" cellpadding="20"><tr><td valign="top" bgcolor="#fffacd">

  <!-- controls for specifying the required customer ID or name -->
  <input type="radio" id="optByID" name="SearchBy" checked="checked" />
  Search by Customer <u>I</u>D:<br /> &nbsp; &nbsp;
  <input type="text" id="txtCustID" size="5" maxlength="5" accesskey="I"
         onkeypress="setCheck('optByID');" /><p /> &nbsp; or<p />
  <input type="radio" id="optByName" name="SearchBy" />
  Search by Customer <u>N</u>ame:<br /> &nbsp; &nbsp;
  <input type="text" id="txtCustName" size="20" maxlength="40"  accesskey="N"
         onkeypress="setCheck('optByName');" /><p />
  <button id="btnSearch" disabled="true" accesskey="S" onclick="doSearch('CustomerID')"><u>S</u>earch</button>
  &nbsp; &nbsp;
  <button id="btnHelp" accesskey="H" onclick="showHelp()"><u>H</u>elp</button><p />
  <span id="lblStatus">Loading customer list - please wait ...</span>

</td><td valign="top">

  <div id="divResult"></div><p />

  <!-- label to display interactive messages -->
  <div id="lblMessage"></div>

</td></tr></table>
</form>

<!-- #include file="../../global/foot.inc" -->

</body>
</html>
