<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	xmlns:svg="http://www.w3.org/2000/svg">
	<xsl:import href="../temp-to-rgbhex.inc.xsl"/>
	<xsl:import href="../day-of-year.inc.xsl"/>
	<xsl:output method="xml" indent="yes"/>
	<xsl:param name="target-year"/>

	<xsl:template match="/">
		<svg:svg width="772">
			<xsl:attribute name="height">
				<xsl:value-of select="count(knmi/year[count(month/day) > 364]) * 10"/>
			</xsl:attribute>
			<svg:rect x="0" y="0" width="772" style="fill:white;stroke:none">
				<xsl:attribute name="height">
					<xsl:value-of select="count(knmi/year[count(month/day) > 364]) * 10"/>
				</xsl:attribute>
			</svg:rect>
			<!-- select only complete years -->
			<xsl:apply-templates select="knmi/year[count(month/day) > 364]"/>
		</svg:svg>
	</xsl:template>

	<xsl:template match="year">
		<xsl:variable name="islastyear">
			<xsl:choose>
				<xsl:when test="@year = (/knmi/year[count(month/day) > 364])[last()]/@year">
					<xsl:text>1</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="y">
			<xsl:call-template name="year-to-y">
				<xsl:with-param name="year" select="@year"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:for-each select="month/day">
			<svg:rect>
				<xsl:attribute name="x">
					<xsl:variable name="xp">
						<xsl:call-template name="day-of-year">
							<xsl:with-param name="year" select="../../@year"/>
							<xsl:with-param name="month" select="../@month"/>
							<xsl:with-param name="day" select="@day"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:value-of select="$xp * 2 + 40"/>
				</xsl:attribute>
				<xsl:attribute name="y">
					<xsl:value-of select="$y"/>
				</xsl:attribute>
				<xsl:attribute name="width">
					<xsl:if test="position() != last()"><xsl:text>3</xsl:text></xsl:if>
					<xsl:if test="position()  = last()"><xsl:text>2</xsl:text></xsl:if>
				</xsl:attribute>
				<xsl:attribute name="height">
					<xsl:if test="$islastyear = 0"><xsl:text>11</xsl:text></xsl:if>
					<xsl:if test="$islastyear = 1"><xsl:text>10</xsl:text></xsl:if>
				</xsl:attribute>
				<xsl:attribute name="fill">
					<xsl:call-template name="temp-to-rgbhex">
						<xsl:with-param name="temp" select="./TG"/>
					</xsl:call-template>
				</xsl:attribute>
			</svg:rect>
		</xsl:for-each>
		<xsl:choose>
			<xsl:when test="@year mod 5 = 0">
				<svg:text style="fill:black;stroke:none;font-size:11px;font-family:sans-serif" x="3">
					<xsl:attribute name="y">
						<xsl:value-of select="$y + 8"/>
					</xsl:attribute>
					<xsl:value-of select="@year"/>
				</svg:text>
				<svg:line style="fill:none;stroke:black;stroke-width:0.5" x1="35" x2="40">
					<xsl:attribute name="y1">
						<xsl:value-of select="$y + 4.5"/>
					</xsl:attribute>
					<xsl:attribute name="y2">
						<xsl:value-of select="$y + 4.5"/>
					</xsl:attribute>
				</svg:line>
			</xsl:when>
			<xsl:otherwise>
				<svg:line style="fill:none;stroke:black;stroke-width:0.5" x1="37" x2="40">
					<xsl:attribute name="y1">
						<xsl:value-of select="$y + 4.5"/>
					</xsl:attribute>
					<xsl:attribute name="y2">
						<xsl:value-of select="$y + 4.5"/>
					</xsl:attribute>
				</svg:line>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="year-to-y">
		<xsl:param name="year"/>
		<xsl:value-of select="($year - /knmi/year[1]/@year) * 10"/>
	</xsl:template>

</xsl:stylesheet>
