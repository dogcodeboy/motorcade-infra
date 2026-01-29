# SESSION HANDOFF — Motorcade Site Theme Program (Post-`site_01b`)

Date: 2026-01-29
Repos: motorcade-infra, motorcade.vip, motorcade-leadgen
Primary Host: motorcade-web-01 (Amazon Linux 2023)
Workstation: mwkst01 (RHEL)

## ✅ Current State (Authoritative)

`site_01` is complete and pushed. Follow-on `site_01b` is complete and pushed.

### External archive (NOT included in Repos.zip uploads)
Path:
- `~/Repos/Archives/motorcade/site-theme-legacy/`

Contains:
- motorcade-trust-theme.zip (~25MB)
- motorcade-trust-live_20260128T125828Z.tar.gz (~27MB)
- motorcade-trust-theme-live.tar.gz (~18MB)

### Repo size (post-GC snapshot)
motorcade.vip:
- Total: ~191MB
- `.git`: ~94MB
- `git count-objects`: `size-pack ~92.83 MiB`

### Git remote stability
motorcade.vip `origin` remote switched to SSH to avoid askpass failures:
- `git@github.com:dogcodeboy/motorcade.vip.git`
SSH verified + push verified.

## ✅ Commits (record)

motorcade.vip:
- cf03fdd — site_01: externalize legacy theme artifacts (repo slimdown only)
- 1225819 — site_01: update theme playbooks to use external archive + add runbook
- c88e8e1 — site_01b: externalize legacy theme tarball (repo slimdown only)

motorcade-infra:
- d1c03a7 — site_01: record external archive pointer + manifest (docs-only)
- cad357c — PLAT_09A: link SITE Theme governance runbook (authoritative)

## 🔒 Locked decisions (do not revisit)

- No CF7. PLAT_09B bridge = custom Motorcade contact/intake plugin designed to later point at LeadGen container without rework.
- WordPress is presentation only (host), not long-term authority.
- Asset-first per page step (images before markup).
- Each page render = its own step under site_* naming.
- Copy constraints: remove “tactical”; don’t mention transporting goods/property; escorting cargo vehicles allowed, transporting cargo not allowed.

## ▶️ Next authorized execution

Start `site_02 🧱 Page-by-Page Render Execution` (asset-first, one page = one step) using:
- SITE_THEME_TREE.md
- SITE_THEME_RENDER_INDEX.md
- SITE_THEME_ASSET_CONVENTIONS.md
- SITE_THEME_CHECKLIST.md
