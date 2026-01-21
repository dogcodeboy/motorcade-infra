SESSION HANDOFF — motorcade-infra (Authoritative)

Date: 2026-01-21
Checkpoint: docs/checkpoints/2026-01-21-PLAT_03A-Postgres-Schema-Roles/

Status
PLAT_03 IMPLEMENTED (pending execution).

Summary
- Added playbook `PLAT_03_postgres_schema_roles.yml`.
- Playbook is backup-first (pg_dumpall) and idempotent.
- Creates Motorcade DB (`motorcade`), schema (`app`), and roles:
  - `motorcade_owner` (NOLOGIN)
  - `motorcade_app` (LOGIN)
  - `motorcade_ro` (LOGIN)
  - `motorcade_migrator` (LOGIN)
- Grants + default privileges are set for future migrations.
- Postgres remains systemd-managed and **boot-disabled** (locked decision preserved).

Required vault additions
Add these encrypted vars to `ansible/group_vars/motorcade/vault.yml`:
- `vault_motorcade_app_db_password`
- `vault_motorcade_ro_db_password`
- `vault_motorcade_migrator_db_password`

Resume Instruction
“Run PLAT_03 with --ask-vault-pass after adding vault role passwords, then proceed to PLAT_04 (Lead Intake API).”
