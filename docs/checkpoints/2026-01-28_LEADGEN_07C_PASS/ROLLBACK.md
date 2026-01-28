# LEADGEN_07C — Rollback

Rollback is a **pinned ref rollback** (no manual host edits).

## 1) Stop worker

```bash
sudo systemctl stop motorcade-leadgen-worker.service
```

## 2) Redeploy the last-known-good API tag

Run the previous PASS playbook pinned to `leadgen-wave1-2026-01-28b`:

```bash
cd ~/Repos/motorcade-infra/ansible
ansible-playbook -i inventories/prod/hosts.ini \
  playbooks/LEADGEN_07B_wave3_psycopg_driver_fix_and_persistence_verify.yml \
  --ask-vault-pass
```

## 3) Optional: drain or purge stuck jobs

If needed, purge the queue (only if you intentionally want to drop queued work):

```bash
sudo /usr/local/bin/podman exec -i motorcade-postgres psql -U postgres -d motorcade -c "TRUNCATE app.intake_jobs;"
```
