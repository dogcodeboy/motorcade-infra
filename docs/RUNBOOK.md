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
1. 🟨 `WP_01_services_one_and_done.yml` (repo: `motorcade.vip`)
2. 🟩 `WP_02_intake_and_scheduling.yml` (repo: `motorcade.vip`)
3. 🟩 Checkpoint + log (append-only)

### Platform (containers)
4. 🟩 `PLAT_01_docker_runtime_base.yml`
   - Notes: Podman is installed via locked-path method (`/usr/local/bin/podman`). See: [RESOURCES](./RESOURCES.md#podman-locked-path-install)
   - Legacy fallback (do not use unless required): [RUNBOOK_PLAT_01B_APPEND](./patches/legacy/RUNBOOK_PLAT_01B_APPEND.md)
5. 🟩 `PLAT_02A_networks_volumes_systemd_foundations.yml`
6. 🟩 `PLAT_02B_postgres_foundation.yml` (container foundation; no start)
7. 🟩 `PLAT_02C_postgres_bringup.yml` (bring-up + healthcheck; boot-disabled)
8. 🟩 `PLAT_03_postgres_schema_roles.yml` (schema + roles; still no app wiring)
9. 🟩 `PLAT_04A_postgres_connectivity_ro.yml` (read-only connectivity verification)
   - **LOCKED — DO NOT RERUN**
   - Checkpoint: `docs/checkpoints/2026-01-20-PLAT_04A/`
   - Root cause resolved: Podman container name mismatch (correct container: `motorcade-postgres`)
   - Status: Ansible YAML, Vault secrets, Postgres roles/schema VERIFIED
   - Proceed next to: `PLAT_04_lead_intake_api.yml`
10. 🟨 `PLAT_04_lead_intake_api.yml`
#### LeadGen repository boundary (authoritative)

- LeadGen application source lives in the separate repository: `motorcade-leadgen` (NOT `motorcade-infra`).
- On production host `motorcade-web-01`, the LeadGen working tree is: `/opt/motorcade-leadgen`
- Canonical app paths used for builds:
  - `/opt/motorcade-leadgen/app/api/leadgen_api/main.py`
  - `/opt/motorcade-leadgen/app/api/requirements.txt`
- Infra playbooks must rebuild/redeploy the LeadGen image from the `motorcade-leadgen` build context; do **not** copy/patch app source files directly via Ansible.

11. 🟩 `PLAT_05_nginx_reverse_proxy_leadgen_api.yml`
   - **NGINX FROZEN** (verified). Do not modify unless OWNER-approved.
12. 🟩 `PLAT_06_people_api.yml`
13. 🟩 `PLAT_07_reverse_proxy_routes.yml`
14. 🟩 `PLAT_08_backups_postgres_to_s3.yml`

15. 🟩 `PLAT_08B_redis_queue_foundation.yml`
   - Status: COMPLETE (verified)
   - Checkpoint: `docs/checkpoints/2026-01-24-PLAT_08B/`
16. 🟩 `PLAT_08C_redis_bringup_health_gate.yml`
   - Status: COMPLETE (verified) — Redis responds `PONG`
   - Notes: Redis bring-up uses readiness/health gate (no churn loops)
17. 🟩 `PLAT_08D_redis_production_stability.yml`
   - Status: COMPLETE (verified)
   - Checkpoint: `docs/checkpoints/2026-01-25-PLAT_08D-Redis-Production-Stability/`
   - Notes: bounded self-healing healthcheck timer installed (`motorcade-redis-healthcheck.timer`)
   
## LeadGen — Wave 1 (Intake API + Leads persistence)

### Completed

18. 🟨 **LEADGEN_01 — DB schema (leads)**
   - Playbook: `ansible/playbooks/LEADGEN_01_wave1_db_schema.yml`
   - Creates: `app.leads`, `app.schema_migrations`
   - Version: `20260126_01_wave1_leads`

19. 🟨 **LEADGEN_02 — API deploy (Wave 1)**
   - Playbook: `ansible/playbooks/LEADGEN_02_wave1_api_deploy.yml`
   - systemd: `motorcade-leadgen-api.service`
   - Host bind: `127.0.0.1:8000 -> container:8080`
   - Health (host): `http://127.0.0.1:8000/lead/health`
   - Health (public via Nginx): `https://motorcade.vip/api/lead/health`
20. 🟨 **LEADGEN_03 — Write-path hardening (DB-backed idempotency + intake persistence)**
   - Playbook: `ansible/playbooks/LEADGEN_03_wave1_write_path_hardening.yml`
   - Applies migration: `20260126_02_wave1_write_path` (adds `intake_id`, `request_id`, `idempotency_key`)
   - Enables real intake: `POST https://motorcade.vip/api/lead/intake`
   - Verifies:
     - Insert into `app.leads` succeeds
     - Duplicate `Idempotency-Key` does not create a second row

21. 🟨 **LEADGEN_04 — Runtime hardening (Wave 2)**
   - Playbook: `ansible/playbooks/LEADGEN_04_wave2_runtime_hardening.yml`
   - Purpose: production-stabilize the LeadGen API runtime (hardened systemd unit + bounded logs + resource caps + watchdog timer)
   - Checkpoint: `docs/checkpoints/2026-01-26-LEADGEN_04-Wave2-Runtime-Hardening/`

22. 🟩 **LEADGEN_05 — Wave 3 E2E intake validation (iteration series)**
   - Purpose: align E2E payload + contract with current OpenAPI, validate end-to-end intake behavior, and collect safe diagnostics during failures
   - Checkpoints (historical iterations; use the latest verified one):
     - `docs/checkpoints/2026-01-26-LEADGEN_05-Wave3-Intake-E2E-Validation/`
     - `docs/checkpoints/2026-01-26-LEADGEN_05-Wave3-E2E-PayloadFixV3/`
     - `docs/checkpoints/2026-01-26-LEADGEN_05_06-Keys-and-Wave3-E2E-Fix/`
     - `docs/checkpoints/2026-01-26-LEADGEN_05-Wave3-E2E-DiagSafeV4/`
     - `docs/checkpoints/2026-01-26-LEADGEN_05-Wave3-E2E-DiagSafeV5/`
     - `docs/checkpoints/2026-01-26-LEADGEN_05-Wave3-E2E-FixV6/`
     - `docs/checkpoints/2026-01-26-LEADGEN_05-Wave3-E2E-FixV7/`

23. 🟩 **LEADGEN_06 — API keys config**
   - Purpose: ensure API key material is present/loaded correctly for the LeadGen intake path (env + infra wiring)
   - Checkpoint: `docs/checkpoints/2026-01-26-LEADGEN_06-API-Keys-Config/`


24. 🟩 **LEADGEN_07B — Psycopg JSONB persistence + Wave 3 schema E2E verify (Authoritative PASS)**
   - Playbook: `ansible/playbooks/LEADGEN_07B_wave3_psycopg_driver_fix_and_persistence_verify.yml`
   - Verified: **2026-01-28**
   - Deploy ref (LeadGen app): tag `leadgen-wave1-2026-01-28b` (SHA: `94da1cdbfb22fb731a51944cc01a12f23e1740b7`)
   - Implementation branch used during fix: `sync/server-leadgen-fixes-2026-01-27` (intermediate commit: `44a9d47`)
   - What was fixed (app-level, in `motorcade-leadgen`):
     - Persisting request payload now uses psycopg3 JSON adapters (e.g., `Jsonb(...)`) so Postgres `jsonb` writes are deterministic (no “cannot adapt type 'dict'”).
   - What was fixed (infra/test contract, in `motorcade-infra`):
     - E2E payload updated to match current OpenAPI (`/lead/intake` requires `contact` + `request` with `timeline` + `location`).
     - Service-area states are configurable (default `["TX"]`) so TX-only can expand later without code changes (admin console can manage this later).
   - Verified outcomes (motorcade-web-01):
     - `GET http://127.0.0.1:8000/lead/health` → `200 OK`
     - `POST http://127.0.0.1:8000/lead/intake` → `202 Accepted` with `intake_id` + `request_id`
     - Postgres durability check succeeds: `app.leads` row count increases; newest timestamp updates.

   - **Pinning rule (production stability):**
     - The playbook now defaults to a pinned release tag for deterministic deployments:
       - `leadgen_git_ref: leadgen-wave1-2026-01-28b` (SHA: `94da1cdbfb22fb731a51944cc01a12f23e1740b7`)
     - Override is allowed **only** for controlled roll-forward / rollback testing:
       - `-e leadgen_git_ref=<release-tag-or-sha>`

25. 🟩 **LEADGEN_07C — Postgres-only async boundary (outbox queue + worker) (Authoritative PASS)**
   - Playbook: `ansible/playbooks/LEADGEN_07C_wave4_postgres_outbox_async_boundary.yml`
   - Verified: **2026-01-28**
   - Deploy ref (LeadGen app): tag `leadgen-wave1-2026-01-28c`
   - Adds durable queue table: `app.intake_jobs`
   - Contract:
     - `POST /lead/intake` returns **202** once job is enqueued (even if worker is stopped)
     - Worker drains queued jobs into `app.leads`
     - Idempotency enforced via `app.intake_jobs.idempotency_key` (unique) + payload match
   - Checkpoint: `docs/checkpoints/2026-01-28_LEADGEN_07C_PASS/`
   

26. 🟨 `PLAT_09A_public_site_completion.yml` (to be created; repo: `motorcade.vip`)
    # 🔗 PLAT_09A — Site Theme Runbook (Authoritative)
   - GitHub:
    - https://github.com/dogcodeboy/motorcade-infra/blob/main/docs/runbooks/SITE_THEME_RUNBOOK.md
   - Scope: finalize all public pages (no placeholders) + fix global layout/responsiveness
   - Completion: desktop/tablet/mobile verified; no horizontal overflow; services menu complete (EP moved under Services)
27. 🟨 `PLAT_09B_leadgen_wordpress_bridge_finalization.yml` (to be created; repo: `motorcade-infra` + `motorcade.vip`)
   - Scope: complete WordPress → LeadGen API bridge and validate end-to-end intake flow
   - Completion: test submission from Contact/Assessment form produces LeadGen record; no 5xx; logs documented
   
   🟨 LEADGEN_08 (Optional)

### Identity (SSO / directory)
28. 🟨 `ID_01_keycloak_bootstrap.yml`
29. 🟨 `ID_02_freeipa_directory.yml`
30. 🟨 `ID_03_service_accounts_and_rbac.yml`

### Mail/Calendar (groupware)
31. 🟨 `MAIL_01_mailcow_deploy.yml`
32. 🟨 `MAIL_02_imap_migrate.yml`
33. 🟨 `MAIL_03_branding.yml`

🟦 BUSINESS PLATFORM
34. 🟨 PLAT_10 — Identity Foundation (SSO + Email)
35. 🟨 PLAT_11 — Employee Backend Service
    -Guards
    -Supervisors
    -Fatigue rules

36. 🟨 PLAT_12 — Admin Panel (Control Plane MVP)
   - Admin AI Authority & Control Plane
    -See: docs/admin-ai/ADMIN_AI_RECONSTRUCTION_AND_SCOPE.md (authoritative)
   - Config
   - Overrides
   - Kill switches

37. 🟨 PLAT_13 — Client & Contract Operations
    -Contracts
    -SLAs
    -Assignments

38. 🟨 PLAT_14 — Billing Operations
    -Invoicing
    -Payroll
    -Client authorization

🟦 GOVERNANCE & LEGAL
39. 🟨 PLAT_15 — Audit & Evidence Foundations
    -Chain of custody
    -Evidence vault

40. 🟥 PLAT_16 — Governance Framework (Dormant)
41. 🟨 PLAT_17 — Static Site Container
42. 🟨 PLAT_18 — WordPress Deprecation
43. 🟨 PLAT_19 — Governance Activation
    -Owner sign-off
    -Legal readiness

🟦 MOBILE PLATFORM (POST-PLAT_19)

Mobile is a second platform, not a UI but will be connected to UI

44. 🟨 MOB_00 — Mobile Architecture Definition (Gate)
45. 🟨 MOB_01 — Mobile Environment Foundations
46. 🟨 MOB_02 — Mobile Identity & Auth Integration
47. 🟨 MOB_03 — Secure Mobile SDK / API Client
48. 🟨 MOB_04 — Mobile Data Persistence Layer
49. 🟨 MOB_05 — Push & Realtime Infrastructure
50. 🟨 MOB_06 — Driver App
51. 🟨 MOB_07 — Guard App
52. 🟨 MOB_08 — Supervisor / Dispatch App
53. 🟨 MOB_09 — Client App
54. 🟨 MOB_10 — Mobile Role Switching
55. 🟨 MOB_11 — Mobile Threat Intelligence Integration
56. 🟨 MOB_12 — Mobile Evidence Handling
57. 🟨 MOB_13 — Offline Operations Mode
58. 🟨 MOB_14 — Mobile Security Hardening
59. 🟨 MOB_15 — Mobile Observability
60. 🟨 MOB_16 — App Lifecycle Management
61. 🟨 MOB_17 — App Store Compliance
62. 🟨 MOB_18 — Mobile Governance Integration
63. 🟨 MOB_19 — Mobile Platform Activation

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

🟨 PLAT_09 — Public Site & LeadGen Completion

🟨 PLAT_09A — Public Site Completion (Content + Layout)
- Finalize all public-facing pages (no placeholders)
- Fix global layout and responsiveness issues
- Verify desktop, tablet, and mobile behavior

🟨 PLAT_09B — LeadGen WordPress Bridge Finalization
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

🟨 PLAT_10 — Identity Foundation (SSO + Email)
🟨 PLAT_11 — Employee Backend Service
🟨 PLAT_12 — Admin Panel (Control Plane MVP)
🟨 PLAT_13 — Client & Contract Operations
🟨 PLAT_14 — Billing Operations
🟨 PLAT_15 — Audit & Evidence Foundations
🟥 PLAT_16 — Governance Framework (Dormant)
🟨 PLAT_17 — Static Site Container
🟨 PLAT_18 — WordPress Deprecation
🟨 PLAT_19 — Governance Activation

---


### Notes

- Vault hygiene: `vault_postgres_password` must exist **once** (no duplicate keys). If you see a duplicate-key warning, fix the encrypted vault file (keep the value that matches `/etc/motorcade/postgres.env` on the server).
- Nginx proxy expects the LeadGen API on `127.0.0.1:8000` (confirmed via `nginx -T`).

### Next

