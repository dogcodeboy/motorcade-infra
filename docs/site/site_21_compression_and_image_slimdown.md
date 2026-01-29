# 🟩 site_21 — Compression & Image Slimdown (Performance Gate)

## Goal
Fast page load + stable repo size.

## Standards
- Photos: WebP (reasonable quality, sized to usage)
- Icons/logos: SVG where possible
- No huge hero images without mobile crops

## Required outputs
- A compression policy note (what tools, what defaults)
- A “before/after” size snapshot (optional but recommended)

## Acceptance criteria
- Key images are optimized
- Total asset weight decreases or stays bounded

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

