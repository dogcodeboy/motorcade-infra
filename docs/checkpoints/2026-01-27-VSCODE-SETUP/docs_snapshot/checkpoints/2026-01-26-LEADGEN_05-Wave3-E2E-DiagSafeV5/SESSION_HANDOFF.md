SESSION HANDOFF — motorcade-infra (LEADGEN_05/06)

Current:
- LEADGEN_06: GREEN (keys written to `/etc/motorcade/leadgen.env`, service restarted)
- LEADGEN_05: Intake POST still failing with **transport error** (no HTTP response). `/lead/health` is 200.

Change in this checkpoint:
- LEADGEN_05 now prints safe diagnostics on transport error (listener + journal tail) without exposing secrets.
- Added `timeout: 15` + `validate_certs: false` to the POST request.

Run:
```bash
cd ~/Repos/motorcade-infra/ansible
ansible-playbook -i inventories/prod/hosts.ini playbooks/LEADGEN_06_configure_api_keys.yml --ask-vault-pass
ansible-playbook -i inventories/prod/hosts.ini playbooks/LEADGEN_05_wave3_intake_e2e_validation.yml --ask-vault-pass -v
```

If transport error persists, on the server:
```bash
sudo ss -ltnp | grep ':8000 '
sudo journalctl -u motorcade-leadgen-api.service -n 200 --no-pager
sudo podman logs --tail 200 motorcade-leadgen-api
```
