SESSION HANDOFF — LEADGEN_06 API Keys Config

Status:
- LEADGEN_05 Wave 3 reaches POST /lead/intake with correct nested schema.
- It was failing with 503: "API key not configured" because the LeadGen API service did not have its runtime key(s) in the env file.

What changed in this checkpoint:
- Added `LEADGEN_06_configure_api_keys.yml` to write the required key vars into `/etc/motorcade/leadgen.env` (the env file used by the service from Waves 1/2)
- Restarted `motorcade-leadgen-api`
- Added verification that `/lead/health` returns status `ok` and printed key **names only** (redacted)

Next steps:
1) Apply LEADGEN_06:

   cd ~/Repos/motorcade-infra/ansible
   ansible-playbook -i inventories/prod/hosts.ini \
     playbooks/LEADGEN_06_configure_api_keys.yml \
     --ask-vault-pass

2) Re-run Wave 3:

   ansible-playbook -i inventories/prod/hosts.ini \
     playbooks/LEADGEN_05_wave3_intake_e2e_validation.yml \
     --vault-id @prompt

Expected:
- Wave 3 finishes `failed=0` and `/lead/intake` returns 200/201.
