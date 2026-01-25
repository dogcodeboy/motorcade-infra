SESSION HANDOFF — motorcade-infra — PLAT_08C Redis Churn Fix

Status:
- PLAT_08B complete (Redis foundation).
- PLAT_08C was failing due to:
  - Podman/conmon journald incompatibility (`--log-driver journald` -> exit 126)
  - Potential redis volume perms/SELinux label issues

Fix in this checkpoint:
- Replaced `ansible/playbooks/PLAT_08C_redis_bringup_health_gate.yml` with an authoritative unit rewrite + bounded verification.
- Updates `docs/RUNBOOK.md` (append-only) with the 2026-01-25 PLAT_08C churn fix entry.
- New checkpoint folder:
  - `docs/checkpoints/2026-01-25_PLAT_08C_redis_churn_fix_preflight/`

Run (authoritative):
```bash
cd ~/Repos/motorcade-infra/ansible
ansible-playbook -i inventories/prod/hosts.ini \
  playbooks/PLAT_08C_redis_bringup_health_gate.yml \
  --ask-vault-pass
```

Quick verify (server):
```bash
ssh motorcade
sudo systemctl status motorcade-redis --no-pager
sudo /usr/local/bin/podman ps -a --filter name=motorcade-redis
sudo /usr/local/bin/podman logs --tail 80 motorcade-redis
sudo /usr/local/bin/podman exec motorcade-redis redis-cli ping
```

Expected:
- systemd shows Active: active (running)
- `podman ps` shows motorcade-redis Up
- ping returns `PONG`
