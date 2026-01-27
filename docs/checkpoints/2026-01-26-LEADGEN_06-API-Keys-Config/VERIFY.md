# Verify — LEADGEN_06 API Keys Config

Run on controller:

```bash
cd ~/Repos/motorcade-infra/ansible

ansible-playbook -i inventories/prod/hosts.ini \
  playbooks/LEADGEN_06_configure_api_keys.yml \
  --ask-vault-pass
```

Expected:
- Play completes with `failed=0`
- Service `motorcade-leadgen-api` is `active`
- Output includes redacted lines like:
  - `LEADGEN_INTAKE_API_KEY=***REDACTED***`
  - `LEADGEN_ADMIN_API_KEY=***REDACTED***`

Then rerun Wave 3:

```bash
ansible-playbook -i inventories/prod/hosts.ini \
  playbooks/LEADGEN_05_wave3_intake_e2e_validation.yml \
  --vault-id @prompt
```
