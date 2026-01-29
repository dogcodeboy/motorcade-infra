# CHECKPOINT — 2026-01-29 — SITE_01b Externalize legacy tarball + Git GC shrink

This checkpoint captures the follow-on repo slimdown work after `site_01`.

## ✅ What was done (authoritative)

### A) Externalized remaining tracked legacy artifact (working-tree shrink)
Moved out of `motorcade.vip` into the external archive (NOT included in Repos.zip uploads):
- `motorcade.vip/ansible/motorcade-trust-theme-live.tar.gz` (~18MB)

External archive path (locked):
- `~/Repos/Archives/motorcade/site-theme-legacy/`

### B) Removed from Git tracking + prevented re-introduction
- `git rm ansible/motorcade-trust-theme-live.tar.gz`
- Added ignore rule to `.gitignore` to prevent re-adding the tarball

Commit (motorcade.vip):
- `c88e8e1` — `site_01b: externalize legacy theme tarball (repo slimdown only)`

### C) Git object store shrink (history maintenance, no rewrite)
Ran:
- `git gc --prune=now --aggressive`

Observed result (from workstation):
- `motorcade.vip` total size: ~191MB
- `.git` size: ~94MB
- packed objects: `size-pack: 92.83 MiB`

Earlier in the session, an additional aggressive GC reclaimed ~99MB; combined effect reduced repo by ~33% from the original ~303MB baseline.

### D) Fixed GitHub push auth (stability)
Changed `motorcade.vip` remote from HTTPS to SSH due to `gnome-ssh-askpass` prompt failures:
- `origin` is now `git@github.com:dogcodeboy/motorcade.vip.git`
SSH auth verified:
- `ssh -T git@github.com` ✅
Push verified:
- `git push` ✅

## 🔒 Notes / governance

- This checkpoint is **docs-only** and belongs in `motorcade-infra` as part of governance history.
- **No history rewrite** was performed. True historical slimming would require a separately governed step (force-push plan).
- External archive remains the approved mechanism to keep session uploads small.

## ▶️ Next authorized work

Proceed to `site_02` (page-by-page render execution, asset-first) using:
- `SITE_THEME_TREE.md`
- `SITE_THEME_RENDER_INDEX.md`
- `SITE_THEME_ASSET_CONVENTIONS.md`
- `SITE_THEME_CHECKLIST.md`
