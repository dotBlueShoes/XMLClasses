<?xml version="1.0" encoding="UTF-8"?>

<!-- 
	[ Dokument XHTML ]
	// DONE
	- Oprócz użycia tego formatu należy także wziąć pod uwagę zalecenia dotyczące 
		dostępności stron HTML: Web Content Accessibility Guidelines.
	// DONE
	- Elementy, na które będzie zwracana szczególna uwaga:
		* walidacja dokumentu jako XHTML 1.0 Strict, np. w usłudze walidacji W3C
		* użycie opisów i/lub tekstu zastępczego dla wszystkich elementów wizualnych, 
			które inaczej nie byłyby dostępne np. dla użytkowników niewidzących.

	[XHTML]
	// DONE
	- XHTML waliduje się
	// DONE
	- wykorzystano elementy CSS
	// DONE
	- poprawnie użyto opisów i/lub tekst zastępczy
 -->

<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="xml" version="1.0" encoding="UTF-8" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" 
	doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" indent="yes"/>

	<xsl:template match="/">
		<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pl" lang="pl">

			<head>
                <title>GameDevBusiness</title>
				<link rel="stylesheet" href="../css/xhtml-style.css"></link>
            </head>

			<body>

				<table style="text-align:center">
                    <caption><b>Representation Of GameDevBusiness Team</b></caption>
                    <tr>
                        <th>Name</th>
                        <th>Address</th>
                        <th>Employment</th>
                        <th>Salary</th>
                        <th>OS</th>
                        <th>Software</th>
                    </tr>
                    <xsl:for-each select="Raport/Employees/Employee">
                        <tr>
                            <td><xsl:value-of select="Name"/></td>
                            <td><xsl:value-of select="Address"/></td>
                            <td><xsl:value-of select="Employment"/></td>
                            <td><xsl:value-of select="Salary"/></td>
                            <td><xsl:value-of select="Desk/OS"/></td>
                            <td><xsl:value-of select="Desk/Software"/></td>
                        </tr>
                    </xsl:for-each>
                </table>

				<table style="text-align:center">
                    <caption><b>Summary</b></caption>
                    <tr>
                        <th>Creation Date</th>
                        <th>BeforeTax Sum</th>
                        <th>AfterTax Sum</th>
                    </tr>
                    <tr>
                        <td><xsl:value-of select="Raport/CreationDate"/></td>
                        <td><xsl:value-of select="Raport/BeforeTaxSum"/></td>
                        <td><xsl:value-of select="Raport/AfterTaxSum"/></td>
                    </tr>
                </table>

				<table style="text-align:center">
                    <caption><b>Emloyees</b></caption>
                    <tr>
                        <th>Count</th>
                        <th>Programmer Count</th>
                        <th>Desiner Count</th>
                        <th>Level Designer Count</th>
                    </tr>
                    <tr>
                        <td><xsl:value-of select="Raport/Emloyees/Count"/></td>
                        <td><xsl:value-of select="Raport/Emloyees/ProgrammerCount"/></td>
                        <td><xsl:value-of select="Raport/Emloyees/DesignerCount"/></td>
                        <td><xsl:value-of select="Raport/Emloyees/LevelDesignerCount"/></td>
                    </tr>
                </table>

				<table style="text-align:center">
                    <caption><b>Desks</b></caption>
                    <tr>
                        <th>Count</th>
                        <th>Type A Count</th>
                        <th>Type B Count</th>
                    </tr>
                    <tr>
                        <td><xsl:value-of select="Raport/Desks/Count"/></td>
                        <td><xsl:value-of select="Raport/Desks/TypeACount"/></td>
                        <td><xsl:value-of select="Raport/Desks/TypeBCount"/></td>
                    </tr>
                </table>

				<table style="text-align:center">
                    <caption><b>Devices</b></caption>
                    <tr>
                        <th>Printer Count</th>
                        <th>Scanner Count</th>
                        <th>FaxMachine Count</th>
                    </tr>
                    <tr>
                        <td><xsl:value-of select="Raport/Devices/PrinterCount"/></td>
                        <td><xsl:value-of select="Raport/Devices/ScannerCount"/></td>
                        <td><xsl:value-of select="Raport/Devices/FaxMachineCount"/></td>
                    </tr>
                </table>

				<p>
					<img src="../img/computer.png" alt="This is a PC" width="500" height="500"></img>
				</p>

			</body>

		</html>
	</xsl:template>

</xsl:stylesheet>