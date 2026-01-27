# Checkpoint: 2026-01-21-LEADGEN-PLAT04-PREP

**Scope:** LeadGen container build readiness + platform roadmap guardrails (pre-PLAT_04 deployment)  
**Date:** 2026-01-21  
**Status:** READY FOR NEXT SESSION (PLAT_04 generation + deployment)

## What is Locked
- Lead Intake API v1 **contract + implementation** lives in `motorcade-leadgen` and is committed/pushed.
- LeadGen container build definition exists (Containerfile + .containerignore + BUILD.md).
- Postgres foundation **PLAT_04A** is COMPLETE + LOCKED (do not re-run PLAT_03/PLAT_04A).

## What is NOT Done Yet
- LeadGen is **not deployed** on EC2 yet (no container listening on :8000).
- PLAT_04 playbook has **not been generated** or run in `motorcade-infra` yet.

## Next Playbook
- `PLAT_04_lead_intake_api.yml` (generate next session)

## Quick Orientation
- Runtime host: `motorcade-web-01`
- Podman is installed and functional on EC2 (confirmed).
- Do **NOT** open AWS port **8000**. Internal-only service.

## Files in this checkpoint
- `00-session-handoff.md` (copy/paste for next session)
- `01-platform-roadmap-guardrailed.md`
- `02-decisions-and-guardrails.md`
- `03-artifacts-and-zips.md`
- `04-command-log-and-errors.md`
