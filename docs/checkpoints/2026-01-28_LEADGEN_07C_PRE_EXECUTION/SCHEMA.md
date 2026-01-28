# Schema — LEADGEN_07C

Table: app.intake_jobs
Columns:
- id (uuid)
- idempotency_key (text)
- payload (jsonb)
- status (queued|processing|done|failed|dead)
- attempt_count (int)
- last_error (text)
- created_at (timestamptz)
- updated_at (timestamptz)
