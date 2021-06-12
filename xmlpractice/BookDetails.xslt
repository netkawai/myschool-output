<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:bk="http://tempuri.org/XMLSchema.xsd">
  <xsl:template match="bk:Publish">
      <div>
         <strong><xsl:value-of select="."/></strong>
      </div>
  </xsl:template>
  <xsl:template match='bk:Book'>
      <div>
      <xsl:value-of select="."/>
      <xsl:if test="contains(bk:Title, 'XML')">
        <b>
          <xsl:value-of select="bk:Title"/>
        </b>
        by
          <i><xsl:value-of select='bk:Author'/></i>
        costs
          <xsl:value-of select="bk:Price"/>
        .(<xsl:apply-templates select="bk:Publish"/>)
      
      </xsl:if>
      </div>
  </xsl:template>
  <xsl:template match="bk:Catalog">
    <html>
      <head>
        <title>example</title>
      </head>
      <body>
        <xsl:value-of select='translate("---------------Books----------","bok","ook")' />
        <br/>
        <xsl:value-of select="concat('AWRD WINNING','BOOK DETAILS')"/>
        <xsl:apply-templates select="bk:Book" />
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
