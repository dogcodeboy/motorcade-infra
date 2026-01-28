# VERIFY — LEADGEN_07C (PASS)

Run these on **prod** (`motorcade-web-01`).

## API health

```bash
curl -fsS http://127.0.0.1:8000/lead/health | jq .
```

Expected: `status=ok`, `queue=pg_outbox`, `db=configured`.

## systemd status

```bash
systemctl --no-pager --full status motorcade-leadgen-api.service | sed -n '1,80p'
systemctl --no-pager --full status motorcade-leadgen-worker.service | sed -n '1,80p'
```

Expected: both **active (running)**.

## Logs (last 100)

```bash
journalctl -u motorcade-leadgen-api.service -n 100 --no-pager
journalctl -u motorcade-leadgen-worker.service -n 100 --no-pager
```

Expected: API shows Uvicorn running; worker shows job processing (`job_done`).

## DB spot-check (lead row exists)

```bash
sudo /usr/local/bin/podman exec -it motorcade-postgres psql -U postgres -d motorcade -c "
SELECT count(*) AS lead_rows, max(created_at) AS newest
FROM app.leads;"
```

Expected: `lead_rows >= 1` and `newest` recent.
