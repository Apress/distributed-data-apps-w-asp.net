using System;
using System.Runtime.Remoting;
using System.Runtime.Remoting.Channels;
using System.Runtime.Remoting.Channels.Http;
using System.Runtime.Remoting.Channels.Tcp;
using Wrox4923.Remoting.Log;

namespace Wrox4923.Remoting
{
    public class logServer
    {
        public static void Main() 
        {
            ChannelServices.RegisterChannel(new HttpChannel(8000));
            ChannelServices.RegisterChannel(new TcpChannel(8001));
            
            RemotingConfiguration.RegisterWellKnownServiceType(typeof(Logger),
            	"Log", WellKnownObjectMode.Singleton);

            Console.WriteLine("Log server listening...");
            Console.WriteLine("Press enter to stop the server...");
            Console.ReadLine();
		}
	}
}