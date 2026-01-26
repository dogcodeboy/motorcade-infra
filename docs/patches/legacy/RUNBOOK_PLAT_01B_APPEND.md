## PLAT_01B — Temporary Podman Runtime Bootstrap (Static Bundle)

**Use only if PLAT_01 cannot install Podman via AWS repos** due to region/AMI repository limitations.

- Playbook: `ops/ansible/playbooks/plat_01b_podman_static.yml`
- Doc: `docs/platform/03-runtime-podman-static-temp.md`

This installs Podman from a static bundle (temporary) and verifies both root and rootless container execution using `hello-world`.
