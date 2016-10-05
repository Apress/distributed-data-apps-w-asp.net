<%@Control Language="VB" %>

<script language="VB" runat="server">

Function ClientType() As Integer
  'return an integer indicating the type of device
  ' 0 = Not Supported by Application
  ' 1 = HTML 3.2. client
  ' 2 = Internet Explorer 4
  ' 3 = Internet Explorer 5 or above
  ' 4 = Small Screen HTML ( < 50 chars per line or < 400px wide)
  ' 5 = WML Supporting Device (i.e. cellphone)
  ' 9 = Error While Detecting Type

  'create integer variable to hold client type
  Dim intType As Integer

  Try
    'get reference to Browser Capabilities
    Dim objBCaps As System.Web.Mobile.MobileCapabilities = Request.Browser

    'check the preferred rendering type of the device
    Dim strRenderType As String = objBCaps.PreferredRenderingType.ToLower()

    If strRenderType.IndexOf("wml") <> -1 Then

      intType = 5     'type is WML device

    ElseIf strRenderType.IndexOf("html") <> -1 Then

      intType = 1     'assume it's an HTML 3.2 device

      'next check the screen size
      If objBCaps.ScreenPixelsWidth < 400 _
      Or objBCaps.ScreenCharactersWidth < 50 Then

        intType = 4     'it's a small screen HTML device

      Else

        'assume it's a normal browser - check if its IE
        If objBCaps.Browser = "IE" Then

            'check the version number
            If objBCaps.MajorVersion >= 5 Then
              intType = 3    'IE 5.x or above
            ElseIf objBCaps.MajorVersion = 4 Then
              intType = 2    'IE 4.x
            End If

        End If

      End If

    Else   'not WML or HTML

      intType = 0    'not recognized or supported

    End If

  Catch objErr As Exception

    intType = 9    'error during detection

  End Try

  Return intType

End Function

</script>
