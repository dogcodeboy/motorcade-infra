# Patch: PLAT_04 One Correct Fix (2026-01-21)

## What this fixes
- Fixes the **Ansible callback error**: `Invalid callback for stdout specified: yaml`
  by providing a correct repo-root `ansible.cfg` with `stdout_callback=default`.
- Fixes **role resolution** so `podman_static` can be found whether roles live under:
  - `ansible/roles`
  - `ops/ansible/roles`
- Updates **only** `ansible/playbooks/PLAT_04_lead_intake_api.yml` to:
  - Load the existing encrypted vault via a playbook-relative `vars_files` path.
  - Use your existing `podman_static` role (no `dnf install podman`).
  - Build with `podman build` using `chdir` to the cloned repo (correct context).
  - Run the container and wait for `http://127.0.0.1:8000/lead/health` to return 200.

## Files changed by this patch
- `ansible.cfg` (repo root)
- `ansible/playbooks/PLAT_04_lead_intake_api.yml`

## Apply
```bash
cd ~/Repos
unzip -o ~/Downloads/PLAT_04_ONE_CORRECT_FIX.zip
```

## Run
```bash
cd ~/Repos/motorcade-infra
ansible-playbook -i ansible/inventories/prod/hosts.ini ansible/playbooks/PLAT_04_lead_intake_api.yml --ask-vault-pass
```
