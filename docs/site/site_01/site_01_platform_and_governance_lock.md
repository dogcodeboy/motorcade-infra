# 🟦 site_01 — Platform & Governance Lock (CLOSED)

## Status
🔒 **CLOSED / LOCKED** — Do not reopen.

## Purpose
Define the governance model for the public site theme work so sessions do not drift.

## Scope (what this program covers)
- Public marketing pages and navigation structure
- Theme styling, layout contracts, header/footer contract
- Image/asset strategy for portability
- Render-spec generation workflow (Option A)
- Bridge-facing UX requirements for later LeadGen integration (implementation governed by site_22)

## Non-goals (not in this program)
- Mobile app UI
- LeadGen backend redesign
- Admin/SSO container implementation (that has its own runbook later)
- Any WordPress “admin panel edits” as a source of truth

## Governance rules
1) **Docs-first**: All changes must be captured in repo docs under docs/site.
2) **Append-only**: Locks change only via appended change records.
3) **One-source-of-truth**: For site theme work, docs/site overrides chat history.
4) **Atomic deliverables**: Each page deliverable is split into Assets then Render Spec.
5) **No silent drift**: If a session proposes a change, it must cite which lock it modifies.

## Handoff discipline
- When starting a new session, the first instruction is: open docs/site/RUNBOOK.md.
- If the session proposes CF7 or form builders for the bridge: **reject and redirect to site_22**.

## Acceptance criteria (why this step is “done”)
- docs/site exists and is referenced from main RUNBOOK
- site_01..05 exist and are marked locked
- SITE_STEP_TREE.md reflects the authoritative program structure
