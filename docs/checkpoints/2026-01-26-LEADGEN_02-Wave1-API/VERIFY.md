# Verification commands (server)

```bash
# Services
sudo systemctl status motorcade-leadgen-api --no-pager
sudo systemctl status motorcade-postgres --no-pager
sudo systemctl status motorcade-redis --no-pager

# Containers (Podman is installed at /usr/local/bin/podman)
sudo /usr/local/bin/podman ps -a --format 'table {{.Names}}\t{{.Status}}\t{{.Image}}'

# LeadGen API health (host bind)
sudo ss -lntp | egrep '(:8000)' || true
sudo curl -sS http://127.0.0.1:8000/lead/health | jq

# Public health via Nginx
sudo curl -sS https://motorcade.vip/api/lead/health | jq

# DB schema
sudo /usr/local/bin/podman exec motorcade-postgres psql -U postgres -v ON_ERROR_STOP=1 -c "\dt app.*"
sudo /usr/local/bin/podman exec motorcade-postgres psql -U postgres -v ON_ERROR_STOP=1 -c "select * from app.schema_migrations order by applied_at desc;"
```
