<?xml version="1.0" encoding="UTF-8"?>

<!-- 
	Pierwsze przekształcenie będzie miało na celu stworzenie pomocniczego dokumentu w 
		formacie XML, będącego raportem uzyskanym na podstawie dokumentu źródłowego.

	// DONE
	- Docelowo ma on być raportem, zestawieniem, podsumowaniem lub wydrukiem dla klienta. 
		Dokument taki powinien zawierać znaczniki XML potrzebne do łatwego 
		uzyskania dokumentu wyjściowego przeznaczonego do prezentacji.

	// DONE
	- Jest to dobry moment, żeby połączyć ze sobą elementy powiązane atrybutami 
		ID i IDREF(S) / key i keyrefs. 

	// DONE
	- Przykładowo, można na fakturze obok towaru dołączyć nazwę producenta, 
		w zestawieniu filmów obok płyty z filmem dołączyć nazwę wydawcy, itd. 
		Jeśli dokument źródłowy zawierał ceny i liczbę towarów, należy obliczyć sumy 
		częściowe, kwoty VAT, itp. Dzięki temu w dokumencie końcowym będzie łatwiej 
		uzyskać sumę końcową(e).

	// DONE
	- Możliwe jest także pogrupowanie i/lub posortowanie elementów względem pewnego 
		kryterium, np. filmów według gatunków i tytułów, towarów według 
		producentów lub rodzaju, itp.
		
	// DONE
	- Na końcu dokumentu należy zawrzeć podsumowanie zawierające statystyki dokumentu 
		oryginalnego. Podsumowanie to może zawierać takie informacje jak:
			* liczbę elementów danych,
			* liczbę różnych kategorii elementów (jeśli takie są - np. dla enumeracji),
			* sumy częściowe, sumę końcową (dla znaczników typu "cena"), 
				sumy kwot VAT (dla różnych stawek VAT),
			* datę wygenerowania raportu.
-->

