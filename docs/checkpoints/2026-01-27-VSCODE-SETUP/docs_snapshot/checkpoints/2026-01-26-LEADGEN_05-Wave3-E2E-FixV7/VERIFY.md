# Verify — LEADGEN_05 Wave 3 E2E Fix V7

Run from your workstation:

```bash
cd ~/Repos/motorcade-infra
unzip -o ~/Downloads/motorcade-infra_LEADGEN_05_06_acceptStatus_fix_v7_checkpoint.zip

cd ~/Repos/motorcade-infra/ansible

# Keep 06 green
ansible-playbook -i inventories/prod/hosts.ini playbooks/LEADGEN_06_configure_api_keys.yml --ask-vault-pass

# Run 05 with -v to show SAFE diagnostics
ansible-playbook -i inventories/prod/hosts.ini playbooks/LEADGEN_05_wave3_intake_e2e_validation.yml --ask-vault-pass -v
```

Expected:
- LEADGEN_06: PASS (service restarted and env vars verified by name)
- LEADGEN_05: PASS
  - Intake POST returns 202 and body contains `status=accepted` and `intake_id`
  - Final assertion passes (202 is accepted)
