# Verify

From your workstation:

```bash
cd ~/Repos/motorcade-infra/ansible

# Ensure keys are configured (LEADGEN_06 should be green)
ansible-playbook -i inventories/prod/hosts.ini playbooks/LEADGEN_06_configure_api_keys.yml --ask-vault-pass

# Run Wave 3 E2E test with safe diagnostics visible
ansible-playbook -i inventories/prod/hosts.ini playbooks/LEADGEN_05_wave3_intake_e2e_validation.yml --ask-vault-pass -v
```

Expected:
- Health check passes (200).
- Intake POST prints a short debug line showing HTTP status and a redacted snippet.
- If intake is not 200/201, the playbook fails with that status visible so we can correct schema/key/app logic quickly.
