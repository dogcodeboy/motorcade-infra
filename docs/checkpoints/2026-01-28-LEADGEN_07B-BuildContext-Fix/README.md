# CHECKPOINT — LEADGEN_07B — Build context fix (Containerfile dir)

## What changed
- Fixed LeadGen image rebuild step to run `podman build` from the **same directory as the Containerfile/Dockerfile**.
- This addresses Podman build failure:
  `COPY requirements.txt ... stat: "/requirements.txt": no such file or directory`
  when the Containerfile lives in `.../api/` and expects `requirements.txt` in that build context.

## Why
The Containerfile at `/opt/motorcade-leadgen/app/api/Containerfile` uses `COPY requirements.txt ...`.
Therefore the build context must be `/opt/motorcade-leadgen/app/api` (not the repo root).

## Scope
Playbook-only change. No service definitions altered.
