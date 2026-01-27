# Verification

Run on `motorcade-web-01`.

```bash
sudo systemctl daemon-reload
sudo systemctl status motorcade-leadgen-api --no-pager
sudo systemctl status motorcade-leadgen-watchdog.timer --no-pager

curl -sS http://127.0.0.1:8000/lead/health | jq
curl -sS https://motorcade.vip/api/lead/health | jq

# Confirm bounded logs at runtime (podman log driver is k8s-file)
sudo /usr/local/bin/podman inspect motorcade-leadgen-api --format '{{.HostConfig.LogConfig.Type}}' || true

# Watchdog logs
sudo journalctl -u motorcade-leadgen-watchdog.service -n 100 --no-pager
```
