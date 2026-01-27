# SESSION HANDOFF — motorcade-infra (LEADGEN_05 Fix V6)

## Current state
- **LEADGEN_06** is green and confirms these env vars inside the container:
  - `LEADGEN_INTAKE_API_KEY`
  - `LEADGEN_ADMIN_API_KEY`
  - `LEADGEN_API_KEY`
- **LEADGEN_05** was repeatedly failing due to YAML/indent/syntax churn. This checkpoint rewrites LEADGEN_05 cleanly.

## Next step (copy/paste)
```bash
cd ~/Repos/motorcade-infra
unzip -o ~/Downloads/<ZIP_NAME>.zip

cd ~/Repos/motorcade-infra/ansible

ansible-playbook -i inventories/prod/hosts.ini playbooks/LEADGEN_06_configure_api_keys.yml --ask-vault-pass
ansible-playbook -i inventories/prod/hosts.ini playbooks/LEADGEN_05_wave3_intake_e2e_validation.yml --ask-vault-pass -v
```

## If LEADGEN_05 fails again
1. Capture the final failure line (it will include safe `status=` and `snippet=`).
2. Run on server:
   - `sudo journalctl -u motorcade-leadgen-api.service -n 120 --no-pager`
   - `sudo ss -ltnp | grep -E ':(8000|8080)\b'`

## Commit suggestion (GitKraken)
- **Commit message:** `LEADGEN_05: rewrite Wave3 E2E playbook (FixV6)`
