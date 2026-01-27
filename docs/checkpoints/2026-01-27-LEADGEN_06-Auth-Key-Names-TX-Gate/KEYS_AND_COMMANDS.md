# LeadGen API keys — names + safe inspection

## Canonical key used by API middleware
- The API expects an **`X-API-Key`** header.
- Operationally, the header should use the **canonical** runtime variable: `LEADGEN_API_KEY`.

## Key variable names present in `/etc/motorcade/leadgen.env`
Names only (no values):
- `LEADGEN_API_KEY`
- `LEADGEN_ADMIN_API_KEY`
- `LEADGEN_INTAKE_API_KEY`

> Note: there may be **vault-side** aliases (example: `vault_leadgen_api_key_canonical`) that map to an existing secret (often the intake key). The container/runtime contract is the three env vars above.

## Show key names only (values redacted)
On the server:

```bash
sudo bash -lc '
  set -a
  source /etc/motorcade/leadgen.env
  set +a
  env | egrep -E "^LEADGEN_.*KEY" | sort | sed "s/=.*$/=<redacted>/"
'
```

## Check if a key is set (prints yes/no only)
```bash
sudo bash -lc '
  set -a
  source /etc/motorcade/leadgen.env
  set +a
  test -n "$LEADGEN_API_KEY" && echo "LEADGEN_API_KEY: yes" || echo "LEADGEN_API_KEY: no"
'
```

## Use the key for an intake call (value not echoed)
```bash
API_KEY="$(sudo bash -lc 'set -a; source /etc/motorcade/leadgen.env; set +a; printf "%s" "$LEADGEN_API_KEY"')"
IDEM="test_$(date +%s)"

curl -sS http://127.0.0.1:8000/lead/intake \
  -H 'content-type: application/json' \
  -H "idempotency-key: $IDEM" \
  -H "X-API-Key: $API_KEY" \
  -d '{
    "contact": {"full_name":"Test Lead TX"},
    "request": {
      "service_type":"executive_protection",
      "timeline": {"start_local":"2026-01-27"},
      "location": {"state":"TX"},
      "recurrence":"one_time"
    },
    "context": {"lead_source":"server_test"}
  }'
```
