using System;
using System.Collections;
using System.Data;
using System.Xml;
using System.Xml.XPath;
using System.Xml.Schema;

// the namespace for the component
namespace SupplierListXml
{

  // the main class definition
  public class SupplierList
  {

    // private internal variables
    private String m_XmlFilePath;   // path and name of XML file
    private String m_SchemaPath;    // path and name of Schema file
    private Boolean m_Validate;     // if ( validation to be performed

    // variable to hold instance of XmlTextReader object
    // allows it to be accessed by separate functions
    private XmlTextReader m_XTReader;

    // ----------------------------------------------------

    // constructor for component - requires the XML file
    // path and name to be provided the first parameter
    // optional second parameter used to specif (y schema file
    public SupplierList(String XmlFilePath, String SchemaPath)
    {
      m_XmlFilePath = XmlFilePath;
      m_SchemaPath = SchemaPath;
      if (m_SchemaPath.Length > 0) m_Validate = true;
    }
    // ------------------------------------------------------

    // method to return an XmlTextReader object for the
    // XML document stored a disk file - ignores any schema
    public XmlTextReader GetSuppliersXmlTextReader()
    {

      try
      {
        // create new XmlTextReader object and load XML document
        XmlTextReader objTReader = new XmlTextReader(m_XmlFilePath);
        return objTReader;
      }
      catch (Exception objErr)
      {
        throw (objErr);    // throw exception to calling routine
      }
    }
    // ------------------------------------------------------

    // method to return an XmlValidatingReader object for the
    // XML document stored a disk file
    public XmlValidatingReader GetSuppliersValidatingReader()
    {

      if (m_Validate == true)
      {   // schema must be specified
        try
        {

          // get instance of validator from separate method
          XmlValidatingReader objValidator = GetValidatingReader();

          // add the event handler for any validation errors found
          objValidator.ValidationEventHandler += new ValidationEventHandler(ValidationError);

          return objValidator;   // return it to the calling routine
        }
        catch (Exception objErr)
        {
          throw (objErr);    // throw exception to calling routine
        }
      }
      else
      {   // no schema provided

        // create a new Exception and fill in details
        Exception objSchemaErr = new Exception("You must provide a Schema when using the GetSuppliersValidatingReader method");
        objSchemaErr.Source = "SupplierListXml";

        throw (objSchemaErr);  // throw exception to calling routine
      }
    }
    // ------------------------------------------------------

    // method to return a String that results from validating
    // the XML document stored a disk file
    public String GetSuppliersXmlString()
    {

      try
      {

        // use method in this class to get an XmlValidatingReader
        XmlValidatingReader objValidator = GetSuppliersValidatingReader();

        // create a new XmlDocument to hold the XML it is validated
        XmlDocument objXmlDoc = new XmlDocument();
          objXmlDoc.Load(objValidator);

        // return the complete XML content of the document
        return objXmlDoc.OuterXml;
      }
      catch (Exception objErr)
      {

        throw (objErr);    // throw exception to calling routine
      }
      finally
      {
        m_XTReader.Close();   // close the XmlTextReader
      }
    }
    // ------------------------------------------------------

    // method to return an XmlDocument object containing the
    // XML stored a disk file, optionally validated against
    // the specif (ied schema
    public XmlDocument GetSuppliersXmlDocument()
    {

      // create a new XmlDocument object
      XmlDocument objXmlDoc = new XmlDocument();

      if (m_Validate == true)
      { // validate against schema

        try
        {

          // use method in this class to get an XmlValidatingReader
          XmlValidatingReader objValidator = GetSuppliersValidatingReader();

          // load the XML and validate it"s being loaded
          objXmlDoc.Load(objValidator);
        }
        catch (Exception objErr)
        {
          throw (objErr);    // throw exception to calling routine
        }
        finally
        {
          m_XTReader.Close();   // close the XmlTextReader
        }
      }
      else
      {// validation not required

        try
        {
          // load the XML from disk without validation
          objXmlDoc.Load(m_XmlFilePath);
        }
        catch (Exception objErr)
        {
          throw (objErr);    // throw exception to calling routine
        }
      }
      // return the XmlDocument object
      return objXmlDoc;
    }
    // ------------------------------------------------------

    // method to return an XPathDocument object from the XML
    // document stored a disk file
    public XPathDocument GetSuppliersXPathDocument()
    {

      // declare a variable to hold an XPathDocument object
      XPathDocument objXPathDoc = null;

      if (m_Validate == true)
      { // validate against schema

        try
        {
          // use method in this class to get an XmlValidatingReader
          XmlValidatingReader objValidator = GetSuppliersValidatingReader();

          // load the XML and validate it's being loaded
          objXPathDoc = new XPathDocument(objValidator);
        }
        catch (Exception objErr)
        {
          throw (objErr);    // throw exception to calling routine
        }
        finally
        {
          m_XTReader.Close();   // close the XmlTextReader
        }
      }
      else
      { // validation not required

        try
        {
          // load the XML from disk without validation
          objXPathDoc = new XPathDocument(m_XmlFilePath);
        }
        catch (Exception objErr)
        {
          throw (objErr);    // throw exception to calling routine
        }
      }
      return objXPathDoc;   // return it to the calling routine
    }
    // ------------------------------------------------------

