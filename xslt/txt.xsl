<?xml version="1.0" encoding="UTF-8"?>

<!--
	[TXT]
	- wygenerowano plik TXT z danymi z XML (dane przedstawiono w postaci kolumnowej - szerokość kolumn obliczana na podstawie danych w XML)

	[ Dokument tekstowy ]
	- Stwórz regularne kolumny tekstu z użyciem dodatkowych spacji - funkcje 
		XPath concat i substring.
-->

<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="yes"/>

	<xsl:template match="/">

		<xsl:variable name="element" select="Raport/Employees/Employee"/>

		<xsl:variable name="maxName">
			<xsl:for-each select="$element">
				<xsl:sort select="string-length(Name)" data-type="number"/>
				<xsl:if test="position() = last()">
				<xsl:value-of select="string-length(Name)"/>
				</xsl:if>
			</xsl:for-each>
		</xsl:variable>	

		<xsl:variable name="maxAddress">
			<xsl:for-each select="$element">
				<xsl:sort select="string-length(Address)" data-type="number"/>
				<xsl:if test="position() = last()">
				<xsl:value-of select="string-length(Address)"/>
				</xsl:if>
			</xsl:for-each>
		</xsl:variable>	

		<xsl:variable name="maxEmployment">
			<xsl:for-each select="$element">
				<xsl:sort select="string-length(Employment)" data-type="number"/>
				<xsl:if test="position() = last()">
				<xsl:value-of select="string-length(Employment)"/>
				</xsl:if>
			</xsl:for-each>
		</xsl:variable>	

		<xsl:variable name="maxSalary">
			<xsl:for-each select="$element">
				<xsl:sort select="string-length(Salary)" data-type="number"/>
				<xsl:if test="position() = last()">
				<xsl:value-of select="string-length(Salary)"/>
				</xsl:if>
			</xsl:for-each>
		</xsl:variable>	

		<xsl:variable name="maxOS">
			<xsl:for-each select="$element">
				<xsl:sort select="string-length(Desk/OS)" data-type="number"/>
				<xsl:if test="position() = last()">
				<xsl:value-of select="string-length(Desk/OS)"/>
				</xsl:if>
			</xsl:for-each>
		</xsl:variable>	

		<xsl:variable name="maxSoftware">
			<xsl:for-each select="$element">
				<xsl:sort select="string-length(Desk/Software)" data-type="number"/>
				<xsl:if test="position() = last()">
				<xsl:value-of select="string-length(Desk/Software)"/>
				</xsl:if>
			</xsl:for-each>
		</xsl:variable>	

		<!-- One Line Here -->
		<xsl:for-each select="1 to $maxName">-</xsl:for-each>
		<xsl:text>-|</xsl:text>

		<xsl:for-each select="1 to $maxAddress">-</xsl:for-each>
		<xsl:text>-|</xsl:text>

		<xsl:for-each select="1 to $maxEmployment">-</xsl:for-each>
		<xsl:text>-|</xsl:text>

		<xsl:for-each select="1 to $maxSalary">-</xsl:for-each>
		<xsl:text>-|</xsl:text>

		<xsl:for-each select="1 to $maxOS">-</xsl:for-each>
		<xsl:text>-|</xsl:text>

		<xsl:for-each select="1 to $maxSoftware">-</xsl:for-each>
		<xsl:text>-|&#10;</xsl:text>
		<!-- One Line Here -->

		<xsl:for-each select="$element">

			<!-- Get length of our data string -->
			<xsl:variable name="lengthName" select="string-length(Name)"/>
			<!-- Display It -->
			<xsl:value-of select="Name"/>
			<!-- Rest signs fill with [empty] -->
			<xsl:for-each select="$lengthName to $maxName">
				<xsl:text> </xsl:text>
			</xsl:for-each>
			<!-- End Column in Row -->
			<xsl:text>|</xsl:text>

			<xsl:variable name="lengthAddress" select="string-length(Address)"/>
			<xsl:value-of select="Address"/>
			<xsl:for-each select="$lengthAddress to $maxAddress">
				<xsl:text> </xsl:text>
			</xsl:for-each>
			<xsl:text>|</xsl:text>

			<xsl:variable name="lengthEmployment" select="string-length(Employment)"/>
			<xsl:value-of select="Employment"/>
			<xsl:for-each select="$lengthEmployment to $maxEmployment">
				<xsl:text> </xsl:text>
			</xsl:for-each>
			<xsl:text>|</xsl:text>

			<xsl:variable name="lengthSalary" select="string-length(Salary)"/>
			<xsl:value-of select="Salary"/>
			<xsl:for-each select="$lengthSalary to $maxSalary">
				<xsl:text> </xsl:text>
			</xsl:for-each>
			<xsl:text>|</xsl:text>

			<xsl:variable name="lengthOS" select="string-length(Desk/OS)"/>
			<xsl:value-of select="Desk/OS"/>
			<xsl:for-each select="$lengthOS to $maxOS">
				<xsl:text> </xsl:text>
			</xsl:for-each>
			<xsl:text>|</xsl:text>

			<xsl:variable name="lengthSoftware" select="string-length(Desk/Software)"/>
			<xsl:value-of select="Desk/Software"/>
			<xsl:for-each select="$lengthSoftware to $maxSoftware">
				<xsl:text> </xsl:text>
			</xsl:for-each>
			<xsl:text>|&#10;</xsl:text>

		</xsl:for-each>	

	</xsl:template>
	

</xsl:stylesheet>