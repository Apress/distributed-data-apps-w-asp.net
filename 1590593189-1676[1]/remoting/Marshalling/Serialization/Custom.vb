Imports System
Imports System.IO
Imports System.Text.Encoding
Imports System.Runtime.Serialization
Imports System.Runtime.Serialization.Formatters.Soap

''Imports System.Runtime.Serialization.Formatters.Binary

Namespace Wrox4923

	' Test harness to (de)serialize a class
	Public Class Test

		Public Shared Sub Main()
	   
			' Creates a new Category object.
			Dim cat As New Category()

			cat.CategoryID = 1
			cat.CategoryName = "First"
			cat.Description = "The first category"
			cat.Picture = ReadPicture("pixels.bmp")

			Console.WriteLine("Before serialization the object contains: ")
			cat.Print()
			
			' Creates a file and serializes the object into it in binary format.
			Dim stream As Stream = File.Open("CategoryCustom.xml", FileMode.Create)
			Dim formatter As New SoapFormatter()

			''Dim formatter As New BinaryFormatter()

			formatter.Serialize(stream, cat)
			stream.Close()

			' Empties obj.
			cat = Nothing

			' Opens file "data.xml" and deserializes the object from it.
			stream = File.Open("CategoryCustom.xml", FileMode.Open)
			formatter = New SoapFormatter()

			''formatter = New BinaryFormatter()

			cat = CType(formatter.Deserialize(stream), Category)
			stream.Close()

			Console.WriteLine("")
			Console.WriteLine("After deserialization the object contains: ")
			cat.Print()

		End Sub
	   

		' read the picture into a byte array
		Public Shared Function ReadPicture(FileName As String) As Byte()
		
			Dim fs As FileStream = New FileStream(FileName, FileMode.Open, FileAccess.Read)
			Dim r As New BinaryReader(fs)
			Dim pic As Byte() = r.ReadBytes(fs.Length)
			r.Close()
			fs.Close()
			
			Return pic
			

		End Function
		
	End Class


	' ------------------------------------------------------------------------------
	' this is the serializable class
	' notice that the Picture property is not serialized
	
	<Serializable()> _
	Public Class Category
		Implements ISerializable

		' Private member variables
		Private _CategoryID As Integer
		Private _CategoryName As String
		Private _Description As String
		<NonSerialized()>Private _Picture As Byte()


		Public Sub New()
		End Sub
		
		' constructor for de-serialization
		Public Sub New(info As SerializationInfo, context As StreamingContext)
		
			Console.WriteLine("Constructed from object serialized at " & info.GetDateTime("SerializedAt"))
			_CategoryID = info.GetInt32("CategoryID")
			_CategoryName = info.GetString("CategoryName")
			_Description = info.GetString("Description")
			
		End Sub
		
		' serialization
		Overridable Overloads Sub GetObjectData(info As SerializationInfo, context As StreamingContext) _
			Implements ISerializable.GetObjectData

			info.AddValue("SerializedAt", DateTime.Now)
			info.AddValue("CategoryID", _CategoryID)
			info.AddValue("CategoryName", _CategoryName)
			info.AddValue("Description", _Description)
			
		End Sub
		
		
		' public properties
		Public Property CategoryID As Integer
			Get
				Return _CategoryID
			End get
			Set
				_CategoryID = Value
			End Set
		End Property

		Public Property CategoryName As String
			Get
				Return _CategoryName
			End get
			Set
				_CategoryName = Value
			End Set
		End Property

		Public Property Description As String
			Get
				Return _Description
			End get
			Set
				_Description = Value
			End Set
		End Property

		Public Property Picture As Byte()
			Get
				Return _Picture
			End get
			Set
				_Picture= Value
			End Set
		End Property

		Public Sub Print()
		
			Console.WriteLine("CategoryID   = " & _CategoryID.ToString())
			Console.WriteLine("CategoryName = " & _CategoryName)
			Console.WriteLine("Description  = " & _Description)
			If _Picture Is Nothing Then
				Console.WriteLine("Picture      = <not set>")
			Else
				Console.WriteLine("Picture      = " & ASCII.GetString(_Picture))
			End If
			
		End Sub
		
	End Class

End Namespace