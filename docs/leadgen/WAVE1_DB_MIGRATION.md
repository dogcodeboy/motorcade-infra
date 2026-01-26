# LeadGen Wave 1 — DB Migration

This wave adds the initial **Lead Intake** persistence layer.

## What it creates

- Schema: `app`
- Table: `app.leads`
- Ledger: `app.schema_migrations` (records applied version)

Migration file:
- `ansible/files/leadgen/20260126_01_wave1_leads.sql`

## Run (from your workstation)

```bash
cd ~/Repos/motorcade-infra/ansible

ansible-playbook -i inventories/prod/hosts.ini   playbooks/LEADGEN_01_wave1_db_schema.yml   --ask-vault-pass
```

## Verify (on server)

```bash
sudo /usr/local/bin/podman exec motorcade-postgres psql -U postgres -v ON_ERROR_STOP=1 -c "\dt app.*"
sudo /usr/local/bin/podman exec motorcade-postgres psql -U postgres -v ON_ERROR_STOP=1 -c "select * from app.schema_migrations order by applied_at desc;"
```
