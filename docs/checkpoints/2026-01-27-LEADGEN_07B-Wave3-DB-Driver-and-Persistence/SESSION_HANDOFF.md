# Session Handoff — LEADGEN_07B

## What we were fixing
Wave 3 Lead Intake E2E was failing because the LeadGen API image did not include a Postgres driver, and we needed a single playbook that *proves persistence* (accepted intake -> row in Postgres).

## What this checkpoint delivers
- A clean regenerated `LEADGEN_07B` playbook (no `motorcade_web` host hallucinations) that:
  - Finds and patches `requirements.txt` to include `psycopg[binary]` if missing
  - Rebuilds the LeadGen API image and restarts `motorcade-leadgen-api.service`
  - Waits for systemd active + TCP port 8000 + `/lead/health` 200
  - Sends a valid Wave3 intake payload using an allowed `request.service_type` enum (`armed_security`)
  - Polls Postgres until the inserted lead exists in `app.leads`
  - Emits safe diagnostics if health or persistence fails

## How to run
```bash
cd ~/Repos/motorcade-infra/ansible
ansible-playbook -i inventories/prod/hosts.ini \
  playbooks/LEADGEN_07B_wave3_psycopg_driver_fix_and_persistence_verify.yml \
  --ask-vault-pass
```

## If it fails
- The playbook prints:
  - `systemctl status` + `journalctl` tail for the service
  - recent rows in `app.leads`

Use those outputs to decide whether the API is still doing async queueing, writing to a different table, or failing an internal DB write.

## Next
- Once `LEADGEN_07B` passes consistently, proceed to the next LeadGen hardening playbook (rate limit / logging / retention) per RUNBOOK.
