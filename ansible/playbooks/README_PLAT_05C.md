README — PLAT_05C (HTTPS-only Nginx Cleanup)

Purpose
- Fix nginx failing with: 'location directive is not allowed here' (commonly caused by a top-level 'location' outside a server block).
- Enforce HTTPS-only for motorcade.vip by making /etc/nginx/conf.d/motorcade.conf an HTTP->HTTPS redirect stub only.
- Quarantine legacy LeadGen conf file (/etc/nginx/conf.d/motorcade-leadgen-api.conf) out of conf.d so nginx won't parse it.

What this playbook does
1) Backs up current /etc/nginx/conf.d/motorcade.conf to /etc/nginx/backup/ with a timestamp.
2) Overwrites /etc/nginx/conf.d/motorcade.conf with a known-good redirect-only server block:
   - listen 80
   - server_name motorcade.vip www.motorcade.vip
   - return 301 https://$host$request_uri;
3) If /etc/nginx/conf.d/motorcade-leadgen-api.conf exists:
   - backs it up to /etc/nginx/backup/
   - moves it to /etc/nginx/conf.d/disabled/ so nginx cannot parse it
4) Runs nginx -t and reloads nginx.

Run (via your wrapper)
  cd ~/Repos/motorcade-infra
  ./scripts/run_playbook.sh motorcade-web-01 playbooks/PLAT_05C_https_only_nginx_cleanup.yml

Verify
  ssh motorcade
  sudo nginx -t
  curl -k -i https://127.0.0.1/api/lead/health

Notes
- This playbook does NOT modify your SSL vhost; it only unblocks nginx parsing by sanitizing the HTTP stub.
- If nginx still fails after this, the error output will identify the next file/line to sanitize.
