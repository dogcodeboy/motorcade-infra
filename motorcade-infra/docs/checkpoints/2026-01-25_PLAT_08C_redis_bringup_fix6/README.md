# 2026-01-25 — PLAT_08C Fix6 — Redis bring-up churn stopper

This checkpoint replaces `PLAT_08C_redis_bringup_health_gate.yml` with an authoritative, one-shot bring-up that:

- Rewrites `/etc/systemd/system/motorcade-redis.service` from scratch (removes journald logging entirely).
- Preflights volume ownership to Redis UID/GID (999:999).
- Applies SELinux container labeling for the volume path (best-effort; prefers semanage+restorecon, falls back to chcon).
- Uses bounded checks that first assert the container is **Up** before running `redis-cli ping`.

Run from:

```bash
cd ~/Repos/motorcade-infra/ansible
ansible-playbook -i inventories/prod/hosts.ini playbooks/PLAT_08C_redis_bringup_health_gate.yml --ask-vault-pass
```
