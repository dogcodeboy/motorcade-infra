# VERIFIED STATE (what to check after running PLAT_03)

```bash
# service is active but still boot-disabled
systemctl is-active motorcade-postgres.service
systemctl is-enabled motorcade-postgres.service

# container running
podman ps --format '{{.Names}}' | grep -x motorcade-postgres

# postgres healthy
podman exec motorcade-postgres pg_isready -U postgres

# roles exist
podman exec -i motorcade-postgres psql -U postgres -d postgres -tAc "\
  SELECT rolname FROM pg_roles WHERE rolname IN ('motorcade_owner','motorcade_app','motorcade_ro','motorcade_migrator') ORDER BY 1;\
"

# database + schema exist
podman exec -i motorcade-postgres psql -U postgres -d postgres -tAc "SELECT datname FROM pg_database WHERE datname='motorcade';"
podman exec -i motorcade-postgres psql -U postgres -d motorcade -tAc "SELECT schema_name FROM information_schema.schemata WHERE schema_name='app';"

# backup files exist
ls -la /srv/motorcade/backups/postgres/
```
