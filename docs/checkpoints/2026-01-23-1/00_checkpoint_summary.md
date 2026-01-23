# Motorcade Infra Checkpoint — 2026-01-23-1 (PLAT_05)

## Purpose
Stabilize the LeadGen **HTTPS-only** reverse proxy in Nginx so `/api/lead/*` routes to the local LeadGen Intake API container without breaking WordPress routing.

This checkpoint resolves two failure modes that occurred during PLAT_04/PLAT_05 work:
- `location directive is not allowed here` (LeadGen `location` blocks ended up outside a `server {}` block).
- `duplicate location "/api/lead/"` (multiple snippets / includes defined the same locations).

## What was implemented (long-term stable approach)
**Single canonical snippet + quarantine legacy snippets**
- Canonical snippet: `/etc/nginx/snippets/motorcade-leadgen-api.conf`
- Any legacy LeadGen snippet files that can cause duplicate `location` parsing are moved into `/etc/nginx/backup/` (timestamped) so Nginx no longer reads them.
- `motorcade-ssl.conf` is scrubbed of old marker blocks and legacy includes, then includes the canonical snippet **inside the correct SSL vhost**.
- Playbook validates with `nginx -t` and reloads only if valid.

## Files (in repo)
- `ansible/playbooks/PLAT_05_nginx_reverse_proxy_leadgen_api.yml`
- `ansible/playbooks/README_PLAT_05.md`

Copies of those two files are stored under `artifacts/` in this checkpoint folder for provenance.

## Verification result (expected)
- `sudo nginx -t` returns `syntax is ok` and `test is successful`.
- `curl -k -i https://127.0.0.1/api/lead/health` returns `HTTP/2 200` and a JSON body like:
  - `{"status":"ok","service":"lead-intake-api",...}`

## Known warnings (not blockers)
- `listen ... http2 directive is deprecated` warning (cosmetic; can be addressed later).
- `conflicting server name ... on 0.0.0.0:80, ignored` warning indicates a *separate duplicate HTTP:80 vhost* exists (see `03_followups.md`).
