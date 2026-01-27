SESSION HANDOFF — motorcade-infra

Status:
- PLAT_08B complete (Redis foundation installed).
- PLAT_08C health check failed due to redis churn; root cause: the host unit still contained `--log-driver journald` and Redis exited immediately (container removed by unit), so `podman exec ... ping` never reached `PONG`.

Fix:
- PLAT_08C has been replaced with an authoritative playbook that:
  - Rewrites `/etc/systemd/system/motorcade-redis.service` from scratch (no regex edits).
  - Removes `--log-driver journald`.
  - Removes any `motorcade-redis.service.d` drop-ins.
  - Preps `/srv/motorcade/volumes/redis` with owner `999:999` and SELinux container labeling (enforcing).
  - Uses bounded verification: wait container `Up`, then requires `PONG`; prints systemd + podman logs on failure.

Rules:
- No manual server edits; all fixes via Ansible.
- Nginx stack frozen; do not reopen.
- Canonical deprecation policy active.

Next:
1) Merge this checkpoint into `~/Repos/motorcade-infra` and commit.
2) Run:
   cd ~/Repos/motorcade-infra/ansible
   ansible-playbook -i inventories/prod/hosts.ini playbooks/PLAT_08C_redis_bringup_health_gate.yml --ask-vault-pass
3) Verify on server:
   sudo systemctl cat motorcade-redis.service | sed -n '1,220p'
   sudo /usr/local/bin/podman ps -a --filter name=motorcade-redis
   sudo /usr/local/bin/podman logs --tail 200 motorcade-redis
   sudo /usr/local/bin/podman exec motorcade-redis redis-cli ping
