# PLAT_03 — Postgres Schema + Roles

This checkpoint establishes the canonical Postgres database, schema namespace,
and role model for the Motorcade platform.

- Runtime: Rootful Podman
- OS: Amazon Linux 2023
- Service model: systemd-first (boot-disabled)
- Canonical root: /srv/motorcade

Roles:
- motorcade_owner (NOLOGIN)
- motorcade_app (LOGIN)
- motorcade_ro (LOGIN)
- motorcade_migrator (LOGIN)

Database:
- {"motorcade"}
Schema:
- {"app"}

Out of scope:
- No tables
- No application wiring
- No auto-start enablement

---

## 2026-01-21 — Execution Fix Addendum

- Replaced any community.postgresql module usage with `podman exec psql`
- Removes all external Ansible collection and Python DB dependencies
- Preserves idempotency and PLAT_02C locked decisions
- Safe to re-run

Run:
ansible-playbook -i inventories/prod/hosts.ini ansible/playbooks/PLAT_03_postgres_schema_roles.yml --ask-vault-pass
