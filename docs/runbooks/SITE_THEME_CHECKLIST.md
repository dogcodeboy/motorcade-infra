# ✅ SITE THEME CHECKLIST (Anti-Churn)

This checklist is run before marking a site step “DONE”.
It exists to prevent drift between governance (`docs/site`) and implementation (`motorcade.vip` theme + playbooks).

---

## A) Governance present + authoritative
- [ ] `motorcade-infra/docs/site/RUNBOOK.md` exists and is referenced from main RUNBOOK
- [ ] `motorcade-infra/docs/site/DELTA_AUDIT_REPORT.md` exists (locked decisions)
- [ ] `motorcade-infra/docs/site/SERVICES_CANON.md` exists (licensing-safe wording)
- [ ] `motorcade-infra/docs/site/site_05_header_footer_contract_portable.md` exists (contract)

## B) Implementation checks (theme)
Canonical theme path (expected):
- `motorcade.vip/ansible/files/themes/motorcade-trust/`

Verify:
- [ ] Header has exactly one logo render
- [ ] Header has CTA to `/security-assessment/` and `/contact/`
- [ ] Mobile nav/hamburger exists or a CSS hook exists to add it (no “menu overflow”)
- [ ] Footer includes Texas DPS license line
- [ ] Footer exists on every public page template

## C) Licensing-safe copy guardrails
- [ ] No “transport goods/cargo/property” claims anywhere
- [ ] Rapid Response is described only as **EP add-on** (not standalone category)
- [ ] “Tactical” wording removed from public positioning

## D) Assets-first enforcement (Option A)
For each page deliverable:
- [ ] Assets doc exists **before** render spec
- [ ] Render spec references only assets that exist in repo
- [ ] Assets are optimized (webp/svg standards where applicable)

## E) Repo hygiene gates (site_20/site_21)
- [ ] Old/bulk theme assets moved to archive paths via governed step (not deleted)
- [ ] Repo zip/upload remains stable (size bounded)
- [ ] Duplicate theme trees are resolved or explicitly documented

## F) Bridge readiness (site_22)
- [ ] No CF7 dependency
- [ ] WP intake plugin supports “local store now / forward later” config
- [ ] Field names align to LeadGen v1 contract
- [ ] Audit logging + rate limiting included

---

## Operator commands (local verification)
From a workstation clone:
- `grep -RIn "Texas DPS" motorcade.vip/ansible/files/themes/motorcade-trust`
- `grep -RIn "/security-assessment/" motorcade.vip/ansible/files/themes/motorcade-trust/header.php`
- `find motorcade.vip/ansible/files/themes/motorcade-trust -maxdepth 2 -type f | sort`
