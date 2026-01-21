# APPEND-ONLY PATCH — docs/RUNBOOK.md

Append this section under the Platform playbooks / execution section:

## PLAT_02C — Postgres Bring-up (start + healthcheck; still no schema)

Run from repo ansible directory:

```bash
cd ~/Repos/motorcade-infra/ansible
ansible-playbook -i inventories/prod/hosts.ini playbooks/PLAT_02C_postgres_bringup.yml --ask-vault-pass
```

Expected:
- systemd unit updated to bring-up variant (no `--rm`)
- service becomes **active**
- service remains **disabled** (foundation policy)
- readiness verified via `pg_isready` inside container

Rollback:
- `sudo systemctl stop motorcade-postgres.service` (container will be removed by ExecStopPost; data persists in /srv/motorcade/volumes/postgres)
