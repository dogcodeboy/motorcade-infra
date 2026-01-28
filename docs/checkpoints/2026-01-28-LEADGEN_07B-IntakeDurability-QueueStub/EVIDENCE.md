# Evidence captured (summary)

From prod host:
- systemd shows `motorcade-leadgen-api.service` running and bound `127.0.0.1:8000 -> 8080` inside container.
- journalctl logs show repeated `GET /lead/health` 200 and intake acceptance events.
- `/etc/motorcade/leadgen.env` points LeadGen DB at `motorcade-postgres:5432`.
- `app.leads` includes `payload jsonb` and idempotency unique index on `idempotency_key` (partial index).
