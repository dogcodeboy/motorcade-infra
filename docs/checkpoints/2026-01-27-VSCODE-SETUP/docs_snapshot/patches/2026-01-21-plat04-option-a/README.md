# PLAT_04 Option A — Done-Right Patch (Lead Intake API)

This patch makes **PLAT_04** run cleanly without changing any existing vault values and without assuming Podman is available via `dnf/yum`.

## What changed

1. **Repo-root `ansible.cfg`**
   - Adds `roles_path` so playbooks under `ansible/playbooks/` can still resolve roles that live under `ops/ansible/roles/` (including `podman_static`).

2. **`ansible/playbooks/PLAT_04_lead_intake_api.yml`**
   - Explicitly loads your existing encrypted vault with a **playbook-relative** path:
     - `{{ playbook_dir }}/../group_vars/motorcade/vault.yml`
   - Uses your repo-standard `podman_static` role (no `dnf/yum` Podman install attempts).
   - Ensures `/opt/motorcade` exists.
   - Clones/updates `motorcade-leadgen` into `/opt/motorcade/motorcade-leadgen`.
   - Builds the image using stable CLI:
     - `podman build -t motorcade/leadgen-api:latest .`
   - Starts/maintains the container via `containers.podman.podman_container` bound to `127.0.0.1:8000`.

## Apply

From your workstation:

```bash
cd ~/Repos
unzip -o ~/Downloads/PLAT_04_OPTION_A_DONE_RIGHT.zip
```

## Run

```bash
cd ~/Repos/motorcade-infra
ansible-playbook -i ansible/inventories/prod/hosts.ini ansible/playbooks/PLAT_04_lead_intake_api.yml --ask-vault-pass
```

## Verify on EC2

```bash
curl -f http://127.0.0.1:8000/lead/health
```
