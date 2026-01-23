SESSION HANDOFF — motorcade-infra (PLAT_06 ready)

Checkpoint created: docs/checkpoints/2026-01-23-2/
Goal: remove the non-fatal Nginx warning:

  conflicting server name "motorcade.vip" on 0.0.0.0:80, ignored

by ensuring a single canonical HTTP:80 redirect vhost exists and quarantining duplicates.

What PLAT_06 does

- Creates canonical HTTP→HTTPS redirect vhost:
  /etc/nginx/conf.d/motorcade-redirect.conf

- Scans /etc/nginx/conf.d/*.conf for any file that contains BOTH:
  - listen 80;
  - server_name ... motorcade.vip ...

- Quarantines duplicates:
  moves them to /etc/nginx/backup/<file>.<timestamp>.disabled
  (canonical redirect vhost is never quarantined)

- Runs nginx -t; reloads only if config is valid.

Repo files involved

- ansible/playbooks/PLAT_06_nginx_http80_canonical_redirect.yml
- ansible/playbooks/README_PLAT_06.md

Recommended commit message

PLAT_06: canonicalize HTTP:80 redirect vhost; quarantine duplicate motorcade.vip port 80 vhosts
