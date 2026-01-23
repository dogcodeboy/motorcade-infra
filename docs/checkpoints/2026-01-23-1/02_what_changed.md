# What changed (behavioral)

## Nginx
- Ensures LeadGen routes are defined **once** and only once.
- Ensures LeadGen routes exist **inside the SSL vhost** for `motorcade.vip`.

### Canonical routing
- `/api/lead/health` → `http://127.0.0.1:8000/lead/health`
- `/api/lead/` → `http://127.0.0.1:8000/`

### Why this is stable
- Snippet-based: keeps `motorcade-ssl.conf` clean and avoids reintroducing top-level `location` blocks.
- Quarantine: even if older files exist, Nginx can’t accidentally parse them.
- Idempotent: re-running the playbook does not stack duplicate blocks.

## Ansible compatibility
This playbook avoids newer/unstable Ansible module parameters that were failing on the local controller.
