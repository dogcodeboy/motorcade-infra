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
Admin AI acts as an operator (decision + authorization), not a human replacing toolchains.

## 3. Environment Separation
### Staging
Near-unlimited authority with guardrails.

### Production
Policy-gated authority.

**Autonomous (policy-bound) actions**
- Reversible infrastructure elasticity actions (scale up/down) may be **auto-approved and executed** within pre-approved budgets, instance classes, and safety rails.
- Admin AI may assume pre-approved cloud IAM roles to carry out these policy-bound actions.

**Approval-required actions**
- Structural directory changes, identity lifecycle changes, and any action outside the approved policy envelope require explicit human approval.

## 4. Human Control (No churn)
Admin AI may autonomously execute **only** the “Autonomous (policy-bound) actions” above.
For everything else, Admin AI recommends and stages a change plan; a human approves and triggers execution.

## 5. Identity Separation
Employee and client identities are strictly separated.

## 6. Cloud & Infrastructure Authority
Admin AI may authorize (and, where policy allows, execute) scale-up/scale-down within constraints.
Numeric caps and boundary values remain undecided until explicitly set.

## 7. Explicit Non-Decisions
Caps, approval rules, rollback strategies, and logging requirements are undecided.

## 8. Enforcement
All future identity or infra changes must reference this document.
