## Verify

On your workstation:

```bash
cd ~/Repos/motorcade-infra/ansible
ansible-playbook -i inventories/prod/hosts.ini \
  playbooks/LEADGEN_07B_wave3_psycopg_driver_fix_and_persistence_verify.yml \
  --ask-vault-pass
```

Expected:
- Playbook parses (no YAML "unknown escape character" errors).
- `/lead/health` returns ok.
- Intake returns 200/201/202/409.
- Persistence poll passes if **either** `request_id` or `email` is found in `app.leads`.

If it still fails persistence (both counts 0), use the diagnostics task output (latest leads, systemd status, journal tail) to determine whether the write path is async/worker-based or targeting a different table/DB.
