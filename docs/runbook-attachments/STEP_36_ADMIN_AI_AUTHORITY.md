# STEP 36 — Admin AI Authority (Mini-Runbook)

Status: Authoritative clarification  
Scope: Authority & governance only (no implementation)  
Source of truth: docs/admin-ai/ADMIN_AI_RECONSTRUCTION_AND_SCOPE.md  
Change policy: Append-only

## 1. Purpose
This document clarifies who is in charge, what Admin AI may decide, and how humans remain in control at Step 36 of the RUNBOOK.
It defines authority only and prevents operational churn.

## 2. Authority Model
Admin AI is the authoritative control plane for identity, directory intent, infrastructure policy decisions, and cross-environment coordination.
Admin AI acts as an operator, not hands.

## 3. Environment Separation
### Staging
Near-unlimited authority with guardrails.

### Production
Policy-gated authority.
Reversible infrastructure elasticity actions (scale up/down) may auto-approve within pre-approved budgets and instance classes.
Structural or identity changes require explicit approval.

## 4. Human Control
Admin AI recommends and authorizes; humans approve and execute.

## 5. Identity Separation
Employee and client identities are strictly separated.

## 6. Cloud & Infrastructure Authority
Admin AI may authorize scale-up/scale-down within constraints.
Numeric limits remain undecided.

## 7. Explicit Non-Decisions
Caps, approval rules, rollback strategies, and logging requirements are undecided.

## 8. Enforcement
All future identity or infra changes must reference this document.
