SESSION HANDOFF — motorcade-infra

Status:
- PLAT_08B complete and verified (Redis foundation).
- PLAT_08C was blocked by systemd churn: Redis container exited immediately and was removed, so PING checks never saw a live container.
- Fix6 replaces PLAT_08C with an authoritative bring-up that rewrites the redis unit (no journald), preflights volume perms + SELinux labeling, and uses bounded checks.

Root Cause (confirmed from PLAT_08B unit):
- Foundation installed `--log-driver journald` (unsupported on this host's static Podman/conmon).
- Foundation created redis volume dir owned by root; Redis inside container runs as UID 999 and can exit if it can't write.

Rules:
- No manual server edits; all corrections via Ansible.
- Nginx stack frozen; canonical deprecation policy active.

Next:
1) Merge Fix6 zip into repo root and commit.
2) Run:
   cd ~/Repos/motorcade-infra/ansible
   ansible-playbook -i inventories/prod/hosts.ini playbooks/PLAT_08C_redis_bringup_health_gate.yml --ask-vault-pass
3) Verify:
   ssh motorcade
   sudo systemctl cat motorcade-redis --no-pager
   sudo /usr/local/bin/podman ps --filter name=motorcade-redis
   sudo /usr/local/bin/podman exec motorcade-redis redis-cli ping
