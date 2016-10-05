using System;
using System.Runtime.Remoting;
using Wrox4923.Remoting.Log;
using System.Data;

namespace Wrox4923.Remoting
{
    public class logClientIIS
	{
        public static void Main() 
		{	
			RemotingConfiguration.Configure("logClientIIS.exe.config");          					

			Logger httpLogger = new Logger();

            httpLogger.Log("HTTP Client Request");
		}
	}
}