# PLAT_06 — Canonicalize HTTP:80 vhost (motorcade.vip) + quarantine duplicates

## Goal

Eliminate the non-fatal but noisy Nginx warning:

- `conflicting server name "motorcade.vip" on 0.0.0.0:80, ignored`

by ensuring there is **exactly one** HTTP:80 vhost for `motorcade.vip`, and that it performs a simple **HTTP → HTTPS redirect**.

## What this playbook does

1. Creates a canonical redirect vhost:

- `/etc/nginx/conf.d/motorcade-redirect.conf`

2. Scans `/etc/nginx/conf.d/*.conf` and detects any file that contains BOTH:
- a `listen 80;` directive
- a `server_name ... motorcade.vip ...` directive

3. Quarantines duplicates:
- Moves any duplicate HTTP:80 motorcade vhost files into `/etc/nginx/backup/` with a timestamped `.disabled` suffix
- The canonical redirect vhost is never quarantined

4. Validates and reloads:
- Runs `nginx -t`
- Reloads nginx **only if** validation succeeds

## How to run

From the `motorcade-infra/ansible` directory:

```bash
ansible-playbook -i inventories/prod/hosts.ini \
  playbooks/PLAT_06_nginx_http80_canonical_redirect.yml \
  --ask-vault-pass
```

## Verify

On the server:

```bash
sudo nginx -t
curl -i http://motorcade.vip/
```

Expected:
- `nginx -t` succeeds
- `http://motorcade.vip/` returns a `301` redirect to `https://motorcade.vip/`

## Notes

- This playbook intentionally limits scope to the **port 80 conflict** only.
- It does not touch the SSL vhost or the LeadGen API proxy implemented in PLAT_05.
