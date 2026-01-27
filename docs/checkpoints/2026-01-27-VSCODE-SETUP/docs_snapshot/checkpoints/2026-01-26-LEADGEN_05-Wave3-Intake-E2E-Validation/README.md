# CHECKPOINT — 2026-01-26-LEADGEN_05-Wave3-Intake-E2E-Validation

## Summary
LeadGen Wave 3 delivers a production-safe **end-to-end intake write-path validation**:
- Intake API accepts a valid TX payload and returns stable IDs
- Idempotency behavior verified
- Postgres persistence confirmed (`app.leads`)
- Optional admin list sanity check
- Controller-side drift guard is repo-bounded and non-blocking (cannot hang)

## Files
- `ansible/playbooks/LEADGEN_05_wave3_intake_e2e_validation.yml`
- `docs/leadgen/WAVE3_INTAKE_E2E_VALIDATION.md`

## Run
```bash
cd ~/Repos/motorcade-infra/ansible

ansible-playbook -i inventories/prod/hosts.ini \
  playbooks/LEADGEN_05_wave3_intake_e2e_validation.yml \
  --vault-id @prompt
```

## Acceptance Criteria
- Play succeeds with `failed=0`
- Intake returns 200/201/202 and supplies `intake_id`
- DB query returns >= 1 row for that `intake_id`



## Patch
- Bounded the controller-side duplicate `ansible.cfg` drift-guard search to the repo to prevent hangs on slow filesystems.

- Fixed intake payload schema (wraps fields under `contact` + `request`) to avoid HTTP 422.


## Patch W3FIX5 (Jan 26)
- Updated nested payload to match current API required fields:
  - `contact.full_name`
  - `request.service_type`, `request.timeline`, `request.location`
- Keeps `service_state`, `service_city`, `requested_start_utc`, and idempotency check.

## Patch W3FIX4 (Jan 26)
- Removed flat-schema fallback (API requires nested `contact` + `request` payload).
- Set `wave3_requested_start_utc` default to `ansible_date_time.iso8601`.
- Fixed repeat submit capture quoting and stabilized assertions.

