# SESSION HANDOFF — motorcade-infra (PLAT_05 complete)

## Current status
PLAT_05 is now **stable and passing**.

- `nginx -t` is successful.
- LeadGen health endpoint works:
  - `curl -k -i https://127.0.0.1/api/lead/health` → `HTTP/2 200` with JSON
  - External `https://motorcade.vip/api/lead/health` loads in browser.

## What was fixed
Root cause was multiple/incorrectly-scoped LeadGen proxy definitions:
- Some `location /api/lead/` blocks were ending up outside a `server {}` (nginx error: `location directive is not allowed here`).
- Multiple snippet/includes created duplicate `location /api/lead/` (nginx error: `duplicate location`).

PLAT_05 resolves this by:
- Removing old marker blocks and legacy includes from `motorcade-ssl.conf`
- Quarantining legacy snippet files (like `/etc/nginx/snippets/leadgen_api.conf` or `/etc/nginx/snippets/motorcade-leadgen-api.conf` duplicates) into `/etc/nginx/backup/` so nginx stops parsing them
- Writing a single canonical snippet: `/etc/nginx/snippets/motorcade-leadgen-api.conf`
- Ensuring that snippet is included **inside the correct SSL vhost** (`listen 443 ssl` + `server_name motorcade.vip`)
- Validating with `nginx -t` and reloading only if valid

## Repo files involved
- `ansible/playbooks/PLAT_05_nginx_reverse_proxy_leadgen_api.yml`
- `ansible/playbooks/README_PLAT_05.md`

## Known non-blocking warnings
- http2 listen deprecation warning (safe to ignore for now)
- `conflicting server name ... on 0.0.0.0:80` indicates duplicate HTTP :80 vhost exists (likely in `motorcade.conf` + the redirect block in `motorcade-ssl.conf`).

## Next step
Create a new playbook (next PLAT number) to resolve the **duplicate port 80 vhost** cleanly (choose one canonical HTTP→HTTPS redirect block and quarantine/remove the other), keeping the same “backup first, validate, reload only if valid” pattern.

## Suggested commit message (PLAT_05)
PLAT_05: stabilize LeadGen SSL proxy via single canonical snippet; quarantine legacy leadgen snippets; prevent duplicate locations
