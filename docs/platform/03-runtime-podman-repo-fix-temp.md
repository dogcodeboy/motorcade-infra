# PLAT_01B — Podman Repo Fix (Temporary Unblocker)

Purpose: **unblock PLAT_01** on Amazon Linux 2023 when `dnf install podman` returns **No match for argument: podman**.

This adds a temporary `mc-container-tools` repo file and installs:

- `podman`
- `slirp4netns`
- `fuse-overlayfs`

## Why this exists

Some AL2023 environments do not expose Podman in the enabled default repos. This playbook is a **temporary** unblocker so we can proceed with the platform spine.

## Rollback

1. Remove the repo file:

- `/etc/yum.repos.d/mc-container-tools.repo`

2. `dnf clean all`

3. Optionally remove packages:

- `dnf remove podman slirp4netns fuse-overlayfs`

## Notes

- The baseurl can be overridden via `mc_container_tools_baseurl` (group_vars) if AWS changes the S3 layout.
- Once the official AL2023 path is confirmed, we will replace this with the supported repo strategy and checkpoint.
