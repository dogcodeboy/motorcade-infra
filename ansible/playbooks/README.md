# Ansible Playbooks (motorcade-infra)

This folder contains the Motorcade Infrastructure playbooks.

## Platform Playbooks

- **PLAT_05** — Nginx SSL reverse proxy for LeadGen API (single canonical snippet; quarantine legacy snippets)
- **PLAT_06A** — Canonicalize HTTP:80 redirect vhost; scrub/quarantine duplicate motorcade.vip port 80 vhosts (robust scrubber)
- **PLAT_07** — Modernize Nginx http2 directive (original; targeted motorcade_web and may skip if inventory lacks that group)
- **PLAT_07A** — Modernize Nginx http2 directive (targets inventory group 'motorcade'; supersedes PLAT_07)
