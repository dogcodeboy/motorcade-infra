# SESSION HANDOFF — motorcade-infra (LEADGEN_07B)

## What happened
- Fixed Wave3 intake payload schema issues (valid service_type + required request.timeline).
- Intake now returns **202 Accepted** and returns a `request_id`.
- Persistence check is still failing: no row appears in `app.leads` within the poll window.

## What this checkpoint adds
- The playbook now polls persistence by `request_id` first (preferred), then falls back to email.
- On persistence failure it prints diagnostics: latest leads, service status, journal tail, podman ps.

## How to run
cd ~/Repos/motorcade-infra/ansible
ansible-playbook -i inventories/prod/hosts.ini \
  playbooks/LEADGEN_07B_wave3_psycopg_driver_fix_and_persistence_verify.yml \
  --ask-vault-pass

## Next investigation target (likely root cause)
Because intake is 202-accepted but nothing is persisted:
- worker/queue processor may not be running (async acceptance without persistence)
- API may be writing to a different table/schema/DB than app.leads
Use the printed diagnostics to confirm which.
