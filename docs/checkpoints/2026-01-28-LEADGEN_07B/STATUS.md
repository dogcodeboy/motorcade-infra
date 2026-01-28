# STATUS — Server + Services (snapshot summary)

## Containers (podman ps --all)

Expected running containers:

- `motorcade-postgres` (postgres:16)
- `motorcade-redis` (redis:7.2-alpine)
- `motorcade-leadgen-api` (localhost/motorcade-leadgen-api:wave1)

## systemd

Expected active units:

- `motorcade-postgres.service` — active/running
- `motorcade-redis.service` — active/running
- `motorcade-leadgen-api.service` — active/running
- `motorcade-platform.target` — active

Watchdogs / timers:

- `motorcade-leadgen-watchdog.timer` — active/waiting (probe /lead/health)
- `motorcade-redis-healthcheck.timer` — active/waiting

## Health

- Direct API health: `http://127.0.0.1:8000/lead/health` returns 200 OK JSON with `"status":"ok"`.

## DB

Database: `motorcade`  
Schema: `app`  
Tables: `app.leads`, `app.schema_migrations`

`app.leads.payload` column is `jsonb`.
