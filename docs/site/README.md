# docs/site — Site Theme Governance (Authoritative)

This folder is the **single source of truth** for the Motorcade public site theme program.

## Why this exists
We had drift across sessions: partial docs, conflicting naming, and “page renders without assets.”
This governance set prevents churn and defines a strict build order.

## Non-negotiables (locked decisions)
- `site_01`–`site_05` are **LOCKED** (do not reopen without append-only change records).
- Every public page deliverable uses **Option A**:
  - **Assets first**, then **Render Spec**
- WordPress is **temporary**. Theme must be **portable** to non-WP static HTML/CSS later.
- **09B bridge plugin** is a **custom Motorcade intake plugin** (NOT CF7) designed to later point at the LeadGen container without rework.
- Public wording avoids “tactical”; primary CTA is **Request a Security Assessment**.

## Quick links (mobile friendly)
- RUNBOOK: https://github.com/dogcodeboy/motorcade-infra/blob/main/docs/site/RUNBOOK.md
- Step Tree: https://github.com/dogcodeboy/motorcade-infra/blob/main/docs/site/SITE_BUILD_TREE.md
- Checklist: https://github.com/dogcodeboy/motorcade-infra/blob/main/docs/site/CHECKLIST.md
- Audit/Delta: https://github.com/dogcodeboy/motorcade-infra/blob/main/docs/site/DELTA_AUDIT_REPORT.md
- Main RUNBOOK Link Block: https://github.com/dogcodeboy/motorcade-infra/blob/main/docs/site/LINK_INTO_MAIN_RUNBOOK.md

## Folder expectations
- These documents must be “substantial” (not stubs).
- If a future session contradicts docs/site, docs/site wins.

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

