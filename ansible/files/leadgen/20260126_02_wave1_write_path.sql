-- Motorcade LeadGen Wave 1 (Write-path hardening)
-- Version: 20260126_02_wave1_write_path
-- Safe to re-run: uses IF NOT EXISTS guards.

BEGIN;

-- Wave 1 canonical schema hardening for API persistence.
-- Adds stable IDs and DB-backed idempotency.

ALTER TABLE app.leads
  ADD COLUMN IF NOT EXISTS intake_id        TEXT,
  ADD COLUMN IF NOT EXISTS request_id       TEXT,
  ADD COLUMN IF NOT EXISTS idempotency_key  TEXT;

-- Idempotency and stable identifiers
CREATE UNIQUE INDEX IF NOT EXISTS uq_leads_idempotency_key ON app.leads (idempotency_key);
CREATE UNIQUE INDEX IF NOT EXISTS uq_leads_intake_id       ON app.leads (intake_id);

-- Optional helper indexes for admin list views
CREATE INDEX IF NOT EXISTS idx_leads_phone ON app.leads (phone);

INSERT INTO app.schema_migrations (version)
VALUES ('20260126_02_wave1_write_path')
ON CONFLICT (version) DO NOTHING;

COMMIT;
