# PLAT_05D — HTTPS-only LeadGen proxy routes inside SSL vhost

## Purpose
If you visit `https://motorcade.vip/api/lead/health` and you see a WordPress 404 page, nginx is **not** proxying that path.

This playbook patches the **real SSL vhost** (the `.conf` file in `/etc/nginx/conf.d/` containing both `listen 443` and `server_name ... motorcade.vip`) and injects nginx `location` blocks **inside that `server {}`** so `/api/lead/*` is handled by the LeadGen container.

## What it changes (and nothing else)
- Finds the correct 443 vhost `.conf` file
- Creates a timestamped backup in `/etc/nginx/backup/`
- Removes any prior injected block with the marker `MOTORCADE_LEADGEN_PROXY_SSL`
- Inserts:
  - `location = /api/lead/health` -> upstream `/lead/health`
  - `location ^~ /api/lead/` -> upstream `/`
- Validates `nginx -t` then reloads nginx
- Performs a local verification call:
  - `curl -k https://127.0.0.1/api/lead/health`

## Apply
From repo root:

```bash
cd ~/Repos/motorcade-infra
unzip -o ~/Downloads/motorcade-infra_PLAT_05D_https_only_leadgen_proxy_into_ssl_vhost.zip
```

## Run
```bash
./scripts/run_playbook.sh motorcade-web-01 playbooks/PLAT_05D_nginx_https_only_proxy_leadgen_into_ssl_vhost.yml
```

## Verify
Browser:
- `https://motorcade.vip/api/lead/health`

Server:
```bash
ssh motorcade
sudo nginx -t
curl -k -i https://127.0.0.1/api/lead/health
```

Expected:
- HTTP `200` and JSON from LeadGen (not a WordPress page)
