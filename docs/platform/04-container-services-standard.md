# Container Services Standard (PLAT_08)

This document defines the canonical pattern for all containerized services in the Motorcade platform.

## Runtime Assumptions
- Podman is installed manually (non-dnf)
- Binary path is fixed and verified
- RPM/dnf is NOT used to detect Podman or helpers

## Service Model
- One service = one container = one systemd unit
- Containers are disposable; volumes are persistent
- systemd owns lifecycle

## Filesystem Layout
/srv/motorcade/services/<service>/
/etc/motorcade/env/<service>.env

## Networking
- motorcade-core: internal services only
- motorcade-edge: reserved (not used here)

## Verification
Each service must:
- pass preflight runtime checks
- expose internal health endpoint
- verify via systemctl + podman ps
