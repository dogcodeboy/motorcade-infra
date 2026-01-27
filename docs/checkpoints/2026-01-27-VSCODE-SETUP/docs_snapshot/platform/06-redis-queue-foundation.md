# Redis / Queue Foundation (PLAT_08B)

Canonical internal Redis service for Motorcade platform services.

## Identity
- Container: `motorcade-redis`
- systemd unit: `motorcade-redis.service`

## Networking
- Podman network: `motorcade-core`
- No host port mapping (internal-only)

## Persistence
- Host volume: `/srv/motorcade/volumes/redis`
- Container path: `/data`
- AOF enabled: `appendonly yes`
- Snapshot rule: `save 60 1000`

## Runtime
- Podman is externally managed (manual install; not tracked by dnf/rpm)
- Binary path assumed: `/usr/local/bin/podman`

## Playbook behavior
- Installs unit + pulls image
- Default posture: disabled + stopped
- Optional start: `-e redis_start_now=true`
