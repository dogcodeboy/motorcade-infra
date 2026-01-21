# CHECKPOINT — 2026-01-21-PLAT_03B-Postgres-Schema-Roles

Status: **COMPLETE (Authoritative)**

This checkpoint captures the successful completion of **PLAT_03 — Postgres Schema + Roles**.

PLAT_03 creates the **motorcade** database and **app** schema, plus the required roles and baseline grants,
while preserving all prior locked decisions:

- Rootful Podman on Amazon Linux 2023
- systemd-first service management
- Canonical platform root: `/srv/motorcade`
- Postgres service active but **boot-disabled**

---

## What PLAT_03 adds
- Database: `motorcade`
- Schema: `app`
- Roles:
  - `motorcade_owner` (NOLOGIN)
  - `motorcade_app` (LOGIN)
  - `motorcade_ro` (LOGIN)
  - `motorcade_migrator` (LOGIN)
- Grants:
  - Baseline schema usage
  - Table and sequence privileges
  - Default privileges for future migrations

---

## Safety posture
- No app wiring performed
- No schema objects (tables) are created
- Role creation is idempotent
- Service remains boot-disabled

---

## Files added/changed by this checkpoint
- `ansible/playbooks/PLAT_03_postgres_schema_roles.yml`
- `docs/checkpoints/2026-01-21-PLAT_03B-Postgres-Schema-Roles/*`

