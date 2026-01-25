# 2026-01-25 — PLAT_08C FIX8 (YAML parse hotfix)

## What changed
- **Replaced** `ansible/playbooks/PLAT_08C_redis_bringup_health_gate.yml` in-place.
- Corrected the `until:` expressions used for the bounded "container Up" check.

## Why
The previous revision used invalid YAML/Ansible expression syntax in the `until:` list which caused Ansible to fail during playbook parse (before any tasks ran).

## How to run
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
