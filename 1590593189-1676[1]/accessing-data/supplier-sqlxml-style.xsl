<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:template match="/">
   <table cellspacing="0" rules="all" border="1" id="dgrSuppliers" style="border-collapse:collapse;">
   <tr style="background-color:Silver;"><td>SupplierName</td><td>SupplierAddress</td><td>SupplierContact</td></tr>
   <xsl:for-each select="//Suppliers">
     <tr>
     <td><xsl:apply-templates select="@SupplierName" /></td>
     <td><xsl:apply-templates select="@SupplierAddress" /></td>
     <td><xsl:apply-templates select="@SupplierContact" /></td>
     </tr>
   </xsl:for-each>
   </table>
</xsl:template>

<xsl:template match="*">
  <xsl:value-of select="." />
</xsl:template>

</xsl:stylesheet>
