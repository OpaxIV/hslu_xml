<?xml version="1.0" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
                doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>
    
    <xsl:template match="menu">
        <html>
            <head>
                <title>Energiewerkepreisvergleich</title>
                <link rel="stylesheet" type="text/css" href="theme.css"/>
            </head>
            <body>
                <h1>Energiewerkepreisvergleich</h1>
                <div class="banner">
                    
                    <img src="img/banner.png" alt="Banner Image" class= "banner img"/>
                    
                </div>
                
                <div class="content">
                    
                    <p>
                        <i>Wilkommen auf unserer Webseite</i>
                    </p>
                    
                    <!-- render menu nav  -->
                    <ul>
                        <xsl:apply-templates select="item">
                            <xsl:sort select="index" data-type="text" order="ascending"/>
                        </xsl:apply-templates>
                    </ul>
                    <a
                        href="database/database.xml"
                        target="_blank"
                        >
                        Rohdaten anzeigen
                    </a>
                </div>
                
            </body>
        </html>
    </xsl:template>
    
    <!-- single menu item  -->
    <xsl:template match="item">
        <li>
            <a> <!-- jedes Menü-Item als Link auflisten -->
                <xsl:attribute name="href">
                    <xsl:value-of select="link"/>
                </xsl:attribute>
                <xsl:value-of select="text"/>
            </a>
        </li>
    </xsl:template>
    
</xsl:stylesheet>
