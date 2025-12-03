const fs = require('fs');
const path = require('path');
const xml2js = require('xml2js');

const folderPath = './'; // Change this to the path of your folder

// Function to process the NPC XML file
function processNPCFile(filePath) {
    fs.readFile(filePath, 'utf-8', (err, data) => {
        if (err) {
            console.error('Error reading file:', err);
            return;
        }

        // Parse XML to JSON
        xml2js.parseString(data, (err, result) => {
            if (err) {
                console.error(`Error parsing XML in file ${filePath}:`, err);
                return;
            }

            // Function to remove duplicate entries and extract only item IDs
            const removeDuplicatesAndExtractIds = (items) => {
                const uniqueItems = {};
                const uniqueItemIds = [];
                items.forEach(item => {
                    const [itemName, itemId, itemCost] = item.split(',').map(str => str.trim());
                    if (!uniqueItems[itemId]) {
                        uniqueItems[itemId] = true;
                        uniqueItemIds.push(itemId);
                    }
                });
                return uniqueItemIds;
            };

            const parameters = result.npc.parameters[0].parameter;

            // Remove duplicates and extract item IDs from shop_buyable
            const buyableItems = parameters.find(p => p.$.key === 'shop_buyable').$.value.split(';');
            const uniqueBuyableItemIds = removeDuplicatesAndExtractIds(buyableItems);
            parameters.find(p => p.$.key === 'shop_buyable').$.value = uniqueBuyableItemIds.join(';');

            // Remove duplicates and extract item IDs from shop_sellable
            const sellableItems = parameters.find(p => p.$.key === 'shop_sellable').$.value.split(';');
            const uniqueSellableItemIds = removeDuplicatesAndExtractIds(sellableItems);
            parameters.find(p => p.$.key === 'shop_sellable').$.value = uniqueSellableItemIds.join(';');

            // Convert JSON back to XML
            const builder = new xml2js.Builder();
            const modifiedXml = builder.buildObject(result);

            // Print modified XML to console
            console.log(modifiedXml);
        });
    });
}

// Find the NPC XML file and process it
const npcFilePath = path.join(folderPath, 'npc.xml');
fs.access(npcFilePath, fs.constants.F_OK, (err) => {
    if (err) {
        console.error('NPC XML file not found:', err);
        return;
    }
    processNPCFile(npcFilePath);
});
