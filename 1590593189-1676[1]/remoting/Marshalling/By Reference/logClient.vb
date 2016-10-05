Imports System
Imports System.Runtime.Remoting
Imports Wrox4923.Remoting.Log
Imports System.Data
Imports System.Data.SqlClient

Namespace Wrox4923.Remoting

    Public Class logClient

        Public Shared Sub Main() 

			Dim httpLogger As Logger
			Dim tcpLogger  As Logger
			
			httpLogger = CType(Activator.GetObject(GetType(Logger), _
            					"http://localhost:8000/Log"), Logger)
            tcpLogger = CType(Activator.GetObject(GetType(Logger), _
            					"tcp://localhost:8001/Log"), Logger)
            					

            httpLogger.Log("HTTP Client Request")
            tcpLogger.Log("TCP Client Request")
            
            'Dim rd As SqlDataReader = tcpLogger.ReadData("select * from authors")
            
            'While (rd.Read())
            '	tcpLogger.Log(rd(0).ToString())
            'End While
            
            'rd.Close()
     	
     	End Sub
    
    End Class

End Namespace