<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html"/>
<xsl:template match="/">
	<html>
		<body>
			<h3>Numeric Function</h3>
			<ul>
				<li>
					<b>number('1548')</b>
						= <xsl:value-of select="number('1548')"/>
				</li>
				<li>
					<b>number('-1548')</b>
						= <xsl:value-of select="number('-1548')"/>
				</li>
				<li>
					<b>number('text')</b>
						= <xsl:value-of select="number('text')"/>
				</li>
				<li>
					<b>number('226.38' div '1')</b>
					= <xsl:value-of select="number('226.38' div '1')"/>
				</li>
			</ul>
			<ul>
				<li>
					<b>ceiling(2.5)</b>
						= <xsl:value-of select="ceiling(2.5)" />
				</li>
				<li>
					<b>ceiling(-2.3)</b>
						= <xsl:value-of select="ceiling(-2.3)" />
				</li>
				<li>
					<b>ceiling(4)</b>
						= <xsl:value-of select="ceiling(4)" />
				</li>
			</ul>
			<ul>
				<li>
					<b>floor(2.5)</b>
						= <xsl:value-of select="floor(2.5)"/>
				</li>
				<li>
					<b>floor(-2.3)</b>
						= <xsl:value-of select="floor(-2.3)"/>
				</li>
				<li>
					<b>floor(4)</b>
						= <xsl:value-of select="floor(4)"/>
				</li>
			</ul>
			<ul>
				<li>
					<b>round(3.6)</b>
						= <xsl:value-of select="round(3.6)"/>
				</li>
				<li>
					<b>round(3.4)</b>
						= <xsl:value-of select="round(3.4)"/>
				</li>
				<li>
					<b>round(-0.6)</b>
						= <xsl:value-of select="round(-0.6)"/>
				</li>
				<li>
					<b>round(-2.5)</b>
						= <xsl:value-of select="round(-2.5)"/>
				</li>
			</ul>
		</body>
	</html>
</xsl:template>
</xsl:stylesheet>
