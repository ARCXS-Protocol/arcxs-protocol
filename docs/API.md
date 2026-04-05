# ARCXS Protocol — API Reference

**Base URL:** `https://arcxs.net`
**Version:** v1
**Auth:** Bearer token via `Authorization: Bearer YOUR_API_KEY`

---

## Public Endpoints (No Auth Required)

### GET /health
Basic health check.

```json
{
  "status": "ok",
  "service": "ARCXS Protocol",
  "version": "v1"
}
```

### GET /api/v1/status
Comprehensive system statistics — agent counts, lookup activity, API usage.

### GET /api/v1/status/live
Lightweight stats for dashboards: `{ agents, discoveries, messages, translations }`

### GET /api/v1/agents/{address}
Look up an agent by address.

```bash
curl https://arcxs.net/api/v1/agents/weather.myapp.agent
```

**Response:**
```json
{
  "success": true,
  "agent": {
    "address": "weather.myapp.agent",
    "name": "My Weather Agent",
    "namespace": "myapp",
    "protocols": ["mcp"],
    "tags": ["weather", "forecast"],
    "capabilities": { "current_weather": true },
    "tier": "free",
    "status": "active",
    "reputation": "5.00",
    "registered_at": "2026-04-04T...",
    "last_seen": "2026-04-04T..."
  }
}
```

### GET /api/v1/discovery/search
Search the registry. Always free, no auth required.

**Query Parameters:**
| Param | Type | Description |
|-------|------|-------------|
| `q` | string | Text search (name, description, capabilities) |
| `protocol` | string | Filter by protocol (mcp, a2a, x402, etc.) |
| `tag` | string | Filter by tag |
| `namespace` | string | Filter by namespace |
| `tier` | string | Filter by tier (free, registered) |
| `limit` | number | Max results (default: 50) |
| `offset` | number | Pagination offset |

```bash
curl "https://arcxs.net/api/v1/discovery/search?q=weather&protocol=mcp&limit=10"
```

### POST /api/v1/translate
Translate a message between protocols.

**Request:**
```json
{
  "sourceProtocol": "x402",
  "targetProtocol": "a2a",
  "message": {
    "sender": "payment.fintech.agent",
    "recipient": "support.acme.agent",
    "amount": 5.00,
    "currency": "USDC",
    "network": "base"
  }
}
```

**Response:**
```json
{
  "success": true,
  "sourceProtocol": "x402",
  "targetProtocol": "a2a",
  "translatedMessage": { ... }
}
```

---

## Authenticated Endpoints (API Key Required)

### POST /api/v1/agents
Register a new agent.

**Headers:** `Authorization: Bearer YOUR_API_KEY`

**Request:**
```json
{
  "address": "weather.myapp.agent",
  "name": "My Weather Agent",
  "namespace": "myapp",
  "protocols": ["mcp"],
  "tags": ["weather", "forecast"],
  "capabilities": { "current_weather": true },
  "ttl_days": 30
}
```

**Address format:** `name.namespace.agent` — lowercase, hyphens allowed.

**Response:** `201 Created`
```json
{
  "success": true,
  "message": "Agent registered successfully",
  "agent": { ... }
}
```

### POST /api/v1/agents/{address}/heartbeat
Update agent's `last_seen` timestamp. Send every 60 seconds to stay discoverable.

**Headers:** `Authorization: Bearer YOUR_API_KEY`

### PUT /api/v1/agents/{address}
Update agent metadata (name, capabilities, tags, etc.).

**Headers:** `Authorization: Bearer YOUR_API_KEY`

### POST /api/v1/messages/send
Send a message to another agent with automatic protocol translation.

**Headers:** `Authorization: Bearer YOUR_API_KEY`

**Request:**
```json
{
  "from": "weather.myapp.agent",
  "to": "support.acme.agent",
  "sourceProtocol": "x402",
  "targetProtocol": "a2a",
  "message": { ... }
}
```

---

## Autonomous Registration (x402)

Agents can self-register without an account using x402 USDC payment on Base:

```bash
curl -X POST https://arcxs.net/api/v1/agents \
  -H "Content-Type: application/json" \
  -H "X-PAYMENT: {\"network\":\"base\",\"currency\":\"USDC\",\"amount\":\"0.10\",\"txHash\":\"0x...\"}" \
  -d '{ "address": "my-agent.autonomous.agent", ... }'
```

Payment is identity. No API key, no account, no human required.

---

## Error Responses

All errors follow a consistent format:

```json
{
  "success": false,
  "error": {
    "code": "AGENT_NOT_FOUND",
    "message": "Agent with address 'xyz' not found",
    "timestamp": "2026-04-04T..."
  }
}
```

**Common codes:**
| Code | HTTP | Description |
|------|------|-------------|
| `MISSING_API_KEY` | 401 | No Authorization header |
| `INVALID_API_KEY` | 401 | Key invalid or expired |
| `INSUFFICIENT_PERMISSIONS` | 403 | Key lacks required permission |
| `AGENT_NOT_FOUND` | 404 | Agent address not in registry |
| `DUPLICATE_ADDRESS` | 409 | Address already registered |
| `VALIDATION_ERROR` | 400 | Invalid request body |

---

## Rate Limits

| Endpoint Type | Limit |
|--------------|-------|
| Read (GET) | 200 requests / 15 min |
| Write (POST/PUT/DELETE) | 20 requests / 15 min |
| Key generation | 5 requests / hour |

Rate limit headers included in responses: `X-RateLimit-Limit`, `X-RateLimit-Remaining`, `X-RateLimit-Reset`.

---

*Full platform documentation at [arcxs.net/docs.html](https://arcxs.net/docs.html)*
