<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:bk="http://tempuri.org/XMLSchema.xsd">
  <xsl:template match="bk:Author">
	<div>
	Author is <i><xsl:value-of select="."/></i>
	</div>
  </xsl:template>
  <xsl:template match="bk:Book">
    <html>
      <head>
        <title>example</title>
      </head>
      <body>
        <xsl:value-of select='translate("---------------Books----------","bok","ook")' />
        <br/>
        <xsl:value-of select="concat('AWRD WINNING','BOOK DETAILS')"/>
        <xsl:apply-templates select="bk:Author" />
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
