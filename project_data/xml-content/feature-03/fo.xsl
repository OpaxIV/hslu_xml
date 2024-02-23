<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format">

    <xsl:template match="fo">
        <fo:root>
            <fo:layout-master-set>
                <fo:simple-page-master master-name="stats" page-height="29.7cm" page-width="21cm" margin-top="1cm"
                                       margin-bottom="2cm" margin-left="2.5cm" margin-right="2.5cm">
                    <fo:region-body margin-top="1cm"/>
                    <fo:region-before extent="2cm"/>
                    <fo:region-after extent="3cm"/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            <fo:page-sequence master-reference="stats">
                <fo:static-content flow-name="xsl-region-before">
                    <fo:block text-align="center" font-size="6pt">
                        Preisstatistik - Seite <!-- top of the page -->
                        <fo:page-number/>
                    </fo:block>
                </fo:static-content>
                <fo:flow flow-name="xsl-region-body">
                    <fo:block font-size="19pt" font-family="sans-serif" line-height="24pt" space-after.optimum="20pt"
                              color="black" text-align="center" padding-top="5pt"
                              padding-bottom="5pt">Energiewerke Mittelland
                    </fo:block>
                    <fo:block font-size="15pt" font-family="sans-serif" line-height="19pt" space-after.optimum="20pt"
                              background-color="green" color="white" text-align="center" padding-top="5pt"
                              padding-bottom="5pt">Price Statistics
                    </fo:block>
                    <xsl:apply-templates
                            select="document('../database/database.xml')/energie-data/energie-plant/plant">

                    </xsl:apply-templates>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>

    <!-- applied templates when creating pdf-->
    <xsl:template match="plant">
        <fo:block font-size="16pt" color="black" font-weight="900" text-align="center">
            <xsl:value-of select="name"/>   <!-- name/location of the plant-->
        </fo:block>
        <fo:table space-after.optimum="20pt" width="13cm" margin="2mm"
                  font-size="11pt"> <!-- border around the table -->
            <fo:table-column column-number="1" column-width="30%"/>
            <fo:table-column column-number="2" column-width="30%"/>
            <fo:table-column column-number="3" column-width="30%"/>     <!-- check if it works-->
            <fo:table-body>
                <xsl:apply-templates select="statistics/price"/>
            </fo:table-body>
        </fo:table>
    </xsl:template>

    <xsl:template match="price">
        <fo:table-row>
            <xsl:variable name="border" select="'1pt solid black'"/> <!-- used for table cell border-->
            <fo:table-cell border="{$border}">
                <fo:block font-size="12pt" color="black" font-weight="900" text-align="center" margin="1mm">
                    <xsl:value-of select="@date"/> <!-- get price attribute "date" -->
                </fo:block>
            </fo:table-cell>
            <fo:table-cell border="{$border}">
                <xsl:choose> <!-- select cheapest prices and mark them green for easier recognition -->
                    <xsl:when test="text() &lt; 9">
                        <fo:block font-size="12pt" color="green" text-align="center" margin="1mm">
                            <xsl:value-of select="text()"/> CHF <!-- get text from price, append "CHF" -->
                        </fo:block>
                    </xsl:when>
                    <xsl:otherwise>
                        <fo:block font-size="12pt" color="black" text-align="center" margin="1mm">
                            <xsl:value-of select="text()"/> CHF <!-- get text from price, append "CHF" -->
                        </fo:block>
                    </xsl:otherwise>
                </xsl:choose>
            </fo:table-cell>
            <fo:table-cell>
                <xsl:choose> <!-- select name of the city and display corresponding picture -->
                    <xsl:when test="//plant/name[text() = 'Aarau']">
                        <fo:block text-align="center" margin="1mm">
                            <fo:external-graphic src="url('../img/Aarau.png')" content-width="500px" content-height="600px" scaling="uniform"/>
                        </fo:block>
                    </xsl:when>
                    <xsl:otherwise>
                        <fo:block text-align="center" margin="1mm">
                            <fo:value-of select="text()"/>  <!-- get text from price, append "CHF" -->  <!-- change it to something more ideal-->
                        </fo:block>
                    </xsl:otherwise>
                </xsl:choose>
            </fo:table-cell>
        </fo:table-row>
    </xsl:template>
</xsl:stylesheet>
