# Server Locations & Resources (Authoritative Reference)

Purpose: Provide a single place to record where environments live (AWS region/account), what each host is, and the key operational resources required to connect and operate.

**Update policy:** Append-only changes preferred. If something changes (IP, instance ID, size), append a dated note at the bottom and update the relevant field above.

---

## AWS Accounts / Regions

- Primary region (current): **us-east-2**
- OS baseline: **Amazon Linux 2023**
- Container runtime: **Podman (manual/static install; expected at /usr/local/bin/podman)**

---

## Production Hosts

### motorcade-web-01 (primary web/platform node)

- Inventory alias: `motorcade-web-01`
- Inventory groups: `motorcade`, `motorcade_platform` (and via `[web:children] motorcade`)
- Public IP (ansible_host): `18.117.220.60`
- SSH user: `ec2-user`
- SSH key: `~/.ssh/motorcade-key.pem`
- Python interpreter: `/usr/bin/python3`
- Known private hostname/IP (observed in logs): `ip-172-31-40-46` / `172.31.40.46`

**Services currently observed on this node (example):**
- `motorcade-postgres` (Podman container)
- `motorcade-leadgen-api` (Podman container)
- `motorcade-redis` (Podman container via systemd unit, internal-only)

---

## Inventory & Naming Conventions (to prevent recurring session errors)

- **Canonical platform group:** `motorcade_platform`
- **Do not use:** `motorcade_web` (does not exist in inventory)
- **Do not use:** `motorcade-web` (group names cannot contain hyphens)

See also: `ansible/inventories/prod/hosts.ini`

---

## Change Log (append-only)

- 2026-01-24: Created this reference doc during PLAT_08C / Redis bring-up work; recorded prod host `motorcade-web-01` from `hosts.ini` and observed system hostname/IP from logs.
