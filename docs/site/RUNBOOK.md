# 🎨 Site Theme RUNBOOK (Authoritative)

This RUNBOOK governs site theme work to prevent churn and ensure portability beyond WordPress.

## Legend
- 🟦 LOCKED foundation
- 🟨 Page deliverable
- 🟧 Assets/Render substeps
- 🟩 Gates / Bridge
- 🟥 Stop condition

## Absolute rules (non-negotiable)
1) 🟦 site_01–05 are **LOCKED**. We do not “re-decide” them each session.
2) 🟧 **Assets first**, then **Render Spec** for every page.
3) 🧾 **Append-only** edits to governance docs (no rewrite of history).
4) 🧳 WordPress is temporary. Theme must remain portable.
5) ⚖️ Licensing-safe canon is mandatory (no goods/cargo transport claims).
6) 🧩 09B bridge is a **custom Motorcade intake plugin** (NOT CF7), designed to later point at LeadGen container without rework.

## What “DONE” means
A step is DONE only when:
- The document exists and is substantial (not a stub),
- Acceptance criteria listed in that doc is met,
- Verify steps exist and can be run,
- Any deviation is recorded in Audit/Delta (append-only).

## Execution strategy (stable, low mistake rate)
**Phase 0 — Governance lock**
- Complete or confirm site_01–05 docs are present and correct.

**Phase 1 — Page specs (Option A)**
For each page (site_06–19):
- Create Assets list + required file names and usage
- Produce Render Spec that references only assets that exist
- Add “verify” checklist for nav + footer license + CTA

**Phase 2 — Hygiene gates**
- site_20 repo size discipline (deprecate heavy theme bulk safely)
- site_21 compression standards (webp/svg rules)
- Only then proceed to bridge plugin implementation.

**Phase 3 — Bridge**
- site_22: implement the custom intake plugin with “local save now / forward later” mode

## References
- SITE_BUILD_TREE.md
- CHECKLIST.md
- DELTA_AUDIT_REPORT.md
