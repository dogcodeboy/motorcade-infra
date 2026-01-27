# LEADGEN Wave 3 — Intake E2E Validation (Write-Path Proof)

## Goal
Prove that the LeadGen API **accepts a valid intake**, returns stable IDs, and **persists the lead to Postgres** (`app.leads`).

This is an **end-to-end write-path validation** suitable for production smoke tests.

## What it validates
1. `GET /lead/health` is OK
2. `POST /lead/intake` returns **200 OK** or **201 Created** and includes:
   - `intake_id` (format `li_{18 hex}`)
   - `request_id`
3. **Idempotency**: repeating the same request with the same `Idempotency-Key` returns the *same* IDs
4. **DB proof**: Postgres contains a row in `app.leads` matching `intake_id`
5. Optional: `GET /admin/leads` works with `X-Admin-Key`


## Intake payload schema (for `/lead/intake`)
The API expects a JSON body with **two top-level objects**:

```json
{
  "contact": { "full_name": "...", "email": "...", "phone": "..." },
  "request": {
    "service_type": "armed_security",
    "timeline": { "type": "flexible" },
    "location": { "city": "Houston", "state": "TX", "raw": "Houston, TX" },
    "service_state": "TX",
    "service_city": "Houston",
    "requested_start_utc": "…",
    "notes": "…"
  }
}
```

**service_type enum (current expected):**
`armed_security`, `executive_protection`, `rapid_response_support`, `armed_escort_driver`, `armed_delivery`, `event_security`

## Playbook
- `ansible/playbooks/LEADGEN_05_wave3_intake_e2e_validation.yml`

## How to run
From your controller:

```bash
cd ~/Repos/motorcade-infra/ansible

ansible-playbook -i inventories/prod/hosts.ini \
  playbooks/LEADGEN_05_wave3_intake_e2e_validation.yml \
  --vault-id @prompt
```

## Notes (production safe)
- Each run creates **one synthetic lead** (tagged as `lead_source=wave3_smoketest` via header/body) unless the playbook is re-run in the same second.
- No secrets are printed to output.
- DB assertion allows `1` (expected). `2` is tolerated only as a safety valve if the DB schema lacks unique constraints.

## Next step after Wave 3
Wave 4 typically wires queue processing (Redis-backed idempotency + job queue) and/or a retention/audit policy for test leads.



### Controller preflight note
The duplicate `ansible.cfg` drift-guard check is bounded to the repo (`find . -maxdepth 6`) to avoid slow/hanging searches outside the project directory.


## Drift Guard (controller)

Wave 3 includes a bounded drift guard that checks for multiple `ansible.cfg` files **inside the repo only**. It is implemented as a standalone script:

- `ansible/files/drift_guard_ansible_cfg.sh`

This avoids inline shell blocks in YAML and prevents slow/unbounded filesystem crawls.
## 2026-01-26 Patch: payload + timestamp hardening
- Ensures `wave3_requested_start_utc` is always defined (defaults to `ansible_date_time.iso8601`).
- Uses the nested schema only (`contact`/`request`). The legacy flat-schema fallback was removed because the API rejects it.
- Adds required fields: `contact.full_name`, `request.service_type`, `request.timeline` (object), `request.location` (object).
- Keeps the idempotency check (repeat submit with same Idempotency-Key must return same intake_id).

## 2026-01-26 Patch (W3FIX3)
- Fix: remove self-referential set_fact that caused wave3_idempotency_key undefined; Wave 3 now uses wave3_idempotency_key directly.
