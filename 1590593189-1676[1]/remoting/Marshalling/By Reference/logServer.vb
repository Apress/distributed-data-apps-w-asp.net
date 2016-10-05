Imports System
Imports System.Runtime.Remoting
Imports System.Runtime.Remoting.Channels
Imports System.Runtime.Remoting.Channels.Http
Imports System.Runtime.Remoting.Channels.Tcp
Imports Wrox4923.Remoting.Log

Namespace Wrox4923.Remoting

    Public Class logServer
    
        Public Shared Sub Main() 
        
            ChannelServices.RegisterChannel(New HttpChannel(8000))
            ChannelServices.RegisterChannel(New TcpChannel(8001))
            
            RemotingConfiguration.RegisterWellKnownServiceType(GetType(Logger), _
            	"Log", WellKnownObjectMode.Singleton)

            Console.WriteLine("Log server listening...")
            Console.WriteLine("Press enter to stop the server...")
            Console.ReadLine()
        
        End Sub
    
    End Class

End Namespace