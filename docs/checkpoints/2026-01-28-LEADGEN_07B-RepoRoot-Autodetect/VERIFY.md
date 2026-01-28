## Verify
From local:

```bash
cd ~/Repos/motorcade-infra/ansible
ansible-playbook -i inventories/prod/hosts.ini \
  playbooks/LEADGEN_07B_wave3_psycopg_driver_fix_and_persistence_verify.yml \
  --ask-vault-pass
```

Expected:
- Playbook parses (no YAML errors)
- Autodetect prints leadgen_repo_root
- POST /lead/intake returns 200/201/202/409
- Persistence poll succeeds when row appears by request_id or email
