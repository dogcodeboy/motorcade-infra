# LeadGen Wave 1 — DB Migration (app.leads)

This drop-in adds the **Wave 1 durable persistence** table (`app.leads`) and the migration ledger (`app.schema_migrations`).

## Apply (industry-standard order)
1) Backup-first (schema-only)
2) Apply migration
3) Verify table + ledger

## Preferred command (run from motorcade-infra repo)
```bash
cd ~/Repos/motorcade-infra
bash scripts/leadgen/run_wave1_db_migration.sh
```

## What it creates
- `app.schema_migrations` (tracks applied migrations by version string)
- `app.leads` (Wave 1 lead storage)
  - consent_state constrained to: `local_only`, `server_draft`, `opted_in`
  - `ip_hash` stored (never raw IP)
  - `idempotency_key` unique when present

## Verify manually
```bash
sudo podman exec motorcade-postgres psql -U postgres -d motorcade -c "\dt+ app.leads"
sudo podman exec motorcade-postgres psql -U postgres -d motorcade -c "SELECT * FROM app.schema_migrations ORDER BY applied_at DESC LIMIT 5;"
```
