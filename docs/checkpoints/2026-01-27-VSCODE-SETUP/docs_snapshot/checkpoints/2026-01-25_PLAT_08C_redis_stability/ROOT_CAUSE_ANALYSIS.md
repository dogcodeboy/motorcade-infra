# Root Cause Analysis — PLAT_08C

Symptom:
- motorcade-redis.service restarts endlessly
- readiness gate hangs indefinitely

Evidence:
- journald shows: "Include journald in compilation path to log to systemd journal"
- podman reports conmon failure (exit status 1), leading to redis unit status=126

Root Cause:
- Static Podman/conmon build on this host lacks journald support.
- The systemd ExecStart uses --log-driver journald, so container start fails.
- The readiness gate is a long-running loop and therefore appears "hung".

Fix direction:
- Remove --log-driver journald.
- Replace readiness daemon with bounded verification inside PLAT_08C.
