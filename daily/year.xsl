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
		<svg:svg height="50" width="732" viewBox="0 0 732 50">
			<!-- select only complete years -->
			<!--<xsl:apply-templates select="knmi/year[count(month/day) > 364]"/>-->
			<xsl:apply-templates select="knmi/year[@year = $target-year]"/>
		</svg:svg>
	</xsl:template>

	<xsl:template match="year">
		<xsl:for-each select="month/day">
			<svg:rect height="50" y="0">
				<xsl:attribute name="x">
					<xsl:variable name="xp">
						<xsl:call-template name="day-of-year">
							<xsl:with-param name="year" select="../../@year"/>
							<xsl:with-param name="month" select="../@month"/>
							<xsl:with-param name="day" select="@day"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:value-of select="$xp * 2"/>
				</xsl:attribute>
				<xsl:attribute name="width">
					<xsl:if test="position() != last()"><xsl:text>3</xsl:text></xsl:if>
					<xsl:if test="position()  = last()"><xsl:text>2</xsl:text></xsl:if>
				</xsl:attribute>
				<xsl:attribute name="fill">
					<xsl:call-template name="temp-to-rgbhex">
						<xsl:with-param name="temp" select="./TG"/>
					</xsl:call-template>
				</xsl:attribute>
			</svg:rect>
		</xsl:for-each>
		<svg:text style="fill:white;stroke:none;font-size:11px;font-family:sans-serif" x="4" y="13">
			<xsl:value-of select="@year"/>
		</svg:text>
		<svg:line style="fill:none;stroke:white;stroke-width:0.5" x1="0" y1="35.5" y2="35.5">
			<xsl:attribute name="x2">
				<xsl:value-of select="2 * count(month/day)"/>
			</xsl:attribute>
		</svg:line>
		<xsl:for-each select="month">
			<svg:line style="fill:none;stroke:white;stroke-width:0.5" y1="31.5" y2="39.5">
				<xsl:variable name="xp">
					<xsl:call-template name="day-of-year">
						<xsl:with-param name="year" select="../@year"/>
						<xsl:with-param name="month" select="@month"/>
						<xsl:with-param name="day" select="1"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:attribute name="x1">
					<xsl:value-of select="$xp * 2 + 0.5"/>
				</xsl:attribute>
				<xsl:attribute name="x2">
					<xsl:value-of select="$xp * 2 + 0.5"/>
				</xsl:attribute>
			</svg:line>
		</xsl:for-each>
		<!-- Max temperature -->
		<svg:polyline style="fill:none;stroke:#bb0000;stroke-width:0.2">
			<xsl:attribute name="points">
				<xsl:for-each select="month/day">
					<xsl:variable name="x">
						<xsl:call-template name="day-of-year">
							<xsl:with-param name="year" select="../../@year"/>
							<xsl:with-param name="month" select="../@month"/>
							<xsl:with-param name="day" select="@day"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:value-of select="$x * 2"/>
					<xsl:text>,</xsl:text>
					<xsl:value-of select="35 - TX"/>
					<xsl:text> </xsl:text>
				</xsl:for-each>
				<!-- Last point at "Dec 32" -->
				<xsl:variable name="x">
					<xsl:call-template name="day-of-year">
						<xsl:with-param name="year" select="@year"/>
						<xsl:with-param name="month" select="12"/>
						<xsl:with-param name="day" select="32"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:value-of select="$x * 2"/>
				<xsl:text>,</xsl:text>
				<xsl:value-of select="35 - ./month[@month=12]/day[@day=31]/TX"/>
				<xsl:text> </xsl:text>
			</xsl:attribute>
		</svg:polyline>
		<!-- Min temperature -->
		<svg:polyline style="fill:none;stroke:#0000bb;stroke-width:0.2">
			<xsl:attribute name="points">
				<xsl:for-each select="month/day">
					<xsl:variable name="x">
						<xsl:call-template name="day-of-year">
							<xsl:with-param name="year" select="../../@year"/>
							<xsl:with-param name="month" select="../@month"/>
							<xsl:with-param name="day" select="@day"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:value-of select="$x * 2"/>
					<xsl:text>,</xsl:text>
					<xsl:value-of select="35 - TN"/>
					<xsl:text> </xsl:text>
				</xsl:for-each>
				<!-- Last point at "Dec 32" -->
				<xsl:variable name="x">
					<xsl:call-template name="day-of-year">
						<xsl:with-param name="year" select="@year"/>
						<xsl:with-param name="month" select="12"/>
						<xsl:with-param name="day" select="32"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:value-of select="$x * 2"/>
				<xsl:text>,</xsl:text>
				<xsl:value-of select="35 - ./month[@month=12]/day[@day=31]/TN"/>
				<xsl:text> </xsl:text>
			</xsl:attribute>
		</svg:polyline>
		<!-- Average temperature -->
		<svg:polyline style="fill:none;stroke:black;stroke-width:0.4">
			<xsl:attribute name="points">
				<xsl:for-each select="month/day">
					<xsl:variable name="x">
						<xsl:call-template name="day-of-year">
							<xsl:with-param name="year" select="../../@year"/>
							<xsl:with-param name="month" select="../@month"/>
							<xsl:with-param name="day" select="@day"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:value-of select="$x * 2"/>
					<xsl:text>,</xsl:text>
					<xsl:value-of select="35 - TG"/>
					<xsl:text> </xsl:text>
				</xsl:for-each>
				<!-- Last point at "Dec 32" -->
				<xsl:variable name="x">
					<xsl:call-template name="day-of-year">
						<xsl:with-param name="year" select="@year"/>
						<xsl:with-param name="month" select="12"/>
						<xsl:with-param name="day" select="32"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:value-of select="$x * 2"/>
				<xsl:text>,</xsl:text>
				<xsl:value-of select="35 - ./month[@month=12]/day[@day=31]/TG"/>
				<xsl:text> </xsl:text>
			</xsl:attribute>
		</svg:polyline>
	</xsl:template>

</xsl:stylesheet>
