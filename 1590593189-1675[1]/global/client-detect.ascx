<%@Control Language="C#" %>

<script language="C#" runat="server">

public int ClientType() {
  // return an integer indicating the type of device
  //  0 = Not Supported by Application
  //  1 = HTML 3.2. client
  //  2 = Internet Explorer 4
  //  3 = Internet Explorer 5 or above
  //  4 = Small Screen HTML ( < 50 chars per line or < 400px wide)
  //  5 = WML Supporting Device (i.e. cellphone)
  //  9 = Error While Detecting Type

  // create integer variable to hold client type
  int intType;

  try {
    // get reference to Browser Capabilities
    System.Web.Mobile.MobileCapabilities objBCaps
      = (System.Web.Mobile.MobileCapabilities) Request.Browser;

    // check the preferred rendering type of the device
    String strRenderType = objBCaps.PreferredRenderingType.ToLower();

    if (strRenderType.IndexOf("wml") != -1)
      intType = 5;     // type is WML device
    else if (strRenderType.IndexOf("html") != -1) {
      intType = 1;     // assume it's an HTML 3.2 device

      // next check the screen size
      if (objBCaps.ScreenPixelsWidth < 400 || objBCaps.ScreenCharactersWidth < 50)
        intType = 4;     // it's a small screen HTML device
      else {
        // assume it's a normal browser - check if its IE
        if (objBCaps.Browser == "IE") {
          // check the version number
          if (objBCaps.MajorVersion >= 5)
            intType = 3;    // IE 5.x or above
          else if (objBCaps.MajorVersion == 4)
            intType = 2;    // IE 4.x
        }
      }
    }
    else  // not WML or HTML
      intType = 0;    // not recognized or supported

  }
  catch(Exception objErr) {
    intType = 9;    // error during detection
  }
  return intType;
}
</script>
