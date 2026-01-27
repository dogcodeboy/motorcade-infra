# What changed (PLAT_06)

## Added

- `ansible/playbooks/PLAT_06_nginx_http80_canonical_redirect.yml`
- `ansible/playbooks/README_PLAT_06.md`

## Updated

- `ansible/playbooks/README.md` — adds PLAT_06 entry.

## Runtime changes on server

- Ensures canonical redirect vhost:
  - `/etc/nginx/conf.d/motorcade-redirect.conf`
- Identifies duplicate HTTP(:80) server blocks in other `/etc/nginx/conf.d/*.conf` files that claim `server_name motorcade.vip`.
- For each file with duplicates:
  - backups original file to `/etc/nginx/backup/<filename>.<timestamp>`
  - removes duplicate server block(s) from the file
  - if the file would become empty (or comments-only), quarantines it to `/etc/nginx/backup/<filename>.<timestamp>.disabled`

Nginx is validated (`nginx -t`) and only reloaded if the configuration is valid.
