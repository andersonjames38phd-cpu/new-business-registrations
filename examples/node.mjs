// New Business Registrations - Node.js example
// npm install apify-client
// APIFY_TOKEN=your_token node node.mjs
import { ApifyClient } from 'apify-client';

const client = new ApifyClient({ token: process.env.APIFY_TOKEN });

// New construction and roofing companies in NY and CO
const run = await client.actor('Turboextract/new-business-registrations').call({
    "states": [
        "NY",
        "CO"
    ],
    "nameKeywords": [
        "construction",
        "roofing"
    ],
    "daysBack": 14
});

const { items } = await client.dataset(run.defaultDatasetId).listItems();
for (const item of items) {
    console.log(item.registeredDate, item.state, item.company, item.email);
}
