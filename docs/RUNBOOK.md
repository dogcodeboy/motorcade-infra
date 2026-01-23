# RUNBOOK (Authoritative)

This document is the **single source of truth** for build/deploy order across all Motorcade repos.

## Rules (Non-negotiable)
- **One-and-done**: each playbook must be idempotent and finish with verification.
- **Backup-first**: if touching state, create a copy-based backup and print restore path.
- **No manual drift**: do not hot-edit live state. Fix via playbook/template and rerun.
- **Pin versions**: nothing is considered "done" until pinned in a release manifest.
- **Log every deploy**: append an entry under `docs/deployments/YYYY-MM-DD.md`.

## Environments
- **prod**: live client-facing
- **staging**: safe test lane

## Current recommended order

### Website (temporary WordPress)
1. `WP_01_services_one_and_done.yml`
2. `WP_02_intake_and_scheduling.yml`
3. Checkpoint + log

### Platform (containers)
4. `PLAT_01_docker_runtime_base.yml`
5. `PLAT_02A_networks_volumes_systemd_foundations.yml`
6. `PLAT_02B_postgres_foundation.yml` (container foundation; no start)
7. `PLAT_02C_postgres_bringup.yml` (bring-up + healthcheck; boot-disabled)
8. `PLAT_03_postgres_schema_roles.yml` (schema + roles; still no app wiring)
9. `PLAT_04A_postgres_connectivity_ro.yml` (read-only connectivity verification)
   - **LOCKED — DO NOT RERUN**
   - Status: Postgres roles/schema + RO connectivity VERIFIED
   - Proceed next to: **Podman foundation** (see PLAT_08A below)

10. `PLAT_06A_nginx_http80_canonical_redirect.yml` (**FINAL — nginx frozen**)
   - Checkpoint: `docs/checkpoints/2026-01-23-5/`
   - Note: One warning about `listen ... http2` deprecation is acceptable and final.

11. `PLAT_08A_podman_container_services_foundation.yml` (**NEXT EXECUTION POINT**)
   - Purpose: baseline Podman runtime + networks/volumes + systemd integration for containers
   - Reason for numbering: `PLAT_07*` in repo is legacy nginx http2 “modernize” work and is **quarantined / prohibited** due to nginx freeze.

12. `PLAT_04_lead_intake_api.yml` (**DEFERRED** — requires PLAT_08A first)
13. `PLAT_05_nginx_reverse_proxy_leadgen_api.yml` (**DEFERRED / PROHIBITED** — nginx frozen)
14. `PLAT_07_reverse_proxy_routes.yml` (**DEFERRED / PROHIBITED** — nginx frozen)
15. `PLAT_08_backups_postgres_to_s3.yml` (allowed once container foundation is complete)

### Identity (SSO / directory)
15. `ID_01_keycloak_bootstrap.yml`
16. `ID_02_freeipa_directory.yml`
17. `ID_03_service_accounts_and_rbac.yml`

### Mail/Calendar (groupware)
18. `MAIL_01_mailcow_deploy.yml`
19. `MAIL_02_imap_migrate.yml`
20. `MAIL_03_branding.yml`

## Quarantined / Prohibited Items

### Nginx http2 “modernize” playbooks (DO NOT RUN)
These exist in the repo for historical context but are prohibited because nginx is frozen:
- `ansible/playbooks/PLAT_07_nginx_http2_directive_modernize.yml`
- `ansible/playbooks/PLAT_07A_nginx_http2_directive_modernize.yml`

### Reverse proxy routing playbooks (DEFERRED)
Any playbooks that modify nginx routing are deferred until an explicit future checkpoint authorizes reopening nginx.

---

## Acceptance criteria
A step is "complete" only when:
- Playbook exits `failed=0`
- Verification checks pass (curl/health/file existence)
- Restore path printed (if state changed)
- Versions pinned in `releases/<env>.yaml`
- Deployment log appended
