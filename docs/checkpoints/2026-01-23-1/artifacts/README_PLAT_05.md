# PLAT_05 — HTTPS-only Nginx Reverse Proxy for LeadGen API (motorcade.vip)

## Root cause

`/etc/nginx/conf.d/motorcade-ssl.conf` currently contains **LeadGen `location` blocks outside any `server {}` block**.

That is why `nginx -t` fails with:

- `location directive is not allowed here ... motorcade-ssl.conf:<line>`

Your read-only inspection confirmed this:

- `awk` scan showed: `FOUND location ... inside_server=NO`
- The file has **multiple `server {}` blocks**, and the LeadGen block landed *between* them.

## Fix strategy (stable + idempotent)

This playbook (the **single** 1-and-done playbook for PLAT_05):

1) Backs up `motorcade-ssl.conf` to `/etc/nginx/backup/`
2) Removes any previously injected LeadGen blocks (marker-based), including the older variants with spaces:
   - `# BEGIN MOTORCADE LEADGEN PROXY ... # END ...`
   - `# BEGIN MOTORCADE_LEADGEN_PROXY ... # END ...`
   - `# BEGIN MOTORCADE_LEADGEN_PROXY_SSL ... # END ...`
3) Removes any legacy LeadGen include lines (we re-add exactly one canonical include):
   - `include /etc/nginx/snippets/motorcade-leadgen-api.conf;`
   - `include /etc/nginx/snippets/leadgen_api.conf;`
   - `include /etc/nginx/snippets/leadgen.conf;`
4) Quarantines any legacy LeadGen snippet files so nginx can’t accidentally include them:
   - `/etc/nginx/snippets/leadgen_api.conf` → `/etc/nginx/backup/leadgen_api.conf.<timestamp>`
   - `/etc/nginx/snippets/leadgen.conf` → `/etc/nginx/backup/leadgen.conf.<timestamp>`
5) Writes the canonical snippet:
   - `/etc/nginx/snippets/motorcade-leadgen-api.conf`
6) Ensures that snippet is included **only** inside the SSL vhost `server {}` that contains both:
   - `listen 443` and
   - `server_name motorcade.vip`
7) Runs `nginx -t` and reloads nginx only when valid.

## Run

From repo root (`~/Repos/motorcade-infra`):

```bash
./scripts/run_playbook.sh motorcade-web-01 playbooks/PLAT_05_nginx_reverse_proxy_leadgen_api.yml --ask-vault-pass
```

## Verify

```bash
sudo nginx -t
curl -k -i https://127.0.0.1/api/lead/health
```

Browser:

- `https://motorcade.vip/api/lead/health`

Expected: `200` + JSON (not WordPress 404).
