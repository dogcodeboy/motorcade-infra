# LEADGEN_07B — Wave 3 DB Driver + Persistence Contract (v3)

Purpose:
- Ensure the LeadGen API container includes a Postgres driver (psycopg v3) so DB writes can succeed.
- Rebuild the image and restart the systemd unit.
- Run an E2E intake request against `POST /lead/intake` using the **current Wave 3 schema** and confirm the lead is persisted in Postgres.

Key fixes in this revision:
- Payload updated to satisfy Wave 3 API schema (`request.timeline` object required).
- `request.service_type` set to a valid enum value (`armed_security`).
- Added `Idempotency-Key` header (kept idempotency key in body meta as well).
- Removed fragile regex escapes in psycopg detection (no `\s`/`\b` usage).
- Health check now waits for systemd active + port open before HTTP GET.

Expected outcome:
- `/lead/health` returns HTTP 200.
- Intake returns HTTP 202 Accepted.
- `app.leads` gains **>= 1** row for the generated unique email (poll until present).
