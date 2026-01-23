# What Changed — PLAT_06

## Added

- `ansible/playbooks/PLAT_06_nginx_http80_canonical_redirect.yml`
- `ansible/playbooks/README_PLAT_06.md`

## Behavior

- Ensures a canonical HTTP redirect vhost exists at:
  - `/etc/nginx/conf.d/motorcade-redirect.conf`

- Detects duplicate motorcade port 80 vhosts by scanning `/etc/nginx/conf.d/*.conf` for:
  - `listen 80;` and `server_name ... motorcade.vip ...`

- Moves duplicates to:
  - `/etc/nginx/backup/<filename>.<timestamp>.disabled`

- Runs `nginx -t` then reloads only if valid.
