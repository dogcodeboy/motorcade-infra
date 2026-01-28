# CHECKPOINT — 2026-01-28 — LEADGEN_07B — Parse-stable YAML + Persistence Poll

## Summary
- Fixes recurring Ansible YAML parse errors caused by backslashes in regex patterns.
- Updates persistence verification to treat a LeadIntake as "persisted" if a row appears in `app.leads` matching **request_id OR email**.

Host: `motorcade-web-01`
Playbook: `ansible/playbooks/LEADGEN_07B_wave3_psycopg_driver_fix_and_persistence_verify.yml`
