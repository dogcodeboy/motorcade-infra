# Patch — PLAT_04 GroupVars-Only Vault Loading (2026-01-21)

## Why
You confirmed `LEADGEN_API_KEY` exists in the encrypted vault:
- `ansible/group_vars/motorcade/vault.yml`

But PLAT_04 was failing the assertion because of vault loading/precedence confusion created during earlier template ZIP overlays.

## What this patch does
- Updates `ops/ansible/playbooks/PLAT_04_lead_intake_api.yml` to **NOT** use `vars_files`.
- Relies on Ansible’s canonical behavior: `group_vars/motorcade/*.yml` is auto-loaded for `hosts: motorcade`.

## Requirements
- Inventory group `[motorcade]` must include `motorcade-web-01` (as in `ansible/inventories/prod/hosts.ini`).
- `LEADGEN_API_KEY` must be present in `ansible/group_vars/motorcade/vault.yml`.

## Optional cleanup (recommended)
If this file exists, remove it to prevent future confusion/overwrites:
- `ansible/vault/vault.yml`

ZIP overlays cannot reliably delete files, so remove manually once:

```bash
cd ~/Repos/motorcade-infra
rm -f ansible/vault/vault.yml
git rm -f ansible/vault/vault.yml 2>/dev/null || true
rmdir ansible/vault 2>/dev/null || true
```

## Run PLAT_04
```bash
cd ~/Repos/motorcade-infra
ansible-playbook -i ansible/inventories/prod/hosts.ini ops/ansible/playbooks/PLAT_04_lead_intake_api.yml --ask-vault-pass
```

## Sanity check (on EC2)
```bash
curl http://localhost:8000/lead/health
```
