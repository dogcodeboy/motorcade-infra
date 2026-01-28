# LEADGEN_07B — RepoRoot Autodetect + Parse-Stable Driver/Persistence Verify

This checkpoint updates the LEADGEN_07B playbook to:
- Autodetect LeadGen repo root from known candidates (prevents requirements.txt-not-found regressions).
- Keep YAML parse stable by avoiding backslash-heavy patterns.
- Continue Wave3 goal: ensure psycopg driver packaged and verify lead intake persistence to Postgres.
