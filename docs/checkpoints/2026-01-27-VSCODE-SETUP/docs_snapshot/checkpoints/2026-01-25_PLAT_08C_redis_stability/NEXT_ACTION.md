# Next Action (do this next session)

1) Replace PLAT_08C with a one-shot model:
   - Create volume/network prerequisites (idempotent)
   - Start redis container WITHOUT journald log driver
   - Bounded verification (redis-cli ping with timeout)
   - If fail, dump podman ps/logs and fail fast

2) Keep systemd unit simple and compatible:
   - No journald log driver
   - Restart policy ok, but ensure container start is valid

3) Verify:
   - systemctl status motorcade-redis
   - podman ps
   - podman exec motorcade-redis redis-cli ping
