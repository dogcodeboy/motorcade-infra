# VERIFY — 2026-01-29 — SITE_01b Externalize tarball + Git GC + SSH remote

## 1) Confirm external archive contains all legacy artifacts
```bash
ls -lh ~/Repos/Archives/motorcade/site-theme-legacy/
```

Expected to include:
- motorcade-trust-theme.zip
- motorcade-trust-live_20260128T125828Z.tar.gz
- motorcade-trust-theme-live.tar.gz
(all outside the repos you zip for upload)

## 2) Confirm repo no longer contains the tarball
```bash
cd ~/Repos/motorcade.vip
test ! -f ansible/motorcade-trust-theme-live.tar.gz && echo "OK: tarball not in repo"
```

## 3) Confirm remote is SSH and push works
```bash
cd ~/Repos/motorcade.vip
git remote -v
ssh -T git@github.com
git push
```

## 4) Confirm current size snapshot (post-GC)
```bash
cd ~/Repos/motorcade.vip
du -h -d 1 . | sort -h | tail -n 25
git count-objects -vH
```

## 5) Confirm clean working tree
```bash
cd ~/Repos/motorcade.vip && git status
cd ~/Repos/motorcade-infra && git status
cd ~/Repos/motorcade-leadgen && git status
```
