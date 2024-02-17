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
                    <h2>Choose between the powerplants you want to receive the data</h2>

                    <!-- dropdown for powerplants  -->
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

                    <!-- TBC content of the powerplants  -->



                </div>

            </body>
        </html>
    </xsl:template>

    <xsl:template match="plant">
        <li>
            <xsl:value-of select="name"/>
        </li>
    </xsl:template>

    <!-- Name of the powerplant  -->
    <xsl:template match="plant">
        <option><xsl:value-of select="name"/></option>
    </xsl:template>

</xsl:stylesheet>
