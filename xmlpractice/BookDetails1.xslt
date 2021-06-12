<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:bk="http://tempuri.org/XMLSchema.xsd">
  <xsl:template match='bk:Book'>
      <strong><xsl:value-of select='bk:Author'/></strong>
  </xsl:template>

  <xsl:template match='//bk:Author'>
      <i><xsl:value-of select='.'/></i>
  </xsl:template>
  <xsl:template match='bk:Book'>
      <div><xsl:value-of select="." />
      <xsl:if test="contains(bk:Title, 'Pattern')">
        <u>if Pattern is </u>
        <b>
          <xsl:value-of select="bk:Title"/>
        </b>
        by
          <xsl:apply-templates select="bk:Author"/>
        consts
        <xsl:value-of select="bk:Price"/>
        .
      </xsl:if>
      BookRecord:<xsl:value-of select="bk:Book"/></div>
  </xsl:template>
  <xsl:template match="/bk:Catalog">
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
