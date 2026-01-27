# 2026-01-25 — PLAT_08C — Redis Unit Override + Perms/SELinux Preflight

## Purpose
Stop `motorcade-redis.service` churn and eliminate the repeating `PING` failures by making PLAT_08C authoritative.

## Key fixes
- **Hard unit overwrite**: writes `/etc/systemd/system/motorcade-redis.service` from scratch (no regex edits).
- **No journald log driver**: removes `--log-driver journald` to avoid Podman/conmon journald incompatibility on this host.
- **Bind-mount preflight**:
  - Ensures `/srv/motorcade/volumes/redis` exists.
  - Ensures ownership `999:999` (Redis container user).
  - Applies SELinux container labeling when enforcing (`semanage`/`restorecon` if available; `chcon` fallback).
- **No hidden overrides**: removes `/etc/systemd/system/motorcade-redis.service.d` drop-ins.
- **Bounded health**: verifies container is `Up`, then requires `redis-cli ping == PONG`. On failure emits `systemctl cat/status` + `podman ps/logs`.

## Run
```bash
cd ~/Repos/motorcade-infra/ansible
ansible-playbook -i inventories/prod/hosts.ini \
  playbooks/PLAT_08C_redis_bringup_health_gate.yml \
  --ask-vault-pass
```

## Verify
```bash
ssh motorcade
sudo systemctl cat motorcade-redis.service | sed -n '1,220p'
sudo systemctl status motorcade-redis --no-pager
sudo /usr/local/bin/podman ps -a --filter name=motorcade-redis
sudo /usr/local/bin/podman logs --tail 200 motorcade-redis
sudo /usr/local/bin/podman exec motorcade-redis redis-cli ping
```
