# SESSION HANDOFF — motorcade-infra — LEADGEN_07B

Status:
- YAML parse stability addressed by moving regex-heavy Jinja expressions into YAML single-quoted scalars with escaped backslashes.
- Persistence verification logic updated to poll `app.leads` by **request_id OR email** (prevents false negatives when `request_id` is returned but not stored).

Next steps:
1) Run LEADGEN_07B playbook.
2) If persistence still fails (both 0), focus on the LeadGen runtime write path (queue/worker, background job, or different table) using the diagnostics outputs.

Guardrails:
- Host is `motorcade-web-01`.
- Do not introduce new playbook names; overwrite `LEADGEN_07B_wave3_psycopg_driver_fix_and_persistence_verify.yml` in place.
