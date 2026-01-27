# CHECKPOINT — 2026-01-21-LEADGEN-PLAT04-ONE-CORRECT-FIX

Scope: **motorcade-infra** (LeadGen deployment)

This checkpoint captures the current state of **PLAT_04 — LeadGen Intake API** deployment work and provides a **single clean patch** that:
- keeps changes isolated to PLAT_04
- fixes role discovery (`podman_static`) via repo-root `ansible.cfg` `roles_path`
- avoids `stdout_callback=yaml` breakage by defaulting to Ansible's built-in `default` callback
- moves build logic away from flaky collection/module args to a plain `podman build`

> **Important:** If you still see `Invalid callback for stdout specified: yaml`, it is coming from your **shell environment** (e.g. `ANSIBLE_STDOUT_CALLBACK=yaml`). See `SESSION_HANDOFF.md`.

## Files included in this checkpoint zip
- `ansible.cfg` (repo root) — adds `roles_path` and sets `stdout_callback=default`
- `ansible/playbooks/PLAT_04_lead_intake_api.yml` — PLAT_04 only
- `docs/checkpoints/2026-01-21-LEADGEN-PLAT04-ONE-CORRECT-FIX/*` — handoff + notes

## Current status
- ✅ Vault assertion can pass (once vault autoload is in a valid location)
- ✅ Playbook runs through prerequisites and cloning
- ❌ Remaining blocker is **Podman build context** (Dockerfile/Containerfile not found in expected directory)

See: `SESSION_HANDOFF.md`
