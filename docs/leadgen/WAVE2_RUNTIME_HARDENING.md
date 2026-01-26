# LeadGen Wave 2 — Runtime Hardening (Production)

This document describes **Wave 2 runtime hardening** for the LeadGen Wave 1 API.

## Goals (stability-first)
- Deterministic service behavior under systemd (restart policy, limits, dependency ordering)
- Container guardrails (bounded logs, resource caps, safer privileges)
- Continuous health monitoring with automatic restart on failure
- No business-logic changes (runtime/ops only)

## What Wave 2 changes
### 1) Hardened systemd unit: `motorcade-leadgen-api.service`
- `Restart=always` with sane start limits
- Deterministic `ExecStartPre` checks
- Keeps bind private: `127.0.0.1:8000` (nginx is the public edge)
- Uses `--log-driver k8s-file` with bounded rotation
- Applies basic least privilege flags:
  - `--cap-drop=all`
  - `--security-opt no-new-privileges`
  - `--read-only` rootfs with host tmp mounted to `/tmp`

### 2) Health watchdog timer
- `motorcade-leadgen-watchdog.timer` runs every ~30s
- Calls local health endpoint: `http://127.0.0.1:8000/lead/health`
- On repeated failure, restarts `motorcade-leadgen-api.service`

## Run
```bash
cd ~/Repos/motorcade-infra/ansible

ansible-playbook -i inventories/prod/hosts.ini \
  playbooks/LEADGEN_04_wave2_runtime_hardening.yml \
  --vault-id @prompt
```

## Verify (server)
```bash
sudo systemctl status motorcade-leadgen-api --no-pager
sudo systemctl status motorcade-leadgen-watchdog.timer --no-pager

curl -sS http://127.0.0.1:8000/lead/health | jq
curl -sS https://motorcade.vip/api/lead/health | jq

# Watchdog logs
sudo journalctl -u motorcade-leadgen-watchdog.service -n 100 --no-pager
```

## Notes / Rollback
- To disable the watchdog:
```bash
sudo systemctl disable --now motorcade-leadgen-watchdog.timer
```
- To revert the leadgen systemd unit, restore `/etc/systemd/system/motorcade-leadgen-api.service` from a prior checkpoint and:
```bash
sudo systemctl daemon-reload
sudo systemctl restart motorcade-leadgen-api
```


## Note
- `StartLimitIntervalSec` / `StartLimitBurst` are set in the `[Unit]` section of the systemd service (systemd ignores them in `[Service]`).
