# 🟦 ADMIN-AI MASTER RUNBOOK
## Canonical build sequence for Admin-AI + dependent platform services

### Status Legend
- 🟩 PASS / Completed
- 🟨 Defined / Planned
- 🟥 Blocked / Deferred
- 🟦 Governance / Structural

### Authority resolution (if disputed)
1. **docs/checkpoints/** (newest explicit lock wins)
2. **docs/runbook-attachments/** (governance + design)
3. **docs/Admin-AI/** (this runbook + step docs)
4. **docs/RUNBOOK.md** (context only)

### Global invariants
- Admin-AI is **never turned off** (staging lane exists to avoid downtime).
- Podman is a **standalone/static install**; `dnf` does not track it.
- Changes flow **staging → live** with explicit promotion and audit.

## Admin-AI
*Notes:* Always-on orchestrator: authority, intent, facts, audit, promotion.

### 🟨 01 — Admin-AI_01
- **Outcome:** Admin-AI container bootstrap (live + staging lanes)
- **Step doc:** [`docs/Admin-AI/steps/Admin-AI_01.md`](docs/Admin-AI/steps/Admin-AI_01.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/checkpoints/2026-01-30_ADMIN_AI_AUTOSCALING_INTENT_LOCK/`](docs/checkpoints/2026-01-30_ADMIN_AI_AUTOSCALING_INTENT_LOCK/)
  - Supporting: [`docs/checkpoints/2026-01-30_ADMIN_AI_GOVERNANCE_COMPLETE/`](docs/checkpoints/2026-01-30_ADMIN_AI_GOVERNANCE_COMPLETE/)
  - Supporting: [`docs/RUNBOOK.md`](docs/RUNBOOK.md)
  - Supporting: [`docs/admin-ai/ADMIN_AI_RECONSTRUCTION_AND_SCOPE.md`](docs/admin-ai/ADMIN_AI_RECONSTRUCTION_AND_SCOPE.md)

### 🟦 02 — Admin-AI_02
- **Outcome:** Authority model, invariants, refusal + halt semantics
- **Step doc:** [`docs/Admin-AI/steps/Admin-AI_02.md`](docs/Admin-AI/steps/Admin-AI_02.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/checkpoints/2026-01-30_ADMIN_AI_GOVERNANCE_COMPLETE/`](docs/checkpoints/2026-01-30_ADMIN_AI_GOVERNANCE_COMPLETE/)
  - Supporting: [`docs/runbook-attachments/ADMIN_AI_GOVERNANCE_COMPLETE.md`](docs/runbook-attachments/ADMIN_AI_GOVERNANCE_COMPLETE.md)
  - Supporting: [`docs/runbook-attachments/STEP_36_ADMIN_AI_AUTHORITY.md`](docs/runbook-attachments/STEP_36_ADMIN_AI_AUTHORITY.md)
  - Supporting: [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

### 🟦 03 — Admin-AI_03
- **Outcome:** Facts/Memory/Intent separation implementation rules
- **Step doc:** [`docs/Admin-AI/steps/Admin-AI_03.md`](docs/Admin-AI/steps/Admin-AI_03.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/checkpoints/2026-01-30_ADMIN_AI_GOVERNANCE_COMPLETE/`](docs/checkpoints/2026-01-30_ADMIN_AI_GOVERNANCE_COMPLETE/)
  - Supporting: [`docs/runbook-attachments/ADMIN_AI_GOVERNANCE_COMPLETE.md`](docs/runbook-attachments/ADMIN_AI_GOVERNANCE_COMPLETE.md)
  - Supporting: [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

### 🟦 04 — Admin-AI_04
- **Outcome:** Audit ledger bring-up + integrity checks (local first)
- **Step doc:** [`docs/Admin-AI/steps/Admin-AI_04.md`](docs/Admin-AI/steps/Admin-AI_04.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/checkpoints/2026-01-30_ADMIN_AI_GOVERNANCE_COMPLETE/`](docs/checkpoints/2026-01-30_ADMIN_AI_GOVERNANCE_COMPLETE/)
  - Supporting: [`docs/runbook-attachments/ADMIN_AI_GOVERNANCE_COMPLETE.md`](docs/runbook-attachments/ADMIN_AI_GOVERNANCE_COMPLETE.md)
  - Supporting: [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

### 🟦 05 — Admin-AI_05
- **Outcome:** Execution gate framework (staging-only at first)
- **Step doc:** [`docs/Admin-AI/steps/Admin-AI_05.md`](docs/Admin-AI/steps/Admin-AI_05.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/checkpoints/2026-01-30_ADMIN_AI_GOVERNANCE_COMPLETE/`](docs/checkpoints/2026-01-30_ADMIN_AI_GOVERNANCE_COMPLETE/)
  - Supporting: [`docs/checkpoints/2026-01-30_ADMIN_AI_STEP28/`](docs/checkpoints/2026-01-30_ADMIN_AI_STEP28/)
  - Supporting: [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

### 🟨 06 — Admin-AI_06
- **Outcome:** Staging lane: change-test harness + dry-run policies
- **Step doc:** [`docs/Admin-AI/steps/Admin-AI_06.md`](docs/Admin-AI/steps/Admin-AI_06.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/checkpoints/2026-01-30_ADMIN_AI_STEP28/`](docs/checkpoints/2026-01-30_ADMIN_AI_STEP28/)
  - Supporting: [`docs/runbook-attachments/STEP_ADMIN_AI_OPEN_QUESTIONS.md`](docs/runbook-attachments/STEP_ADMIN_AI_OPEN_QUESTIONS.md)
  - Supporting: [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

### 🟨 07 — Admin-AI_07
- **Outcome:** Promotion workflow: staging → live (no drift)
- **Step doc:** [`docs/Admin-AI/steps/Admin-AI_07.md`](docs/Admin-AI/steps/Admin-AI_07.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/checkpoints/2026-01-30_ADMIN_AI_AUTOSCALING_INTENT_LOCK/`](docs/checkpoints/2026-01-30_ADMIN_AI_AUTOSCALING_INTENT_LOCK/)
  - Supporting: [`docs/checkpoints/2026-01-30_ADMIN_AI_GOVERNANCE_COMPLETE/`](docs/checkpoints/2026-01-30_ADMIN_AI_GOVERNANCE_COMPLETE/)
  - Supporting: [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

### 🟦 08 — Admin-AI_08
- **Outcome:** Break-glass destructive revocation (OWNER-only)
- **Step doc:** [`docs/Admin-AI/steps/Admin-AI_08.md`](docs/Admin-AI/steps/Admin-AI_08.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/checkpoints/2026-01-30_ADMIN_AI_GOVERNANCE_COMPLETE/`](docs/checkpoints/2026-01-30_ADMIN_AI_GOVERNANCE_COMPLETE/)
  - Supporting: [`docs/runbook-attachments/ADMIN_AI_GOVERNANCE_COMPLETE.md`](docs/runbook-attachments/ADMIN_AI_GOVERNANCE_COMPLETE.md)
  - Supporting: [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

## SSO
*Notes:* Authentication boundary and RBAC mapping. No execution authority.

### 🟨 09 — SSO_01
- **Outcome:** SSO architecture + integration points (Admin-AI aware)
- **Step doc:** [`docs/Admin-AI/services/SSO_01.md`](docs/Admin-AI/services/SSO_01.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/checkpoints/2026-01-30_ADMIN_AI_GOVERNANCE_COMPLETE/`](docs/checkpoints/2026-01-30_ADMIN_AI_GOVERNANCE_COMPLETE/)
  - Supporting: [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

### 🟨 10 — SSO_02
- **Outcome:** RBAC model + role mapping (OWNER/Admin/Dispatcher/etc.)
- **Step doc:** [`docs/Admin-AI/services/SSO_02.md`](docs/Admin-AI/services/SSO_02.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/runbook-attachments/STEP_36_ADMIN_AI_AUTHORITY.md`](docs/runbook-attachments/STEP_36_ADMIN_AI_AUTHORITY.md)
  - Supporting: [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

### 🟨 11 — SSO_03
- **Outcome:** Client multi-org login model (limits + sites)
- **Step doc:** [`docs/Admin-AI/services/SSO_03.md`](docs/Admin-AI/services/SSO_03.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/checkpoints/2026-01-30_ADMIN_AI_STEP28/`](docs/checkpoints/2026-01-30_ADMIN_AI_STEP28/)
  - Supporting: [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

### 🟨 12 — SSO_04
- **Outcome:** Service accounts + API auth strategy (non-human)
- **Step doc:** [`docs/Admin-AI/services/SSO_04.md`](docs/Admin-AI/services/SSO_04.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/checkpoints/2026-01-30_ADMIN_AI_STEP28/`](docs/checkpoints/2026-01-30_ADMIN_AI_STEP28/)
  - Supporting: [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

### 🟨 13 — SSO_05
- **Outcome:** Session policy, MFA policy, device policy (ops defaults)
- **Step doc:** [`docs/Admin-AI/services/SSO_05.md`](docs/Admin-AI/services/SSO_05.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

## LDAP
*Notes:* Canonical directory: users, groups, service accounts. Staging→live strategy.

### 🟨 14 — LDAP_01
- **Outcome:** Directory service choice + topology (staging/live)
- **Step doc:** [`docs/Admin-AI/services/LDAP_01.md`](docs/Admin-AI/services/LDAP_01.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/runbook-attachments/STEP_ADMIN_AI_LDAP_GOVERNANCE.md`](docs/runbook-attachments/STEP_ADMIN_AI_LDAP_GOVERNANCE.md)
  - Supporting: [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

### 🟨 15 — LDAP_02
- **Outcome:** Base DIT + naming conventions + org/site scoping
- **Step doc:** [`docs/Admin-AI/services/LDAP_02.md`](docs/Admin-AI/services/LDAP_02.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/runbook-attachments/STEP_ADMIN_AI_LDAP_GOVERNANCE.md`](docs/runbook-attachments/STEP_ADMIN_AI_LDAP_GOVERNANCE.md)
  - Supporting: [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

### 🟨 16 — LDAP_03
- **Outcome:** Groups/Roles schema aligned to RBAC
- **Step doc:** [`docs/Admin-AI/services/LDAP_03.md`](docs/Admin-AI/services/LDAP_03.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/runbook-attachments/STEP_ADMIN_AI_LDAP_GOVERNANCE.md`](docs/runbook-attachments/STEP_ADMIN_AI_LDAP_GOVERNANCE.md)
  - Supporting: [`docs/runbook-attachments/STEP_36_ADMIN_AI_AUTHORITY.md`](docs/runbook-attachments/STEP_36_ADMIN_AI_AUTHORITY.md)
  - Supporting: [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

### 🟨 17 — LDAP_04
- **Outcome:** Service accounts lifecycle + rotation hooks
- **Step doc:** [`docs/Admin-AI/services/LDAP_04.md`](docs/Admin-AI/services/LDAP_04.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/runbook-attachments/STEP_ADMIN_AI_LDAP_GOVERNANCE.md`](docs/runbook-attachments/STEP_ADMIN_AI_LDAP_GOVERNANCE.md)
  - Supporting: [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

### 🟨 18 — LDAP_05
- **Outcome:** Staging→Live directory promotion strategy
- **Step doc:** [`docs/Admin-AI/services/LDAP_05.md`](docs/Admin-AI/services/LDAP_05.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/runbook-attachments/STEP_ADMIN_AI_LDAP_GOVERNANCE.md`](docs/runbook-attachments/STEP_ADMIN_AI_LDAP_GOVERNANCE.md)
  - Supporting: [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

### 🟨 19 — LDAP_06
- **Outcome:** Directory backup/restore + disaster recovery runbook
- **Step doc:** [`docs/Admin-AI/services/LDAP_06.md`](docs/Admin-AI/services/LDAP_06.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/runbook-attachments/STEP_ADMIN_AI_LDAP_GOVERNANCE.md`](docs/runbook-attachments/STEP_ADMIN_AI_LDAP_GOVERNANCE.md)
  - Supporting: [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

## Email
*Notes:* System messaging, notifications, and inbound rules.

### 🟨 20 — Email_01
- **Outcome:** Mail domain strategy + system mailbox plan
- **Step doc:** [`docs/Admin-AI/services/Email_01.md`](docs/Admin-AI/services/Email_01.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/runbook-attachments/STEP_ADMIN_AI_EMAIL_GOVERNANCE.md`](docs/runbook-attachments/STEP_ADMIN_AI_EMAIL_GOVERNANCE.md)
  - Supporting: [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

### 🟨 21 — Email_02
- **Outcome:** Outbound relay setup + DKIM/SPF/DMARC plan
- **Step doc:** [`docs/Admin-AI/services/Email_02.md`](docs/Admin-AI/services/Email_02.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/runbook-attachments/STEP_ADMIN_AI_EMAIL_GOVERNANCE.md`](docs/runbook-attachments/STEP_ADMIN_AI_EMAIL_GOVERNANCE.md)
  - Supporting: [`docs/runbook-attachments/STEP_ADMIN_AI_DNS_DOMAIN_CONNECT.md`](docs/runbook-attachments/STEP_ADMIN_AI_DNS_DOMAIN_CONNECT.md)
  - Supporting: [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

### 🟨 22 — Email_03
- **Outcome:** Inbound processing rules (no command execution)
- **Step doc:** [`docs/Admin-AI/services/Email_03.md`](docs/Admin-AI/services/Email_03.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/runbook-attachments/STEP_ADMIN_AI_EMAIL_GOVERNANCE.md`](docs/runbook-attachments/STEP_ADMIN_AI_EMAIL_GOVERNANCE.md)
  - Supporting: [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

### 🟨 23 — Email_04
- **Outcome:** Notification routing (alerts, audit notices, client comms)
- **Step doc:** [`docs/Admin-AI/services/Email_04.md`](docs/Admin-AI/services/Email_04.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/runbook-attachments/STEP_ADMIN_AI_EMAIL_GOVERNANCE.md`](docs/runbook-attachments/STEP_ADMIN_AI_EMAIL_GOVERNANCE.md)
  - Supporting: [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

### 🟨 24 — Email_05
- **Outcome:** Retention + journaling + eDiscovery considerations
- **Step doc:** [`docs/Admin-AI/services/Email_05.md`](docs/Admin-AI/services/Email_05.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/runbook-attachments/STEP_ADMIN_AI_EMAIL_GOVERNANCE.md`](docs/runbook-attachments/STEP_ADMIN_AI_EMAIL_GOVERNANCE.md)
  - Supporting: [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

## DNS
*Notes:* Domain connect, records lifecycle, and certificate hooks.

### 🟨 25 — DNS_01
- **Outcome:** Domain connect + DNS authority boundaries
- **Step doc:** [`docs/Admin-AI/services/DNS_01.md`](docs/Admin-AI/services/DNS_01.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/runbook-attachments/STEP_ADMIN_AI_DNS_DOMAIN_CONNECT.md`](docs/runbook-attachments/STEP_ADMIN_AI_DNS_DOMAIN_CONNECT.md)
  - Supporting: [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

### 🟨 26 — DNS_02
- **Outcome:** Record lifecycle policy (intent-driven)
- **Step doc:** [`docs/Admin-AI/services/DNS_02.md`](docs/Admin-AI/services/DNS_02.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/runbook-attachments/STEP_ADMIN_AI_DNS_DOMAIN_CONNECT.md`](docs/runbook-attachments/STEP_ADMIN_AI_DNS_DOMAIN_CONNECT.md)
  - Supporting: [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

### 🟨 27 — DNS_03
- **Outcome:** TLS certificate automation hooks (future enable)
- **Step doc:** [`docs/Admin-AI/services/DNS_03.md`](docs/Admin-AI/services/DNS_03.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/runbook-attachments/STEP_ADMIN_AI_DNS_DOMAIN_CONNECT.md`](docs/runbook-attachments/STEP_ADMIN_AI_DNS_DOMAIN_CONNECT.md)
  - Supporting: [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

### 🟨 28 — DNS_04
- **Outcome:** Disaster recovery: zone export/import + rollback
- **Step doc:** [`docs/Admin-AI/services/DNS_04.md`](docs/Admin-AI/services/DNS_04.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/runbook-attachments/STEP_ADMIN_AI_DNS_DOMAIN_CONNECT.md`](docs/runbook-attachments/STEP_ADMIN_AI_DNS_DOMAIN_CONNECT.md)
  - Supporting: [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

## Audit
*Notes:* Append-only ledger, retention/export, verification and review SOP.

### 🟦 29 — Audit_01
- **Outcome:** Audit schema + required fields + chaining rules
- **Step doc:** [`docs/Admin-AI/services/Audit_01.md`](docs/Admin-AI/services/Audit_01.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/checkpoints/2026-01-30_ADMIN_AI_GOVERNANCE_COMPLETE/`](docs/checkpoints/2026-01-30_ADMIN_AI_GOVERNANCE_COMPLETE/)
  - Supporting: [`docs/runbook-attachments/ADMIN_AI_GOVERNANCE_COMPLETE.md`](docs/runbook-attachments/ADMIN_AI_GOVERNANCE_COMPLETE.md)
  - Supporting: [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

### 🟦 30 — Audit_02
- **Outcome:** Write-ahead audit enforcement for actions
- **Step doc:** [`docs/Admin-AI/services/Audit_02.md`](docs/Admin-AI/services/Audit_02.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/checkpoints/2026-01-30_ADMIN_AI_GOVERNANCE_COMPLETE/`](docs/checkpoints/2026-01-30_ADMIN_AI_GOVERNANCE_COMPLETE/)
  - Supporting: [`docs/runbook-attachments/ADMIN_AI_GOVERNANCE_COMPLETE.md`](docs/runbook-attachments/ADMIN_AI_GOVERNANCE_COMPLETE.md)
  - Supporting: [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

### 🟨 31 — Audit_03
- **Outcome:** Retention policy + archive/export
- **Step doc:** [`docs/Admin-AI/services/Audit_03.md`](docs/Admin-AI/services/Audit_03.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/checkpoints/2026-01-30_ADMIN_AI_GOVERNANCE_COMPLETE/`](docs/checkpoints/2026-01-30_ADMIN_AI_GOVERNANCE_COMPLETE/)
  - Supporting: [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

### 🟦 32 — Audit_04
- **Outcome:** Verification tooling + tamper detection SOP
- **Step doc:** [`docs/Admin-AI/services/Audit_04.md`](docs/Admin-AI/services/Audit_04.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/checkpoints/2026-01-30_ADMIN_AI_GOVERNANCE_COMPLETE/`](docs/checkpoints/2026-01-30_ADMIN_AI_GOVERNANCE_COMPLETE/)
  - Supporting: [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

### 🟨 33 — Audit_05
- **Outcome:** Human review process + incident response tie-in
- **Step doc:** [`docs/Admin-AI/services/Audit_05.md`](docs/Admin-AI/services/Audit_05.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/checkpoints/2026-01-30_ADMIN_AI_GOVERNANCE_COMPLETE/`](docs/checkpoints/2026-01-30_ADMIN_AI_GOVERNANCE_COMPLETE/)
  - Supporting: [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

## Secrets
*Notes:* Vault model, rotation, redaction, and access control.

### 🟨 34 — Secrets_01
- **Outcome:** Secrets vault strategy (Ansible vault + runtime vault)
- **Step doc:** [`docs/Admin-AI/services/Secrets_01.md`](docs/Admin-AI/services/Secrets_01.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

### 🟨 35 — Secrets_02
- **Outcome:** Key hierarchy + encryption at rest standards
- **Step doc:** [`docs/Admin-AI/services/Secrets_02.md`](docs/Admin-AI/services/Secrets_02.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

### 🟨 36 — Secrets_03
- **Outcome:** Access patterns (least privilege) + audit of access
- **Step doc:** [`docs/Admin-AI/services/Secrets_03.md`](docs/Admin-AI/services/Secrets_03.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

### 🟨 37 — Secrets_04
- **Outcome:** Rotation policy + emergency rotation procedure
- **Step doc:** [`docs/Admin-AI/services/Secrets_04.md`](docs/Admin-AI/services/Secrets_04.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

### 🟨 38 — Secrets_05
- **Outcome:** Redaction rules for logs/audit + diagnostics bundles
- **Step doc:** [`docs/Admin-AI/services/Secrets_05.md`](docs/Admin-AI/services/Secrets_05.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

## Observability
*Notes:* Logs/metrics/alerts signals; visibility without auto-action.

### 🟨 39 — Observability_01
- **Outcome:** Log collection plan (containers + host)
- **Step doc:** [`docs/Admin-AI/services/Observability_01.md`](docs/Admin-AI/services/Observability_01.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

### 🟨 40 — Observability_02
- **Outcome:** Metrics plan (capacity, health, SLO signals)
- **Step doc:** [`docs/Admin-AI/services/Observability_02.md`](docs/Admin-AI/services/Observability_02.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

### 🟨 41 — Observability_03
- **Outcome:** Alert policy (notify humans; no auto-act)
- **Step doc:** [`docs/Admin-AI/services/Observability_03.md`](docs/Admin-AI/services/Observability_03.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

### 🟨 42 — Observability_04
- **Outcome:** Tracing / correlation IDs across services
- **Step doc:** [`docs/Admin-AI/services/Observability_04.md`](docs/Admin-AI/services/Observability_04.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

### 🟨 43 — Observability_05
- **Outcome:** Dashboard + on-call SOP (minimal viable)
- **Step doc:** [`docs/Admin-AI/services/Observability_05.md`](docs/Admin-AI/services/Observability_05.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

## Provisioning
*Notes:* Provider adapters and deterministic capacity controls.

### 🟨 44 — Provisioning_01
- **Outcome:** Provider adapters: AWS first (roles only, no creds hardcoded)
- **Step doc:** [`docs/Admin-AI/services/Provisioning_01.md`](docs/Admin-AI/services/Provisioning_01.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/checkpoints/2026-01-30_ADMIN_AI_AUTOSCALING_INTENT_LOCK/`](docs/checkpoints/2026-01-30_ADMIN_AI_AUTOSCALING_INTENT_LOCK/)
  - Supporting: [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

### 🟨 45 — Provisioning_02
- **Outcome:** Worker AMI contract (LEMP+Podman) inputs/outputs
- **Step doc:** [`docs/Admin-AI/services/Provisioning_02.md`](docs/Admin-AI/services/Provisioning_02.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/checkpoints/2026-01-30_ADMIN_AI_AUTOSCALING_INTENT_LOCK/`](docs/checkpoints/2026-01-30_ADMIN_AI_AUTOSCALING_INTENT_LOCK/)
  - Supporting: [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

### 🟨 46 — Provisioning_03
- **Outcome:** Admission protocol: how workers join + get config
- **Step doc:** [`docs/Admin-AI/services/Provisioning_03.md`](docs/Admin-AI/services/Provisioning_03.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/checkpoints/2026-01-30_ADMIN_AI_AUTOSCALING_INTENT_LOCK/`](docs/checkpoints/2026-01-30_ADMIN_AI_AUTOSCALING_INTENT_LOCK/)
  - Supporting: [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

### 🟨 47 — Provisioning_04
- **Outcome:** Deterministic autoscaling policy (bounded)
- **Step doc:** [`docs/Admin-AI/services/Provisioning_04.md`](docs/Admin-AI/services/Provisioning_04.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/checkpoints/2026-01-30_ADMIN_AI_AUTOSCALING_INTENT_LOCK/`](docs/checkpoints/2026-01-30_ADMIN_AI_AUTOSCALING_INTENT_LOCK/)
  - Supporting: [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

### 🟨 48 — Provisioning_05
- **Outcome:** Warm pool mode implementation plan (customer selectable)
- **Step doc:** [`docs/Admin-AI/services/Provisioning_05.md`](docs/Admin-AI/services/Provisioning_05.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/checkpoints/2026-01-30_ADMIN_AI_AUTOSCALING_INTENT_LOCK/`](docs/checkpoints/2026-01-30_ADMIN_AI_AUTOSCALING_INTENT_LOCK/)
  - Supporting: [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

### 🟨 49 — Provisioning_06
- **Outcome:** Surge-only mode plan + advisory warm-pool suggestions
- **Step doc:** [`docs/Admin-AI/services/Provisioning_06.md`](docs/Admin-AI/services/Provisioning_06.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/checkpoints/2026-01-30_ADMIN_AI_AUTOSCALING_INTENT_LOCK/`](docs/checkpoints/2026-01-30_ADMIN_AI_AUTOSCALING_INTENT_LOCK/)
  - Supporting: [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

## Workers
*Notes:* Worker fleet admission, container drop, health/drain/replace.

### 🟨 50 — Workers_01
- **Outcome:** Worker baseline: AL2023 now, RHEL later; container host contract
- **Step doc:** [`docs/Admin-AI/services/Workers_01.md`](docs/Admin-AI/services/Workers_01.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

### 🟨 51 — Workers_02
- **Outcome:** Deploy LEMP+Podman worker services (portable)
- **Step doc:** [`docs/Admin-AI/services/Workers_02.md`](docs/Admin-AI/services/Workers_02.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

### 🟨 52 — Workers_03
- **Outcome:** Container drop protocol (configs, secrets, version pins)
- **Step doc:** [`docs/Admin-AI/services/Workers_03.md`](docs/Admin-AI/services/Workers_03.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

### 🟨 53 — Workers_04
- **Outcome:** Health checks, drain, replace workflow
- **Step doc:** [`docs/Admin-AI/services/Workers_04.md`](docs/Admin-AI/services/Workers_04.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

### 🟨 54 — Workers_05
- **Outcome:** Graceful degradation strategy during extreme spikes
- **Step doc:** [`docs/Admin-AI/services/Workers_05.md`](docs/Admin-AI/services/Workers_05.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/checkpoints/2026-01-30_ADMIN_AI_AUTOSCALING_INTENT_LOCK/`](docs/checkpoints/2026-01-30_ADMIN_AI_AUTOSCALING_INTENT_LOCK/)
  - Supporting: [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

### 🟨 55 — Workers_06
- **Outcome:** Cost controls: TTL grace + license invariants
- **Step doc:** [`docs/Admin-AI/services/Workers_06.md`](docs/Admin-AI/services/Workers_06.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/checkpoints/2026-01-30_ADMIN_AI_AUTOSCALING_INTENT_LOCK/`](docs/checkpoints/2026-01-30_ADMIN_AI_AUTOSCALING_INTENT_LOCK/)
  - Supporting: [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

## Client-Portal
*Notes:* Multi-org client access, limits, approvals, and billing model.

### 🟨 56 — Client-Portal_01
- **Outcome:** Client org model + user limits + site scoping
- **Step doc:** [`docs/Admin-AI/services/Client-Portal_01.md`](docs/Admin-AI/services/Client-Portal_01.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/checkpoints/2026-01-30_ADMIN_AI_STEP28/`](docs/checkpoints/2026-01-30_ADMIN_AI_STEP28/)
  - Supporting: [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

### 🟨 57 — Client-Portal_02
- **Outcome:** Client permissions matrix + approval workflows
- **Step doc:** [`docs/Admin-AI/services/Client-Portal_02.md`](docs/Admin-AI/services/Client-Portal_02.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/checkpoints/2026-01-30_ADMIN_AI_STEP28/`](docs/checkpoints/2026-01-30_ADMIN_AI_STEP28/)
  - Supporting: [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

### 🟨 58 — Client-Portal_03
- **Outcome:** Contract visibility + addendum requests
- **Step doc:** [`docs/Admin-AI/services/Client-Portal_03.md`](docs/Admin-AI/services/Client-Portal_03.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/checkpoints/2026-01-30_ADMIN_AI_STEP28/`](docs/checkpoints/2026-01-30_ADMIN_AI_STEP28/)
  - Supporting: [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

### 🟨 59 — Client-Portal_04
- **Outcome:** Billing decision-maker model (centralized)
- **Step doc:** [`docs/Admin-AI/services/Client-Portal_04.md`](docs/Admin-AI/services/Client-Portal_04.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/checkpoints/2026-01-30_ADMIN_AI_STEP28/`](docs/checkpoints/2026-01-30_ADMIN_AI_STEP28/)
  - Supporting: [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

### 🟨 60 — Client-Portal_05
- **Outcome:** Audit/notifications to clients (safe summaries)
- **Step doc:** [`docs/Admin-AI/services/Client-Portal_05.md`](docs/Admin-AI/services/Client-Portal_05.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/runbook-attachments/STEP_ADMIN_AI_EMAIL_GOVERNANCE.md`](docs/runbook-attachments/STEP_ADMIN_AI_EMAIL_GOVERNANCE.md)
  - Supporting: [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

## Employee-Portal
*Notes:* Internal access (dispatch/supervisor/payroll) + OWNER visibility.

### 🟨 61 — Employee-Portal_01
- **Outcome:** Employee identity + roles (dispatch, supervisor, payroll, etc.)
- **Step doc:** [`docs/Admin-AI/services/Employee-Portal_01.md`](docs/Admin-AI/services/Employee-Portal_01.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/runbook-attachments/STEP_36_ADMIN_AI_AUTHORITY.md`](docs/runbook-attachments/STEP_36_ADMIN_AI_AUTHORITY.md)
  - Supporting: [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

### 🟦 62 — Employee-Portal_02
- **Outcome:** OWNER visibility/access requirements (all accounts)
- **Step doc:** [`docs/Admin-AI/services/Employee-Portal_02.md`](docs/Admin-AI/services/Employee-Portal_02.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/checkpoints/2026-01-30_ADMIN_AI_GOVERNANCE_COMPLETE/`](docs/checkpoints/2026-01-30_ADMIN_AI_GOVERNANCE_COMPLETE/)
  - Supporting: [`docs/runbook-attachments/STEP_36_ADMIN_AI_AUTHORITY.md`](docs/runbook-attachments/STEP_36_ADMIN_AI_AUTHORITY.md)
  - Supporting: [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

### 🟨 63 — Employee-Portal_03
- **Outcome:** Operational modules: employee mgmt, client mgmt, billing hooks
- **Step doc:** [`docs/Admin-AI/services/Employee-Portal_03.md`](docs/Admin-AI/services/Employee-Portal_03.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

### 🟨 64 — Employee-Portal_04
- **Outcome:** Admin assistance UX (AI assist in advanced view)
- **Step doc:** [`docs/Admin-AI/services/Employee-Portal_04.md`](docs/Admin-AI/services/Employee-Portal_04.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/RUNBOOK.md`](docs/RUNBOOK.md)

### 🟨 65 — Employee-Portal_05
- **Outcome:** Policy controls: guardrails toggles (capacity, provisioning)
- **Step doc:** [`docs/Admin-AI/services/Employee-Portal_05.md`](docs/Admin-AI/services/Employee-Portal_05.md)
- **Required documents:**
  - **Primary / authoritative:** [`docs/checkpoints/2026-01-30_ADMIN_AI_AUTOSCALING_INTENT_LOCK/`](docs/checkpoints/2026-01-30_ADMIN_AI_AUTOSCALING_INTENT_LOCK/)
  - Supporting: [`docs/RUNBOOK.md`](docs/RUNBOOK.md)
