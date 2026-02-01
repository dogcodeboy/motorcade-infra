# 🟦 35 — Secrets_02
## Ansible Vault policy (vault.yml; ask-vault-pass)

### Goal
- Ansible Vault policy (vault.yml; ask-vault-pass)

### Preconditions
- Admin-AI remains running at all times (staging lane exists to avoid downtime).
- Changes start in **staging** and only reach **live** via explicit promotion.
- If facts are stale or anything is ambiguous: **halt** and document the refusal.

### Step-by-step procedure
1. Read the Primary/authoritative document(s) below and extract the non-negotiables for this step.
1. Define the exact outputs (configs, intent records, accounts, policies) this step will produce.
1. Execute the step in **staging** first; record verification evidence.
1. If staging passes, prepare a promotion record and apply to **live** (if this step is live-impacting).
1. Write an audit entry referencing the produced artifacts and verification evidence.

### Outputs
- Documented artifacts for this step (intent/config/policy), stored in-repo and referenced by path.
- Verification evidence captured and referenced in audit trail.

### Verification checklist
- Staging behavior verified and logged.
- Live impact occurs only via explicit promotion (if applicable).
- Audit write succeeded for the step and references outputs/evidence.

### Rollback
- Revert the specific intent/config artifact(s) produced by this step.
- Document rollback as an auditable event.
- Do **not** stop Admin-AI; use staging lane to remediate safely.

### Required documents
- **Primary / authoritative:** [`docs/runbook-attachments/ADMIN_AI_GOVERNANCE_COMPLETE.md`](docs/runbook-attachments/ADMIN_AI_GOVERNANCE_COMPLETE.md)
- Supporting: [`docs/Admin-AI/ADMIN-AI_RUNBOOK.md`](docs/Admin-AI/ADMIN-AI_RUNBOOK.md)
- Supporting: [`docs/RUNBOOK.md`](docs/RUNBOOK.md)
- Supporting: [`docs/runbook-attachments/STEP_28_35_CLASSIFICATION_POST_ADMIN_AI.md`](docs/runbook-attachments/STEP_28_35_CLASSIFICATION_POST_ADMIN_AI.md)
