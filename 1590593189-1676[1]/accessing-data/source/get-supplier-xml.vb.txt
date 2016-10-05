Option Explicit On

Imports System
Imports System.Xml
Imports System.Xml.XPath
Imports System.Xml.Schema
Imports System.Collections
Imports System.Data

'the namespace for the component
Namespace SupplierListXml

  'the main class definition
  Public Class SupplierList

    'private internal variables
    Private m_XmlFilePath As String  'path and name of XML file
    Private m_SchemaPath As String  'path and name of Schema file
    Private m_Validate As Boolean = False  'if validation to be performed

    'variable to hold instance of XmlTextReader object
    'allows it to be accessed by separate functions
    Private m_XTReader As XmlTextReader

    '----------------------------------------------------

    'constructor for component - requires the XML file
    'path and name to be provided as the first parameter
    'optional second parameter used to specify schema file
    Public Sub New(ByVal XmlFilePath As String, _
                   Optional ByVal SchemaPath As String = "")
      MyBase.New() 'call constructor for base class
      m_XmlFilePath = XmlFilePath
      m_SchemaPath = SchemaPath
      If m_SchemaPath.Length > 0 Then m_Validate = True
    End Sub

    '------------------------------------------------------

    'function to return an XmlTextReader object for the
    'XML document stored as a disk file - ignores any schema
    Public Function GetSuppliersXmlTextReader() As XmlTextReader

      Try

        'create new XmlTextReader object and load XML document
        Return New XmlTextReader(m_XmlFilePath)

      Catch objErr As Exception

        Throw objErr    'throw exception to calling routine

      End Try

    End Function

    '------------------------------------------------------

    'function to return an XmlValidatingReader object for the
    'XML document stored as a disk file
    Public Function GetSuppliersValidatingReader() As XmlValidatingReader

      If m_Validate = True Then  'schema must be specified

        Try

          'get instance of validator from separate function
          Dim objValidator As XmlValidatingReader = GetValidatingReader()

          'add the event handler for any validation errors found
          AddHandler objValidator.ValidationEventHandler, AddressOf ValidationError

          Return objValidator   'return it to the calling routine

        Catch objErr As Exception

          Throw objErr    'throw exception to calling routine

        End Try

      Else   'no schema provided

        'create a new Exception and fill in details
        Dim objSchemaErr As New Exception("You must provide a Schema when using the GetSuppliersValidatingReader method")
        objSchemaErr.Source = "SupplierListXml"

        Throw objSchemaErr  'throw exception to calling routine

      End If

    End Function

    '------------------------------------------------------

    'function to return a String that results from validating
    'the XML document stored as a disk file
    Public Function GetSuppliersXmlString() As String

      Try

        'use function in this class to get an XmlValidatingReader
        Dim objValidator As XmlValidatingReader = GetSuppliersValidatingReader()

        'create a new XmlDocument to hold the XML as it is validated
        Dim objXmlDoc As New XmlDocument()
        objXmlDoc.Load(objValidator)

        'return the complete XML content of the document
        Return objXmlDoc.OuterXml

      Catch objErr As Exception

        Throw objErr    'throw exception to calling routine

      Finally

        m_XTReader.Close()   'close the XmlTextReader

      End Try

    End Function

    '------------------------------------------------------

    'function to return an XmlDocument object containing the
    'XML stored as a disk file, optionally validated against
    'the specified schema
    Public Function GetSuppliersXmlDocument() As XmlDocument

      'create a new XmlDocument object
      Dim objXmlDoc As New XmlDocument()

      If m_Validate = True Then  'validate against schema

        Try

          'use function in this class to get an XmlValidatingReader
          Dim objValidator As XmlValidatingReader = GetSuppliersValidatingReader()

          'load the XML and validate as it's being loaded
          objXmlDoc.Load(objValidator)

        Catch objErr As Exception

          Throw objErr    'throw exception to calling routine

        Finally

          m_XTReader.Close()   'close the XmlTextReader

        End Try

      Else  'validation not required

        Try

          'load the XML from disk without validation
          objXmlDoc.Load(m_XmlFilePath)

        Catch objErr As Exception

          Throw objErr    'throw exception to calling routine

        End Try

      End If

      'return the XmlDocument object
      Return objXmlDoc

    End Function

    '------------------------------------------------------

    'function to return an XPathDocument object from the XML
    'document stored as a disk file
    Public Function GetSuppliersXPathDocument() As XPathDocument

      'declare a variable to hold an XPathDocument object
      Dim objXPathDoc As XPathDocument

      If m_Validate = True Then  'validate against schema

        Try

          'use function in this class to get an XmlValidatingReader
          Dim objValidator As XmlValidatingReader = GetSuppliersValidatingReader()

          'load the XML and validate as it's being loaded
          objXPathDoc = New XPathDocument(objValidator)

        Catch objErr As Exception

          Throw objErr    'throw exception to calling routine

        Finally

          m_XTReader.Close()   'close the XmlTextReader

        End Try

      Else  'validation not required

        Try

          'load the XML from disk without validation
          objXPathDoc = New XPathDocument(m_XmlFilePath)

        Catch objErr As Exception

          Throw objErr    'throw exception to calling routine

        End Try

      End If

      Return objXPathDoc   'return it to the calling routine

    End Function

    '------------------------------------------------------

    'function to return an Array object from the XML
    'document stored as a disk file
    Public Function GetSuppliersArray() As Array

      'use function in this class to get an XPathDocument
      Dim objXPathDoc As XPathDocument = GetSuppliersXPathDocument()

      'create a new XPathNavigator object using the XPathDocument object
      Dim objXPNav As XPathNavigator = objXPathDoc.CreateNavigator()

      'declare variables to hold two XPathNodeIterator objects
      Dim objXPRowIter, objXPColIter As XPathNodeIterator

      'move to document element
      objXPNav.MoveToFirstChild()

      'select all the child nodes of the document node into an
      'XPathNodeIterator object using an XPath expression
      objXPRowIter = objXPNav.Select("child::*")

      'get number of "rows" (child elements)
      Dim intLastRowIndex As Integer = objXPRowIter.Count - 1

      'move to first child of first "row" element
      objXPNav.MoveToFirstChild()

      'select all the child nodes of this node into another
      'XPathNodeIterator object using an XPath expression
      objXPColIter = objXPNav.Select("child::*")

      'get number of "columns" (one per child element)
      Dim intLastColIndex As Integer = objXPColIter.Count - 1

      'can now create an Array of the appropriate size
      Dim arrResult(intLastColIndex, intLastRowIndex) As String
      Dim intLoop As Integer   'to hold index into array

      'iterate through the "rows"
      While objXPRowIter.MoveNext

        'create an XPathNavigator for this "row" element
        objXPNav = objXPRowIter.Current

        'get an XPathNodeIterator containing the child nodes
        objXPColIter = objXPNav.Select("child::*")

        'iterate through these child nodes adding values to array
        For intLoop = 0 To intLastColIndex
          objXPColIter.MoveNext()
          arrResult(intLoop, objXPRowIter.CurrentPosition - 1) = objXPColIter.Current.Value
        Next
      End While

      Return arrResult    'and return the array to the calling routine

    End Function

    '------------------------------------------------------

    'function to return a ArrayList object from the XML document
    'stored as a disk file, containing all the values from the
    'elements with the name specified in the single parameter
    Public Function GetSuppliersArrayList(ByVal strElementName As String) As ArrayList

      'use function in this class to get an XPathDocument
      Dim objXPathDoc As XPathDocument = GetSuppliersXPathDocument()

      'create a new XPathNavigator object using the XPathDocument object
      Dim objXPNav As XPathNavigator = objXPathDoc.CreateNavigator()

      'declare variables to hold an XPathNodeIterator object
      Dim objXPIter As XPathNodeIterator

      'move to document element
      objXPNav.MoveToFirstChild()

      'select the required descendant nodes of document node into
      'an XPathNodeIterator object using an XPath expression
      objXPIter = objXPNav.Select("descendant::" & strElementName)

      'create an ArrayList to hold the results
      Dim arrResult As New ArrayList()

      'iterate through the element nodes in the XPathNodeIterator
      'collection adding their values to the ArrayList
      While objXPIter.MoveNext()
        arrResult.Add(objXPIter.Current.Value)
      End While

      Return arrResult   'and return it to the calling routine

    End Function

    '------------------------------------------------------

    'function to return a DataSet object from the XML
    'document stored as a disk file
    Public Function GetSuppliersDataSet() As DataSet

      'to access DataSet property of XmlDataDocuemnt a valid
      'schema must be loaded into the DataSet first
      If m_Validate = True Then

        Try

          'get instance of validator from separate function
          Dim objValidator As XmlValidatingReader = GetValidatingReader()

          'add the event handler for any validation errors found
          AddHandler objValidator.ValidationEventHandler, AddressOf ValidationError

          'create a new XmlDataDocument object
          Dim objDataDoc As New XmlDataDocument()

          'load the schema into the DataSet exposed by the XmlDataDocument object
          objDataDoc.DataSet.ReadXmlSchema(m_SchemaPath)

          'load document using Schema
          objDataDoc.Load(objValidator)

          'return the DataSet to the calling routine
          Return objDataDoc.DataSet

        Catch objErr As Exception

          Throw objErr    'throw exception to calling routine

        Finally

          m_XTReader.Close()   'close the XmlTextReader

        End Try

      Else   'no Schema provided

        'create a new Exception and fill in details
        Dim objSchemaErr As New Exception("You must provide a Schema when using the GetSuppliersDataSet method")
        objSchemaErr.Source = "SupplierListXml"

        Throw objSchemaErr  'throw exception to calling routine

      End If

    End Function

    '------------------------------------------------------

    'event handler called when a validation error is found
    Private Sub ValidationError(ByVal objSender As Object, ByVal objArgs As ValidationEventArgs)

      'create a new Exception and fill in details
      Dim objValidErr As New Exception("Validation error: " & objArgs.Message)
      objValidErr.Source = "SupplierListXml"

      Throw objValidErr  'throw exception to calling routine

    End Sub

    '------------------------------------------------------

    'returns an XmlValidatingReader with the specified Schema attached
    Private Function GetValidatingReader() As XmlValidatingReader

      'create new XmlTextReader object and load XML document
      m_XTReader = New XmlTextReader(m_XmlFilePath)

      'create an XMLValidatingReader for this XmlTextReader
      Dim objValidator As New XmlValidatingReader(m_XTReader)

      'set the validation type to "Auto"
      objValidator.ValidationType = ValidationType.Auto

      'create a new XmlSchemaCollection
      Dim objSchemaCol As New XmlSchemaCollection()

      'add our schema to it
      objSchemaCol.Add("", m_SchemaPath)

      'assign the schema collection to the XmlValidatingReader
      objValidator.Schemas.Add(objSchemaCol)

      Return objValidator  'return to calling routine

    End Function

    '------------------------------------------------------


  End Class



End Namespace
