## Verify
1) Run playbook:

```bash
cd ~/Repos/motorcade-infra/ansible
ansible-playbook -i inventories/prod/hosts.ini \
  playbooks/LEADGEN_07B_wave3_psycopg_driver_fix_and_persistence_verify.yml \
  --ask-vault-pass
```

2) Confirm it reaches persistence check and succeeds if **either**:
- a row exists in `app.leads` with matching `request_id`, OR
- a row exists in `app.leads` with matching generated email.

3) If it still fails, use the printed diagnostics (last 10 rows) to confirm whether writes are occurring to a different table/schema.
