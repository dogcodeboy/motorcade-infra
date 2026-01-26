# SESSION HANDOFF — motorcade-infra — LEADGEN Wave 1 complete

## Status

- **LEADGEN_01** DB migration applied:
  - `app.leads` table present
  - `app.schema_migrations` contains `20260126_01_wave1_leads`
- **LEADGEN_02** API deployed and stable:
  - `motorcade-leadgen-api.service` active
  - Host bind: `127.0.0.1:8000`
  - Health OK locally and via Nginx

## Notes / gotchas

- If you see an Ansible warning about a **duplicate key** in the encrypted vault (e.g., `vault_postgres_password`),
  you must fix the vault file to contain **exactly one** value. Keep the value that matches `/etc/motorcade/postgres.env`
  on the server.

## Next step (Wave 2+)

- Wire intake endpoints to actually INSERT into `app.leads` (Wave 1 currently reports `db_readonly_check: optional`).
- Add admin endpoints + auth split enforcement (intake vs admin).
- Add job queue integration (Redis) if needed for email notifications / CRM.

