<?xml version="1.0" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
                doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>
    
    <xsl:template match="feature">
        <html>
            <head>
                <title>Energiewerkepreisvergleich</title>
                <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css"/>
                <link rel="stylesheet" type="text/css" href="theme.css"/>
            </head>
            <body>
                <div class="flex-container">
                    <div class="w3-container">
                        <!-- title and nav  -->
                        <div class="w3-container w3-teal w3-cell w3-mobile">
                            <h1>Energiepreise nach Standort</h1>
                        </div>
                        <div class="w3-card">
                            
                            <img src="img/banner.png" alt="Banner Image" />
                            <small>
                                <a href="index.xml">Home</a>
                            </small>
                        </div>
                    </div>
                    
                    <div class="w3-container">
                        <div class="w3-container w3-teal">
                            <h2>Für welches Energiewerk möchten Sie die Preise anzeigen lassen?</h2>
                        </div>
                        <div class= "w3-container">
                            <!-- dropdown for power plants  -->
                            <form class="w3-container">
                                <div class="w3-container">
                                    
                                    <label for="plant-input" >Power plant</label>
                                    <select name="plant" id="plant-input" class="w3-input">
                                        <!-- Namen der einzelnen Plants als Select-Optionen (siehe template-match unten) -->
                                        <xsl:apply-templates
                                            select="document('../database/database.xml')/energie-data/energie-plant/plant"><!-- XML-Dokument auf das das Template bezogen wird, festlegen -->
                                        </xsl:apply-templates>
                                    </select>
                                    
                                </div>
                            </form>
                        </div>
                        
                        
                        <!-- TBC content of the power plants  -->
                        <button type="button" class="w3-button w3-teal" onclick="loadPlant()">Submit</button>
                        <br/>
                        <br/>
                        <table id="plantInformation"/>
                    </div>
                </div>
                
                <script>
                    <![CDATA[
                    function loadPlant() { //Capture the selected plant name
                        var xmlHttp = new XMLHttpRequest();
                        var plantName = document.getElementById('plant-input').value;
                        xmlHttp.onreadystatechange = function () {
                            if (this.readyState == 4 && this.status == 200) {
                                createPlantTable(this, plantName);
                                // TODO not working yet displaying wappen
                                displayWappen(plantName);
                            }
                        };
                        xmlHttp.open("GET", "../database/database.xml", false);
                        xmlHttp.send();
                    }

                    <!-- alte Version der Funktion ohne xsl -->
                    function createPlantTableOld(xml, plantName) {
                        var xmlDoc = xml.responseXML;
                        var table = "<tr><th>Date</th><th>Price</th></tr>";
                        var plants = xmlDoc.getElementsByTagName("plant");

                        for (var i = 0; i < plants.length; i++) {
                            var name = plants[i].getElementsByTagName("name")[0].childNodes[0].nodeValue;

                            if (name === plantName) { //check if this is the plant
                                var prices = plants[i].getElementsByTagName("price");

                                for (var j = 0; j < prices.length; j++) {
                                    var date = prices[j].getAttribute("date") //Get date Attribute
                                    var price = prices[j].childNodes[0].nodeValue; //Get price value
                                    table += "<tr><td>" + date + "</td><td>" + price + "</td></tr>"; // Add table row
                                }
                            }
                        }
                        document.getElementById("plantInformation").innerHTML = table;
                    }

                    <!-- neue Funktion mit xsl -->
                    function createPlantTable(xml, plantName) {
                        var xmlDoc = xml.responseXML;
                        var xsltDoc = new DOMParser().parseFromString(`
                            <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
                                <!-- declare xsl variable "plantName" -->
                                <xsl:variable name="plantName" select="'` + plantName + `'"/>
                                <xsl:template match="/">
                                
                                    <div class="w3-container">
                                        <table>
                                            <xsl:apply-templates select="document('../database/database.xml')/energie-data/energie-plant/plant[name=$plantName]"/>
                                            
                                            <tr>
                                                <th>Date</th>
                                                <th>Price</th>
                                            </tr>
                                            <!-- template auf jeden der Preise anwenden, um neue Zeile zu erstellen -->
                                            <!-- <xsl:apply-templates select="//plant[name=$plantName]/statistics/price"/> -->
                                            <xsl:apply-templates select="document('../database/database.xml')/energie-data/energie-plant/plant[name=$plantName]/statistics/price"/>
                                            
                                        </table>

                                    </div>

                                    
                                </xsl:template>

                                <xsl:template match="plant">
                                    <tr> 
                                        <!-- add the image located in img/{name}.png -->
                                        <img src="img/{name}.png" class="Wappen" alt="{name}" />
                                    </tr>
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

                    function displayWappen(plantName) {
                        console.log("displayWappen-Funktion aufgerufen")
                        var wappen = document.createElement('img');
                        wappen.src = 'img/' + plantName + '.png';
                        wappen.width = 500;
                        wappen.height = 600;
                        console.log(document.getElementById("plantInformation"))
                        document.getElementById("plantInformation").appendChild(img);
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