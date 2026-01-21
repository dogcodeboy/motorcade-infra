# PLAT_04 — Done-right fix (LeadGen Intake API)

This patch fixes **PLAT_04** without touching other playbooks.

## What it fixes

1. **Vault load is reliable**
   - PLAT_04 now loads the existing encrypted vault using a **playbook-relative** path:
     - `ansible/group_vars/motorcade/vault.yml`

2. **Build source is guaranteed to exist**
   - The playbook ensures `/opt/motorcade/motorcade-leadgen` exists by cloning/updating:
     - `https://github.com/dogcodeboy/motorcade-leadgen.git`

3. **Image build works regardless of podman module version**
   - Replaces `containers.podman.podman_image` build args (which were failing) with:
     - `podman build -t motorcade/leadgen-api:latest -f Dockerfile .`

## Files changed

- `motorcade-infra/ansible/playbooks/PLAT_04_lead_intake_api.yml`
- `motorcade-infra/docs/patches/2026-01-21-plat04-done-right/README.md`

## Run

From repo root:

```bash
cd ~/Repos/motorcade-infra
ansible-playbook -i ansible/inventories/prod/hosts.ini ansible/playbooks/PLAT_04_lead_intake_api.yml --ask-vault-pass
```

## Expected

- Vault assertion passes
- Repo clone/update runs
- Image builds
- Container starts on `127.0.0.1:8000`
- Healthcheck passes: `http://localhost:8000/lead/health`
