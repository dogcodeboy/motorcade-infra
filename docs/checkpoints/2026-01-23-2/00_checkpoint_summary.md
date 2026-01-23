# Checkpoint 2026-01-23-2 — PLAT_06 (HTTP:80 canonical redirect + duplicate vhost cleanup)

## Goal

Remove the non-blocking nginx warning:

- `conflicting server name "motorcade.vip" on 0.0.0.0:80, ignored`

by ensuring a single canonical HTTP(:80) vhost exists for `motorcade.vip` and removing duplicate port-80 vhost definitions.

## Outcome

- Creates a canonical `motorcade.vip` HTTP→HTTPS redirect vhost (`/etc/nginx/conf.d/motorcade-redirect.conf`)
- Scrubs duplicate `listen 80` + `server_name motorcade.vip` server blocks from other `/etc/nginx/conf.d/*.conf` files
- If a file becomes empty (or only comments) after scrubbing, it is quarantined into `/etc/nginx/backup/` with a timestamp and `.disabled`
- Validates config via `nginx -t` and reloads nginx **only** if valid
