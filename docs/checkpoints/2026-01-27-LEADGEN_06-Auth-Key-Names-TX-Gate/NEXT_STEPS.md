# Next steps

## 1) Confirm E2E persistence behavior (DB)
- If the current Wave 1 build uses a stub queue, `202 Accepted` may **not** immediately write into `app.leads`.
- Decide whether v1 should:
  - (A) write directly to Postgres synchronously (simplest + reliable for v1), or
  - (B) enqueue + run a worker that persists leads (more scalable, but more moving parts).

## 2) Confirm which key is intended for which caller
- `LEADGEN_API_KEY` — canonical middleware key (required by `/lead/intake`).
- `LEADGEN_INTAKE_API_KEY` — reserved for alternate/public intake caller strategy (if/when split).
- `LEADGEN_ADMIN_API_KEY` — reserved for admin endpoints (if/when enabled).

## 3) Keep TX-only gate until multi-state launch
- Current validation correctly rejects non-TX.
- When expanding beyond TX, this gate should become a config-driven allowlist.
