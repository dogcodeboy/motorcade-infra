# SESSION HANDOFF — motorcade-infra (LEADGEN_07B)

## Where we are
- LEADGEN_07B playbook successfully:
  - autodetects LeadGen repo root on host
  - fixes psycopg driver packaging (idempotent)
  - rebuilds container image using argv-safe Podman command
  - restarts LeadGen API systemd service cleanly
  - posts Wave3-schema intake payload and receives `202 Accepted`

## Critical clarification (source of confusion)
- `/lead/health` currently reports `queue=stub`.
- Prior sessions suggested a queue must be enabled for persistence; this is **not authoritative**.
- **Authoritative contract:** intake must be durable to Postgres before returning success (200/201/202/409). Queue/Redis is optional and must not gate persistence verification.

## Next playbook to create
- `LEADGEN_07C_wave3_intake_persistence_verify_postgres.yml` (name suggestion)
  - After POST, query Postgres for row by `idempotency_key` / `request_id`
  - Fail if not present within a bounded timeout (e.g., 5–10s max) with actionable logs.

## Notes
- Inventory host is `motorcade-web-01` (never `motorcade_web`)
- Podman locked path is `/usr/local/bin/podman`
- Vault file is `ansible/group_vars/motorcade/vault.yml` and playbooks run with `--ask-vault-pass`
