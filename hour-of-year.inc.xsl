<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:import href="day-of-year.inc.xsl"/>

	<xsl:template name="hour-of-year">
		<xsl:param name="year"/>
		<xsl:param name="month"/>
		<xsl:param name="day"/>
		<xsl:param name="hour"/>
		<xsl:variable name="dayx">
			<xsl:call-template name="day-of-year">
				<xsl:with-param name="year" select="$year"/>
				<xsl:with-param name="month" select="$month"/>
				<xsl:with-param name="day" select="$day"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:value-of select="$dayx * 24 + $hour - 1"/>
	</xsl:template>

</xsl:stylesheet>
