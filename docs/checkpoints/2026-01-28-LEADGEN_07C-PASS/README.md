# Checkpoint — LEADGEN_07C (PASS)

Date: 2026-01-28  
Repo: `motorcade-infra` (plus pinned ref in `motorcade-leadgen`)  
Environment: `prod` (host: `motorcade-web-01`)  

## What this checkpoint certifies

LEADGEN_07C Wave4 is **verified PASS** on prod:

- LeadGen API starts cleanly and binds **127.0.0.1:8000**
- `/lead/health` returns **200** with `queue=pg_outbox`
- **Async boundary works**: intake returns **202** even when worker is stopped
- Worker drains queued jobs and writes to `app.leads`
- Idempotency key replays return **409** (no duplicate lead row)

## Pinned refs

- LeadGen app deploy ref: `leadgen-wave1-2026-01-28d`
- Infra playbook pin: `LEADGEN_07C_wave4_postgres_outbox_async_boundary.yml` sets `leadgen_git_ref: "leadgen-wave1-2026-01-28d"`

## Root cause recap

A SyntaxError at `/app/leadgen_api/main.py` line ~130 prevented `uvicorn` import and service bind.  
The initial playbook pin (`...28c`) rebuilt from the wrong ref. Pin was corrected to `...28d`.

## How to re-run (idempotent)

From your workstation:

```bash
cd ~/Repos/motorcade-infra/ansible
ansible-playbook -i inventories/prod/hosts.ini \
  playbooks/LEADGEN_07C_wave4_postgres_outbox_async_boundary.yml \
  --ask-vault-pass
```

See `VERIFY.md` for exact verification commands and expected outputs.
