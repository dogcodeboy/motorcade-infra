# 🧪 SITE THEME DELTA AUDIT (Re-Audit, 2026-01-29)

**Scope:** reconcile site-theme governance + observed implementation across:
- `motorcade-infra` (governance + runbooks)
- `motorcade.vip` (WordPress theme + deploy playbooks)
- `motorcade-leadgen` (intake API contract)

**Why this exists:** a prior audit run crashed and produced several stubs in `docs/runbooks/SITE_THEME_*`.
This document replaces those stubs with a complete, traceable re-audit so future sessions stop rewriting history.

---

## 1) Truth priority (anti-churn)

1) **Implementation reality** (what is actually deployed / templated)
2) **docs/site governance** (authoritative forward rules)
3) **docs/runbooks audit artifacts** (this folder — provenance + reconciliation)
4) Chat history (non-authoritative)

If implementation conflicts with governance, record the conflict here and propose an append-only governance change (do **not** silently “fix” it).

---

## 2) Key locked decisions validated

### 2.1 “Assets first” and Option A
Governance requires **Assets → Render Spec** ordering per page.
Observed: assets and page templates exist for Services; other pages are partial.

### 2.2 CTA language / tone
Governance requires avoiding “tactical” language and using “Request a Security Assessment”.
Observed header CTA:
- `/security-assessment/` label: **Request an Assessment**
- `/contact/` label: **Talk to Security**
Source: `motorcade.vip/ansible/files/themes/motorcade-trust/header.php`

### 2.3 Texas DPS license footer line
Observed footer includes:
- `Texas DPS Private Security License: B31011701`
Source: `motorcade.vip/ansible/files/themes/motorcade-trust/footer.php`

### 2.4 09B bridge (custom intake plugin, NOT CF7)
Governance hard-lock: custom plugin (no CF7) that can later forward to LeadGen.
Observed: current repo includes **content injector** plugin zip:
- `motorcade.vip/ansible/files/wp/plugins/motorcade-content-injector-v1.1.0.zip`
No dedicated intake plugin is present yet. This is expected prior to `site_22` execution.

---

## 3) Structural drift / duplication findings

### 3.1 Duplicate theme source directories
Two similar theme trees exist:

- Canonical theme files used by deploy roles:
  - `motorcade.vip/ansible/files/themes/motorcade-trust`
- Secondary copy under playbook files:
  - `motorcade.vip/ansible/playbooks/files/themes/motorcade-trust`

**Risk:** sessions edit one copy and deploy the other → churn and “it worked yesterday” failures.

**Recommendation (append-only):**
- Pick a **single canonical source** for theme files (prefer `motorcade.vip/ansible/files/themes/motorcade-trust/`)
- Treat the other as a **read-only mirror** or remove from active paths via a governed `site_20` hygiene step.

---

## 4) Intake contract alignment (LeadGen)

LeadGen v1 contract defines:
- required headers (`X-API-Key`)
- recommended idempotency header
- deterministic schema validation
Source (authoritative): `motorcade-leadgen/docs/19-api/lead-intake-v1.md`

**Implication for WP intake (site_22):**
- The form fields and naming should align with LeadGen `POST /lead/intake` contract.
- The WP plugin must support “local store now / forward later” (config flag).

---

## 5) “Future development context” referenced by audit

The prior audit referenced a future-planning session text for admin/portal decisions.
Preserved context lives in:
- `motorcade-infra/docs/_archives/motorcade-chatgpt-session.full.txt`

Key point extracted:
- Portal vs public-site header/footer decision for guard/client portals
- Admin backend should be function-first; portal branded where it matters
This is **not** site-theme governance for public pages, but it affects `site_17` / `site_16` choices.

---

## 6) What was missing in the crashed audit run (now completed)

The crashed run left stubs for:
- tree/index/checklist
- asset conventions
- deprecation plan
- admin portability notes
- runbook link block

Those are now fully rebuilt in:
- `SITE_THEME_TREE.md`
- `SITE_THEME_CHECKLIST.md`
- `SITE_THEME_ASSET_CONVENTIONS.md`
- `SITE_THEME_RENDER_INDEX.md`
- `SITE_THEME_WP_ADMIN_PORTABILITY.md`
- `SITE_THEME_DEPRECATION_PLAN.md`
- `SITE_THEME_RUNBOOK_LINK.md`

---

## 7) Append-only change log

- 2026-01-29: Re-audit performed using repo snapshots from `3 Repos and session chat about future.zip`. Replaced stub audit artifacts with complete versions.
