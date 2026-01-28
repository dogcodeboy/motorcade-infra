# Checkpoint — 2026-01-28 — LEADGEN_07B — Persistence query fallback

Purpose: Fix false-negative persistence verification when API response includes `request_id` but DB row does not store it.

Change: persistence poll now checks **request_id OR email** and captures diagnostic counts for both.
