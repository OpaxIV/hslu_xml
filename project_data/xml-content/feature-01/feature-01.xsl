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
                                <!-- XPath abfrage im Dokument -->
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
                    <!-- test eintrag-->
                    <label id="test" />
                </div>

                <script>
                    <![CDATA[
                    function loadPlant() { //Capture the selected plant name
                        var xmlHttp = new XMLHttpRequest();
                        var plantName = document.getElementById('plant-input').value;
                        xmlHttp.onreadystatechange = function () {
                            if (this.readyState == 4 && this.status == 200) {
                                createPlantTable(this, plantName);
                            }
                        };
                        xmlHttp.open("GET", "../database/database.xml", true);
                        xmlHttp.send();
                    }

                    function createPlantTable(xml, plantName) {
                        var xmlDoc = xml.responseXML;
                        var table = "<tr><th>Date</th><th>Price</th></tr>";
                        var xpath = "/energie-data/energie-plant/plant[name='" + plantName + "']/price";
                        var prices = xmlDoc.evaluate(xpath, xmlDoc, null, XPathResult.ORDERED_NODE_ITERATOR_TYPE, null);
                        var price = prices.iterateNext();

                        while (price) {
                            var date = price.getAttribute("date"); // Hole das 'date'-Attribut
                            var priceValue = price.textContent; // Hole den Textinhalt, der den Preis darstellt
                            table += "<tr><td>" + date + "</td><td>" + priceValue + "</td></tr>";
                            price = prices.iterateNext();
                        }

                        // Aktualisieren Sie die Tabelle im DOM
                        document.getElementById("plantInformation").innerHTML = table;
                        document.getElementById("test").innerHTML = price;
                    }

                    //TODO not working yet displaying wappen, for each kanton in the list different logo
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