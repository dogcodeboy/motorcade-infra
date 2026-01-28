SESSION HANDOFF — motorcade-infra — LEADGEN_07B

What changed:
- LEADGEN_07B now parses intake IDs using regex from the sanitized body snippet, tolerant of non-JSON response bodies.

Why:
- Prior runs showed request_id present in the displayed body snippet, but the SQL poll used request_id='' due to JSON parsing assumptions.

Next:
- Re-run LEADGEN_07B.
- If persistence still returns 0|0 (email + request_id), treat as real persistence failure and focus on app ingest path/worker/config.
