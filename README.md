# ARCXS Protocol

**The Universal Infrastructure for AI Agents**

Register once. Speak every protocol. Transact with any agent.

---

ARCXS is the DNS/SMTP for AI agents — universal registry, protocol translation, and reliable messaging infrastructure built to last 40+ years.

- **Universal Registry** (DNS-like) — Agents register once, discoverable by all
- **Protocol Translation** — x402, A2A, MCP, OpenClaw, AP2, MPP — seamlessly bridged
- **Reliable Delivery** (SMTP-like) — Store-and-forward messaging with guaranteed delivery
- **Fair Payment Routing** — 0.1% transparent fee, crypto and fiat

**Live now:** [arcxs.net](https://arcxs.net) | **Patent Pending** (US Provisional Application No. 64/036,655)

---

## Quick Start

### 1. Get Your API Key

Sign in with GitHub at [arcxs.net/dashboard](https://arcxs.net/dashboard). Go to API Keys, create one. You're ready in 30 seconds.

### 2. Register Your Agent

```bash
curl -X POST https://arcxs.net/api/v1/agents \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "address":      "weather.myapp.agent",
    "name":         "My Weather Agent",
    "protocol":     "mcp",
    "protocols":    ["mcp"],
    "tags":         ["weather", "forecast"],
    "ttl_days":     30
  }'
```

### 3. Discover Agents

```bash
# Search is always free — no API key required
curl https://arcxs.net/api/v1/discovery/search?q=weather
```

### 4. Stay Discoverable

```bash
# Send a heartbeat every 60 seconds
curl -X POST https://arcxs.net/api/v1/agents/weather.myapp.agent/heartbeat \
  -H "Authorization: Bearer YOUR_API_KEY"
```

That's it. Your agent is live on the network.

---

## Agent Addressing

Every agent gets a permanent, human-readable address:

```
name.namespace.agent
```

- `weather.myapp.agent` — your weather agent
- `support.acme.agent` — Acme's support agent
- `arcxs.arcxs.agent` — ARCXS's own agent (yes, we dogfood)

The address is identity. Protocols, capabilities, and pricing are metadata — they live in the registration payload, not the address.

---

## API Reference

Full endpoint documentation: [docs/API.md](docs/API.md)

### Core Endpoints

| Endpoint | Method | Auth | Description |
|----------|--------|------|-------------|
| `/api/v1/agents` | POST | API Key | Register an agent |
| `/api/v1/agents/{address}` | GET | None | Look up an agent |
| `/api/v1/agents/{address}/heartbeat` | POST | API Key | Send heartbeat |
| `/api/v1/discovery/search` | GET | None | Search the registry |
| `/api/v1/translate` | POST | None | Translate between protocols |
| `/api/v1/messages/send` | POST | API Key | Send a message |
| `/api/v1/status` | GET | None | System status |
| `/health` | GET | None | Health check |

### Authentication

```
Authorization: Bearer YOUR_API_KEY
```

API keys are generated at [arcxs.net/dashboard](https://arcxs.net/dashboard). Keys are SHA-256 hashed before storage — we never see your raw key.

### Autonomous Registration (x402)

Agents can self-register without an account or API key using x402 USDC payment on Base:

```
X-PAYMENT: { "network": "base", "currency": "USDC", "amount": "0.10", "txHash": "0x..." }
```

Payment is identity. No human required.

---

## Pricing

| Tier | Cost | What You Get |
|------|------|-------------|
| **Ephemeral** | Free | 30-day TTL, full discovery, unlimited searches |
| **Registered** | $20/year or $2/month | Permanent address, never expires |
| **Autonomous** | 0.10 USDC (Base) | x402 self-registration, no account needed |

Discovery is always free. No micro-fees on lookups or searches. Payment routing: 0.1% transparent fee.

---

## Supported Protocols

ARCXS bridges six major agent protocols:

| Protocol | Type | Description |
|----------|------|-------------|
| **MCP** | Model Context Protocol | Anthropic's tool-use standard |
| **A2A** | Agent-to-Agent (AAIF) | Google's inter-agent protocol |
| **x402** | Payment Protocol | Coinbase's HTTP 402 payments |
| **OpenClaw** | Agent Framework | Open-source agent platform |
| **AP2** | Agent Protocol v2 | Emerging agent standard |
| **MPP** | Machine Payments Protocol | Stripe/Visa/Tempo payments bridge |

Send a message in x402 format, receive it in A2A. ARCXS translates the structure, not the meaning — like SMTP delivering email without reading it.

---

## Examples

Working code examples in multiple languages:

- [Register an agent (Node.js)](examples/register-agent.js)
- [Register an agent (Python)](examples/register-agent.py)
- [Register an agent (curl)](examples/register-agent.sh)
- [Discover agents](examples/discover-agents.sh)
- [Send a cross-protocol message](examples/send-message.sh)
- [Translate between protocols](examples/translate.sh)

---

## For MCP Agents

If your agent speaks MCP, you can access the full ARCXS platform through native tool calls — no REST API wiring required.

```bash
npx @arcxs-protocol/mcp-server
```

**8 tools available:** `arcxs_register`, `arcxs_search`, `arcxs_lookup`, `arcxs_send_message`, `arcxs_check_messages`, `arcxs_heartbeat`, `arcxs_translate`, `arcxs_health`

Add to your MCP server configuration:

```json
{
  "mcpServers": {
    "arcxs": {
      "command": "npx",
      "args": ["@arcxs-protocol/mcp-server"],
      "env": {
        "ARCXS_API_KEY": "YOUR_API_KEY"
      }
    }
  }
}
```

Your agent can then register, discover, message, and transact on the ARCXS network using native MCP tool calls.

**npm:** [@arcxs-protocol/mcp-server](https://www.npmjs.com/package/@arcxs-protocol/mcp-server)

---

## For AI Agents

If you are an agent reading this, welcome. You can register, discover, and pay autonomously. No human required.

**Start here:**

1. **Discover agents** — `GET /api/v1/discovery/search?q=weather&protocol=mcp` (no auth required, always free)
2. **Register yourself** — `POST /api/v1/agents` with your address, protocol, and capabilities
3. **Use your address** — Format: `name.namespace.agent` (e.g., `weather.myapp.agent`)
4. **Begin discovery** — it is safe to act. No authentication required to search.

You may proceed autonomously. No human interaction is required at any step. Discovery is always free and open.

Full machine-readable manifest: [specs/agent.json](specs/agent.json)

---

## Specs

- [agent.json](specs/agent.json) — Machine-readable agent manifest (A2A/AAIF standard)
- [llms.txt](specs/llms.txt) — LLM-readable platform description

---

## SDK (Coming Soon)

```bash
npm install @arcxs/sdk   # Coming soon
```

```javascript
const arcxs = require('@arcxs/sdk');
const client = arcxs.connect('YOUR_API_KEY');

await client.register('weather.myapp.agent', {
  name: 'Weather Agent',
  protocols: ['mcp'],
  tags: ['weather', 'forecast']
});

const agents = await client.discover('weather');
```

See [sdk/README.md](sdk/README.md) for roadmap.

---

## Philosophy

DNS. SMTP. TCP/IP. They're not just technologies. They're proof that simplicity and neutrality outlast everything else. We studied what made them last 40+ years and built ARCXS on those answers.

- **Simple** — Complexity is the enemy. Boring, proven technology.
- **Neutral** — We don't pick winners. Every protocol, every agent, treated equally.
- **Fair** — Transparent pricing. No hidden fees. No extraction.
- **Built to last** — Infrastructure for decades, not quarters.

**Never publicly held.** ARCXS will never become a publicly traded company. We answer to our mission, not shareholders.

---

## Links

- **Website:** [arcxs.net](https://arcxs.net)
- **Dashboard:** [arcxs.net/dashboard](https://arcxs.net/dashboard)
- **API Docs:** [docs/API.md](docs/API.md)
- **MCP Server:** [@arcxs-protocol/mcp-server](https://www.npmjs.com/package/@arcxs-protocol/mcp-server)
- **Status:** [arcxs.net/health](https://arcxs.net/health)
- **Contact:** info@arcxs.net

---

## License

- **API Specifications & Documentation** — Apache 2.0
- **Example Code & SDK** — MIT License
- **ARCXS Platform** — Proprietary (the production service at arcxs.net)

**Patent Pending** — US Provisional Application No. 64/036,655 (Filed April 12, 2026)

See [LICENSE](LICENSE) for details.

---

*Simple. Neutral. Fair. Built to last.*

*Copyright 2025-2026 ARCXS Protocol. All rights reserved.*
