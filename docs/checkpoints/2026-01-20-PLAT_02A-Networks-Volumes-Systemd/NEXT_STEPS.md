# Next Steps

## 1) Run PLAT_02A (prod)
From repo root:

```bash
cd motorcade-infra
./scripts/run_playbook.sh motorcade-web-01 playbooks/PLAT_02A_networks_volumes_systemd_foundations.yml -i inventories/prod/hosts.ini
```

Expected:
- `failed=0`
- Networks created (or already present)
- `/srv/motorcade` layout present
- systemd target enabled and prep service ran once

## 2) Append deploy log (after successful run)
Update:
- `docs/deployments/2026-01-20.md` — add an entry under `Entries` for PLAT_02A with verification outputs

## 3) Proceed to PLAT_02B (Postgres phase 1)
Per RUNBOOK order, next is a containerized Postgres primitive using the new `/srv/motorcade/volumes/postgres` mount and the `motorcade-core` network.

Constraints:
- Still no application containers (APIs/proxy) beyond DB validation.
