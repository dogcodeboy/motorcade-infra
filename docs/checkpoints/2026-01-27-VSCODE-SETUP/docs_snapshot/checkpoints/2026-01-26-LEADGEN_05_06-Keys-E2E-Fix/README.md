# Checkpoint — 2026-01-26 — LEADGEN_05 + LEADGEN_06 Keys + Wave 3 E2E

## What changed
- **LEADGEN_06_configure_api_keys.yml**
  - Ensures **three** key vars exist in `/etc/motorcade/leadgen.env`:
    - `LEADGEN_INTAKE_API_KEY`
    - `LEADGEN_ADMIN_API_KEY`
    - `LEADGEN_API_KEY` (canonical; defaults to intake key unless `vault_leadgen_api_key` is provided)
  - Restarts `motorcade-leadgen-api.service`
  - Verifies the container sees the key names (values redacted)

- **LEADGEN_05_wave3_intake_e2e_validation.yml**
  - Validates `/lead/health`
  - Posts a nested Wave 3 payload to `/lead/intake` using `X-API-Key` + `Idempotency-Key`

## Run (recommended order)
1) LEADGEN_06 (configure keys + restart)
2) LEADGEN_05 (Wave 3 E2E)

See `docs/leadgen/API_KEYS_CONFIGURATION.md` for details.
