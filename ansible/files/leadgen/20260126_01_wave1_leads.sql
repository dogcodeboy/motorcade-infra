-- Motorcade LeadGen Wave 1 (Leads intake) schema
-- Version: 20260126_01_wave1_leads
-- Safe to re-run: uses IF NOT EXISTS guards.

BEGIN;

CREATE SCHEMA IF NOT EXISTS app;

CREATE TABLE IF NOT EXISTS app.leads (
  id              BIGSERIAL PRIMARY KEY,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  source          TEXT,
  name            TEXT,
  email           TEXT,
  phone           TEXT,
  message         TEXT,
  metadata        JSONB NOT NULL DEFAULT '{}'::jsonb,
  ip              INET,
  user_agent      TEXT
);

CREATE INDEX IF NOT EXISTS idx_leads_created_at ON app.leads (created_at DESC);
CREATE INDEX IF NOT EXISTS idx_leads_email      ON app.leads (email);

CREATE TABLE IF NOT EXISTS app.schema_migrations (
  version     TEXT PRIMARY KEY,
  applied_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);

INSERT INTO app.schema_migrations (version)
VALUES ('20260126_01_wave1_leads')
ON CONFLICT (version) DO NOTHING;

COMMIT;
