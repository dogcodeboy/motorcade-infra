# Verify (Manual)

These are the same checks the playbook performs.

## Health

```bash
curl -fsS http://127.0.0.1:8000/lead/health | jq .
```

## Intake (TX-only)

Use the intake key and a unique email:

```bash
export KEY="<redacted>"
export EMAIL="e2e-$(uuidgen)@example.com"

curl -fsS -X POST http://127.0.0.1:8000/lead/intake \
  -H "Content-Type: application/json" \
  -H "X-API-Key: $KEY" \
  -H "Idempotency-Key: $(uuidgen)" \
  -d '{
    "contact": {"full_name":"E2E Persistence Test","email":"'"$EMAIL"'","phone":"+15551234567"},
    "request": {"service_type":"armed_security","timeline":{"mode":"flexible","start_local":"'"$(date -u +%Y-%m-%dT%H:%M:%SZ)"'"},
      "location":{"city":"Houston","state":"TX"},
      "service_state":"TX","service_city":"Houston",
      "requested_start_utc":"'"$(date -u +%Y-%m-%dT%H:%M:%SZ)"'",
      "notes":"LEADGEN_07 persistence verify"
    }
  }' | jq .
```

## DB check

```bash
sudo /usr/local/bin/podman exec motorcade-postgres psql -U postgres -d motorcade -tAc \
  "SELECT count(*) FROM app.leads WHERE email = '$EMAIL';"
```

Expected: `>= 1`