<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

	<xsl:template match="/">
		<xsl:element name="Raport">
			<xsl:apply-templates select="GameDevBusiness/Employees"/>

			<xsl:element name="CreationDate">
				<!-- Does not generate in notepad++ use https://www.freeformatter.com/xsl-transformer.html#before-output -->
				<xsl:value-of select="format-dateTime(current-dateTime(),'[D01]-[M01]-[Y0001]')"/>
			</xsl:element>

			<!-- After, Before Tax sums -->
			<xsl:variable name="BeforeTaxSumPLN" select="sum(GameDevBusiness/Employees/Employee/Salary/BeforeTax)"/>
			<xsl:variable name="AfterTaxSumPLN" select="sum(GameDevBusiness/Employees/Employee/Salary/AfterTax)"/>

			<xsl:element name="BeforeTaxSum">
				<xsl:value-of select="$BeforeTaxSumPLN"/>
			</xsl:element>

			<xsl:element name="AfterTaxSum">
				<xsl:value-of select="$AfterTaxSumPLN"/>
			</xsl:element>

			<!-- Number of Emloyee appearances -->
			<!-- Number of Emloyee [type Programmer] appearances -->
			<!-- Number of Emloyee [type Desiner] appearances -->
			<!-- Number of Emloyee [type Level-Designer] appearances -->
			<xsl:element name="Emloyees">

				<xsl:element name="Count">
					<xsl:value-of select="count(GameDevBusiness/Employees/Employee)"/>
				</xsl:element>

				<xsl:element name="ProgrammerCount">
					<xsl:value-of select="count(GameDevBusiness/Employees/Employee[@position='Programmer'])"/>
				</xsl:element>

				<xsl:element name="DesignerCount">
					<xsl:value-of select="count(GameDevBusiness/Employees/Employee[@position='Desiner'])"/>
				</xsl:element>

				<xsl:element name="LevelDesignerCount">
					<xsl:value-of select="count(GameDevBusiness/Employees/Employee[@position='Level-Designer'])"/>
				</xsl:element>

			</xsl:element>

			<!-- Number of Desk appearances -->
			<!-- Number of Desk [type A] appearances -->
			<!-- Number of Desk [type B] appearances -->
			<xsl:element name="Desks">

				<xsl:element name="Count">
					<xsl:value-of select="count(GameDevBusiness/Desks/Desk)"/>
				</xsl:element>

				<xsl:element name="TypeACount">
					<xsl:value-of select="count(GameDevBusiness/Desks/Desk[@type='A'])"/>
				</xsl:element>

				<xsl:element name="TypeBCount">
					<xsl:value-of select="count(GameDevBusiness/Desks/Desk[@type='B'])"/>
				</xsl:element>

			</xsl:element>

			<!-- Number of Printer appearances -->
			<!-- Number of Scanner appearances -->
			<!-- Number of FaxMachine appearances -->
			<xsl:element name="Devices">

				<xsl:element name="PrinterCount">
					<xsl:value-of select="count(GameDevBusiness/Desks/Desk/Printer)"/>
				</xsl:element>

				<xsl:element name="ScannerCount">
					<xsl:value-of select="count(GameDevBusiness/Desks/Desk/Scanner)"/>
				</xsl:element>

				<xsl:element name="FaxMachineCount">
					<xsl:value-of select="count(GameDevBusiness/Desks/Desk/FaxMachine)"/>
				</xsl:element>

			</xsl:element>

		</xsl:element>
	</xsl:template>

	<xsl:key name="deskId" match="/GameDevBusiness/Desks/Desk" use="@id" />

	<xsl:template match="GameDevBusiness/Employees">
		<xsl:element name="Employees">
        
			<xsl:for-each select="Employee">
				<xsl:sort select="Name" order="descending"/>
				<xsl:element name="Employee">

					<xsl:element name="Name">
						<xsl:attribute name="Id">
                    		<xsl:value-of select="PersonalID"/>
                		</xsl:attribute>
						<xsl:value-of select="Name"/>
						<xsl:text> </xsl:text>
						<xsl:value-of select="Surname"/>
					</xsl:element>

					<xsl:element name="Address">
						<xsl:value-of select="Address/Country"/>
						<xsl:text> </xsl:text>
						<xsl:value-of select="Address/City"/>
						<xsl:text> </xsl:text>
						<xsl:value-of select="Address/Street"/>
						<xsl:text> </xsl:text>
						<xsl:value-of select="Address/Number"/>
					</xsl:element>

					<xsl:element name="Employment">
						<xsl:variable name="year">
							<xsl:value-of select="substring(DateOfEmployment,1,4)" />
						</xsl:variable>

						<xsl:choose>
							<xsl:when test="$year &lt;= '2018'">
								<xsl:text>Old</xsl:text>
							</xsl:when>
							<xsl:when test="$year &lt;= '4000'">
								<xsl:text>New</xsl:text>
							</xsl:when>
						</xsl:choose>

					</xsl:element>	

					<xsl:element name="Salary">
						<xsl:variable name="value">
							<xsl:value-of select="Salary/AfterTax" />
						</xsl:variable>

						<xsl:choose>
							<xsl:when test="$value &gt;= 4000.00">
								<xsl:attribute name="estimated">
                    				<xsl:text>GreaterThen4000</xsl:text>
                				</xsl:attribute>
							</xsl:when>
							<xsl:when test="$value &gt;= 3000.00">
								<xsl:attribute name="estimated">
                    				<xsl:text>GreaterThen3000</xsl:text>
                				</xsl:attribute>
							</xsl:when>
							<xsl:when test="$value &gt;= 2000.00">
								<xsl:attribute name="estimated">
                    				<xsl:text>GreaterThen2000</xsl:text>
                				</xsl:attribute>
							</xsl:when>
							<xsl:when test="$value &gt;= 1000.00">
								<xsl:attribute name="estimated">
                    				<xsl:text>GreaterThen1000</xsl:text>
                				</xsl:attribute>
							</xsl:when>
							<xsl:otherwise>
								<xsl:attribute name="estimated">
                    				<xsl:text>GreaterThen0000</xsl:text>
                				</xsl:attribute>
							</xsl:otherwise>
						</xsl:choose>

						<xsl:value-of select="$value" />

					</xsl:element>

					<xsl:element name="Desk">
						<xsl:variable name="desk" select="key('deskId', @ref-desk)" />
						<xsl:element name="OS">
							<xsl:value-of select="$desk/PC/OS"/>
						</xsl:element>
						<xsl:element name="Software">
							<xsl:value-of select="$desk/PC/Program/Name"/>
							<xsl:text> </xsl:text>
							<xsl:value-of select="$desk/PC/Program/Version"/>
							<xsl:text>, </xsl:text>
							<xsl:value-of select="$desk/PC/Software"/>
						</xsl:element>
					</xsl:element>

				</xsl:element>
			</xsl:for-each>
			
		</xsl:element>
	</xsl:template>

	

</xsl:stylesheet>