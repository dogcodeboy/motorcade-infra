# NEXT STEPS — After PLAT_02B

1. Ensure vault contains `vault_postgres_password` (>=12 chars).
2. Run playbook with vault:
   - `ansible-playbook ... PLAT_02B_postgres_foundation.yml --ask-vault-pass`
3. Confirm unit is disabled:
   - `systemctl is-enabled motorcade-postgres.service` => disabled

Do NOT start Postgres until PLAT_02C is approved.
