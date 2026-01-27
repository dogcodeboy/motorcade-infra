# Verify

## 1) Configure keys (LEADGEN_06)
```bash
cd ~/Repos/motorcade-infra/ansible
ansible-playbook -i inventories/prod/hosts.ini \
  playbooks/LEADGEN_06_configure_api_keys.yml \
  --ask-vault-pass
```

## 2) Run Wave 3 E2E (LEADGEN_05)
```bash
cd ~/Repos/motorcade-infra/ansible
ansible-playbook -i inventories/prod/hosts.ini \
  playbooks/LEADGEN_05_wave3_intake_e2e_validation.yml \
  --ask-vault-pass
```
