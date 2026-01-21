## What Changed in PLAT_04

Infrastructure:
- Confirmed correct role discovery for podman_static
- Fixed stdout callback drift via repo-root ansible.cfg
- Ensured podman build uses plain CLI (no module drift)

Application:
- Resolved LeadGen API startup crash
- Added required dependency: pydantic[email] / email-validator
- Container rebuild verified

Process:
- Enforced GitKraken-first workflow
- Clarified multi-repo boundaries (infra vs app)
- Locked zip-based change delivery rules
