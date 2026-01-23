# CHECKPOINT — 2026-01-23-4 — PLAT_07 (Nginx http2 directive modernization)

## Goal
Remove the non-blocking Nginx warning about deprecated `listen ... http2` syntax by moving to modern syntax (`http2 on;`).

## Deliverables
- `ansible/playbooks/PLAT_07_nginx_http2_directive_modernize.yml`
- `ansible/playbooks/README_PLAT_07.md`
- `ansible/playbooks/README.md` (index updated)
- Artifacts copied into `docs/checkpoints/2026-01-23-4/artifacts/`

## Expected result
Running `sudo nginx -t` should no longer show:
- `the "listen ... http2" directive is deprecated`

Config should remain valid and nginx reload safely.
