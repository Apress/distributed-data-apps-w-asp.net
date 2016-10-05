using System;
using System.Runtime.Remoting;
using Wrox4923.Remoting.Log;
using System.Data;

namespace Wrox4923.Remoting
{
    public class logClient
	{
        public static void Main() 
		{
			Logger httpLogger;
			Logger tcpLogger;
			
			httpLogger = (Logger)Activator.GetObject(typeof(Logger),
            					"http://localhost:8000/Log");
            tcpLogger = (Logger)Activator.GetObject(typeof(Logger),
            					"tcp://localhost:8001/Log");
            					

            httpLogger.Log("HTTP Client Request");
            tcpLogger.Log("TCP Client Request");
     	}
    }
}