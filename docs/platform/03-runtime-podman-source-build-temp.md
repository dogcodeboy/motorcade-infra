# PLAT_01B — Podman Source-Build Temporary (AL2023 Unblocker)

This is a **temporary** path when `dnf install podman` is unavailable on the target host.

## What it does
- Builds **conmon** and **podman** from source (pinned tags) into `/usr/local`
- Writes a minimal `/etc/containers/storage.conf` using **vfs** storage driver for maximum compatibility
- Optionally installs **runc** from upstream GitHub releases if not present

## Why (temporary)
Your current AL2023 host cannot locate the `podman` package in enabled repos. This unblocks PLAT workstreams
without touching any frozen website areas.

## Run command (from repo root)
```bash
ANSIBLE_ROLES_PATH=ops/ansible/roles \
ansible-playbook \
  -i ansible/inventories/prod/hosts.ini \
  ops/ansible/playbooks/plat_01b_podman_source_build.yml
```

## Rollback
- Remove `/usr/local/bin/podman` and related installed files, or replace with the official repo-based install later.
- Revert `/etc/containers/storage.conf` if needed.

