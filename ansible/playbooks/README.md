# Playbooks

Place new playbooks here using the naming scheme:
- `WP_..` for WordPress site work
- `PLAT_..` for platform containers
- `ID_..` for identity
- `MAIL_..` for mail/calendar

Each playbook must:
- be idempotent
- backup-first if modifying state
- print restore path
- verify success

## Current playbooks

### Platform
- `PLAT_02A_networks_volumes_systemd_foundations.yml` — Creates Podman networks, `/srv/motorcade` directories, and the rootful systemd target + prep service.
- `PLAT_02B_postgres_foundation.yml` — Pulls Postgres image, creates volume + env file, installs **boot-disabled** systemd unit (does **not** start Postgres).
- `PLAT_02C_postgres_bringup.yml` — Verification-only bring-up checkpoint (service active, container running, healthcheck passes).
- `PLAT_03_postgres_schema_roles.yml` — Creates Motorcade database + schema + roles (backup-first). Keeps Postgres **boot-disabled**.
