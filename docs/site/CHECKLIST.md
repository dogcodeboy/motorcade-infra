# ✅ Site Theme Program — Checklist (Anti-Churn)

This checklist is used to catch failures early.

## A) Governance completeness
- [ ] README.md explains scope + non-negotiables
- [ ] RUNBOOK.md defines process + DONE criteria
- [ ] SITE_BUILD_TREE.md is continuous and matches the intended step tree
- [ ] LINK_INTO_MAIN_RUNBOOK.md exists and contains clickable GitHub links
- [ ] DELTA_AUDIT_REPORT.md exists and locks decisions / drift rules

## B) Locked decisions (site_01–05)
- [ ] Design avoids “tactical” language
- [ ] Primary CTA is “Request a Security Assessment”
- [ ] Services canon matches licensing constraints
- [ ] Mobile menu/hamburger behavior is required
- [ ] Header/footer contract is portable and enforced

## C) Page deliverable rules (site_06–19)
For each page:
- [ ] Assets step exists BEFORE render spec
- [ ] Render spec references only assets that exist
- [ ] Footer includes required license line
- [ ] No copy implies goods/cargo/property transport
- [ ] Nav works desktop + mobile

## D) Hygiene gates
- [ ] Deprecated theme bulk is removed from active working paths (moved/archived, not deleted)
- [ ] Compressed assets are used (webp where appropriate, svg for icons)
- [ ] Zip + repo upload stability improved after cleanup

## E) Bridge constraints (site_22)
- [ ] Bridge is custom plugin (not CF7)
- [ ] Supports “local persistence now, forward-to-LeadGen later” via config
- [ ] Includes audit logging + rate limiting + spam controls
