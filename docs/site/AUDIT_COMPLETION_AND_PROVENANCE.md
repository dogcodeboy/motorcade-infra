# Audit completion & provenance (Site Theme)

This document exists to stop churn after a crashed audit run produced **partial stubs** in `docs/runbooks/SITE_THEME_*`.

## What happened
- A generator/audit run wrote `docs/runbooks/SITE_THEME_*` files and then crashed.
- Several of those files were left as short “stubs” and did not capture all intended content.
- Re-running generators can overwrite operator edits and reintroduce churn.

## Correct handling (locked)
- `docs/site/*` is authoritative **forward governance**.
- `docs/runbooks/SITE_THEME_*` are **audit artifacts**; they may be replaced if they are incomplete stubs, but once complete they should be treated as immutable snapshots.

## Re-audit performed
- 2026-01-29: A full re-audit was performed using a repo snapshot (3 repos + preserved session text).
- The stub files were replaced with complete versions:
  - `docs/runbooks/SITE_THEME_DELTA_AUDIT.md`
  - `docs/runbooks/SITE_THEME_TREE.md`
  - `docs/runbooks/SITE_THEME_CHECKLIST.md`
  - `docs/runbooks/SITE_THEME_ASSET_CONVENTIONS.md`
  - `docs/runbooks/SITE_THEME_RENDER_INDEX.md`
  - `docs/runbooks/SITE_THEME_WP_ADMIN_PORTABILITY.md`
  - `docs/runbooks/SITE_THEME_DEPRECATION_PLAN.md`
  - `docs/runbooks/SITE_THEME_RUNBOOK_LINK.md`

## If something is still “missing”
Do **not** patch these artifacts by guessing.

Instead:
1) Add a dated note to `SITE_THEME_DELTA_AUDIT.md` describing what is missing and why.
2) Capture the missing material as a new “addendum” doc under `docs/runbooks/` (append-only).
3) If it changes a locked decision, append to `docs/site/DELTA_AUDIT_REPORT.md`.

## Reference: future admin backend context
Some audit rationale references preserved future-planning text:
- `motorcade-infra/docs/_archives/motorcade-chatgpt-session.full.txt`

This is not authoritative for the public theme, but informs portal/admin decisions later.
