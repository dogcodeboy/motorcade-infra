# VERIFY — LEADGEN_05 Wave 3

Run the playbook and confirm:
- Intake returns 202 Accepted
- Idempotency repeat returns same intake_id/request_id
- DB shows row in app.leads for intake_id

Optional manual spot-check on server:
```bash
curl -sS http://127.0.0.1:8000/lead/health | jq

# Use a known intake_id from play output:
sudo /usr/local/bin/podman exec -e PGPASSWORD=*** motorcade-postgres \
  psql -U postgres -d motorcade -tAc "SELECT * FROM app.leads ORDER BY created_at DESC LIMIT 1;"
```


## Note
Wave 3 drift guard executes via `bash` on the controller and is bounded to the repo to avoid hangs.
