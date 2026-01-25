# 2026-01-25 — PLAT_08D — Redis Production Stability (Healthcheck Timer)

This checkpoint adds production stability guardrails for Redis **without** introducing any infinite readiness daemons.

## What changed

- Added `ansible/playbooks/PLAT_08D_redis_production_stability.yml`
- Added a timer-based healthcheck that:
  - Verifies the Redis container exists
  - Verifies `redis-cli ping` returns `PONG`
  - If either fails, restarts `motorcade-redis`

## Files installed on the server

- `/usr/local/libexec/motorcade/redis_healthcheck.sh`
- `/etc/systemd/system/motorcade-redis-healthcheck.service`
- `/etc/systemd/system/motorcade-redis-healthcheck.timer`

## Run

```bash
cd ~/Repos/motorcade-infra/ansible
ansible-playbook -i inventories/prod/hosts.ini \
  playbooks/PLAT_08D_redis_production_stability.yml \
  --ask-vault-pass
```

## Verify

```bash
sudo systemctl is-active motorcade-redis
sudo /usr/local/bin/podman ps --filter name=motorcade-redis
sudo /usr/local/bin/podman exec motorcade-redis redis-cli ping

sudo systemctl status motorcade-redis-healthcheck.timer --no-pager
sudo journalctl -u motorcade-redis-healthcheck.service -n 50 --no-pager
```
