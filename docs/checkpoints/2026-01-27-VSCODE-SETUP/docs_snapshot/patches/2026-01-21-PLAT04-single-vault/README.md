# Patch — PLAT_04 Single Vault Source of Truth (2026-01-21)

## Why
We discovered two vault locations in the repo:

- `ansible/group_vars/motorcade/vault.yml`  ✅ existing, non-empty, encrypted (authoritative)
- `ansible/vault/vault.yml`                ❌ created/overwritten by a template ZIP

To prevent future secret loss/confusion, we standardize on **one** vault file:
`ansible/group_vars/motorcade/vault.yml`

## What this patch changes
- Updates `ops/ansible/playbooks/PLAT_04_lead_intake_api.yml` to load **only**:
  - `../group_vars/motorcade/vault.yml`
- Keeps `hosts: motorcade_platform` (matches `ansible/inventories/prod/hosts.ini`)

## Required manual cleanup (one-time)
Because ZIP overlays cannot reliably delete files, remove the extra vault file manually:

```bash
cd ~/Repos/motorcade-infra
rm -f ansible/vault/vault.yml
git rm -f ansible/vault/vault.yml 2>/dev/null || true
```

If the directory becomes empty, optionally remove it:
```bash
rmdir ansible/vault 2>/dev/null || true
```

## Add the new secret (authoritative vault)
Edit the authoritative vault and add LEADGEN_API_KEY:

```bash
cd ~/Repos/motorcade-infra
ansible-vault edit ansible/group_vars/motorcade/vault.yml
```

Add:
```yaml
LEADGEN_API_KEY: "PASTE_RANDOM_SECRET"
```

Generate:
```bash
openssl rand -hex 32
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
