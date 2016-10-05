using System;
using System.IO;
using System.Text;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Formatters.Soap;


namespace Wrox4923
{
	// Test harness to (de)serialize a class
	public class Test
	{
		public static void Main()
	   	{
			// Creates a new Category object.
			Category cat = new Category();

			cat.CategoryID = 1;
			cat.CategoryName = "First";
			cat.Description = "The first category";
			cat.Picture = ReadPicture("pixels.bmp");

			Console.WriteLine("Before serialization the object contains: ");
			cat.Print();
			
			// Creates a file and serializes the object into it in binary format.
			Stream stream = File.Open("CategoryBasic.xml", FileMode.Create);
			SoapFormatter formatter = new SoapFormatter();

			//BinaryFormatter formatter = new BinaryFormatter();

			formatter.Serialize(stream, cat);
			stream.Close();

			// Empties obj.
			cat = null;

			// Opens file "CategoryBasic.xml" and deserializes the object from it.
			stream = File.Open("CategoryBasic.xml", FileMode.Open);
			formatter = new SoapFormatter();

			//formatter = New BinaryFormatter()

			cat = (Category)formatter.Deserialize(stream);
			stream.Close();

			Console.WriteLine("");
			Console.WriteLine("After deserialization the object contains: ");
			cat.Print();
		}
	   

		// read the picture into a byte array
		public static byte[] ReadPicture(string FileName)
		{
			FileStream fs = new FileStream(FileName, FileMode.Open, FileAccess.Read);
			BinaryReader r = new BinaryReader(fs);
			byte[] pic = r.ReadBytes((int)fs.Length);
			r.Close();
			fs.Close();
			
			return pic;
		}
	}


	// ------------------------------------------------------------------------------
	// this is the serializable class
	// notice that the Picture property is not serialized
	
	[Serializable()]
	public class Category
	{
		// Private member variables
		int _CategoryID;
		string _CategoryName;
		string _Description;
		[NonSerialized()]byte[] _Picture;

		public int CategoryID
		{
			get { return _CategoryID;}
			set {_CategoryID = value;}
		}

		public string Description
		{
			get { return _Description;}
			set {_Description = value;}
		}

		public string CategoryName
		{
			get { return _CategoryName;}
			set {_CategoryName = value;}
		}

		public byte[] Picture
		{
			get { return _Picture;}
			set {_Picture = value;}
		}


		public void Print()
		{
			Console.WriteLine("CategoryID   = " + _CategoryID.ToString());
			Console.WriteLine("CategoryName = " + _CategoryName);
			Console.WriteLine("Description  = " + _Description);
			if (_Picture == null)
				Console.WriteLine("Picture      = <not set>");
			else
				Console.WriteLine("Picture      = " + Encoding.ASCII.GetString(_Picture));
		}
	}
}