"""New Business Registrations - Python example.

pip install apify-client
export APIFY_TOKEN=your_token
"""
import os

from apify_client import ApifyClient

client = ApifyClient(os.environ["APIFY_TOKEN"])

# Connecticut businesses with an email, last 7 days
run = client.actor("Turboextract/new-business-registrations").call(run_input={
    "states": [
        "CT"
    ],
    "daysBack": 7,
    "requireEmail": True
})

# Stream every item
for item in client.dataset(run["defaultDatasetId"]).iterate_items():
    print(item.get("registeredDate"), item.get("state"), item.get("company"), item.get("email"))

# Or fetch one page of items
page = client.dataset(run["defaultDatasetId"]).list_items(limit=100)
print(f"{page.total} items in dataset")
