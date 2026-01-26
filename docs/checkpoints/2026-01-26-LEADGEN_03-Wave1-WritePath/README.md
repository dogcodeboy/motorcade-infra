# CHECKPOINT — 2026-01-26 — LEADGEN_03 — Wave 1 Write-Path Hardening

This checkpoint upgrades LeadGen Wave 1 from **health-only** to a **production-safe intake write path**.

## Included

- DB migration: `ansible/files/leadgen/20260126_02_wave1_write_path.sql`
  - Adds columns to `app.leads`: `intake_id`, `request_id`, `idempotency_key`
  - Adds unique indexes on `idempotency_key` and `intake_id`
- Playbook: `ansible/playbooks/LEADGEN_03_wave1_write_path_hardening.yml`
  - Applies the migration
  - Writes canonical `LEADGEN_DB_*` variables to `/etc/motorcade/leadgen.env`
  - Rebuilds the LeadGen API image and restarts `motorcade-leadgen-api.service`
- Docs: `docs/leadgen/WAVE1_WRITE_PATH_HARDENING.md`

## Verified outcomes

- `POST /lead/intake` persists to Postgres (`app.leads`)
- Duplicate submits using the same `Idempotency-Key` do not create a second row
- Health continues to work locally and via Nginx

See `VERIFY.md` for exact commands.
