# 🟩 site_20 — Asset Consolidation & Freeze (Repo Hygiene Gate)

## Goal
Eliminate repo bloat and prevent session upload failures.

## Rules
- Do not delete history; move bulk to archive paths.
- Record checksums and restore steps.

## Actions
1) Identify large directories (themes, image packs, archives).
2) Move deprecated bulk out of active theme directories.
3) Write/maintain checksum manifest (sha256).
4) Document restore command paths.

## Acceptance criteria
- Repo zip size is stable and “session friendly”
- Active theme paths are minimal
- Archive is restorable

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

