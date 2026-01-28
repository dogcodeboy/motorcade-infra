# DECISIONS (Production-safe defaults)

## JSONB persistence

We chose “serialize + explicit cast” over relying on psycopg auto-adapters because:

- It is stable across psycopg3 builds and container images.
- It avoids runtime surprises (“cannot adapt type dict”) in production.
- It preserves raw payload fidelity in `jsonb`.

## E2E test approach

- Use OpenAPI as the contract to generate a schema-valid payload.
- Permit `200/201/202/409` as acceptable outcomes:
  - 409 covers idempotency replays without failing the run.

## Scope control

- No Redis/Nginx/Postgres foundation changes while validating LEADGEN_07B.
- Only LeadGen app ref selection + E2E payload correctness + persistence proof.
