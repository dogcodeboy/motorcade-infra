# LEADGEN_07B — Wave 3 DB Driver + Persistence Contract

This checkpoint introduces **LEADGEN_07B**, a single playbook that:

- Ensures the LeadGen API container image includes a Postgres driver (`psycopg[binary]`) so the app can actually talk to Postgres.
- Rebuilds the image, restarts the systemd service, and waits for health.
- Enforces the **persistence contract**: after `/lead/intake` returns 2xx/409, a row must exist in `app.leads` in the `motorcade` database.

If the contract fails, the playbook prints safe diagnostics (systemd status, journal tail, and last 10 `app.leads` rows) to support fast triage.
