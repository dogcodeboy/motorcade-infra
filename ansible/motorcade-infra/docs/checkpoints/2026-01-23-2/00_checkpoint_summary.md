# Checkpoint Summary — 2026-01-23-2

**Repo:** motorcade-infra  
**Playbook:** `PLAT_06_nginx_http80_canonical_redirect.yml`  
**Purpose:** Canonicalize the single HTTP:80 vhost for `motorcade.vip` as an HTTP→HTTPS redirect, and quarantine any duplicate port 80 vhosts that cause `conflicting server name ... on 0.0.0.0:80`.

## Outcome

After applying PLAT_06:

- Only one `listen 80` vhost for `motorcade.vip` remains active: `/etc/nginx/conf.d/motorcade-redirect.conf`
- Duplicate/conflicting port 80 motorcade vhosts are moved to `/etc/nginx/backup/` (timestamped `.disabled`)
- Nginx is reloaded only if `nginx -t` succeeds
