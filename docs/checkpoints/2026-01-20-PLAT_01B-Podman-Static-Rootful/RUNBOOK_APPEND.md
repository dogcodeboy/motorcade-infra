# RUNBOOK_APPEND — 2026-01-20-PLAT_01B-Podman-Static-Rootful

Append this section to docs/RUNBOOK.md under Platform Spine when appropriate (append-only).

## PLAT_01 (via PLAT_01B) — Podman Runtime Base (Static, Rootful)

On Amazon Linux 2023 where repo-native Podman installation is unavailable, use **PLAT_01B** to bootstrap Podman via static bundle.

- Playbook: ops/ansible/playbooks/plat_01b_podman_static.yml
- Mode: rootful only
- Verification: podman run --rm hello-world

### Rollback
- Remove installed binaries/config under /usr/local and /etc/containers per docs/platform/03-runtime-podman-static-temp.md
- Remove PLAT_01B playbook/role if no longer needed
