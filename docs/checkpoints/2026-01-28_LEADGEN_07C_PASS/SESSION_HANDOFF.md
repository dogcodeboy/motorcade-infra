# SESSION HANDOFF — LEADGEN_07C (PASS)

Date: 2026-01-28

Status: **LEADGEN_07C PASS**

## Summary

- LeadGen intake enqueues into `app.intake_jobs` and returns **202 Accepted** once queued.
- A dedicated worker (`motorcade-leadgen-worker.service`) drains queued jobs and persists into `app.leads`.
- Idempotency is enforced by `app.intake_jobs.idempotency_key` (unique) plus payload-match checks at enqueue.

## What was run

- Playbook: `ansible/playbooks/LEADGEN_07C_wave4_postgres_outbox_async_boundary.yml`

## How to verify

See `VERIFY.md` in this checkpoint.

## Where to look if broken

```bash
journalctl -u motorcade-leadgen-api.service -n 200 --no-pager
journalctl -u motorcade-leadgen-worker.service -n 200 --no-pager
sudo /usr/local/bin/podman exec -it motorcade-postgres psql -U postgres -d motorcade -c "select status,count(*) from app.intake_jobs group by 1 order by 1;"
```
