<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
    <html>
    <body>
    <!--
        This is an XSLT template file. Fill in this area with the
        XSL elements which will transform your XML to XHTML.
    -->
    <h3>Node-set Function</h3>
    <table witdh="100%" border="1">
      <tr>
        <td width="25%">
          <b>namespace-uri()</b>
        </td>
        <td width="25%">
          <b>name()</b>
        </td>
        <td width="25%">
          <b>local-name</b>
        </td>
        <td width="25%">
          <b>text()</b>
        </td>
      </tr>
      <xsl:apply-templates />
    </table>
    </body>
    </html>
</xsl:template>
  <xsl:template match="*">
    <tr>
      <td>
        <xsl:value-of select="namespace-uri()"/>
      </td>
      <td>
        <xsl:value-of select="name()"/>
      </td>
      <td>
        <xsl:value-of select="local-name()"/>
      </td>
      <td>
        <xsl:value-of select="text()"/>
      </td>
    </tr>
    <xsl:apply-templates select="*"/>
  </xsl:template>
</xsl:stylesheet> 
