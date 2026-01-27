LEADGEN_07 — Decision Checkpoint (Documentation Only)

Date: 2026-01-27

Decision:
LeadGen v1 uses synchronous persistence directly to Postgres.
This provides durable acceptance with minimal moving parts.

Rationale:
- Matches existing LEADGEN_06 behavior
- No auth or secret changes
- Lowest churn, production-safe
- Async worker reserved for future scaling

No code changes were made in this checkpoint.