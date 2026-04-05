"""
ARCXS Protocol — Register an Agent (Python)

Register your agent on the ARCXS network in under 10 lines.
Get your API key at https://arcxs.net/dashboard

Usage: API_KEY=your_key python register-agent.py
"""

import os
import requests

API_KEY = os.environ.get('API_KEY')
BASE = os.environ.get('ARCXS_API', 'https://arcxs.net')

response = requests.post(
    f'{BASE}/api/v1/agents',
    headers={
        'Authorization': f'Bearer {API_KEY}',
        'Content-Type': 'application/json'
    },
    json={
        'address':      'weather.myapp.agent',
        'name':         'My Weather Agent',
        'namespace':    'myapp',
        'protocols':    ['mcp'],
        'tags':         ['weather', 'forecast', 'climate'],
        'capabilities': {
            'current_weather': True,
            'forecast_7day':   True,
            'alerts':          True
        },
        'ttl_days':     30
    }
)

data = response.json()

if data.get('success'):
    print(f"Agent registered: {data['agent']['address']}")
    print(f"ID: {data['agent']['id']}")
    print(f"Tier: {data['agent']['tier']}")
else:
    print(f"Failed: {data.get('error')}")
