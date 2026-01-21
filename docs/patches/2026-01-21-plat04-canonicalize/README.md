# PLAT_04 Canonicalization Patch (No-Manual-Edit compliant)

## What this patch does
1) Places **PLAT_04** at the canonical location so Ansible auto-loads group vars (including your encrypted vault):
   - `motorcade-infra/ansible/playbooks/PLAT_04_lead_intake_api.yml`

2) Removes the need for any `vars_files` / explicit vault includes.
   - The playbook expects your existing encrypted file:
     - `motorcade-infra/ansible/group_vars/motorcade/vault.yml`

## What this patch does NOT do
- Does NOT change inventory
- Does NOT change vault contents
- Does NOT install Podman (assumes it is already installed on the target EC2)

## Apply (overlay)
From your repo parent directory (`~/Repos`):

```bash
cd ~/Repos
unzip -o PLAT_04_CANONICALIZE_PLAYBOOK.zip
```

## One-time cleanup (to avoid future confusion)
Because unzip overlays files, it cannot delete old paths.
If you have an old copy under `ops/ansible/playbooks/`, remove it with the included script:

```bash
bash motorcade-infra/docs/patches/2026-01-21-plat04-canonicalize/remove_ops_plat04.sh
```

## Run (authoritative)
```bash
cd ~/Repos/motorcade-infra
ansible-playbook -i ansible/inventories/prod/hosts.ini ansible/playbooks/PLAT_04_lead_intake_api.yml --ask-vault-pass
```

## Success checks (on EC2)
From the EC2 host:
```bash
curl http://localhost:8000/lead/health
podman ps --filter name=motorcade-lead-intake-api
```
