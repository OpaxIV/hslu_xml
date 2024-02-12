const express = require('express')
const path = require('path')
const fs = require('fs')
const libxmljs = require('libxmljs2')
const app = express()

app.use(express.static(path.join(__dirname, 'xml-content'))); // search path for static content
app.use(express.text());
app.use(express.urlencoded({ extended: false }));

app.get('/', (req, res) => {
    res.sendFile(path.resolve('xml-content', 'index.xml')); // get the startpage
})




/* features implementations */

// feature 3: call FO service from HSLU and give req to server
app.post('/convertToPdf', async (req, res) => {
    const response = await fetch('https://fop.xml.hslu-edu.ch/fop.php', {
        method: "POST",
        mode: "cors",
        cache: "no-cache",
        credentials: "same-origin",
        body: req.body,
    });
    const responseText = await (await response.blob()).arrayBuffer()
    const buffer = Buffer.from(responseText)
    fs.writeFileSync(path.resolve('temp.pdf'), buffer) // temporary pdf
    res.sendFile(path.resolve('temp.pdf')) // send temporary pdf to client (link)
})

// feature 4: forum submission for adding more items to db
app.post('/updateData', (req, res) => {
    const dataToUpdate = req.body // obj containing our data (feature-03.xsl)
    // read database xml
    const databasePath = path.resolve('xml-content', 'database', 'database.xml');
    const databaseXml = fs.readFileSync(databasePath, 'utf-8') // read data from db
    const xmlDocDatabase = libxmljs.parseXml(databaseXml) // parse to doc
    // select node to update
    const plantStatistics = xmlDocDatabase.get(`//plant[name="${dataToUpdate.plant}"]/statistics`); // get node (plant) to update via XPath, // change in own project

    console.log(plantStatistics);

    // create new node with attribute etc.
    plantStatistics.node('price', dataToUpdate.price).attr('date', dataToUpdate.date) // change in own project

    console.log(xmlDocDatabase.toString())


    // remove existing nodes


    // update existing nodes



    // validate new database against schema
    const valid = validateDatabase(xmlDocDatabase)
    if (!valid) {
        res.status(400).send('Invalid XML')
        return
    }

    // write new database.xml
    fs.writeFileSync(databasePath, xmlDocDatabase.toString(), 'utf-8')

    res.sendStatus(200)
})

function validateDatabase(xmlDocDatabase) {
    const databaseXsd = fs.readFileSync(path.resolve('xml-content', 'database', 'database.xsd'), 'utf-8')
    const xmlDocDatabaseXsd = libxmljs.parseXml(databaseXsd)
    return xmlDocDatabase.validate(xmlDocDatabaseXsd)
}

app.listen(3000, () => {
    console.log('listen on port', 3000)
})
