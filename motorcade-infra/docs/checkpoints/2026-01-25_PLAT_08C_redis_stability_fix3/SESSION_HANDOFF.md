SESSION HANDOFF — motorcade-infra

Status:
- PLAT_08B complete and verified (Redis foundation).
- PLAT_08C blocked previously by Podman/conmon journald incompatibility.
- This checkpoint replaces PLAT_08C with an authoritative unit rebuild that removes journald log-driver and uses bounded verification.

Next:
- Run: ansible/playbooks/PLAT_08C_redis_bringup_health_gate.yml
- Verify Redis returns PONG.
