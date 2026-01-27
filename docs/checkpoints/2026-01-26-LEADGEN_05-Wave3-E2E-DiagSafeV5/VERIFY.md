## Verify

```bash
cd ~/Repos/motorcade-infra/ansible

ansible-playbook -i inventories/prod/hosts.ini playbooks/LEADGEN_06_configure_api_keys.yml --ask-vault-pass
ansible-playbook -i inventories/prod/hosts.ini playbooks/LEADGEN_05_wave3_intake_e2e_validation.yml --ask-vault-pass -v
```

If the intake POST fails with a transport error, the playbook should print:
- transport error message
- `ss` snapshot around port 8000
- last 20 lines of `journalctl -u motorcade-leadgen-api.service -n 60`
