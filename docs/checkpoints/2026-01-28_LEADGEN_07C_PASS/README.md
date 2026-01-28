# LEADGEN_07C — PASS (Postgres Outbox Async Boundary)

Date: 2026-01-28
Host: motorcade-web-01 (AL2023)

This checkpoint records a successful execution of **LEADGEN_07C**.

## What changed

- Intake path (`POST /lead/intake`) **enqueues** a durable job in Postgres (`app.intake_jobs`) and returns **202 Accepted**.
- A worker service drains queued jobs and writes the canonical lead record into `app.leads`.
- Idempotency is enforced via Postgres (`app.intake_jobs.idempotency_key` + payload match verification).

## Runbook

- Playbook: `ansible/playbooks/LEADGEN_07C_wave4_postgres_outbox_async_boundary.yml`
- Pre-exec specification: `docs/checkpoints/2026-01-28_LEADGEN_07C_PRE_EXECUTION/`

## Verification

See: `VERIFY.md`
