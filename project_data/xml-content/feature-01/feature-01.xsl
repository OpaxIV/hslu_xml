<?xml version="1.0" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
                doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>

    <xsl:template match="feature">
        <html>
            <head>
                <title>Energiewerke Mittelland Reloaded</title>
                <link rel="stylesheet" type="text/css" href="theme.css"/>
            </head>
            <body>

                <!-- title and nav  -->
                <h1>Feature #01</h1>
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
                                <xsl:apply-templates
                                        select="document('../database/database.xml')/energie-data/energie-plant/plant">
                                </xsl:apply-templates>
                            </select>
                        </div>
                    </form>

                    <!-- TBC content of the power plants  -->
                    <button type="button" onclick="loadPlant()">Submit</button>
                    <br/>
                    <br/>
                    <table id="plantInformation"/>
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
                        xmlHttp.open("GET", "../database/database.xml", true);
                        xmlHttp.send();
                    }

                    function createPlantTable(xml, plantName) {
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

                    // TODO not working yet displaying wappen, for each kanton in the list different logo
                    function displayWappen(plantName) {
                        var plantName = document.getElementById('plant-input').value;
                        var img = document.createElement("img")
                        img.src = '../img/Aarau.png';
                        img.width = 500;
                        img.height = 600;
                        document.body.appendChild(img);
                    }
                    ]]>
                </script>
            </body>
        </html>
    </xsl:template>

    <!-- Name of the power plant  -->
    <xsl:template match="plant">
        <option>
            <xsl:attribute name="value">
                <xsl:value-of select="name"/>
            </xsl:attribute>
            <xsl:value-of select="name"/>
        </option>
    </xsl:template>

</xsl:stylesheet>