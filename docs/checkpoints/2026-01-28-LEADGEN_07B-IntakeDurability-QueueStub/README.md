# Checkpoint: 2026-01-28-LEADGEN_07B-IntakeDurability-QueueStub

## Purpose
Record the current verified state of **LEADGEN_07B**:
- LeadGen API rebuild succeeds under static Podman on AL2023.
- Wave3 intake payload schema validated (422 fixed -> 202 Accepted).
- Document the authoritative durability contract: **intake must persist to Postgres regardless of queue mode**.

## What changed in repo
- Updated `docs/RUNBOOK.md` **inline** (no append file) to reflect LEADGEN_07B findings and lock the durability contract.

## Runtime evidence (from prod host)
- `motorcade-leadgen-api.service` active (rootful Podman, read-only filesystem, tmp bind).
- `/etc/motorcade/leadgen.env` shows DB points to `motorcade-postgres:5432`.
- Postgres `app.leads` includes `payload jsonb`, idempotency unique index, consent_state constraints.

## Next step
Create the next playbook to **verify persistence**:
- After `POST /lead/intake`, query Postgres for the inserted row by `idempotency_key` and/or `request_id`.
- Treat `queue=stub` as allowed, but **do not allow accept-without-persist**.
