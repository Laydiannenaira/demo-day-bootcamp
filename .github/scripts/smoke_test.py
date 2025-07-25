# scripts/smoke_test.py
import requests

try:
    resp = requests.get('http://localhost:8000/health')
    if resp.status_code != 200:
        print('Smoke test falhou: status', resp.status_code)
        exit(1)
    print('✅ Smoke test passou!')
except Exception as e:
    print('Smoke test falhou com erro:', e)
    exit(1)