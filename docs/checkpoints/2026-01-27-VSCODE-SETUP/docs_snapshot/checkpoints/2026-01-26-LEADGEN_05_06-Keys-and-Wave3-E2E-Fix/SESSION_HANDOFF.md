SESSION HANDOFF — motorcade-infra (LEADGEN_05/06)

Status
- LEADGEN_06: confirmed keys exist in `/etc/motorcade/leadgen.env` and container sees:
  - LEADGEN_INTAKE_API_KEY
  - LEADGEN_ADMIN_API_KEY
  - LEADGEN_API_KEY
- LEADGEN_05: playbook previously failed to parse due to a mis-indented `verbosity:` in a debug task. This checkpoint fixes that so the playbook can execute and show the real API response (e.g., 422 vs 503).

Next step
1) Run LEADGEN_05 Wave 3 E2E playbook.
2) If it still fails, capture the **HTTP status + response body** the playbook prints (safe output) so we can align the payload/auth to the API’s expectations.
