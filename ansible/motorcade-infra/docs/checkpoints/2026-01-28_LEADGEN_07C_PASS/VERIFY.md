# LEADGEN_07C — Verification (PASS)

All commands are intended to run on **motorcade-web-01**.

## 0) Quick health

```bash
curl -fsS http://127.0.0.1:8000/lead/health | jq .
systemctl --no-pager --full status motorcade-leadgen-api.service | sed -n '1,80p'
systemctl --no-pager --full status motorcade-leadgen-worker.service | sed -n '1,80p'
```

## 1) Worker stopped: intake still returns 202 and jobs accumulate

```bash
sudo systemctl stop motorcade-leadgen-worker.service

API_KEY="$(sudo bash -lc 'set -a; source /etc/motorcade/leadgen.env; set +a; printf "%s" "${LEADGEN_API_KEY:-}"')"
IDEM="e2e_$(date +%s)"

curl -sS -X POST http://127.0.0.1:8000/lead/intake \
  -H "X-API-Key: ${API_KEY}" \
  -H "Idempotency-Key: ${IDEM}" \
  -H "Content-Type: application/json" \
  -d '{
    "contact": {"full_name":"E2E Test","email":"e2e-'"$(date +%s)'"@example.com","phone":"+12125550123","preferred_contact_method":"email"},
    "request": {"service_type":"armed_escort_driver","timeline":{"start_local":"2026-02-01 09:00","end_local":"2026-02-01 19:00"},"location":{"street":"123 Demo St","city":"Houston","state":"TX","postal_code":"77002"},"site_type":"commercial","notes":"E2E payload","recurrence":"one_time","expected_hours":10},
    "context": {"lead_source":"ansible-e2e"}
  }' | jq .

sudo /usr/local/bin/podman exec -i motorcade-postgres psql -U postgres -d motorcade -c \
  "select status, count(*) from app.intake_jobs group by status order by status;"
```

Expected:
- Intake returns **202 Accepted**
- `app.intake_jobs` shows at least one row in status `queued`

## 2) Start worker: jobs drain and leads are written

```bash
sudo systemctl start motorcade-leadgen-worker.service

# Watch queued count fall (repeat a few times)
sudo /usr/local/bin/podman exec -i motorcade-postgres psql -U postgres -d motorcade -c \
  "select status, count(*) from app.intake_jobs group by status order by status;"

sudo /usr/local/bin/podman exec -i motorcade-postgres psql -U postgres -d motorcade -c \
  "select count(*) as lead_rows, max(created_at) as newest from app.leads;"
```

Expected:
- `queued` goes to 0 (or decreases) and `done` increases
- `app.leads` count and newest timestamp update

## 3) Idempotency

```bash
# Re-submit same IDEM and payload: should not create an additional job

curl -sS -X POST http://127.0.0.1:8000/lead/intake \
  -H "X-API-Key: ${API_KEY}" \
  -H "Idempotency-Key: ${IDEM}" \
  -H "Content-Type: application/json" \
  -d '{
    "contact": {"full_name":"E2E Test","email":"same@example.com","phone":"+12125550123","preferred_contact_method":"email"},
    "request": {"service_type":"armed_escort_driver","timeline":{"start_local":"2026-02-01 09:00","end_local":"2026-02-01 19:00"},"location":{"street":"123 Demo St","city":"Houston","state":"TX","postal_code":"77002"},"site_type":"commercial","notes":"E2E payload","recurrence":"one_time","expected_hours":10},
    "context": {"lead_source":"ansible-e2e"}
  }' | jq .

sudo /usr/local/bin/podman exec -i motorcade-postgres psql -U postgres -d motorcade -c \
  "select count(*) from app.intake_jobs where idempotency_key='${IDEM}';"
```

Expected:
- count remains **1** for that idempotency key
