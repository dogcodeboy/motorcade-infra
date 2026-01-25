SESSION HANDOFF — motorcade-infra

Status:
- Redis bring-up (PLAT_08C) is now stable: container stays running and `redis-cli ping` returns PONG.
- Added PLAT_08D to harden Redis operational stability using a **bounded systemd timer** (no infinite readiness daemons).

What PLAT_08D does:
- Installs `/usr/local/libexec/motorcade/redis_healthcheck.sh`.
- Creates `motorcade-redis-healthcheck.service` (oneshot) and `motorcade-redis-healthcheck.timer` (runs every minute).
- If the container disappears or PING fails, the timer run **restarts motorcade-redis**.

Run:
```bash
cd ~/Repos/motorcade-infra/ansible
ansible-playbook -i inventories/prod/hosts.ini \
  playbooks/PLAT_08D_redis_production_stability.yml \
  --ask-vault-pass
```

Verify (server):
```bash
sudo systemctl is-active motorcade-redis
sudo /usr/local/bin/podman ps --filter name=motorcade-redis
sudo /usr/local/bin/podman exec motorcade-redis redis-cli ping

sudo systemctl status motorcade-redis-healthcheck.timer --no-pager
sudo journalctl -u motorcade-redis-healthcheck.service -n 50 --no-pager
```

Notes:
- “Journald disabled” refers to the **Podman container log driver** (no `--log-driver journald` in `podman run`).
- You will still see Podman/systemd messages in the system journal because systemd itself logs there.
