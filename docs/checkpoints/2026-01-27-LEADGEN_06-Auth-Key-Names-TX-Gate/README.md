# Checkpoint: 2026-01-27 — LEADGEN_06 Auth + Key Names + TX Gate

Goal
- Confirm LeadGen API is healthy.
- Confirm `/lead/intake` is protected by `X-API-Key`.
- Capture **API key variable names** (names only, no values) and the safe inspection commands.
- Confirm the v1 **Texas-only** validation gate is working.

What we verified on-server
- `GET /lead/health` returns `status=ok`.
- `POST /lead/intake` requires `X-API-Key` (returns `UNAUTHORIZED` without it).
- With `X-API-Key` present, payload validates and the API enforces `request.location.state == "TX"` (returns `VALIDATION_ERROR` for non-TX states).

Notes
- Postgres schema exists (`app.leads`) and the LeadGen API can reach Postgres over the Podman network.
- In Wave 1, `/lead/health` reports `queue=stub`. Depending on the current codepath, a `202 Accepted` response may not immediately insert into `app.leads` (stub queue / async behavior). Treat DB persistence as a separate verification item.

Files / references
- Playbook used: `ansible/playbooks/LEADGEN_06_configure_api_keys.yml`
- Env file: `/etc/motorcade/leadgen.env`
- Service: `motorcade-leadgen-api.service`
