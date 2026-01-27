# LeadGen Wave 1 — Write-path hardening (LEADGEN_03)

## Purpose

Wave 1 already provides:

- A running LeadGen API container behind Nginx
- A Wave 1 Postgres schema (`app.leads`)

**LEADGEN_03** hardens the write path so the API can accept real submissions and persist them safely.

## What LEADGEN_03 changes

### Database

Applies migration `20260126_02_wave1_write_path` which adds the following columns to `app.leads`:

- `intake_id` (TEXT) — stable external ID returned to the client
- `request_id` (TEXT) — correlation ID for logs/troubleshooting
- `idempotency_key` (TEXT) — DB-backed idempotency

And adds:

- Unique index on `idempotency_key`
- Unique index on `intake_id`

### API

The endpoint becomes operational:

- `POST /lead/intake`

Behavior:

- Requires `X-API-Key` (intake key)
- Accepts optional `Idempotency-Key`
  - If not provided, the API derives a stable hash from (lead_source + payload)
- Inserts exactly one row into `app.leads`
- Replays return the same `intake_id` (no duplicate rows)

### Environment

LEADGEN_03 ensures the env file includes canonical DB settings:

- `LEADGEN_DB_HOST`, `LEADGEN_DB_PORT`, `LEADGEN_DB_NAME`, `LEADGEN_DB_USER`, `LEADGEN_DB_PASSWORD`

## Operational notes

- Do not rotate Postgres credentials unless explicitly planned. The live container uses `/etc/motorcade/postgres.env`.
- Nginx remains frozen; LeadGen remains bound to `127.0.0.1:8000` and exposed publicly only through Nginx.

## Verification checklist

1) Health:

```bash
curl -sS http://127.0.0.1:8000/lead/health | jq
curl -sS https://motorcade.vip/api/lead/health | jq
```

2) Intake (example):

```bash
curl -sS -X POST https://motorcade.vip/api/lead/intake \
  -H "Content-Type: application/json" \
  -H "X-API-Key: <intake_key>" \
  -H "Idempotency-Key: demo-123" \
  -d '{
    "contact": {"full_name": "Demo User", "email": "demo@example.com", "phone": "+1-713-555-0101"},
    "request": {
      "service_type": "executive_protection",
      "timeline": {"start_local": "2026-01-27T10:00:00-06:00"},
      "location": {"state": "TX", "city": "Houston"},
      "notes": "Wave 1 write-path test"
    },
    "context": {"lead_source": "motorcade.vip"}
  }' | jq
```

3) Replay the same request with the same `Idempotency-Key`:

- Expect: same `intake_id` (no second row)

4) DB check:

```bash
sudo /usr/local/bin/podman exec motorcade-postgres \
  psql -U postgres -v ON_ERROR_STOP=1 -c "select created_at, intake_id, idempotency_key, source, email from app.leads order by created_at desc limit 5;"
```
