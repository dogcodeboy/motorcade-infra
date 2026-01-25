SESSION HANDOFF — motorcade-infra

Status:
- PLAT_08B complete and verified (Redis foundation).
- PLAT_08C replaced with stable one-shot bring-up (no journald log driver, bounded verification).
- Legacy readiness-gate model is no longer used; any existing `motorcade-redis-ready.service` is masked by PLAT_08C.
- Host naming confirmed: motorcade-web-01.
- Podman runtime is static/manual install at /usr/local/bin/podman.

What to run next:
1) Run PLAT_08C (authoritative bring-up + bounded health check)
   - `ansible/playbooks/PLAT_08C_redis_bringup_health_gate.yml`
2) If you encounter volume-perm crashloops, run PLAT_08C1
   - `ansible/playbooks/PLAT_08C1_redis_volume_permissions.yml`

Commands:
```bash
cd ~/Repos/motorcade-infra/ansible
ansible-playbook -i inventories/prod/hosts.ini \
  playbooks/PLAT_08C_redis_bringup_health_gate.yml \
  --ask-vault-pass
```

If needed:
```bash
cd ~/Repos/motorcade-infra/ansible
ansible-playbook -i inventories/prod/hosts.ini \
  playbooks/PLAT_08C1_redis_volume_permissions.yml \
  --ask-vault-pass
```
