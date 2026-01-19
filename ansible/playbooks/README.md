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
