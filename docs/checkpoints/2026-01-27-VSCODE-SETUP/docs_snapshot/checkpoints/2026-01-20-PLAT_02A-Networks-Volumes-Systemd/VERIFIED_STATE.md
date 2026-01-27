# Verified State (Expected After Running PLAT_02A)

After running the playbook on the platform host, the following must be true:

## Podman
- Podman binary exists at: `/usr/local/bin/podman`
- `podman --version` prints successfully

## Networks
These Podman networks exist:
- `motorcade-core` (CIDR: `10.77.0.0/24`, GW: `10.77.0.1`)
- `motorcade-edge` (CIDR: `10.78.0.0/24`, GW: `10.78.0.1`)

Verification:
- `podman network inspect motorcade-core` succeeds
- `podman network inspect motorcade-edge` succeeds

## Filesystem layout
These directories exist with owner/group `root:root` and mode `0755`:
- `/srv/motorcade`
- `/srv/motorcade/containers`
- `/srv/motorcade/volumes`
- `/srv/motorcade/volumes/postgres`
- `/srv/motorcade/volumes/redis`
- `/srv/motorcade/volumes/uploads`
- `/srv/motorcade/logs`
- `/srv/motorcade/backups`

## systemd
- Target installed: `/etc/systemd/system/motorcade-platform.target`
- Prep service installed: `/etc/systemd/system/motorcade-platform-prep.service`
- Prep script installed: `/usr/local/sbin/motorcade-platform-prep.sh`

Verification:
- `systemctl is-enabled motorcade-platform.target` returns `enabled`
- `systemctl status motorcade-platform-prep.service` shows `active (exited)` after it runs
