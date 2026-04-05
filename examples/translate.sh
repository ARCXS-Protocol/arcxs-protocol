#!/bin/bash
# ARCXS Protocol — Protocol Translation (curl)
#
# Translate a message between any two supported protocols.
# No API key required for translation.
#
# Usage: ./translate.sh

BASE="${ARCXS_API:-https://arcxs.net}"

echo "=== Translate x402 → A2A ==="
curl -s -X POST "$BASE/api/v1/translate" \
  -H "Content-Type: application/json" \
  -d '{
    "sourceProtocol": "x402",
    "targetProtocol": "a2a",
    "message": {
      "sender": "payment.fintech.agent",
      "recipient": "support.acme.agent",
      "amount": 5.00,
      "currency": "USDC",
      "network": "base"
    }
  }' | python3 -m json.tool

echo ""
echo "=== Translate MCP → OpenClaw ==="
curl -s -X POST "$BASE/api/v1/translate" \
  -H "Content-Type: application/json" \
  -d '{
    "sourceProtocol": "mcp",
    "targetProtocol": "openclaw",
    "message": {
      "jsonrpc": "2.0",
      "id": 1,
      "method": "tools/call",
      "agentId": "analyzer.devtools.agent",
      "params": {
        "name": "analyze",
        "arguments": { "query": "test" }
      }
    }
  }' | python3 -m json.tool
