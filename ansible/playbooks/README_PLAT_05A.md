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
- `PLAT_04A_postgres_connectivity_ro.yml` — Read-only connectivity verification against Postgres. **LOCKED — DO NOT RERUN**.
- `PLAT_04_lead_intake_api.yml` — Builds + deploys the LeadGen Intake API container (loopback-bound) and validates `/lead/health`.
- `PLAT_05_nginx_reverse_proxy_leadgen_api.yml` — Deploys NGINX reverse-proxy routes to the loopback LeadGen API and validates via NGINX.
- `PLAT_05A_nginx_proxy_leadgen_into_motorcade_site.yml` — Patches the main site vhost (`/etc/nginx/conf.d/motorcade.conf`) to expose `/api/lead/*` via the website domain (no new ports).
