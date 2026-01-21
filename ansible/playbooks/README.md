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
- `PLAT_02A_networks_volumes_systemd_foundations.yml` — Creates Podman networks, /srv/motorcade directories, and a rootful systemd target + prep service.
