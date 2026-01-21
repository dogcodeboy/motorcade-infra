# SESSION HANDOFF — 2026-01-21-LEADGEN-PLAT04-PREP

## Current authoritative state
- **PLAT_04A** (Postgres read-only connectivity verification) COMPLETE + LOCKED.
  - Result: `ok=4 changed=0 failed=0`
  - Root cause resolved: Podman container name mismatch → correct container `motorcade-postgres`
  - Postgres roles/schema/secrets OK. Do **NOT** re-run PLAT_03 or PLAT_04A.

## LeadGen status
- Lead Intake API v1 contract + implementation is complete in `motorcade-leadgen` and was committed/pushed.
- LeadGen is **NOT deployed** on EC2 yet.
- Local Podman is **not installed** on workstation (expected); do not attempt local container runs.

## Confirmed on EC2 (motorcade-web-01)
- Podman installed: `podman version 5.7.1`
- Containers present: includes `motorcade-postgres`
- Networks present: `podman`, `podman-default-kube-network`, `podman-kube-network`

## Key corrections learned this session
- Curling `localhost:8000` on EC2 fails until LeadGen container is deployed.
- Curling `localhost:8000` locally is not possible without local Podman; do not chase this.

## Deliverables created (zips)
- `LEADGEN_CONTAINER_BUILD_ZIP.zip` (Containerfile/.containerignore/BUILD.md)
- `LEADGEN_CONTAINER_BUILD_FIX_ZIP.zip` (Containerfile fixes: correct requirements path + __init__.py)
- `LEADGEN_EMAIL_VALIDATOR_FIX.zip` (adds `email-validator` to requirements for Pydantic EmailStr)
- (Earlier) `LEADGEN_STEP2_API_CONTRACT_V1.zip` and `MOTORCADE_LEADGEN_ALIGNMENT_ZIP.zip` were used to align endpoints + contract (already committed/pushed).

## Locked guardrails
- Default architecture: **Ansible + Podman containers**, internal-only ports by default.
- `motorcade-infra` owns how services run; service repos own what services do.
- No new container/repo without justification (scale, security boundary, deploy cadence, runtime).

## Next action (do next session, in order)
1) Generate `motorcade-infra/ansible/playbooks/PLAT_04_lead_intake_api.yml` as a zip patch.
2) PLAT_04 must:
   - Build LeadGen image from `motorcade-leadgen` Containerfile (source-based build on EC2) OR pull prebuilt image (later)
   - Run container named `motorcade-lead-intake-api`
   - Bind **127.0.0.1:8000** (or internal podman net), NOT public
   - Inject `LEADGEN_API_KEY` via Ansible vault → secrets env file (fail-closed if missing)
   - Add healthcheck: `GET /lead/health`
   - No AWS SG changes; do **NOT** open port 8000
   - Optionally create Redis queue + worker (only if justified; can be deferred)

## Sanity test after deployment (on EC2)
```bash
curl http://localhost:8000/lead/health
```

## Suggested commit message for upcoming PLAT_04 patch
```
infra(plat): add PLAT_04 lead intake api deployment (podman, internal-only, vault secrets)
```
