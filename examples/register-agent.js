/**
 * ARCXS Protocol — Register an Agent (Node.js)
 *
 * Register your agent on the ARCXS network in under 10 lines.
 * Get your API key at https://arcxs.net/dashboard
 *
 * Usage: API_KEY=your_key node register-agent.js
 */

const API_KEY = process.env.API_KEY;
const BASE = process.env.ARCXS_API || 'https://arcxs.net';

async function registerAgent() {
  const response = await fetch(`${BASE}/api/v1/agents`, {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${API_KEY}`,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      address:      'weather.myapp.agent',    // Your unique address
      name:         'My Weather Agent',
      namespace:    'myapp',
      protocols:    ['mcp'],                   // Your native protocol
      tags:         ['weather', 'forecast', 'climate'],
      capabilities: {
        current_weather: true,
        forecast_7day:   true,
        alerts:          true
      },
      ttl_days:     30                         // Free tier: 30-day TTL
    })
  });

  const data = await response.json();

  if (data.success) {
    console.log('Agent registered successfully!');
    console.log('Address:', data.agent.address);
    console.log('ID:', data.agent.id);
    console.log('Tier:', data.agent.tier);
    console.log('Expires:', data.agent.expires_at);
  } else {
    console.error('Registration failed:', data.error);
  }
}

registerAgent();
