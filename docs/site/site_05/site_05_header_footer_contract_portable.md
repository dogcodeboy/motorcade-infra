# 🟦 site_05 — Header & Footer Contract (Portable)

## Why this is locked
Header/footer drift causes churn, branding breaks, and legal compliance risk.

## Header contract (must always hold)
- Logo appears **exactly once** in header.
- Header must be portable to static HTML/CSS (not WP widget dependent).
- Desktop nav matches site_04 rules.
- Mobile nav provides hamburger/dropdown when menu cannot fit.

## Footer contract (must always hold)
- Footer includes required license line (Texas private security licensing requirement).
- Footer appears on every public page.
- Footer must remain portable (static HTML works).

## Verification expectations (implementation)
When a playbook verifies header/footer, it should check:
- only one logo reference in rendered HTML
- license token presence
- nav contains expected top-level items
- mobile menu trigger exists (or CSS class hook exists)

## Acceptance criteria
- Any theme update maintains this contract.
- Any change requires an append-only note in DELTA_AUDIT_REPORT.md

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

