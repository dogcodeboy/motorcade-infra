# CHECKPOINT — 2026-01-26-LEADGEN_04-Wave2-Runtime-Hardening

## Summary
Wave 2 makes LeadGen Wave 1 **production-stable** by hardening the systemd runtime, bounding container logs, adding resource caps, and installing a watchdog timer that restarts the API on health failure.

## Included
- Playbook: `ansible/playbooks/LEADGEN_04_wave2_runtime_hardening.yml`
- Docs: `docs/leadgen/WAVE2_RUNTIME_HARDENING.md`

## What changed (high level)
- Replaced `motorcade-leadgen-api.service` with a hardened unit (restart policy, limits, safer podman run flags)
- Installed watchdog:
  - `/usr/local/bin/motorcade-leadgen-watchdog.sh`
  - `motorcade-leadgen-watchdog.service`
  - `motorcade-leadgen-watchdog.timer`

## Verify
See `VERIFY.md`.

## Do not
- Do not expose LeadGen directly to public internet; keep bind on `127.0.0.1:8000` and proxy via nginx.
- Do not remove `--vault-id @prompt` usage; vault is authoritative in `ansible/group_vars/motorcade/vault.yml`.
