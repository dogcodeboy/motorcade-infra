SESSION HANDOFF — LEADGEN_07B — Persistence verify false-negative fix

- Updated persistence verification to query `app.leads` by **request_id OR email**.
- Rationale: API may return `request_id` but the DB row may not store it; previously we would skip the email fallback when request_id was present and incorrectly fail.
- Next step after this checkpoint: if still failing, identify the actual persistence target (table/column) used by the API worker and align the verification query accordingly.
