## Verify

From your workstation:

```bash
cd ~/Repos/motorcade-infra/ansible
ansible-playbook -i inventories/prod/hosts.ini \
  playbooks/LEADGEN_07B_wave3_psycopg_driver_fix_and_persistence_verify.yml \
  --ask-vault-pass
```

Expected:
- Play completes successfully.
- Output includes an `intake_status` of `200/201/202/409`.
- Postgres persistence check passes (row count >= 1 for the generated E2E email).
