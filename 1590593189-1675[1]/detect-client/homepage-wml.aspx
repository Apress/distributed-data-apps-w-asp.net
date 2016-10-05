<%@Page Inherits="System.Web.UI.MobileControls.MobilePage" Language="C#" %>
<%@Register TagPrefix="mobile" Namespace="System.Web.UI.MobileControls" Assembly="System.Web.Mobile"%>

<script language="C#" runat="server">
void Page_Load() {
  System.Web.Mobile.MobileCapabilities objMobCap;
  objMobCap = (System.Web.Mobile.MobileCapabilities) Request.Browser;
  lbl2.Text = "Make: " + objMobCap.MobileDeviceManufacturer;
  lbl3.Text = "Model: " + objMobCap.MobileDeviceModel;
  lbl4.Text = "MIME Type: " + objMobCap.PreferredRenderingMime;
  lbl5.Text = "Rendering Type: " + objMobCap.PreferredRenderingType;
  lbl6.Text = "Image MIME Type: " + objMobCap.PreferredImageMime;
  lbl7.Text = "Color Screen: " + objMobCap.IsColor;
  lbl8.Text = "Screen Height (chars): " + objMobCap.ScreenCharactersHeight;
  lbl9.Text = "Screen Width (chars): " + objMobCap.ScreenCharactersWidth;
  lbl10.Text = "Screen Height (pixels): " + objMobCap.ScreenPixelsHeight;
  lbl11.Text = "Screen Width (pixels): " + objMobCap.ScreenPixelsWidth;
  lbl12.Text = "Supports Bold Text: " + objMobCap.SupportsBold;
  lbl13.Text = "Supports Italic Text: " + objMobCap.SupportsItalic;
  lbl14.Text = "Input Type: " + objMobCap.InputType;
  lbl15.Text = "Has Back Button: " + objMobCap.HasBackButton;
  lbl16.Text = "Num Soft Keys: " + objMobCap.NumberOfSoftkeys;
  if ((String) Session["Supported"] == "yes")
    lbl17.Text = "ASP.NET Sessions: True";
  else
    lbl17.Text = "ASP.NET Sessions: False";
}
</script>

<mobile:Form runat="server">
  <mobile:Label id="lbl1" Font-Bold="True" runat="server" >
    Page for a WML client only
  </mobile:Label>
  <mobile:Label id="lbl2" runat="server" />
  <mobile:Label id="lbl3" runat="server" />
  <mobile:Label id="lbl4" runat="server" />
  <mobile:Label id="lbl5" runat="server" />
  <mobile:Label id="lbl6" runat="server" />
  <mobile:Label id="lbl7" runat="server" />
  <mobile:Label id="lbl8" runat="server" />
  <mobile:Label id="lbl9" runat="server" />
  <mobile:Label id="lbl10" runat="server" />
  <mobile:Label id="lbl11" runat="server" />
  <mobile:Label id="lbl12" runat="server" />
  <mobile:Label id="lbl13" runat="server" />
  <mobile:Label id="lbl14" runat="server" />
  <mobile:Label id="lbl15" runat="server" />
  <mobile:Label id="lbl16" runat="server" />
  <mobile:Label id="lbl17" runat="server" />
</mobile:Form>
