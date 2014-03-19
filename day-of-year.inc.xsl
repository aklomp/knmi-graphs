<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="day-of-year">
		<xsl:param name="year"/>
		<xsl:param name="month"/>
		<xsl:param name="day"/>

		<xsl:variable name="feb">
			<xsl:choose>
				<xsl:when test="$year mod 4 = 0">
					<xsl:value-of select="29"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="28"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$month = 01"><xsl:value-of select="$day - 1"/></xsl:when>
			<xsl:when test="$month = 02"><xsl:value-of select="31 + $day - 1"/></xsl:when>
			<xsl:when test="$month = 03"><xsl:value-of select="31 + $feb + $day - 1"/></xsl:when>
			<xsl:when test="$month = 04"><xsl:value-of select="31 + $feb + 31 + $day - 1"/></xsl:when>
			<xsl:when test="$month = 05"><xsl:value-of select="31 + $feb + 31 + 30 + $day - 1"/></xsl:when>
			<xsl:when test="$month = 06"><xsl:value-of select="31 + $feb + 31 + 30 + 31 + $day - 1"/></xsl:when>
			<xsl:when test="$month = 07"><xsl:value-of select="31 + $feb + 31 + 30 + 31 + 30 + $day - 1"/></xsl:when>
			<xsl:when test="$month = 08"><xsl:value-of select="31 + $feb + 31 + 30 + 31 + 30 + 31 + $day - 1"/></xsl:when>
			<xsl:when test="$month = 09"><xsl:value-of select="31 + $feb + 31 + 30 + 31 + 30 + 31 + 31 + $day - 1"/></xsl:when>
			<xsl:when test="$month = 10"><xsl:value-of select="31 + $feb + 31 + 30 + 31 + 30 + 31 + 31 + 30 + $day - 1"/></xsl:when>
			<xsl:when test="$month = 11"><xsl:value-of select="31 + $feb + 31 + 30 + 31 + 30 + 31 + 31 + 30 + 31 + $day - 1"/></xsl:when>
			<xsl:when test="$month = 12"><xsl:value-of select="31 + $feb + 31 + 30 + 31 + 30 + 31 + 31 + 30 + 31 + 30 + $day - 1"/></xsl:when>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>
