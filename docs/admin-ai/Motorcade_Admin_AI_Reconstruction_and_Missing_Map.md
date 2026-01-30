# Motorcade Admin AI — Reconstruction & Missing Map

## Status
This document reconstructs the lost ~4 hour design session and locks recovered intent.
Append-only. Authoritative for handoff.

## HARD LOCKS (Confirmed)
- Admin AI is AI-as-operator, not hands
- Admin AI is the authoritative domain controller and directory
- Full LDAP control in staging; guarded control in production
- Clear separation of employee vs client identity
- Multi-site client support with caps and overrides
- Email, service mailboxes, and group access via portal
- Cross-cloud domain join (on-prem, AWS, Azure)
- IAM-driven elastic infrastructure with guardrails
- Guardrails configurable via Admin AI UI
- Dual admin interface (Business vs IT/Advanced)
- AI assistance only in IT/Advanced view
- User-supplied OpenAI account and billing

## STAGING vs PRODUCTION
Staging: near-unlimited power with guardrails to prevent churn.
Production: policy- and approval-gated execution.

## RUNBOOK IMPACT
Steps 28–35 are groundwork.
Step 36 consolidates Admin AI authority.
Append-only updates only.

## MISSING / DECISIONS
- Default caps
- Auto-approved LDAP actions in prod
- Bulk change approval model
- Rollback strategy
- AI output logging policy
