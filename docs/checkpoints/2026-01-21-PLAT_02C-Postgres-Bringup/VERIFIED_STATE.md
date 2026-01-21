# VERIFIED STATE (PLAT_02C)

Run on motorcade-web-01:

```bash
sudo systemctl is-active motorcade-postgres.service
sudo systemctl is-enabled motorcade-postgres.service
sudo podman ps --format '{{.Names}} {{.Status}}' | grep '^motorcade-postgres '
sudo podman exec motorcade-postgres pg_isready -U postgres
sudo ls -ld /srv/motorcade/volumes/postgres
```

Expected:
- is-active: active
- is-enabled: disabled (policy)
- pg_isready returns 0 (accepting connections)
- volume owned by 999:999, mode 0700
