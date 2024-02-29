<?xml version="1.0" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
                doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>
    
    <xsl:template match="menu">
        <html>
            <head>
                <title>Energiewerkepreisvergleich</title>
                <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css"/>
                <link rel="stylesheet" type="text/css" href="theme.css"/>
            </head>
            <body>
                <header class="w3-container">
                    <div class="w3-container w3-teal">
                        <h1>Energiewerkepreisvergleich</h1>
                    </div>
                </header>
                
                <div class="w3-container w3-cell-row">
                    <div class="w3-container w3-cell w3-half">
                        <h2>Wilkommen auf unserer Webseite</h2>
                        
                        <div class="w3-container w3-cell">
                            <!-- render menu nav  -->
                            <ul class="w3-ul w3-hoverable">
                                <xsl:apply-templates select="item">
                                    <xsl:sort select="index" data-type="text" order="ascending"/>
                                </xsl:apply-templates>
                            </ul>
                        </div>
                        <p>
                            <a href="database/database.xml" target="_blank" class="w3-button w3-teal">
                                Rohdaten anzeigen
                            </a>
                        </p>
                    </div>
                    
                    <div class="w3-container w3-half" id="bannerContainer">
                        <div style="width: 100%; height: 100%;">
                            <img src="img/banner.png" alt="Banner Image" style="max-width: 100%; max-height: 100%;" />
                        </div>
                    </div>
                </div>
                
            </body>
        </html>
    </xsl:template>
    
    <!-- single menu item  -->
    <xsl:template match="item">
        <li>
            <a href="{link}" class="w3-button w3-hover-teal">
                <xsl:value-of select="text"/>
            </a>
        </li>
    </xsl:template>
    
</xsl:stylesheet>
