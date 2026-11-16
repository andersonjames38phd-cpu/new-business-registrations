#!/usr/bin/env bash
# New Business Registrations - curl examples
# Replace YOUR_TOKEN with an Apify API token (https://console.apify.com/account/integrations).

set -euo pipefail

ACTOR="Turboextract~new-business-registrations"
TOKEN="${APIFY_TOKEN:-YOUR_TOKEN}"

# 1. Connecticut businesses with an email, last 7 days (start a run)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/runs?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "states": [
      "CT"
    ],
    "daysBack": 7,
    "requireEmail": true
  }'

# 2. New construction and roofing companies in NY and CO (start a run)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/runs?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "states": [
      "NY",
      "CO"
    ],
    "nameKeywords": [
      "construction",
      "roofing"
    ],
    "daysBack": 14
  }'

# 3. Every new business in Denver this week (wait and get the dataset items in one call)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/run-sync-get-dataset-items?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "states": [
      "CO"
    ],
    "cities": [
      "Denver"
    ],
    "daysBack": 7,
    "maxResults": 1000
  }'
