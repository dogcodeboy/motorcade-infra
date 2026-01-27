# SESSION HANDOFF — motorcade-infra (LeadGen Wave 3)

## Current status
- LEADGEN_06_configure_api_keys.yml: **PASS** (keys written into /etc/motorcade/leadgen.env; service restarted)
- LEADGEN_05_wave3_intake_e2e_validation.yml: **Still failing** on the intake POST, but previous versions hid details due to no_log.
- This checkpoint updates LEADGEN_05 so the failure becomes **visible and actionable** (safe + redacted).

## Next step (do this first)
Run with `-v` so the safe debug output prints:

```bash
cd ~/Repos/motorcade-infra/ansible
ansible-playbook -i inventories/prod/hosts.ini playbooks/LEADGEN_05_wave3_intake_e2e_validation.yml --ask-vault-pass -v
```

## What to report back (copy/paste)
- The debug line showing **HTTP status**
- The (redacted) snippet message, if any
- If it’s:
  - **401/403** → key mismatch (vault vars vs API expectation)
  - **422** → payload/schema mismatch
  - **503** → app-side config/route dependency issue (DB, downstream, middleware)

## Commit suggestion (after confirm)
Commit message:
`LEADGEN_05: make Wave3 E2E diagnosable (safe debug + key fallback)`
