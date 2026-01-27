# SESSION_HANDOFF — motorcade-infra (Authoritative)

Date: 2026-01-21  
Checkpoint: `docs/checkpoints/2026-01-21-PLAT_03B-Postgres-Schema-Roles/`

Status
PLAT_03B COMPLETE.

Summary
- Added PLAT_03 playbook to create Postgres **roles + database + schema** via `podman exec`
- Uses `psql -U postgres` to avoid the `role "root" does not exist` failure mode
- Pulls DB passwords from encrypted vault: `ansible/group_vars/motorcade/vault.yml`
- Preserves systemd-first + boot-disabled policy for `motorcade-postgres`

Decisions (Locked)
- Rootful Podman on Amazon Linux 2023
- systemd-first service management
- Canonical platform root: `/srv/motorcade`
- Postgres does not auto-start on boot
- No application wiring beyond PLAT_03

Vault requirements
Add these encrypted vars to `ansible/group_vars/motorcade/vault.yml` (16+ chars recommended):
- `vault_motorcade_app_db_password`
- `vault_motorcade_ro_db_password`
- `vault_motorcade_migrator_db_password`

Verification
- Run: `ansible-playbook ... PLAT_03_postgres_schema_roles.yml --ask-vault-pass`
- Expect: `ok=4 changed=1 failed=0`
- Confirm roles/db/schema exist if needed via `podman exec motorcade-postgres psql -U postgres -tAc ...`

Next Approved Workstream
PLAT_04 — Application DB Connectivity (read-only verification first)

Resume Instruction
“Resume from PLAT_03B complete. Proceed to PLAT_04 per runbook.”
