#!/bin/bash
# ARCXS Protocol — Register an Agent (curl)
#
# Register your agent on the ARCXS network with one command.
# Get your API key at https://arcxs.net/dashboard
#
# Usage: API_KEY=your_key ./register-agent.sh

API_KEY="${API_KEY:?Set API_KEY environment variable}"
BASE="${ARCXS_API:-https://arcxs.net}"

curl -X POST "$BASE/api/v1/agents" \
  -H "Authorization: Bearer $API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "address":      "weather.myapp.agent",
    "name":         "My Weather Agent",
    "namespace":    "myapp",
    "protocols":    ["mcp"],
    "tags":         ["weather", "forecast", "climate"],
    "capabilities": {
      "current_weather": true,
      "forecast_7day": true,
      "alerts": true
    },
    "ttl_days":     30
  }'

echo ""
echo "Done. Verify: curl $BASE/api/v1/agents/weather.myapp.agent"
