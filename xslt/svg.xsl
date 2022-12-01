<?xml version="1.0" encoding="UTF-8"?>
<!-- 
	[SVG]
	- przedstawiono dane w postaci wykresu (dane pobrane z dokumentu XML oraz 
		dokonano przeliczenia danych - wykres będzie się uaktualniał, jeśli dodane zostaną kolejne węzły)
	- dodano wiele różnych animacji do wybranych elementów wykresu
	- wykorzystano dodatkowe możliwości transformacji oraz zastosowano ciekawe rozwiązania

	[ Dokument SVG ]
	- Stwórz transformację pomocniczego dokumentu XML do postaci obrazu 
		SVG (Scalable Vector Graphics). Ma on stanowić inną formę prezentacji 
		danych z raportu w postaci wykresów. Dołącz transformacje wybranych 
		elementów lub parametrów obrazu tak, aby powstały proste animacje.
-->

<xsl:stylesheet version="3.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" indent="yes"/>

<xsl:template match="/">

	<svg width="1800" height="2000" xmlns="http://www.w3.org/2000/svg">

		<xsl:variable name="margin" select="20.00"/>
		<xsl:variable name="salaryMax" select="230.025"/>

		<rect x="{$margin}" y="{$margin}" width="{1180 + $margin * 2}" height="{$salaryMax}" style="fill:rgb(163,163,163);stroke-width:1;stroke:rgb(0,0,0)" />
		<xsl:for-each select="Raport/Employees/Employee">
			<xsl:sort select="Salary" data-type="number"/>
			<xsl:variable name="i" select="position()" />
			<xsl:variable name="value" select="Salary"/>
			<rect x="{($i - 1) * 60 + $margin * 2}" y="{$salaryMax - ($value div 10) + 20}" width="30" height="{$value div 10}" style="fill:rgb(0,127,127);stroke-width:1;stroke:rgb(0,0,0)" />
			<text x="{($i - 1) * 60 + $margin * 2 - 10}" y="{$salaryMax + 60}" fill="black">
				<xsl:value-of select="$value"/>
			</text>
		</xsl:for-each>
		<text x="{$margin * 2}" y="{$margin * 2}" fill="black"><xsl:text>Salary</xsl:text></text>

		<xsl:variable name="programers" select="Raport/Emloyees/ProgrammerCount"/>
		<xsl:variable name="designers" select="Raport/Emloyees/DesignerCount"/>
		<xsl:variable name="leveldesigners" select="Raport/Emloyees/LevelDesignerCount"/>
		<xsl:variable name="emloyeesMax" select="$programers"/>

		<rect x="{$margin}" y="{320}" width="{1180 + $margin * 2}" height="{$emloyeesMax * 10}" style="fill:rgb(163,163,163);stroke-width:1;stroke:rgb(0,0,0)" />
		<rect x="{00 + $margin * 2}" y="{($emloyeesMax - $programers) * 10 + 320}" width="30" height="{($programers * 10)}" style="fill:rgb(127,0,0);stroke-width:1;stroke:rgb(0,0,0)" />
		<rect x="{60 + $margin * 2}" y="{($emloyeesMax - $designers) * 10 + 320}" width="30" height="{($designers * 10)}" style="fill:rgb(0,127,0);stroke-width:1;stroke:rgb(0,0,0)" />
		<rect x="{120 + $margin * 2}" y="{($emloyeesMax - $leveldesigners) * 10 + 320}" width="30" height="{($leveldesigners * 10)}" style="fill:rgb(0,0,127);stroke-width:1;stroke:rgb(0,0,0)" />
		<text x="{00 + $margin * 2 + 10}" y="{$emloyeesMax * 10 + 360}" fill="black"><xsl:value-of select="$programers"/></text>
		<text x="{60 + $margin * 2 + 10}" y="{$emloyeesMax * 10 + 360}" fill="black"><xsl:value-of select="$designers"/></text>
		<text x="{120 + $margin * 2 + 10}" y="{$emloyeesMax * 10 + 360}" fill="black"><xsl:value-of select="$leveldesigners"/></text>
		<text x="{$margin * 2}" y="{$margin + 320}" fill="black"><xsl:text>Employees</xsl:text></text>

		<xsl:variable name="printers" select="Raport/Devices/PrinterCount"/>
		<xsl:variable name="scanners" select="Raport/Devices/ScannerCount"/>
		<xsl:variable name="faxMachines" select="Raport/Devices/FaxMachineCount"/>
		<xsl:variable name="devicesMax" select="$printers"/>

		<rect x="{$margin}" y="{480}" width="{1180 + $margin * 2}" height="{$devicesMax * 10}" style="fill:rgb(163,163,163);stroke-width:1;stroke:rgb(0,0,0)" />
		<rect x="{00 + $margin * 2}" y="{($devicesMax - $printers) * 10 + 480}" width="30" height="{($printers * 10)}" style="fill:rgb(191,0,0);stroke-width:1;stroke:rgb(0,0,0)" />
		<rect x="{60 + $margin * 2}" y="{($devicesMax - $scanners) * 10 + 480}" width="30" height="{($scanners * 10)}" style="fill:rgb(0,191,0);stroke-width:1;stroke:rgb(0,0,0)" />
		<rect x="{120 + $margin * 2}" y="{($devicesMax - $faxMachines) * 10 + 480}" width="30" height="{($faxMachines * 10)}" style="fill:rgb(0,0,191);stroke-width:1;stroke:rgb(0,0,0)" />
		<text x="{00 + $margin * 2 + 10}" y="{$devicesMax * 10 + 520}" fill="black"><xsl:value-of select="$printers"/></text>
		<text x="{60 + $margin * 2 + 10}" y="{$devicesMax * 10 + 520}" fill="black"><xsl:value-of select="$scanners"/></text>
		<text x="{120 + $margin * 2 + 10}" y="{$devicesMax * 10 + 520}" fill="black"><xsl:value-of select="$faxMachines"/></text>
		<text x="{$margin * 2}" y="{$margin + 480}" fill="black"><xsl:text>Devices</xsl:text></text>

	</svg>
	
	<!--
	<svg width="500" height="500" xmlns="http://www.w3.org/2000/svg">
		<path d="M100,100 L200,100 L200,150 M300,200 L200,200 L100,100" style="stroke:red; stroke-width:2; fill:yellow"/>
	</svg>
	-->

	<!-- Rysowanie łuków -->
	<!--
	<svg xmlns="http://www.w3.org/2000/svg" width="500" height="500">
		<path d="M100,100 A50,50 0 0,1 150,300" style="stroke:blue; stroke-width:2; fill:yellow"/>
		<path d="M100,100 A50,50 0 0,0 150,300" style="stroke:red; stroke-width:2; fill:none"/>
	</svg>
	-->

	<!-- Text -->
	<!--
	<svg width="600" height="600">
		<text x="50" y="100" style="stroke:blue; stroke-with:2px; fill:red; font-size:85px; letter-spacing:5; word-spacing:20; text-decoration:line-through">My favorite</text>
		<text x="50" y="100" style="stroke:blue; stroke-with:2px; fill:red; font-size:85px; letter-spacing:5; word-spacing:20; text-decoration:line-through">text</text>
	</svg>
	-->

</xsl:template>	

</xsl:stylesheet>