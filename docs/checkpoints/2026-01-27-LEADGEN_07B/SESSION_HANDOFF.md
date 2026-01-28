# SESSION HANDOFF — 2026-01-27/28 — LEADGEN_07B (Wave3 persistence + E2E)

## What was achieved (do not redo)
- **LeadGen persistence code is now in motorcade-leadgen** branch:
  `origin/sync/server-leadgen-fixes-2026-01-27`
  - Fix: insert JSON payload via `payload_json` + `::jsonb` cast (avoids psycopg dict adaptation)
- **Repo boundary confirmed**
  - App code lives in: `/opt/motorcade-leadgen/app/api/leadgen_api/main.py`
  - Playbooks must target `/opt/motorcade-leadgen` (NOT motorcade-infra)
- **LEADGEN_07B playbook now enforces auto-clean**
  - Runs hard reset + clean before checkout to eliminate drift.
- Container rebuild + service restart are working and health is OK.

## Current blocker (only remaining issue)
- LEADGEN_07B E2E request is failing **validation** with HTTP **422**
- Reason: `request.service_type` must match enum/pattern:
  `^(armed_security|executive_protection|rapid_response_support|armed_escort_driver|armed_delivery|event_security)$`
- The playbook payload is still sending **"armed escort"** (invalid).

## Next action (one thing)
- Update the LEADGEN_07B generated payload so `request.service_type` is one of the allowed values
  (recommend: `armed_escort_driver`).
- Re-run LEADGEN_07B and confirm:
  - intake status is 200/201/202/409
  - Postgres `app.leads` row count increases and newest timestamp updates.

## Commands (workstation)
Run playbook after fixing payload:
```bash
cd /home/codeboy/Repos/motorcade-infra/ansible && \
ansible-playbook -i inventories/prod/hosts.ini \
  playbooks/LEADGEN_07B_wave3_psycopg_driver_fix_and_persistence_verify.yml \
  --ask-vault-pass \
  -e leadgen_git_ref=origin/sync/server-leadgen-fixes-2026-01-27
```

DB manual verify (on motorcade-web-01):
```bash
sudo /usr/local/bin/podman exec -it motorcade-postgres \
  psql -U postgres -d motorcade -c \
  "select count(*) as lead_rows, max(created_at) as newest from app.leads;"
```
