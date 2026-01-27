# Verify (commands)

From your workstation:

```bash
cd ~/Repos/motorcade-infra/ansible

# Optional: ensure keys are deployed (should be green)
ansible-playbook -i inventories/prod/hosts.ini playbooks/LEADGEN_06_configure_api_keys.yml --ask-vault-pass

# Run E2E with safe diagnostics (-v)
ansible-playbook -i inventories/prod/hosts.ini playbooks/LEADGEN_05_wave3_intake_e2e_validation.yml --ask-vault-pass -v
```

If intake still fails, grab these on the server:

```bash
sudo journalctl -u motorcade-leadgen-api.service -n 120 --no-pager
sudo ss -ltnp | grep -E ':(8000|8080)\b'
sudo systemctl status motorcade-leadgen-api.service --no-pager
```
