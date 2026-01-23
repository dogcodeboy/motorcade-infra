# PLAT_05E — Fix SSL vhost injection placement (HTTPS-only)

## Symptom
`nginx -t` fails with:

- `nginx: [emerg] "location" directive is not allowed here in /etc/nginx/conf.d/motorcade-ssl.conf:<line>`

Meaning: a `location {}` block exists **outside** a `server {}` block.

## What this playbook does
- Targets `/etc/nginx/conf.d/motorcade-ssl.conf` (the file shown in the error).
- Backs it up to `/etc/nginx/backup/`.
- Removes any prior managed LeadGen proxy block (marker-based) anywhere in the file.
- Finds the `server {}` block that contains BOTH:
  - `listen ... 443`
  - `server_name ... motorcade.vip`
- Injects the LeadGen proxy routes **inside** that server block (right before the closing `}`).
- Runs `nginx -t`, reloads nginx, and verifies:
  - `https://127.0.0.1/api/lead/health` returns **200** (curl -k).

## Run
```bash
./scripts/run_playbook.sh motorcade-web-01 playbooks/PLAT_05E_fix_ssl_location_injection.yml
```

## Expected
- `nginx -t` passes
- `https://motorcade.vip/api/lead/health` returns **200 + JSON**
