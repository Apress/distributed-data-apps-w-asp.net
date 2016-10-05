Imports System
Imports System.Data
Imports System.Data.SqlClient

Namespace Wrox4923.Remoting.Log

    Public Class Logger
    	Inherits MarshalByRefObject

        Public Sub Log(Message As String) 
        
            Console.WriteLine(Message)
        
        End Sub
        
        
        Public Function ReadData(SqlString As String) As SqlDataReader

        	Console.WriteLine("Read Start")
            
            Dim conn As New SqlConnection("Server=OWL; Database=pubs; UID=sa; PWD=elbereth")
            Dim cmd As New SqlCommand(SqlString, conn)
            conn.Open()
            
        	Console.WriteLine("returning reader")
        	
            Return cmd.ExecuteReader()
        
        End Function
        
    End Class

End Namespace