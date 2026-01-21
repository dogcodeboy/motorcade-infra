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
9. `PLAT_04_lead_intake_api.yml`
10. `PLAT_05_people_api.yml`
11. `PLAT_06_reverse_proxy_routes.yml`
12. `PLAT_07_backups_postgres_to_s3.yml`

### Identity (SSO / directory)
13. `ID_01_keycloak_bootstrap.yml`
14. `ID_02_freeipa_directory.yml`
15. `ID_03_service_accounts_and_rbac.yml`

### Mail/Calendar (groupware)
16. `MAIL_01_mailcow_deploy.yml`
17. `MAIL_02_imap_migrate.yml`
18. `MAIL_03_branding.yml`

## Acceptance criteria
A step is "complete" only when:
- Playbook exits `failed=0`
- Verification checks pass (curl/health/file existence)
- Restore path printed (if state changed)
- Versions pinned in `releases/<env>.yaml`
- Deployment log appended
