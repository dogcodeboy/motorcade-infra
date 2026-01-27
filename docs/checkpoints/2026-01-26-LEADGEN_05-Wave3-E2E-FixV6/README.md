# Checkpoint: LEADGEN_05 Wave3 E2E Fix V6

**Date:** 2026-01-26 (America/Chicago)  
**Repo:** motorcade-infra  
**Scope:** Fix YAML/syntax churn in `LEADGEN_05_wave3_intake_e2e_validation.yml` and make the E2E test deterministic and safe.

## What changed
- Rewrote `LEADGEN_05_wave3_intake_e2e_validation.yml` from scratch to remove indentation/syntax issues and simplify E2E flow.
- Keeps secrets protected (`no_log: true` on the POST), but exposes **safe** status/snippet under `-v`.

## Expected outcome
- `GET /lead/health` returns 200 and JSON `status=ok`.
- `POST /lead/intake` returns HTTP 200/201/202.
- If not, the playbook fails with a safe status/snippet to guide the next fix.

## Notes
- This playbook targets the **literal host** `motorcade-web-01` (as used in prior sessions).
- Canonical key is preferred: `vault_leadgen_api_key` falls back to `vault_leadgen_intake_api_key`.
