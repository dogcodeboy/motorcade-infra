# Checkpoint: LEADGEN_07B — Authoritative PASS

**Date:** 2026-01-28  
**Scope:** LeadGen Wave 1 (motorcade-leadgen) + Infra verify (motorcade-infra)  
**Host:** motorcade-web-01 (AL2023)  
**Goal:** Prove `/lead/intake` accepts a schema-valid payload and persists to Postgres (`app.leads.payload` jsonb) without psycopg dict-adaptation failures.

## What was proven (ground truth)

- **Infra foundation stable:** Postgres + Redis + LeadGen API containers running under systemd; no restarts observed during probes.
- **API surface confirmed:** OpenAPI exposes POST **`/lead/intake`** (not `/lead`).
- **Schema required fields honored:** request body must include **`contact`** and **`request`**; request requires **`service_type`**, **`timeline`**, **`location`**.
- **Persistence fixed:** Lead payload is stored into `app.leads.payload` (jsonb) using a safe cast path; the prior error
  `cannot adapt type 'dict' using placeholder '%s' (format: AUTO)` is resolved when deploying the fixed LeadGen ref.

## Deployed ref (application)

- **motorcade-leadgen ref:** `44a9d47`  
- Branch: `sync/server-leadgen-fixes-2026-01-27`

> Note: LEADGEN_07B playbook defaults `leadgen_git_ref=origin/main`. For the authoritative PASS, it was run with:
> `-e leadgen_git_ref=44a9d47`

## Artifacts in this checkpoint

- `STATUS.md` — current state + container/systemd status summary
- `VERIFY.md` — exact commands + expected outputs (PASS)
- `ROOT_CAUSE.md` — why it failed earlier (two independent causes)
- `DECISIONS.md` — why we chose the current approach (production-safe)
- `NEXT_STEPS.md` — immediate follow-on work (no scope creep)
