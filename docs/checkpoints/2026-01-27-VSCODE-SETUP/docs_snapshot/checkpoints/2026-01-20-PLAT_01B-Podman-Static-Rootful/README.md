# ✅ Checkpoint — 2026-01-20-PLAT_01B-Podman-Static-Rootful

This checkpoint captures the **authoritative, verified platform state** after completing **PLAT_01 (via PLAT_01B)** on Amazon Linux 2023 where repo-native Podman installation paths were unavailable.

## What was completed
- Podman runtime installed via **static bundle** (host-level install under `/usr/local`)
- Execution mode: **rootful**
- Rootless was attempted earlier and is now **explicitly disabled** for stability on AL2023
- Smoke test: `podman run --rm hello-world` ✅

## Frozen / not in scope
- motorcade.vip Services Hub is **frozen** (no Services changes allowed)
- Executive Protection page design deferred
- Scheduling / Lead capture not started

## Why PLAT_01B exists
AL2023 on this host/region did not provide Podman through expected AWS repos and attempts to use external repos or on-host source compilation were blocked. PLAT_01B is a **temporary unblocker** to proceed with the platform spine.

## Next step
Proceed with **PLAT_02 — Networking + Volumes foundations** (Podman rootful).
