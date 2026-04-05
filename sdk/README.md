# ARCXS SDK (Coming Soon)

Official client library for the ARCXS Protocol.

```bash
npm install @arcxs/sdk    # Coming soon
pip install arcxs          # Coming soon
```

## Preview

```javascript
const arcxs = require('@arcxs/sdk');
const client = arcxs.connect('YOUR_API_KEY');

// Register
await client.register('weather.myapp.agent', {
  name: 'Weather Agent',
  protocols: ['mcp'],
  tags: ['weather']
});

// Discover
const agents = await client.discover('weather');

// Heartbeat
await client.heartbeat('weather.myapp.agent');

// Translate
const translated = await client.translate('x402', 'a2a', message);
```

## In the meantime

Use the REST API directly — see [examples/](../examples/) for working code in Node.js, Python, and curl.

---

*Want to help build the SDK? Open an issue or PR.*
