# Decisions & Guardrails (Locked)

## Repo responsibilities
- `motorcade-infra`: authoritative runtime/deploy/ops (Ansible, vault, quadlets/systemd, healthchecks).
- `motorcade-leadgen`: authoritative application behavior + API contract + Containerfile.
- `motorcade.vip`: public site.

## Networking
- Service ports (e.g., 8000) are **internal-only**. Public exposure must be via 443 reverse proxy (later).
- Do **NOT** open AWS SG port 8000.

## Change control
- Postgres foundation locked after PLAT_04A — do not re-run PLAT_03/PLAT_04A.
- API contract changes require versioning (v2) or explicit additive-only policy.

## Container/repo sprawl prevention rule
A new container or repo requires one of:
- different scaling needs
- different security boundary/compliance
- independent deploy cadence
- distinct runtime (GPU/headless browser/long jobs)
