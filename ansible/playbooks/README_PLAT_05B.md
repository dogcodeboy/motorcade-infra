PLAT_05B — HTTPS-only LeadGen Proxy (motorcade.vip)

Purpose
- Expose the LeadGen Intake API (PLAT_04) via the existing HTTPS vhost for motorcade.vip.
- Keep the LeadGen container bound to 127.0.0.1:8000 (no new public ports).
- Disable any legacy /etc/nginx/conf.d/motorcade-leadgen-api.conf file that can break nginx parsing.

What this playbook does
1) Detects the correct SSL vhost file under /etc/nginx/conf.d/*.conf by requiring BOTH:
   - a 'listen 443' line, AND
   - a 'server_name ... motorcade.vip' line
2) Backs up that SSL vhost config (timestamped) to /etc/nginx/backup/
3) If /etc/nginx/conf.d/motorcade-leadgen-api.conf exists, backs it up and MOVES it out of conf.d
   (so nginx will not parse it).
4) Inserts these proxy routes INSIDE the SSL server block (marker-based, idempotent):
   - /api/lead/health  ->  http://127.0.0.1:8000/lead/health
   - /api/lead/*       ->  http://127.0.0.1:8000/*
5) Runs 'nginx -t' and reloads nginx
6) Verifies via loopback: https://127.0.0.1/api/lead/health (validate_certs=false)

Run
From repo root:
  ./scripts/run_playbook.sh motorcade-web-01 playbooks/PLAT_05B_nginx_https_only_proxy_leadgen_into_ssl_vhost.yml

Verify
Browser:
  https://motorcade.vip/api/lead/health

Server:
  curl -k -i https://127.0.0.1/api/lead/health

Notes
- This playbook is designed for HTTPS-only sites. Port 80 should be redirect-only.
- If you later want to keep a standalone leadgen vhost, do it as a FULL server{} block.
  Never leave top-level 'location' directives in conf.d files.
