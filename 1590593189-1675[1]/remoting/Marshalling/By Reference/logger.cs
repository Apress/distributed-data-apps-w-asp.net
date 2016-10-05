using System;
using System.Data;
using System.Data.SqlClient;

namespace Wrox4923.Remoting.Log
{
    public class Logger : MarshalByRefObject
    {
        public void Log(string Message) 
        {
            Console.WriteLine(Message);
		}
	}
}