# DECISIONS LOCKED — ADMIN AI AUTOSCALING INTENT

This checkpoint locks the following intent (non-executable, implementation-agnostic):

1. Admin-AI is the licensed **control plane**; workers are a licensed **worker plane** and do not run Admin-AI.
2. Separate AMIs: premium Admin-AI AMI and lower-cost worker AMI (LEMP + Podman).
3. Licensing is continuous and enforced below extensions; temporary authority loss uses TTL grace (Option B).
4. Worker nodes are provisioned exclusively by Admin-AI from the vendor worker AMI; Admin-AI drops containers + configs.
5. Worker bootstrap after launch is allowed but must be fast, deterministic, idempotent, auditable; failures are quarantined.
6. Autoscaling is deterministic (no LLM dependency), bounded by guardrails, and fully audited.
7. Customer-selectable autoscaling modes: Warm Pool + Surge or Surge Only.
8. If Surge Only is chosen, Admin-AI provides **advisory recommendations** for warm pool upon repeated spike patterns (no enforcement).
9. Advisories never change authority; vendor/internal deployments are exempt from advisories by default.
10. Customers control **capacity intent** (caps/budgets/mode), not **platform authority** (governance/licensing/refusals).
11. Under extreme spikes, graceful degradation is acceptable to preserve integrity (queue/throttle/reject), never violating guardrails/audit/licensing.

References (authoritative governance; not re-litigated):
- `docs/runbook-attachments/ADMIN_AI_GOVERNANCE_COMPLETE.md`
- `docs/checkpoints/2026-01-30_ADMIN_AI_GOVERNANCE_COMPLETE/`
