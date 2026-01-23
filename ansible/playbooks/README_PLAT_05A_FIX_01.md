# PLAT_05A_FIX_01 — Nginx "location not allowed here" hotfix

## Symptom
Running **PLAT_05A** failed at `nginx -t` with:

- `nginx: [emerg] "location" directive is not allowed here`

This indicates a `location { ... }` block was written *outside* a `server { ... }` block.

## Root cause
The initial PLAT_05A version attempted to insert the LeadGen reverse-proxy block by anchoring on a PHP location stanza. In environments where that anchor isn't present in `/etc/nginx/conf.d/motorcade.conf`, Ansible's `blockinfile` falls back to inserting at EOF, which places the `location { ... }` blocks after the closing `}` of the `server` block — invalid in Nginx.

## Fix (what changed)
PLAT_05A now:

1. **Verifies** the target vhost file contains a `server_name ... motorcade.vip` line.
2. Inserts the proxy `location` blocks **immediately after** that `server_name` line, ensuring the block lands inside the intended `server { ... }`.

This makes the playbook idempotent and resilient to minor `motorcade.conf` formatting differences.

## How to run
From `motorcade-infra` repo root:

```bash
./scripts/run_playbook.sh motorcade-web-01 playbooks/PLAT_05A_nginx_proxy_leadgen_into_motorcade_site.yml
```

## Verification
After the playbook completes successfully:

- Browser: `http://motorcade.vip/api/lead/health`
- Server:

```bash
curl -i http://127.0.0.1/api/lead/health
nginx -t
systemctl status nginx --no-pager
```

Expected: HTTP 200 + JSON from the LeadGen service.
