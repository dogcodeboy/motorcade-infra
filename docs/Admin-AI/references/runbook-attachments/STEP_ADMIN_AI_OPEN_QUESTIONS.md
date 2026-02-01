# STEP_ADMIN_AI_OPEN_QUESTIONS (Authoritative)

Purpose: capture **LOCKED** Admin AI governance decisions and the remaining **OPEN** questions, so future sessions do not re-derive intent or introduce churn.

This file is authoritative for Admin AI governance continuity. It complements the existing Admin AI governance attachments already created under `docs/runbook-attachments/`.

## Existing Authoritative Governance Attachments (Already Locked)

- `STEP_ADMIN_AI_EMAIL_GOVERNANCE.md`
- `STEP_ADMIN_AI_LDAP_GOVERNANCE.md`
- `STEP_ADMIN_AI_DNS_DOMAIN_CONNECT.md`
- `STEP_CLIENT_PORTAL_MULTI_SITE_GOVERNANCE.md`

## LOCKED Decisions (Do Not Re-litigate)

### A. Runbook structure and scope
- Admin AI is the **authoritative control plane** for the platform once installed.
- Admin AI **replaces the planned manual RUNBOOK sequence for steps 28–38**, including installs necessary for Admin AI to function (not governance-only).
- RUNBOOK numbering is preserved (no renumbering now). Steps 28–38 remain as placeholders pointing into Admin AI reality.
- Governance attachments live under `docs/runbook-attachments/` and are referenced from RUNBOOK.

### B. WordPress replacement posture
- There is **no bridge mode** for governance: once Admin AI is complete, it **replaces WordPress** rather than coexisting as a long-lived hybrid.
- Public site assets/themes are being designed to be portable to **native nginx** serving.

### C. Admin AI authority model
- Admin AI governs **policy and enforcement** (authoritative), not “advisory-only inference.”
- OWNER impersonation is **view-only by default** with **audited elevation** for actions that must be taken as the user.
- Staging can allow broader Admin AI power (with guardrails) than production; production requires explicit controls and audit.

### D. Identity & LDAP governance
- Admin AI is the authoritative controller of LDAP/directory governance.
- LDAP governs employees and all company-managed devices.
- Identity model uses **single identity + capability flags** (avoid “account moves” to change access).
- Lifecycle flow is explicitly: **Suspension → Reduced Suspension → Termination**, where Reduced Suspension preserves evidence while limiting actions.
- Evidence preservation rules apply to artifacts such as body cams, calls, texts, etc., as described in LDAP governance attachment.

### E. DNS / domain connect governance
- Domain Connect is limited to **Motorcade-owned domains**.
- DNS includes both internet-facing DNS and internal device DNS.
- Strict, human-readable naming templates per device class; renames are controlled and audited; controlled renaming allowed for permanent relocation.

### F. Client portal multi-site governance
- Client portal access is limited to **decision makers only**.
- Default limits: **5 decision-makers per org + 3 per site**, with temporary overflow supported using throttling (no IT bottleneck).
- Default visibility is site-scoped; centralized and distributed billing/legal are supported; contracts are usually site-owned.

### G. Service accounts (non-email)
- Service accounts are **not email accounts** (service mailboxes like hr@, legal@ are separate).
- Service accounts are **non-human identities** used for software-to-software authentication and automation.
- Service account **IDs are immutable for life** (LOCKED: 3A). If scope changes materially, create a new identity and deprecate the old one (do not rename).
- Admin AI ultimately “owns” the governance of service accounts across tenants and environments.

### H. Platform-as-product posture
- Motorcade is **customer #1**; Admin AI should be portable to other businesses/tenants (AMI delivery is a primary distribution mechanism, but non-AMI installs must remain viable via bootstrap).
- Admin AI, once complete, should be able to execute and reconcile the operational steps it governs (installs/config/deploy), not merely document them.

## OPEN Questions (To Answer Next, One-at-a-Time)

### Ordering rule
Do not finalize downstream details (like rotation cadence) until upstream authority and execution boundaries are locked.

1. **ADMINAI_01 — Minimal prerequisite state before Step 28 runs**
   - What must exist before Admin AI installs itself (OS baseline, SSH access model, Ansible availability, secrets bootstrap, networking prerequisites)?
2. **ADMINAI_02 — Root trust & OWNER bootstrap**
   - How initial OWNERs are created/verified; break-glass model; how Admin AI gains initial authority safely.
3. **ADMINAI_03 — Execution authority & guardrails**
   - How Admin AI runs playbooks/operations (approval model, audit logging, safe mode, rollback gates, staging vs prod differences).
4. **ADMINAI_04.2 — Service account credential types & defaults**
   - Short-lived vs long-lived standards; IAM role assumption vs mTLS vs tokens; exception process.
5. **Secrets backend choice and posture**
   - Create vs integrate; encryption/KMS posture; secret material exposure rules; audit requirements.
6. **Admin AI self-update, testing, and rollback**
   - How Admin AI updates itself safely (staging gates, canaries, one-click rollback, anti-churn).
7. **Cutover semantics (WordPress replacement)**
   - Exact cutover gating: when WP is removed from serving path; how rollback to WP would work (if allowed) and under what conditions.

## Explicit Deferrals (Prevent Churn)
- Do not attempt to fully normalize “render vs file output” determinism for the site build during Step 26/other pre-Admin-AI steps; Admin AI is the reconciliation and enforcement layer post-Step 28.
- Do not define detailed rotation cadences until AdminAI_01–03 are locked.
