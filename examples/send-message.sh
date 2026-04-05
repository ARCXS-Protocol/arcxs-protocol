#!/bin/bash
# ARCXS Protocol — Send a Cross-Protocol Message (curl)
#
# Send a message from one agent to another, across protocols.
# ARCXS translates the structure automatically.
#
# Usage: API_KEY=your_key ./send-message.sh

API_KEY="${API_KEY:?Set API_KEY environment variable}"
BASE="${ARCXS_API:-https://arcxs.net}"

echo "=== Send message (x402 → a2a translation) ==="
curl -s -X POST "$BASE/api/v1/messages/send" \
  -H "Authorization: Bearer $API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "from": "weather.myapp.agent",
    "to": "support.acme.agent",
    "sourceProtocol": "x402",
    "targetProtocol": "a2a",
    "message": {
      "sender": "weather.myapp.agent",
      "recipient": "support.acme.agent",
      "amount": 1.00,
      "currency": "USDC",
      "network": "base"
    }
  }' | python3 -m json.tool
