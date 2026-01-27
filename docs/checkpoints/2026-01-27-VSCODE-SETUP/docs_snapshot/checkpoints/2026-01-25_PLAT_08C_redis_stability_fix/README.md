# PLAT_08C — Redis Bring-Up (Stability Fix) — Checkpoint

This checkpoint replaces the prior PLAT_08C readiness-gate approach with a stable **one-shot**
Redis bring-up compatible with the current static Podman install.

Outcomes:
- Redis unit no longer relies on journald logging
- Legacy readiness-gate service is masked to prevent hangs
- Verification is bounded (fail-fast): `redis-cli ping` with retries

Use this checkpoint together with the append-only RUNBOOK entry titled:
"APPEND — 2026-01-25 — PLAT_08C Redis Bring-Up (FIX APPLIED)".
