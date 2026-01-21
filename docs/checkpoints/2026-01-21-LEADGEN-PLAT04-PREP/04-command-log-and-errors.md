# Command Log & Errors (Condensed)

## Observed errors
1) Container build failed due to wrong requirements path:
   - Containerfile referenced `requirements.txt` at repo root, but file lives at `app/api/requirements.txt`.
2) Runtime crash when using Pydantic `EmailStr`:
   - `email-validator` missing; Pydantic requires it.

## Confirmed on EC2 (motorcade-web-01)
- `podman version` shows 5.7.1
- `podman ps` includes `motorcade-postgres` running
- `podman network ls` includes podman networks
- `curl http://localhost:8000/lead/health` fails until LeadGen is deployed (expected)

## Correct verification sequence
- Do not test :8000 until PLAT_04 deploys LeadGen container on EC2.
