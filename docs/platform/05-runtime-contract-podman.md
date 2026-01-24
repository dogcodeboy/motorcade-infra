# Runtime Contract — Podman (Externally Managed)

Podman is treated as a platform runtime artifact.

## Detection
- /usr/local/bin/podman
- podman --version
- podman info

## Explicitly Not Used
- dnf
- rpm
- ansible package module

## Helpers
Helpers are detected, not installed:
- conmon
- crun (or equivalent)
- netavark / aardvark-dns
- iptables (path check only)

Missing dependencies cause playbooks to fail early with instructions.
