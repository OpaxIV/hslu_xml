<?xml version="1.0" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
                doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>
    
    <xsl:template match="feature">
        <html>
            <head>
                <title>Energiewerkepreisvergleich</title>
                <link rel="stylesheet" type="text/css" href="theme.css"/>
            </head>
            <body>
                
                
                <!-- title and nav  -->
                <h1>Energiepreise nach Standort</h1>
                <div class="banner">
                    
                    <img src="img/banner.png" alt="Banner Image" class= "banner img"/>
                    
                </div>
                <small>
                    <a href="index.xml">Home</a>
                </small>
                
                <div class="content">
                    <h2>Choose between the power plants you want to receive the data</h2>
                    
                    <!-- dropdown for power plants  -->
                    <form>
                        <div>
                            <label for="plant-input">Power plant</label>
                            <select name="plant" id="plant-input">
                                <!-- Namen der einzelnen Plants als Select-Optionen (siehe template-match unten) -->
                                <xsl:apply-templates
                                    select="document('../database/database.xml')/energie-data/energie-plant/plant"><!-- XML-Dokument auf das das Template bezogen wird, festlegen -->
                                </xsl:apply-templates>
                            </select>
                            
                        </div>
                    </form>
                    
                    
                    
                    <!-- TBC content of the power plants  -->
                    <button type="button" onclick="loadPlant()">Submit</button>
                    <br/>
                    <br/>
                    <div id="plantInformation"/> <!-- neuer div-Container mit den Informationen der ausgewählten Plant -->
                
                
                
                </div>
            
            <script>
                <![CDATA[
                    function loadPlant() { <!-- //Capture the selected plant name -->
                        var plantName = document.getElementById('plant-input').value;
                                document.getElementById("plantInformation").appendChild(createPlantTable(this, plantName));
                                <!-- createPlantTable(this, plantName); -->
                                <!-- // TODO not working yet displaying wappen -->
                                <!-- displayWappen(plantName); -->
                    }


                    <!-- neue Funktion mit xsl -->
                    function createPlantTable(xml, plantName) {
                        var xmlDoc = xml.responseXML;
                        var xsltDoc = new DOMParser().parseFromString(`
                            <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
                                <!-- declare xsl variable "plantName" -->
                                <xsl:variable name="plantName" select="'` + plantName + `'"/>
                                <xsl:template match="/">

                                    <table>
                                        <tr>
                                            <th>Date</th>
                                            <th>Price</th>
                                        </tr>
                                        <!-- template auf jeden Preis anwenden, um neue Zeile zu erstellen -->
                                        <xsl:apply-templates select="//plant[name=$plantName]/statistics/price"/>
                                    </table>
                                    <xsl:apply-templates select="//plant[name=$plantName]"/>
                                </xsl:template>

                                <xsl:template match="plant">
                                    <div> 
                                        <!-- add the image located in img/{plantName}.png -->
                                        <img src="img/{name}.png" class="Wappen" alt="{name}" />
                                    </div>
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


                    }

                    // TODO not working yet displaying wappen, for each kanton in the list different logo
                    function displayWappen(plantName) {
                        var img = document.createElement('img');
                        img.src = 'img/' + plantName + '.png';
                        img.width = auto;
                        img.height = auto;
                        document.body.appendChild(img);
                        console.log(document.body);
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