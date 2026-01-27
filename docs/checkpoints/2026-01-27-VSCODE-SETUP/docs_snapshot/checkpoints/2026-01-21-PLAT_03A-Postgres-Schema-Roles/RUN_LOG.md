# RUN LOG (PLAT_03A)

Command (from `~/Repos/motorcade-infra/ansible`):

```bash
ansible-playbook -i inventories/prod/hosts.ini playbooks/PLAT_03_postgres_schema_roles.yml --ask-vault-pass
```

Notes:
- Requires additional vault secrets for the Motorcade DB roles.
- Creates a logical backup under `/srv/motorcade/backups/postgres/` before applying changes.
