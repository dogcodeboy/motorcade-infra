# RUNBOOK Append — PLAT_02A

The top-level RUNBOOK currently lists `PLAT_02_postgres_phase1.yml` as the next platform step after the runtime.

PLAT_02A is a **foundational sub-step** that must run immediately before the Postgres phase so that:
- networks are defined deterministically
- volume/bind mount layout is standardized
- a rootful systemd target exists to group future platform units

Recommended order:
1. PLAT_01 runtime (COMPLETED via PLAT_01B)
2. PLAT_02A networks/volumes/systemd foundations (this checkpoint)
3. PLAT_02B Postgres phase 1 container

When PLAT_02B is added, it should follow the established naming scheme and reference:
- network: `motorcade-core`
- volume root: `/srv/motorcade/volumes/postgres`
