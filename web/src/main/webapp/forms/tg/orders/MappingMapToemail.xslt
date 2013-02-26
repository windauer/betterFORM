<?xml version="1.0" encoding="UTF-8"?>
<!--
This file was generated by Altova MapForce 2011sp1

YOU SHOULD NOT MODIFY THIS FILE, BECAUSE IT WILL BE
OVERWRITTEN WHEN YOU RE-RUN CODE GENERATION.

Refer to the Altova MapForce Documentation for further details.
http://www.altova.com/mapforce
-->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:ns0="urn:icit:greenery:orders" exclude-result-prefixes="xs fn ns0">
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">
		<xsl:variable name="var1_DESADV" as="node()*" select="ns0:DESADV"/>
		<email xmlns="urn:icit:greenery:email">
			<xsl:attribute name="xsi:schemaLocation" namespace="http://www.w3.org/2001/XMLSchema-instance" select="'urn:icit:greenery:email C:/Users/marcelv/Mappings/GO-DOC~1/8713702009999/ORDERS/trunk/email/email.xsd'"/>
			<subject>
				<nameSupplier>
					<xsl:for-each select="$var1_DESADV/ns0:HeaderAddresses/ns0:Supplier/ns0:Name/node()[fn:boolean(self::text())]">
						<xsl:sequence select="fn:string(.)"/>
					</xsl:for-each>
				</nameSupplier>
				<orderDate>
					<xsl:sequence select="xs:string(fn:current-dateTime())"/>
				</orderDate>
				<deliveryDate>
					<xsl:for-each select="$var1_DESADV/ns0:HeaderInfo/ns0:EstimatedDateTimeOfArrival">
						<xsl:sequence select="xs:string(xs:dateTime(fn:string(.)))"/>
					</xsl:for-each>
				</deliveryDate>
				<BuyerOrderNumber>
					<xsl:for-each select="$var1_DESADV/ns0:HeaderInfo/ns0:BuyerOrderNumber">
						<xsl:sequence select="fn:string(.)"/>
					</xsl:for-each>
				</BuyerOrderNumber>
			</subject>
			<body>
				<xsl:for-each select="$var1_DESADV/ns0:Consignment/ns0:LineInfos">
					<lines>
						<xsl:for-each select="ns0:LineInfo">
							<line>
								<greeneryArticleNumber>
									<xsl:for-each select="ns0:BuyerProductCode">
										<xsl:sequence select="fn:string(.)"/>
									</xsl:for-each>
								</greeneryArticleNumber>
								<articleDescription>
									<xsl:for-each select="ns0:Description">
										<xsl:sequence select="fn:string(.)"/>
									</xsl:for-each>
								</articleDescription>
								<quantityDelivered>
									<xsl:for-each select="ns0:DespatchQuantityPCE">
										<xsl:sequence select="xs:string(xs:integer(fn:string(.)))"/>
									</xsl:for-each>
								</quantityDelivered>
								<price>
									<xsl:for-each select="ns0:Unitprice">
										<xsl:sequence select="xs:string(xs:decimal(fn:string(.)))"/>
									</xsl:for-each>
								</price>
							</line>
						</xsl:for-each>
					</lines>
				</xsl:for-each>
			</body>
		</email>
	</xsl:template>
</xsl:stylesheet>