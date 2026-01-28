# Architecture — LEADGEN_07C

Pattern: Postgres-only transactional job queue (outbox pattern).
Components:
- Intake API: validates + enqueues job, returns 202.
- intake_jobs table: durable queue.
- Worker: processes jobs and writes to app.leads.
No Redis, no AI, no enrichment.
