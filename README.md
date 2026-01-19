# motorcade-infra

Authoritative infrastructure + deployment orchestration for Motorcade.

**Source of truth** for:
- Run order (RUNBOOK)
- Release manifests (what is deployed)
- Cross-repo API contracts
- Ansible playbooks (one-and-done, idempotent)
- Deployment logs

## Quick Start
1. Read `docs/RUNBOOK.md`
2. Copy `releases/prod.yaml` to a new dated release when changing versions.
3. Run playbooks via `scripts/run_playbook.sh`.

## Structure
- `ansible/` playbooks and roles
- `docs/contracts/` OpenAPI + integration contracts
- `releases/` pinned versions per environment
- `docs/deployments/` append-only deployment logs

