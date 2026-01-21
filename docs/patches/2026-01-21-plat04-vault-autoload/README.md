# Patch: PLAT_04 Vault Autoload Fix (Group Vars Path)

## What this fixes
PLAT_04 fails with:

- `LEADGEN_API_KEY missing from Ansible vault. Aborting (fail-closed).`

Even when the key exists in `ansible/group_vars/motorcade/vault.yml`.

## Root cause
Ansible auto-loads `group_vars/` relative to the **inventory directory** and (separately) the **playbook base dir**.
Your repo stores the encrypted vault at:

- `ansible/group_vars/motorcade/vault.yml`

…but your inventory is executed from:

- `ansible/inventories/prod/hosts.ini`

So Ansible never auto-loads the `ansible/group_vars/...` tree, and the variable appears "missing".

## What this patch does (safe)
It **does not modify** your existing vault.
It copies the same encrypted vault file into locations that Ansible will auto-load:

- `ansible/inventories/group_vars/motorcade/vault.yml`
- `ansible/inventories/prod/group_vars/motorcade/vault.yml`

This keeps your "single vault" rule intact while making autoload deterministic.

## Apply
Unzip into `~/Repos` so it overlays the repo:

```bash
cd ~/Repos
unzip -o PLAT_04_VAULT_AUTOLOAD_FIX.zip
```

## Run
```bash
cd ~/Repos/motorcade-infra
ansible-playbook -i ansible/inventories/prod/hosts.ini ansible/playbooks/PLAT_04_lead_intake_api.yml --ask-vault-pass
```
