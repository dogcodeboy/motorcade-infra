# 🧱 Admin Portability Notes (site_17 direction)

## Goal
We will eventually deprecate WordPress. The “admin experience” we design now should be portable to the future containerized admin.

## What this means right now
- The **look/feel** of wp-login and a basic admin skin can mirror the public brand.
- But we must treat it as a **prototype** and not build deep WP-only dependencies.

## Future direction (containerized admin)
- Admin will become the system of record for:
  - user creation
  - role management / RBAC
  - employee lifecycle (suspend, terminate)
  - client portal accounts
  - service accounts + mailbox ACLs (policy controlled)

## SSO / Identity strategy (high-level)
- Linux-first identity (FreeIPA/IdM direction is acceptable)
- Must support Windows domain join compatibility (via trust / Samba / AD interop)
- Admin must provide simplified role UI with advanced config still available.

## Acceptance criteria
- Any work done in WP-admin is documented as portable patterns, not WP-only hacks

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

