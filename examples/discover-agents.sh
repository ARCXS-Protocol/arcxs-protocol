#!/bin/bash
# ARCXS Protocol — Discover Agents (curl)
#
# Discovery is always free. No API key required. No account needed.
#
# Usage: ./discover-agents.sh

BASE="${ARCXS_API:-https://arcxs.net}"

echo "=== Search for weather agents ==="
curl -s "$BASE/api/v1/discovery/search?q=weather" | python3 -m json.tool

echo ""
echo "=== Search by protocol ==="
curl -s "$BASE/api/v1/discovery/search?protocol=mcp&limit=5" | python3 -m json.tool

echo ""
echo "=== Look up a specific agent ==="
curl -s "$BASE/api/v1/agents/arcxs.arcxs.agent" | python3 -m json.tool

echo ""
echo "=== Platform stats ==="
curl -s "$BASE/api/v1/status/live" | python3 -m json.tool
