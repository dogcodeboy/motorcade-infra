# Checkpoint — LEADGEN_06 API Keys Config

Purpose: Fix Wave 3 E2E failure where LeadGen API returns **503 "API key not configured"**.

This checkpoint adds a **server-side** configuration playbook to ensure the LeadGen API service/container has its runtime API keys set via the **existing env file** used by the systemd unit (Waves 1/2).

## Added / Updated
- `ansible/playbooks/LEADGEN_06_configure_api_keys.yml`
- `docs/leadgen/API_KEYS_CONFIGURATION.md`

## What it changes
- Writes/updates these lines in `/etc/motorcade/leadgen.env` (in-place, without overwriting other env vars):
  - `LEADGEN_INTAKE_API_KEY=...`
  - `LEADGEN_ADMIN_API_KEY=...`
- Restarts `motorcade-leadgen-api`
- Verifies `/lead/health` is OK
- Prints **names only** (values redacted)

## Safety notes
- No secrets are printed (tasks use `no_log: true`, and reporting is redacted).
- This does NOT lock intake to Houston/TX; those values only apply to the Wave 3 E2E test payload.
