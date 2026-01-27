SESSION HANDOFF — motorcade-infra (FIX8)

Status:
- FIX8 replaces PLAT_08C in-place to fix a YAML parse error in the health gate.

Run:
```bash
cd ~/Repos/motorcade-infra/ansible
ansible-playbook -i inventories/prod/hosts.ini \
  playbooks/PLAT_08C_redis_bringup_health_gate.yml \
  --ask-vault-pass
```
