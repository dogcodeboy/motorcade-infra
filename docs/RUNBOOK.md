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

## Reference docs (clickable)
- [RESOURCES (hosts, service names, log commands)](./RESOURCES.md)
- [Platform docs (vision, governance, roadmap)](./platform/)
- [Doctrine](./doctrine/)
- [LeadGen docs](./leadgen/)
- [Deployments log + environment inventory](./deployments/)
- [Policies](./policies/)
- [Checkpoints](./checkpoints/)


## Current recommended order

### Website (temporary WordPress)
1. `WP_01_services_one_and_done.yml` (repo: `motorcade.vip`)
2. `WP_02_intake_and_scheduling.yml` (repo: `motorcade.vip`)
3. Checkpoint + log (append-only)

### Platform (containers)
4. `PLAT_01_docker_runtime_base.yml`
   - Notes: Podman is installed via locked-path method (`/usr/local/bin/podman`). See: [RESOURCES](./RESOURCES.md#podman-locked-path-install)
   - Legacy fallback (do not use unless required): [RUNBOOK_PLAT_01B_APPEND](./patches/legacy/RUNBOOK_PLAT_01B_APPEND.md)
5. `PLAT_02A_networks_volumes_systemd_foundations.yml`
6. `PLAT_02B_postgres_foundation.yml` (container foundation; no start)
7. `PLAT_02C_postgres_bringup.yml` (bring-up + healthcheck; boot-disabled)
8. `PLAT_03_postgres_schema_roles.yml` (schema + roles; still no app wiring)
9. `PLAT_04A_postgres_connectivity_ro.yml` (read-only connectivity verification)
   - **LOCKED — DO NOT RERUN**
   - Checkpoint: `docs/checkpoints/2026-01-20-PLAT_04A/`
   - Root cause resolved: Podman container name mismatch (correct container: `motorcade-postgres`)
   - Status: Ansible YAML, Vault secrets, Postgres roles/schema VERIFIED
   - Proceed next to: `PLAT_04_lead_intake_api.yml`
10. `PLAT_04_lead_intake_api.yml`
11. `PLAT_05_nginx_reverse_proxy_leadgen_api.yml`
   - **NGINX FROZEN** (verified). Do not modify unless OWNER-approved.
12. `PLAT_06_people_api.yml`
13. `PLAT_07_reverse_proxy_routes.yml`
14. `PLAT_08_backups_postgres_to_s3.yml`

15. `PLAT_08B_redis_queue_foundation.yml`
   - Status: COMPLETE (verified)
   - Checkpoint: `docs/checkpoints/2026-01-24-PLAT_08B/`
16. `PLAT_08C_redis_bringup_health_gate.yml`
   - Status: COMPLETE (verified) — Redis responds `PONG`
   - Notes: Redis bring-up uses readiness/health gate (no churn loops)
17. `PLAT_08D_redis_production_stability.yml`
   - Status: COMPLETE (verified)
   - Checkpoint: `docs/checkpoints/2026-01-25-PLAT_08D-Redis-Production-Stability/`
   - Notes: bounded self-healing healthcheck timer installed (`motorcade-redis-healthcheck.timer`)

18. `PLAT_09A_public_site_completion.yml` (to be created; repo: `motorcade.vip`)
   - Scope: finalize all public pages (no placeholders) + fix global layout/responsiveness
   - Completion: desktop/tablet/mobile verified; no horizontal overflow; services menu complete (EP moved under Services)
19. `PLAT_09B_leadgen_wordpress_bridge_finalization.yml` (to be created; repo: `motorcade-infra` + `motorcade.vip`)
   - Scope: complete WordPress → LeadGen API bridge and validate end-to-end intake flow
   - Completion: test submission from Contact/Assessment form produces LeadGen record; no 5xx; logs documented

### Identity (SSO / directory)
20. `ID_01_keycloak_bootstrap.yml`
21. `ID_02_freeipa_directory.yml`
22. `ID_03_service_accounts_and_rbac.yml`

### Mail/Calendar (groupware)
23. `MAIL_01_mailcow_deploy.yml`
24. `MAIL_02_imap_migrate.yml`
25. `MAIL_03_branding.yml`



## Acceptance criteria
A step is "complete" only when:
- Playbook exits `failed=0`
- Verification checks pass (curl/health/file existence)
- Restore path printed (if state changed)
- Versions pinned in `releases/<env>.yaml`
- Deployment log appended

---

# Canonical Deprecation Policy (Effective 2026-01-23-11)

**Goal:** Keep the platform build stable and recoverable while allowing iterative experimentation.

## Rules
1) If a playbook fails or is superseded, **do not delete it during active platform build**.
2) Move it to: `ansible/playbooks/deprecated/` (or the repo’s canonical deprecated folder) and add a clear banner:
   - `⚠️ DEPRECATED — DO NOT RUN`
   - Reason + date
   - Replacement playbook (if any) or “none”
3) Keep all deprecated items for historical context until the platform reaches a full “done” milestone.
4) A **purge pass** (deletion) is allowed only after:
   - Replacement is verified
   - RUNBOOK + checkpoints no longer reference it
   - A dedicated “PURGE” checkpoint is created

## Nginx Freeze Reminder
Nginx/SSL/HTTP2 is **frozen and verified**. Do not reopen or “fix” http2 warnings.
- Canonical nginx playbook allowed (HTTP:80 only): `ansible/playbooks/PLAT_06A_nginx_http80_canonical_redirect.yml`

## Next Subsystem (Non-nginx)
Proceed with **Podman / container services** and platform orchestration work (e.g., PLAT_08A+).


---
## Platform Progress — Current State (Append-Only)

