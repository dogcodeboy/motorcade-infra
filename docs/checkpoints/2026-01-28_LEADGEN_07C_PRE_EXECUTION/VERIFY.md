# Verification — LEADGEN_07C

1. Stop worker → POST /lead/intake returns 202.
2. Start worker → jobs drain to app.leads.
3. Idempotency preserved.
