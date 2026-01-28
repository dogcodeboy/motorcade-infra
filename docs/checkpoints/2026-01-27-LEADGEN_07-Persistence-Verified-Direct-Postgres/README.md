# LEADGEN_07 — Persistence Verified (Direct Postgres)

Date: 2026-01-27  
Repo: motorcade-infra  
Scope: LeadGen (leadgen.motorcade.vip)  
Host: `motorcade-web-01`

## Goal

Convert the RUNBOOK "Next" item into an **executed, verifiable contract**:

> `/lead/intake` is not considered accepted unless the lead is **persisted to Postgres**.

This checkpoint adds a dedicated verification playbook that proves:
- API accepts a valid TX lead request, and
- A corresponding row exists in `app.leads` in Postgres (queried by unique email).

## What changed

- Added playbook: `ansible/playbooks/LEADGEN_07_wave3_persistence_contract_verify.yml`
- Updated `docs/RUNBOOK.md` to mark LEADGEN_07 as executed and verified

## Non-goals (locked)

- No auth changes
- No secret changes
- No schema changes
- No async worker / queue introduction
- No Redis involvement

## Run

```bash
cd ~/Repos/motorcade-infra/ansible
ansible-playbook -i inventories/prod/hosts.ini \
  playbooks/LEADGEN_07_wave3_persistence_contract_verify.yml \
  --ask-vault-pass
```

## Expected output

- Playbook ends with: `LEADGEN_07 OK: intake accepted and persisted to Postgres.`
- Uses a unique test email so it does not collide with real leads.
