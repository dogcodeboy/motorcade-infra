# CHECKPOINT — 2026-01-21-PLAT_02C-Postgres-Bringup

Status: **COMPLETE (Authoritative)**

This checkpoint captures the successful completion of **PLAT_02C — Postgres Bring-up**.

Postgres is running, healthy, and managed by systemd, with boot policy explicitly disabled.
All verification tasks are clean and rerunnable.

---

## Included Workstreams
- PLAT_02 — Networks, Volumes, systemd foundations
- PLAT_02B — Postgres Foundation (image, volume, env, unit disabled)
- PLAT_02C — Postgres Bring-up (start + healthcheck)

---

## Locked Decisions
- Rootful Podman on Amazon Linux 2023
- systemd-first service management
- Canonical platform root: `/srv/motorcade`
- Postgres runs **only when explicitly started**
- No schema or application wiring at this stage

---

## Verified State
- systemd service: `motorcade-postgres.service`
  - Active: **yes**
  - Enabled on boot: **no**
- Container: `motorcade-postgres`
- Healthcheck: `pg_isready` passing
- Volume: `/srv/motorcade/volumes/postgres`

---

This checkpoint is safe to restore, rerun, or branch from.
