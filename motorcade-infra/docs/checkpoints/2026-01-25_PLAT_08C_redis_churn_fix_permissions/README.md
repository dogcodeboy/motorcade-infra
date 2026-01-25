# Checkpoint — 2026-01-25 — PLAT_08C Redis churn fix (permissions + SELinux)

This checkpoint replaces PLAT_08C Redis bring-up to eliminate systemd churn / crashloop.

## What changed
- `ansible/playbooks/PLAT_08C_redis_bringup_health_gate.yml`
  - Adds filesystem preflight for `/srv/motorcade/volumes/redis`
  - Enforces ownership `999:999` recursively
  - Applies SELinux label `container_file_t` (best-effort)
  - Rewrites `motorcade-redis.service` to remove journald and run `--user 999:999`
  - Bounded verification (container Up + PONG)

- `ansible/playbooks/PLAT_08C1_redis_volume_permissions.yml`
  - Updated to match new doctrine (no readiness gate)

- `docs/RUNBOOK.md`
  - Append-only entry documenting the churn root cause and fix

## Run
From local:
```bash
cd ~/Repos/motorcade-infra/ansible
ansible-playbook -i inventories/prod/hosts.ini playbooks/PLAT_08C_redis_bringup_health_gate.yml --ask-vault-pass
```

## Verify (server)
```bash
ssh motorcade
sudo systemctl status motorcade-redis --no-pager
sudo /usr/local/bin/podman ps --filter name=motorcade-redis
sudo /usr/local/bin/podman exec motorcade-redis redis-cli ping
```
