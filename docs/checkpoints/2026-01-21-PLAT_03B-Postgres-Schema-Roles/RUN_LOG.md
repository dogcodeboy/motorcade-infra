# RUN_LOG — PLAT_03B

## Commands run (control node)

```bash
cd ~/Repos/motorcade-infra/ansible
ansible-playbook -i inventories/prod/hosts.ini playbooks/PLAT_03_postgres_schema_roles.yml --ask-vault-pass
```

## Expected recap (first run)

```
ok=4
changed=1
failed=0
```

## Notes
- An earlier failure (`role "root" does not exist`) was resolved by connecting to Postgres inside the container as:
  `psql -U postgres`
- The SQL task is `no_log: true` to avoid exposing secrets.
