# Patch — PLAT_04 Explicit Vault Load (2026-01-21)

## Symptom
PLAT_04 fails on:
- `Assert LEADGEN_API_KEY is defined (fail-closed)`

even though `LEADGEN_API_KEY` exists in the encrypted vault at:
- `ansible/group_vars/motorcade/vault.yml`

## Root Cause
Ansible auto-loads `group_vars/` relative to the inventory directory. Your inventory is:
- `ansible/inventories/prod/hosts.ini`

Depending on how Ansible resolves variable search paths, `ansible/group_vars/...` may not be auto-loaded.

## Fix
This patch updates PLAT_04 to explicitly load the encrypted vault file using `playbook_dir`:

```yaml
vars_files:
  - "{{ playbook_dir }}/../../../ansible/group_vars/motorcade/vault.yml"
```

This makes the playbook independent of current working directory and inventory-relative `group_vars` discovery.

## Apply
Unzip into `~/Repos` so it overlays correctly:

```bash
cd ~/Repos
unzip -o ~/Downloads/PLAT_04_EXPLICIT_VAULT_LOAD_FIX.zip
```

## Run
```bash
cd ~/Repos/motorcade-infra
ansible-playbook -i ansible/inventories/prod/hosts.ini ops/ansible/playbooks/PLAT_04_lead_intake_api.yml --ask-vault-pass
```

## Sanity check (on EC2)
```bash
curl http://localhost:8000/lead/health
```
