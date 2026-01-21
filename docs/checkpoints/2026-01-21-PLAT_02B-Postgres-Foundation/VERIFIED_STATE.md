# VERIFIED STATE — PLAT_02B

This checkpoint prepares Postgres foundation changes in-repo.
Verification on the host occurs when the playbook is executed.

## Expected on-host results after running PLAT_02B
- Directory exists: `/srv/motorcade/volumes/postgres` (owner 999:999, mode 0700)
- Env file exists: `/etc/motorcade/postgres.env` (root:root, mode 0600)
- systemd unit exists: `/etc/systemd/system/motorcade-postgres.service`
- `systemctl is-enabled motorcade-postgres.service` => `disabled`
- Container NOT running (by design)
