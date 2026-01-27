# Checkpoint: LEADGEN_05 — Wave 3 E2E Validation (Diag-Safe V4)

Date: 2026-01-26
Repo: motorcade-infra
Scope: Merge-only (playbook + checkpoint docs)

## What changed
- LEADGEN_05_wave3_intake_e2e_validation.yml:
  - Targets inventory group `motorcade` (not a literal host).
  - Uses `vault_leadgen_api_key` if present, otherwise falls back to `vault_leadgen_intake_api_key`.
  - Makes the intake POST *diagnosable* without leaking secrets:
    - Wraps the POST in a `block/rescue` so transport failures report a clear message.
    - Accepts common HTTP statuses to avoid `uri` hard-failing and hiding details.
    - Emits a short, sanitized debug line with HTTP status + redacted body (requires `-v`).

## Goal
Stop the "censored/no_log" dead-end so we can see **which** failure class we’re in (401/403 vs 422 vs 503) and fix accordingly.
