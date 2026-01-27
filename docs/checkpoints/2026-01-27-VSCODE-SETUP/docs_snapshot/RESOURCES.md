# Resources (Authoritative Quick References)

This file is a living reference of *operational resources* (paths, service names, log commands).
Update when new stable resources are introduced.

## Host naming (important)

- Use the inventory host: `motorcade-web-01`
- Do **not** use: `motorcade_web` (invalid / never existed)

## Redis healthcheck (PLAT_08D)

### Systemd units
- Timer: `motorcade-redis-healthcheck.timer`
- Service: `motorcade-redis-healthcheck.service` (oneshot)

### Logs
```bash
sudo journalctl -u motorcade-redis-healthcheck.service -n 50 --no-pager
sudo systemctl status motorcade-redis-healthcheck.timer --no-pager -l
```

### Script path
- `/usr/local/sbin/motorcade-redis-healthcheck.sh`

## Podman (locked-path install)

This environment uses Podman installed via non-standard method (do not assume dnf/rpm paths).

- Expected binary path: `/usr/local/bin/podman`

---

## LeadGen API (Wave 1)

**systemd**
- `motorcade-leadgen-api.service`

**Container**
- Name: `motorcade-leadgen-api`
- Image: `localhost/motorcade-leadgen-api:wave1`
- Network: `motorcade-core`
- Port mapping: `127.0.0.1:8000 -> 8080/tcp`

**Config**
- `/etc/motorcade/leadgen.env` (root-only)

**Health**
- Host: `http://127.0.0.1:8000/lead/health`
- Public: `https://motorcade.vip/api/lead/health` (via Nginx include: `motorcade-leadgen-api.conf`)
