set REFS=/r:System.Runtime.Remoting.dll /r:System.dll
csc /nologo /debug+ /t:library %REFS% /r:System.Data.dll  Logger.cs
csc /nologo /debug+ %REFS% /r:Logger.dll logServer.cs
csc /nologo /debug+ %REFS% /r:Logger.dll /r:System.Data.dll logClient.cs
rem csc /nologo /debug+ %REFS% /r:Logger.dll /r:System.Data.dll logClientIIS.cs
