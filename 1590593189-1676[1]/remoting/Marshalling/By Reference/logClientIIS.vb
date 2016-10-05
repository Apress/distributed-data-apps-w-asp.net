Imports System
Imports System.Runtime.Remoting
Imports Wrox4923.Remoting.Log
Imports System.Data
Imports System.Data.SqlClient

Namespace Wrox4923.Remoting

    Public Class logClientIIS

        Public Shared Sub Main() 
			
			RemotingConfiguration.Configure("logClientIIS.exe.config")            					

			Dim httpLogger As New Logger()

            httpLogger.Log("HTTP Client Request")
     	
     	End Sub
    
    End Class

End Namespace