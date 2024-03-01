<?xml version="1.0" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
                doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>
    
    <xsl:template match="feature">
        <html>
            <head>
                <title>Energiewerkepreisvergleich</title>
                <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css"/>
                <!-- <link rel="stylesheet" type="text/css" href="theme.css"/> -->
                <style>
                    /* Additional CSS to adjust layout */
                    .w3-half {
                    width: 50%;
                    float: left;
                    }
                    .w3-row::after {
                    content: "";
                    clear: both;
                    display: table;
                    }
                </style>
            </head>
            <body>
                <!-- Header -->
                <header class="w3-container w3-teal">
                    <h1>Energiepreise nach Standort</h1>
                    <p>
                        <a href="index.xml">Home</a>
                    </p>
                </header>
                <!-- Main content -->
                <div class="w3-container">
                    <div class="w3-row">
                        <!-- Left half -->
                        <div class="w3-third">
                            <h2>Für welches Energiewerk möchten Sie die Preise anzeigen lassen?</h2>
                            <form class="w3-container">
                                <div class="w3-container">
                                    <label for="plant-input">Power plant</label>
                                    <select name="plant" id="plant-input" class="w3-input">
                                        <xsl:apply-templates select="document('../database/database.xml')/energie-data/energie-plant/plant"/>
                                    </select>
                                </div>
                            </form>
                            <button type="button" class="w3-button w3-teal" onclick="loadPlant()">Submit</button>
                            <br/>
                            <br/>
                            <table id="plantInformation" class="w3-table-all"></table> <!-- Close table tag properly -->
                        </div>
                        <!-- Right half -->
                        <div class="w3-container w3-half">
                            <div style="width: 100%; height: 100%;">
                                <img src="img/banner.png" alt="Banner Image" style="max-width: 100%; max-height: 100%;" />
                            </div>
                        </div>
                    </div>
                </div>
                
                <script>
                    <![CDATA[
                    function loadPlant() {
                        var xmlHttp = new XMLHttpRequest();
                        var plantName = document.getElementById('plant-input').value;
                        xmlHttp.onreadystatechange = function () {
                            if (this.readyState == 4 && this.status == 200) {
                                createPlantTable(this, plantName);
                            }
                        };
                        xmlHttp.open("GET", "../database/database.xml", false);
                        xmlHttp.send();
                    }

                    function createPlantTable(xml, plantName) {
                        var xmlDoc = xml.responseXML;
                        var xsltDoc = new DOMParser().parseFromString(`
                            <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
                                <xsl:variable name="plantName" select="'` + plantName + `'"/>
                                <xsl:template match="/">
                                    <div class="w3-container">
                                        <div class="w3-container w3-half" id="WappenContainer">
                                            <xsl:apply-templates select="document('../database/database.xml')/energie-data/energie-plant/plant[name=$plantName]/wappen-link"/>
                                        </div>
                                        
                                        <table class="w3-table-all">
                                            
                                            <tr>
                                                <th>Date</th>
                                                <th>Price</th>
                                            </tr>
                                            <xsl:apply-templates select="document('../database/database.xml')/energie-data/energie-plant/plant[name=$plantName]/statistics/price"/>
                                        
                                        </table>
                                    </div>
                                </xsl:template>

                                <xsl:template match="wappen-link">
                                    <img src="{.}" class="w3-container" alt="Wappen von {../name}" style="max-width: 50%; max-height: 50%;" />
                                </xsl:template>

                                <xsl:template match="price">
                                    <tr>
                                        <td>
                                            <xsl:value-of select="@date"/>
                                        </td>
                                        <td>
                                            <xsl:value-of select="."/>
                                        </td>
                                    </tr>
                                </xsl:template>
                            </xsl:stylesheet>
                        `, "text/xml");

                        var xsltProcessor = new XSLTProcessor();
                        xsltProcessor.importStylesheet(xsltDoc);

                        var resultDoc = xsltProcessor.transformToDocument(xmlDoc);
                        var resultHtml = new XMLSerializer().serializeToString(resultDoc);

                        document.getElementById("plantInformation").innerHTML = resultHtml;
                    }


                    ]]>
                </script>
            </body>
        </html>
    </xsl:template>
    
    <!-- Name of the power plant für Select-Optionen -->
    <xsl:template match="plant">
        <option>
            <xsl:attribute name="value">
                <xsl:value-of select="name"/>
            </xsl:attribute>
            <xsl:value-of select="name"/>
        </option>
    </xsl:template>
    
    
</xsl:stylesheet>