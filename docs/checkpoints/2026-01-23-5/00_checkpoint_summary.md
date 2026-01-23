# Checkpoint 2026-01-23-5 (motorcade-infra)

## Goal
Modernize Nginx HTTP/2 syntax in the SSL vhost to remove the deprecated `listen ... http2` warning.

## Result
Provides **PLAT_07A** which targets the authoritative inventory group `motorcade` and updates the SSL vhost to the modern http2 syntax.

## Why this checkpoint exists
PLAT_07 originally targeted `hosts: motorcade_web` and could skip entirely if the inventory does not define that group. This checkpoint supersedes PLAT_07 with PLAT_07A.
