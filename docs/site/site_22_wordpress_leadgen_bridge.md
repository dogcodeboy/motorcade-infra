# 🟩 site_22 — WordPress ↔ LeadGen Bridge (Custom Plugin, NOT CF7)

## Hard lock decision
The 09B bridge will be a **custom Motorcade intake plugin**, not CF7.

## Why
We need a bridge that later points to the LeadGen container without rework.
Form markup must remain stable while backend routing changes.

## Minimum requirements
- Intake fields: name, company, email, phone, preferred contact method, service type, notes
- Spam controls: honeypot + rate limit (captcha optional later)
- Audit log: timestamp, request id, hashed IP, user agent
- Storage modes:
  - Local WP persistence (initial)
  - Forward-to-LeadGen API (later via config flag)

## Acceptance criteria
- No CF7 dependency
- Configurable routing (local now / API later)
- Documented verification steps

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

