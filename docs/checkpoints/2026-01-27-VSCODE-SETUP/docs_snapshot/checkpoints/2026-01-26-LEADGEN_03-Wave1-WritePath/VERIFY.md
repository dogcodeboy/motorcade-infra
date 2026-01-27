# Verification commands (server)

Run on `motorcade-web-01`.

```bash
# Service and logs
sudo systemctl status motorcade-leadgen-api --no-pager
sudo /usr/local/bin/podman logs --tail 200 motorcade-leadgen-api

# Listener and health (host bind)
sudo ss -lntp | egrep '(:8000)' || true
curl -sS http://127.0.0.1:8000/lead/health | jq
curl -sS https://motorcade.vip/api/lead/health | jq

# Intake smoke test (replace <intake_key>)
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

# Replay the same Idempotency-Key (expect same intake_id)
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

# DB check (confirm intake_id + idempotency_key populated)
sudo /usr/local/bin/podman exec motorcade-postgres \
  psql -U postgres -v ON_ERROR_STOP=1 -c "select created_at, intake_id, idempotency_key, source, email from app.leads order by created_at desc limit 5;"

# Schema check (confirm columns exist)
sudo /usr/local/bin/podman exec motorcade-postgres \
  psql -U postgres -v ON_ERROR_STOP=1 -c "\d app.leads"
