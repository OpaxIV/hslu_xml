<?xml version="1.0" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml"
                xmlns:svg="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
    >
    <xsl:output doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
                doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>
    
    <xsl:template match="feature">
        <html>
            <head>
                <title>Energiewerkepreisvergleich</title>
                <link rel="stylesheet" type="text/css" href="theme.css"/>
            </head>
            <body>
                
                <!-- Title and nav  -->
                
                <h1>Energiedaten drucken</h1>
                <div class="banner">
                    
                    <img src="img/banner.png" alt="Banner Image" class= "banner img"/>
                    <small>
                        <a href="index.xml">Home</a>
                    </small>
                </div>
                <small>
                    <a href="index.xml">Home</a>
                </small>
                
                <div class="content">
                    
                    <div>
                        <p>
                            <i>Hier können Sie sich die aktuellen Energiepreise ganz einfach ausdrucken:
                            </i>
                        </p>
                        <p>
                            <!-- Phase 1, XML->FO file creation -->
                            <a href="fo.xml" target="_blank">create FO</a>
                            <small>(directly in browser with XSTL)</small>
                        </p>
                        <p>
                            <!-- Phase 2, FO->PDF file creation -->
                            <!-- call fo-functions.js function createPDF() -->
                            <a href="#" onclick="createPdf()">create PDF</a>
                            <small>(create FO and render as PDF via web service)</small>
                        </p>
                        <!-- Dummy-Link for PDF-Download -->
                        <a id="dummyLink"></a>
                    </div>
                    
                </div>
                <!-- Javascript-Functions for FO-Transformation -->
                <!-- provide js functionality in browser -->
                <script src="feature-03/fo-functions.js" type="text/javascript"></script>
                
                <small>
                    (Achtung: Das Drucken der Daten funktioniert nur im HSLU-Netzwerk, da Web-Service auf internen Servern gehostet ist)
                </small>
            </body>
        </html>
    </xsl:template>
    
</xsl:stylesheet>
