# PLAT_05D — HTTPS-only LeadGen Proxy Injection (motorcade.vip SSL vhost)

## What this fixes
If visiting `https://motorcade.vip/api/lead/health` shows a WordPress 404 (“Page not found”), nginx is **not** proxying `/api/lead/*` inside the real 443 `server {}`.

This playbook injects the reverse proxy `location` blocks **inside the SSL vhost** that serves `motorcade.vip`.

## What it changes
- Finds the `.conf` in `/etc/nginx/conf.d/*.conf` that contains **both**:
  - `listen 443`
  - `server_name ... motorcade.vip`
- Backs it up to `/etc/nginx/backup/`
- Removes any previous injected block (marker-based)
- Inserts two routes **immediately after** the `server_name` line:
  - `location = /api/lead/health` → upstream `/lead/health`
  - `location ^~ /api/lead/` → upstream `/`
- Runs `nginx -t` and reloads nginx
- Verifies `https://127.0.0.1/api/lead/health` returns HTTP 200 (ignores cert)

## Run
From repo root:

```bash
cd ~/Repos/motorcade-infra
./scripts/run_playbook.sh motorcade-web-01 playbooks/PLAT_05D_nginx_https_only_proxy_leadgen_into_ssl_vhost.yml
```

## Verify
- Browser: `https://motorcade.vip/api/lead/health`
- Server:

```bash
curl -k -i https://127.0.0.1/api/lead/health
```
