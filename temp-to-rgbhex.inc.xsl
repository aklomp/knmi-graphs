<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="temp-to-rgbhex">
		<xsl:param name="temp"/>
		<xsl:choose>
			<xsl:when test="$temp &lt; 0">
				<xsl:call-template name="tempscale-rgbhex">
					<xsl:with-param name="tmp" select="$temp"/>
					<xsl:with-param name="tlo" select="-15"/>
					<xsl:with-param name="thi" select="0"/>
					<xsl:with-param name="rlo" select="55"/>
					<xsl:with-param name="glo" select="2"/>
					<xsl:with-param name="blo" select="131"/>
					<xsl:with-param name="rhi" select="24"/>
					<xsl:with-param name="ghi" select="123"/>
					<xsl:with-param name="bhi" select="215"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="$temp &gt;= 0 and $temp &lt; 15">
				<xsl:call-template name="tempscale-rgbhex">
					<xsl:with-param name="tmp" select="$temp"/>
					<xsl:with-param name="tlo" select="0"/>
					<xsl:with-param name="thi" select="15"/>
					<xsl:with-param name="rlo" select="24"/>
					<xsl:with-param name="glo" select="123"/>
					<xsl:with-param name="blo" select="215"/>
					<xsl:with-param name="rhi" select="221"/>
					<xsl:with-param name="ghi" select="239"/>
					<xsl:with-param name="bhi" select="101"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="$temp &gt;= 15 and $temp &lt; 25">
				<xsl:call-template name="tempscale-rgbhex">
					<xsl:with-param name="tmp" select="$temp"/>
					<xsl:with-param name="tlo" select="15"/>
					<xsl:with-param name="thi" select="25"/>
					<xsl:with-param name="rlo" select="221"/>
					<xsl:with-param name="glo" select="239"/>
					<xsl:with-param name="blo" select="101"/>
					<xsl:with-param name="rhi" select="255"/>
					<xsl:with-param name="ghi" select="192"/>
					<xsl:with-param name="bhi" select="56"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="$temp &gt;= 25 and $temp &lt; 35">
				<xsl:call-template name="tempscale-rgbhex">
					<xsl:with-param name="tmp" select="$temp"/>
					<xsl:with-param name="tlo" select="25"/>
					<xsl:with-param name="thi" select="35"/>
					<xsl:with-param name="rlo" select="255"/>
					<xsl:with-param name="glo" select="192"/>
					<xsl:with-param name="blo" select="56"/>
					<xsl:with-param name="rhi" select="212"/>
					<xsl:with-param name="ghi" select="0"/>
					<xsl:with-param name="bhi" select="0"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>#ffffff</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="tempscale-rgbhex">
		<xsl:param name="tmp"/><!-- temperature -->
		<xsl:param name="tlo"/><!-- temp range lo -->
		<xsl:param name="thi"/><!-- temp range hi -->
		<xsl:param name="rlo"/><!-- red low -->
		<xsl:param name="rhi"/><!-- red hi -->
		<xsl:param name="glo"/><!-- green low -->
		<xsl:param name="ghi"/><!-- green hi -->
		<xsl:param name="blo"/><!-- blue low -->
		<xsl:param name="bhi"/><!-- blue hi -->
		<xsl:variable name="r">
			<xsl:call-template name="dec2hex">
				<xsl:with-param name="dec" select="$rlo + (($tmp - $tlo) div ($thi - $tlo)) * ($rhi - $rlo)"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="g">
			<xsl:call-template name="dec2hex">
				<xsl:with-param name="dec" select="$glo + (($tmp - $tlo) div ($thi - $tlo)) * ($ghi - $glo)"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="b">
			<xsl:call-template name="dec2hex">
				<xsl:with-param name="dec" select="$blo + (($tmp - $tlo) div ($thi - $tlo)) * ($bhi - $blo)"/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:text>#</xsl:text>
		<xsl:if test="string-length($r) = 1"><xsl:text>0</xsl:text></xsl:if><xsl:value-of select="$r"/>
		<xsl:if test="string-length($g) = 1"><xsl:text>0</xsl:text></xsl:if><xsl:value-of select="$g"/>
		<xsl:if test="string-length($b) = 1"><xsl:text>0</xsl:text></xsl:if><xsl:value-of select="$b"/>
	</xsl:template>

	<xsl:template name="dec2hex">
		<xsl:param name="dec"/>
		<xsl:if test="$dec >= 16">
			<xsl:call-template name="dec2hex">
				<xsl:with-param name="dec" select="floor($dec div 16)"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:value-of select="substring('0123456789abcdef', floor($dec mod 16) + 1, 1)"/>
	</xsl:template>

</xsl:stylesheet>
