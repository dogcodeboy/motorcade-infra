# CHECKPOINT — 2026-01-21-PLAT_02C-Postgres-Bringup

Status: **PLAT_02C COMPLETE** (Postgres bring-up running, healthchecked)

This checkpoint advances the platform from PLAT_02B (foundation only) to an operational Postgres container
managed by systemd **without** creating schemas or connecting applications.

Locked constraints respected:
- Rootful Podman on AL2023
- Networks pre-created (motorcade-core)
- Canonical root: /srv/motorcade
- No schema / no app wiring
- systemd oneshot verification rules unchanged
- Postgres systemd service remains **disabled** by default (started for this step only)

Artifacts added:
- ansible/playbooks/PLAT_02C_postgres_bringup.yml
- patches/*.append.md
