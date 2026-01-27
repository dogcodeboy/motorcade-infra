# 03 — Runtime: Podman Static (Temporary)

## Why this exists
Some Amazon Linux 2023 AMIs/regions do not expose Podman packages via enabled AWS repositories, and enabling the expected container repositories may fail (e.g., 404 for region-bucket paths). When RPM installation and on-host compilation are blocked by missing `*-devel` packages, we use a **temporary, reversible** runtime bootstrap to unblock the platform spine.

This document defines **PLAT_01B**: a temporary Podman runtime installed from a static bundle.

## Source
We use the `mgoltzsche/podman-static` project, which publishes a tarball containing Podman and required dependencies (crun/runc, conmon, fuse-overlayfs/libfuse, netavark/aardvark-dns/pasta, catatonit). The project documents host installation and uninstallation steps. citeturn1view0

## Contract
- This is **temporary** and must be replaced once we migrate to a container-ready AMI (e.g., ECS-optimized AL2023) or a region/AMI where repo-native Podman is available.
- This does **not** modify the frozen Services hub (motorcade.vip). It is confined to `motorcade-infra` platform spine.
- Installation is under `/usr/local` plus `/etc/containers` as provided by the bundle.

## What we install
- `/usr/local/bin/podman`
- Dependency binaries (as provided in the tarball), e.g. `conmon`, `crun`, `runc`, `fuse-overlayfs`, `pasta`, `aardvark-dns`, etc.

## Rootless mode
Rootless is enabled by default in the playbook by creating a dedicated user (`mc_podman`) and setting `/etc/subuid` and `/etc/subgid` mappings. The bundle includes key rootless dependencies, but the host should also have common utilities like `uidmap`, `iptables`, and `nsenter` available.

## Storage mode
If overlay helpers are not viable on the host, the playbook supports forcing `vfs` storage driver by setting:
- `mc_force_storage_vfs: true`

## Playbook
- `ops/ansible/playbooks/plat_01b_podman_static.yml`
- Role: `ops/ansible/roles/podman_static`

## Rollback (Uninstall)
Before uninstalling, remove containers/images/volumes to free space:
- `sudo podman system reset`

Then remove installed files (per upstream guidance):
- `sudo rm -rf /etc/containers/*`
- `sudo rm -rf /usr/local/bin/{crun,fuse-overlayfs,fusermount3,pasta,pasta.avx2,podman,runc}`
- `sudo rm -rf /usr/local/{lib,libexec}/podman`
- `sudo rm -rf /usr/local/lib/systemd/{system,user}/podman*`
- `sudo rm -rf /usr/local/lib/systemd/{system,user}-generators/podman-*-generator` citeturn1view0

## Migration note
Once the platform spine is containerized and stable, migrate to a clean base (ECS-optimized AL2023 or equivalent) and remove PLAT_01B. Containers/volumes should be designed for portability (named volumes bound to a consistent filesystem path, config-in-code, secrets in vault).
