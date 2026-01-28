# Checkpoint: LEADGEN_07B — Intake ID parse hardening (regex, non-JSON tolerant)

Purpose:
- Some /lead/intake builds return a Python-dict style string (single quotes) instead of strict JSON.
- This checkpoint hardens LEADGEN_07B so we can extract request_id/intake_id reliably and avoid empty request_id in DB poll queries.

Scope:
- Overwrite only the existing playbook: `ansible/playbooks/LEADGEN_07B_wave3_psycopg_driver_fix_and_persistence_verify.yml`
- Append-only note in `docs/RUNBOOK.md`

Result target:
- Playbook parses reliably.
- Parsed IDs shown in output.
- Persistence polling uses request_id and email (as before), but request_id should no longer be blank when present in response.
