<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	xmlns:svg="http://www.w3.org/2000/svg">
	<xsl:import href="../temp-to-rgbhex.inc.xsl"/>
	<xsl:import href="../hour-of-year.inc.xsl"/>
	<xsl:output method="xml" indent="yes"/>
	<xsl:param name="target-year"/>

	<xsl:template match="/">
		<svg:svg height="50" width="8784" viewBox="0 0 8784 50">
			<!-- select only complete years -->
			<!--<xsl:apply-templates select="knmi/year[count(month/day) > 364]"/>-->
			<xsl:apply-templates select="knmi/year[@year = $target-year]"/>
		</svg:svg>
	</xsl:template>

	<xsl:template match="year">
		<xsl:for-each select="month/day/hour">
			<svg:rect height="50" y="0">
				<xsl:attribute name="x">
					<xsl:call-template name="hour-of-year">
						<xsl:with-param name="year" select="../../../@year"/>
						<xsl:with-param name="month" select="../../@month"/>
						<xsl:with-param name="day" select="../@day"/>
						<xsl:with-param name="hour" select="@hour"/>
					</xsl:call-template>
				</xsl:attribute>
				<xsl:attribute name="width">
					<xsl:if test="position() != last()"><xsl:text>1.1</xsl:text></xsl:if>
					<xsl:if test="position()  = last()"><xsl:text>1</xsl:text></xsl:if>
				</xsl:attribute>
				<xsl:attribute name="fill">
					<xsl:call-template name="temp-to-rgbhex">
						<xsl:with-param name="temp" select="./T"/>
					</xsl:call-template>
				</xsl:attribute>
			</svg:rect>
		</xsl:for-each>
		<svg:line style="fill:none;stroke:white;stroke-width:1" x1="0" y1="35.5" y2="35.5">
			<xsl:attribute name="x2">
				<xsl:value-of select="count(month/day/hour)"/>
			</xsl:attribute>
		</svg:line>
		<svg:polyline style="fill:none;stroke:black;stroke-width:0.5">
			<xsl:attribute name="points">
				<xsl:for-each select="month/day/hour">
					<xsl:call-template name="hour-of-year">
						<xsl:with-param name="year" select="../../../@year"/>
						<xsl:with-param name="month" select="../../@month"/>
						<xsl:with-param name="day" select="../@day"/>
						<xsl:with-param name="hour" select="@hour"/>
					</xsl:call-template>
					<xsl:text>,</xsl:text>
					<xsl:value-of select="35 - T"/>
					<xsl:text> </xsl:text>
				</xsl:for-each>
			</xsl:attribute>
		</svg:polyline>
		<svg:text style="fill:white;stroke:none;font-size:11px;font-family:sans-serif" x="4" y="13">
			<xsl:value-of select="@year"/>
		</svg:text>
	</xsl:template>

</xsl:stylesheet>
