## Root cause
The Redis foundation unit (PLAT_08B) used `--log-driver journald`, but the static Podman/conmon build on the host does not support journald logging. The container never started, leaving systemd in a restart loop and any readiness gating unable to complete.

## Fix
Rebuild the Redis unit file without journald log driver and remove any systemd drop-in overrides to guarantee the runtime flags.
