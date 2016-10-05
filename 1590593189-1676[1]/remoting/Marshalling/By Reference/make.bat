set REFS=/r:System.Runtime.Remoting.dll /r:System.dll
vbc /nologo /debug+ /t:library %REFS% /r:System.Data.dll  Logger.vb
vbc /nologo /debug+ %REFS% /r:Logger.dll logServer.vb
vbc /nologo /debug+ %REFS% /r:Logger.dll /r:System.Data.dll logClient.vb
rem vbc /nologo /debug+ %REFS% /r:Logger.dll /r:System.Data.dll logClientIIS.vb
