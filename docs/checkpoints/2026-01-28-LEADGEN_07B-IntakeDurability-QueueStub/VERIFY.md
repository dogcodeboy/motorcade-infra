# Verify (prod)

Run from your workstation:

```bash
cd ~/Repos/motorcade-infra/ansible
ansible-playbook -i inventories/prod/hosts.ini   playbooks/LEADGEN_07B_wave3_psycopg_driver_fix_and_persistence_verify.yml   --ask-vault-pass
```

Expected (current):
- Build + restart succeeds
- `GET /lead/health` returns 200 and includes `queue=stub`
- `POST /lead/intake` returns one of: 200/201/202/409
- Playbook may stop after printing that queue is stub (until next playbook enforces Postgres verification)

Manual evidence commands on host:
```bash
sudo systemctl --no-pager --full status motorcade-leadgen-api.service | sed -n '1,120p'
sudo journalctl -u motorcade-leadgen-api.service --no-pager -n 80
curl -fsS http://127.0.0.1:8000/lead/health | jq .
```
