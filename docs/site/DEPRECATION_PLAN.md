# 🗑️ Deprecation Plan — Theme Bulk & Repo Stability (site_20)

## Problem
Old theme files and bulk assets make the repo heavy:
- slow uploads to new sessions
- slow zips
- higher risk of drift and churn

## Policy
We do not destroy history, but we do remove bulk from active working paths.

## Standard approach (recommended)
1) Move deprecated theme bulk to a single “archive” area (not in active theme path)
2) Record:
   - date
   - original path
   - new path
   - checksum file
   - restore steps
3) Keep active paths lean

## Acceptance criteria
- Repo zips cleanly and uploads reliably
- Active theme directory contains only the current theme + required assets
- Archive is recoverable via checksum + restore notes

---

## Appendix — Gate Checks
- Must align with `docs/site/RUNBOOK.md` and `docs/site/DELTA_AUDIT_REPORT.md`
- Must not contradict locked decisions (`site_01`–`site_05`)
- Must remain portability-friendly (WordPress is temporary)

## Appendix — Stop Conditions
- If a future session proposes CF7 for intake, stop and use the custom bridge plugin path
- If copy implies goods/cargo/property transport, stop and correct per Services Canon
- If a page spec references missing assets, stop and complete Assets step first

## Appendix — Change Log (Append-only)
- 2026-01-29: Expanded to meet governance minimum-content gate and prevent drift

