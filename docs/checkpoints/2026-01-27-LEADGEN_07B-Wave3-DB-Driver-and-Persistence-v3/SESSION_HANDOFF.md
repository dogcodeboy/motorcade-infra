# SESSION HANDOFF — motorcade-infra — LEADGEN_07B (Wave 3) v3

Where we are:
- Container rebuild + restart path is working.
- Health check gating is stable (waits for systemd active + port 8000 before `/lead/health`).
- Intake payload was updated to match Wave 3 schema requirements:
  - request.service_type uses allowed enum (`armed_security`)
  - request.timeline object included (start_local/end_local)
  - location.state=TX only (minimal strict payload)
  - Idempotency-Key header included

What remains:
- Re-run LEADGEN_07B after merging this zip and confirm:
  - intake_status=202
  - DB persistence poll succeeds (count >= 1 by email)
- If the DB poll still returns 0 even after a 202:
  - Inspect LeadGen API logs (systemd + container logs) for async queue / write path issues.
  - Confirm the API really writes into `app.leads` (not a different schema/table), and confirm the DB credentials in the container env match the Postgres container.

Commands:
```bash
cd ~/Repos/motorcade-infra/ansible
ansible-playbook -i inventories/prod/hosts.ini   playbooks/LEADGEN_07B_wave3_psycopg_driver_fix_and_persistence_verify.yml   --ask-vault-pass
```