    // method to return an Array object from the XML
    // document stored a disk file
    public String[,] GetSuppliersArray()
    {

      // use method in this class to get an XPathDocument
      XPathDocument objXPathDoc = GetSuppliersXPathDocument();

      // create a new XPathNavigator object using the XPathDocument object
      XPathNavigator objXPNav = objXPathDoc.CreateNavigator();

      // declare variables to hold two XPathNodeIterator objects
      XPathNodeIterator objXPRowIter, objXPColIter;

      // move to document element
      objXPNav.MoveToFirstChild();

      // select all the child nodes of the document node into an
      // XPathNodeIterator object using an XPath expression
      objXPRowIter = objXPNav.Select("child::*");

      // get number of "rows" (child elements)
      int intLastRowIndex = objXPRowIter.Count;

      // move to first child of first "row" element
      objXPNav.MoveToFirstChild();

      // select all the child nodes of this node into another
      // XPathNodeIterator object using an XPath expression
      objXPColIter = objXPNav.Select("child::*");

      // get number of "columns" (one per child element)
      int intLastColIndex = objXPColIter.Count;

      // can now create an Array of the appropriate size
      String[,] arrResult = new String[intLastColIndex, intLastRowIndex];
      int intLoop;   // to hold index into array

      // iterate through the "rows"
      while (objXPRowIter.MoveNext())
      {
        // create an XPathNavigator for this "row" element
        objXPNav = objXPRowIter.Current;

        // get an XPathNodeIterator containing the child nodes
        objXPColIter = objXPNav.Select("child::*");

        // iterate through these child nodes adding values to array
        for (intLoop = 0; intLoop < intLastColIndex; intLoop++)
        {
          objXPColIter.MoveNext();
          arrResult[intLoop, objXPRowIter.CurrentPosition - 1] = objXPColIter.Current.Value;
        }
      }
      return arrResult;    // and return the array to the calling routine
    }
    // ------------------------------------------------------

    // method to return a ArrayList object from the XML document
    // stored a disk file, containing all the values from the
    // elements with the name specif (ied in the single parameter
    public ArrayList GetSuppliersArrayList(String strElementName)
    {

      // use method in this class to get an XPathDocument
      XPathDocument objXPathDoc = GetSuppliersXPathDocument();

      // create a new XPathNavigator object using the XPathDocument object
      XPathNavigator objXPNav = objXPathDoc.CreateNavigator();

      // declare variables to hold an XPathNodeIterator object
      XPathNodeIterator objXPIter;

      // move to document element
      objXPNav.MoveToFirstChild();

      // select the required descendant nodes of document node into
      // an XPathNodeIterator object using an XPath expression
      objXPIter = objXPNav.Select("descendant::" + strElementName);

      // create an ArrayList to hold the results
      ArrayList arrResult = new ArrayList();

      // iterate through the element nodes in the XPathNodeIterator
      // collection adding their values to the ArrayList
      while (objXPIter.MoveNext())
        arrResult.Add(objXPIter.Current.Value);

      return arrResult;   // and return it to the calling routine
    }
    // ------------------------------------------------------

    // method to return a DataSet object from the XML
    // document stored a disk file
    public DataSet GetSuppliersDataSet()
    {

      // to access DataSet property of XmlDataDocuemnt a valid
      // schema must be loaded into the DataSet first
      if (m_Validate == true)
      {

        try
        {
          // get instance of validator from separate method
          XmlValidatingReader objValidator = GetValidatingReader();

          // add the event handler for any validation errors found
          objValidator.ValidationEventHandler += new ValidationEventHandler(ValidationError);

          // create a new XmlDataDocument object
          XmlDataDocument objDataDoc = new XmlDataDocument();

          // load the schema into the DataSet exposed by the XmlDataDocument object
          objDataDoc.DataSet.ReadXmlSchema(m_SchemaPath);

          // load document using Schema
          objDataDoc.Load(objValidator);

          // return the DataSet to the calling routine
          return objDataDoc.DataSet;
        }
        catch (Exception objErr)
        {
          throw (objErr);    // throw exception to calling routine
        }
        finally
        {
          m_XTReader.Close();   // close the XmlTextReader
        }
      }
      else
      { // no Schema provided

        // create a new Exception and fill in details
        Exception objSchemaErr = new Exception("You must provide a Schema when using the GetSuppliersDataSet method");
        objSchemaErr.Source = "SupplierListXml";

        throw (objSchemaErr);  // throw exception to calling routine
      }
    }
    // ------------------------------------------------------

    // event handler called when a validation error is found
    private void ValidationError(Object objSender, ValidationEventArgs objArgs)
    {

      // create a new Exception and fill in details
      Exception objValidErr = new Exception("Validation error: " + objArgs.Message);
      objValidErr.Source = "SupplierListXml";

      throw (objValidErr);  // throw exception to calling routine
    }
    // ------------------------------------------------------

    // returns an XmlValidatingReader with the specif (ied Schema attached
    private XmlValidatingReader GetValidatingReader()
    {
      // create new XmlTextReader object and load XML document
      m_XTReader = new XmlTextReader(m_XmlFilePath);

      // create an XMLValidatingReader for this XmlTextReader
      XmlValidatingReader objValidator = new XmlValidatingReader(m_XTReader);

      // set the validation type to "Auto"
      objValidator.ValidationType = ValidationType.Auto;

      // create a new XmlSchemaCollection
      XmlSchemaCollection objSchemaCol = new XmlSchemaCollection();

      // add our schema to it
      objSchemaCol.Add("", m_SchemaPath);

      // assign the schema collection to the XmlValidatingReader
      objValidator.Schemas.Add(objSchemaCol);

      return objValidator;  // return to calling routine

    }
    // ------------------------------------------------------
  }
}
