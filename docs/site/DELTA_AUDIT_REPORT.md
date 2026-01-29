# 🧾 Delta Audit Report (Authoritative Drift Lock)

This report locks the decisions that repeatedly drifted across sessions.

## Priority of truth
1) docs/site (this folder)
2) Main RUNBOOK
3) Checkpoints (if explicitly linked)
4) Chat history (least authoritative)

## Locked decisions (summary)
### 1) Program naming
- The site work uses **site_XX** steps (not PLAT_XX) because it is a multi-step creative program.

### 2) WordPress is temporary
- The public theme must be portable to static HTML/CSS later.
- Do not depend on WP-only widgets for core structure.

### 3) CTA & language
- Primary CTA: **Request a Security Assessment**
- Remove “tactical” from public positioning.

### 4) Services canon + licensing constraints
- We transport **people**, not property.
- We can escort vehicles (including cargo vehicles) as escort/security, but do not transport goods.
- Rapid Response is an EP add-on only (not standalone).

### 5) Navigation & responsive
- Mobile hamburger/dropdown is required when menu cannot fit.
- A simple “Login” nav entry is acceptable for employee/client auth entry.

### 6) 09B bridge decision (hard lock)
- The WP↔LeadGen bridge is a **custom Motorcade intake plugin** (NOT CF7),
  built to later point to the LeadGen container without rework.

## Drift patterns to reject immediately
- Reintroducing CF7
- Adding “asset transportation” / cargo transport claims
- Treating Rapid Response as standalone service category
- Skipping “Assets first” and writing render specs that can’t be implemented

## Append-only change policy
If any locked decision changes later:
- Add a dated change note here
- Add a dated change note in the relevant lock doc
- Never rewrite earlier content
