# CHECKPOINT — 2026-01-25 — PLAT_08C Redis Churn Fix (Preflight + Unit Rewrite)

This checkpoint replaces **PLAT_08C** with a stable one-shot Redis bring-up playbook.

## Problem observed
- `motorcade-redis.service` restart loop / exit `126`.
- Ansible health check never reaches `PONG` because container never reaches a Running state.

## Root cause (confirmed)
- Host Podman/conmon does **not** support `--log-driver journald`.
- Redis volume directory can be wrong-owner / wrong SELinux label, causing Redis to exit immediately.

## Fix summary
- PLAT_08C now rewrites `/etc/systemd/system/motorcade-redis.service` authoritatively:
  - no `--log-driver journald`
  - runs Redis as UID/GID **999:999**
  - persistent volume at `/srv/motorcade/volumes/redis:/data:Z`
- Filesystem + SELinux preflight (semanage+restorecon when available; chcon fallback).
- Bounded health checks + diagnostics (`systemctl status`, `podman logs`) on failure.

## How to run
From local repo:

```bash
cd ~/Repos/motorcade-infra/ansible
ansible-playbook -i inventories/prod/hosts.ini \
  playbooks/PLAT_08C_redis_bringup_health_gate.yml \
  --ask-vault-pass
```