### Completed
- PLAT_08B — Redis / Queue Foundation
  - Redis installed as internal-only foundation service
  - Runtime: rootful Podman (manual/static install; non-dnf)
  - systemd unit installed disabled + stopped by default
  - Network: motorcade-core
  - Persistent volume: /srv/motorcade/volumes/redis

### Active / Next
- PLAT_08C — Redis bring-up + health gate for dependent services
  - Explicit enable/start
  - Readiness and dependency verification

### Notes
- Nginx stack remains frozen and verified; do not reopen.
- Canonical deprecation policy remains in effect.
- Platform remains in foundation phase; services are installed before activation.

### Operator Guidance
- Refer to `docs/user-preferences.md` for authoritative session and build preferences.


---
## APPEND — 2026-01-25 — PLAT_08C Redis Bring-Up Blocked (Stability)

### What happened
- `motorcade-redis.service` entered an auto-restart loop.
- `motorcade-redis-ready.service` (readiness gate) hung because Redis never became reachable.
- Root cause observed in journald: Podman/conmon build does **not** support journald logging (`--log-driver journald`) on this host, causing the container start to fail.

### Key rule going forward
- **Do not use** `--log-driver journald` for Podman-managed containers on this stack.
- **Do not use** infinite/daemon-style readiness gates. Any health gating must be bounded and fail fast with actionable logs.

### Host naming note (recurring issue)
- Inventory host is **`motorcade-web-01`**.
- **`motorcade_web` does not exist** (avoid using it in playbooks/commands).

### Current status
- **PLAT_08C is BLOCKED** until the playbook is replaced with a stable, one-shot Redis bring-up that is compatible with the static Podman install on AL2023.

---

## PLAT_08C (Fix6) — Redis Bring-up Churn Stopper (Unit Rewrite + Volume Perms + SELinux)

If `motorcade-redis.service` is in an auto-restart loop and `podman exec motorcade-redis redis-cli ping` fails because the container is missing, apply Fix6.

**Run:**
```bash
cd ~/Repos/motorcade-infra/ansible
ansible-playbook -i inventories/prod/hosts.ini playbooks/PLAT_08C_redis_bringup_health_gate.yml --ask-vault-pass
```

**Expected:**
- `podman ps --filter name=motorcade-redis` shows **Up**
- `redis-cli ping` returns **PONG**


────────────────────────────────
FUTURE PLATFORM WORKSTREAM (POST-PLAT_08D)
────────────────────────────────

PLAT_09 — Public Site & LeadGen Completion

PLAT_09A — Public Site Completion (Content + Layout)
- Finalize all public-facing pages (no placeholders)
- Fix global layout and responsiveness issues
- Verify desktop, tablet, and mobile behavior

PLAT_09B — LeadGen WordPress Bridge Finalization
- Complete WordPress → LeadGen API bridge
- Validate end-to-end intake flow


### BRIDGE CONTRACT (STABLE)
- WordPress is **non-authoritative** (presentation + intake only)
- Bridge provides:
  - Bridge-owned intake form (shortcode/block) posting to LeadGen intake
  - WP Admin **read-only** viewer sourced from LeadGen admin endpoints
- **Abandoned-form capture (progressive consent):**
  - Local-only autosave starts immediately (browser)
  - Server-side draft save begins only after email/phone entered + inline notice shown
  - Continued interaction permits **one assistance follow-up**
  - SMS/scheduling require explicit opt-in
  - Draft TTL enforced; drafts are non-authoritative and do not create LeadGen leads unless submitted
- **Scheduling:** Capability stubs may exist but **must remain disabled** until Scheduling container is deployed

PLAT_10 — Identity Foundation (SSO + Email)
PLAT_11 — Employee Backend Service
PLAT_12 — Admin Panel (Control Plane MVP)
PLAT_13 — Client & Contract Operations
PLAT_14 — Billing Operations
PLAT_15 — Audit & Evidence Foundations
PLAT_16 — Governance Framework (Dormant)
PLAT_17 — Static Site Container
PLAT_18 — WordPress Deprecation
PLAT_19 — Governance Activation

---

## LeadGen — Wave 1 (Intake API + Leads persistence)

### Completed

1. **LEADGEN_01 — DB schema (leads)**
   - Playbook: `ansible/playbooks/LEADGEN_01_wave1_db_schema.yml`
   - Creates: `app.leads`, `app.schema_migrations`
   - Version: `20260126_01_wave1_leads`

2. **LEADGEN_02 — API deploy (Wave 1)**
   - Playbook: `ansible/playbooks/LEADGEN_02_wave1_api_deploy.yml`
   - systemd: `motorcade-leadgen-api.service`
   - Host bind: `127.0.0.1:8000 -> container:8080`
   - Health (host): `http://127.0.0.1:8000/lead/health`
   - Health (public via Nginx): `https://motorcade.vip/api/lead/health`

### Notes

- Vault hygiene: `vault_postgres_password` must exist **once** (no duplicate keys). If you see a duplicate-key warning, fix the encrypted vault file (keep the value that matches `/etc/motorcade/postgres.env` on the server).
- Nginx proxy expects the LeadGen API on `127.0.0.1:8000` (confirmed via `nginx -T`).

### Next

3. **LEADGEN_03 — Write-path hardening (DB-backed idempotency + intake persistence)**
   - Playbook: `ansible/playbooks/LEADGEN_03_wave1_write_path_hardening.yml`
   - Applies migration: `20260126_02_wave1_write_path` (adds `intake_id`, `request_id`, `idempotency_key`)
   - Enables real intake: `POST https://motorcade.vip/api/lead/intake`
   - Verifies:
     - Insert into `app.leads` succeeds
     - Duplicate `Idempotency-Key` does not create a second row

