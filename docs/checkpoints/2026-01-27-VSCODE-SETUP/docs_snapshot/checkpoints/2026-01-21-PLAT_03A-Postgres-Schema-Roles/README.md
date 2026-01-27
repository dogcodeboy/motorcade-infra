# PLAT_03A — Postgres Schema + Roles

Status: ✅ Corrected + Wired

This checkpoint finalizes PLAT_03 by:
- Removing dependency on community.postgresql
- Using podman exec directly
- Explicitly loading vault vars from group_vars/motorcade/vault.yml
- Preserving systemd-first posture (boot disabled)
