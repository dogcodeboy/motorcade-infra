# SESSION HANDOFF — motorcade-infra (LEADGEN_03 Wave 1 write-path hardening)

## Status

Wave 1 LeadGen is now **read/write**:

- `POST https://motorcade.vip/api/lead/intake` persists to Postgres (`app.leads`)
- DB-backed idempotency prevents duplicate inserts (unique `idempotency_key`)
- Health remains OK locally and through Nginx

## What was done

- Added Wave 1 DB hardening migration: `20260126_02_wave1_write_path`
  - Adds columns: `intake_id`, `request_id`, `idempotency_key`
  - Adds unique indexes on `idempotency_key` and `intake_id`

- Added playbook: `ansible/playbooks/LEADGEN_03_wave1_write_path_hardening.yml`
  - Applies the migration in `motorcade-postgres`
  - Writes canonical `LEADGEN_DB_*` vars to `/etc/motorcade/leadgen.env`
  - Rebuilds the LeadGen API image and restarts `motorcade-leadgen-api.service`

- Fixed `LEADGEN_02_wave1_api_deploy.yml`
  - Uses inventory group `motorcade` (no `motorcade_web`)
  - Builds the correct image context (`/opt/motorcade-leadgen/app/api`)
  - Writes canonical DB env vars (`LEADGEN_DB_*`) while keeping `POSTGRES_PASSWORD` for backward compatibility

## Gotchas

- Do NOT rotate `vault_postgres_password` unless we explicitly plan a rotation. Existing data uses `/etc/motorcade/postgres.env`.
- Do NOT unzip checkpoint zips on the EC2 host. Merge into local repo, commit, then deploy with Ansible.

## Next suggested step

- LEADGEN Wave 2: introduce a minimal admin UI/endpoint for triage + export, and/or wire queue/notification behaviors (Redis-backed) for alerting.
