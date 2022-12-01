<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method = "html"/>
	<!-- <xsl:output method="xml" version="1.0" encoding="UTF-8" standalone="yes" /> -->
	<!-- <xsl:output method="text" /> -->

	<!--
	<xsl:template match="/">
		<html><body><h2>Order Details: </h2></body></html>
	</xsl:template>
	-->

	<!-- 
	ŁĄCZENIE KLUCZY I REFERENCJI
		np. id=[a,b,c] i idref=[a,b,c]
		nie ma to znaczenia czy atrybuty czy elementy czy kombinacja atrybut element
		musimy zdefiniować coś co nazywa się kluczem - key
		nazwa, matach - sciezka do elementu która stanowi kluczem
		w atrybucie use mówimy co będzie naszym kluczem @ - znaczy atrybut w elemencie
	-->

	<xsl:key name="category" match="/Order/Items-No" use="@id" />

	<!--
		chcąc się odwoływać do tego klucza korzystamy z
		mówimy że nastąpi połączenie wartości z naczym kluczem category to ta nazwa co wcześniej ustaliliśmy
		2 atrybutem są wartośći jakie chcemy połączyć
		czyli atrybut idref w elemencie No.
		jeśli pasują to zostaną połączone 
		jeśli nie pasują to ta referencja nie zostanie wyświetlona.
		<xsl:copy-of select "ItemId" />
		<xsl:element name="genre">
			<xsl:value-of select="key('category', No/@idref)" />
		</xsl:element>
	-->

	<!-- 
	Wyciągnięcie zawartośći elementu 
		Jeśli xpath będzie nie poprawny to otrzymamy pustą zawartość
		tym samym nie wyświetlimy nic
	-->
	<xsl:template match="/">
		<html>
			<body>
				<h2>
					<xsl:value-of select="Order/CustomerName"/>
				</h2>

				<!-- 
				Można dodawać atrybuty
					korzystamy z ampersant i nazwa atrybuty w dokumencie xmlowym
				 -->
				<h3>
				 OrderId: <xsl:value-of select="Order/@idx" />
				</h3>

				<!-- 
				Idąc dalej....
				-->

				<table border="1">
					<tr>
						<th>Item Id</th>
						<th>Item Name</th>
						<th>Item Price</th>
						<th>Item Quantity</th>
						<th>Item Category</th>
					</tr>
					<xsl:for-each select="Order/Item">
						<!-- SORTOWANIE [atrybut/niedafault, jegotyp, ascending/descending]-->
						<!-- <xsl:sort select="Price" data-type="number order="descending /> -->
						<tr>
							<td>
								<xsl:value-of select="ItemId" />
							</td>
							<td>
								<xsl:value-of select="ItemName" />
							</td>
							<td>
								<xsl:value-of select="Price" />
							</td>
							<td>
								<xsl:value-of select="Quantity" />
							</td>
							<td>
								<xsl:choose>
									<xsl:when test="Price >= 100">
										<b>Platinum</b>
									</xsl:when>
									<xsl:when test="Price >= 20">
										<b>Gold</b>
									</xsl:when>
									<xsl:otherwise>
										<b>Silver</b>
									</xsl:otherwise>
								</xsl:choose>			
							</td>
						</tr>
					</xsl:for-each>
					
				</table>

			</body>
		</html>
	</xsl:template>

</xsl:stylesheet>