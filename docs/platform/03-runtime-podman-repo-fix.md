# PLAT_01B — Podman Repo Fix (Temporary Unblocker)

## Why this exists
On some **Amazon Linux 2023** builds, the default enabled repos may not include `podman` (and related packages), and older guidance for AL2 (amazon-linux-extras / container-tools config-manager) does not apply.

This playbook adds a **dedicated `mc-container-tools` yum repo** (AWS-hosted S3) and installs:
- `podman`
- `podman-docker`
- `slirp4netns`
- `fuse-overlayfs`

## What it changes
- Writes one file: `/etc/yum.repos.d/mc-container-tools.repo`
- Runs `dnf makecache`
- Installs the packages above

## How to run
From repo root:

```bash
ANSIBLE_ROLES_PATH=ops/ansible/roles \
ansible-playbook \
  -i ansible/inventories/prod/hosts.ini \
  ops/ansible/playbooks/plat_01b_podman_repo_fix.yml
```

## Override knobs
If AWS changes the repo layout, override the baseurl in `group_vars/prod/main.yml`:

```yaml
mc_container_tools_baseurl: "https://<your-correct-baseurl>/$basearch/"
```

You can also set:

```yaml
mc_podman_repo_debug: true
```

to print repo file + repolist output during the run.

## Rollback
To remove this temporary unblocker:

```bash
sudo rm -f /etc/yum.repos.d/mc-container-tools.repo
sudo dnf clean all
```

Then proceed with the "final" Podman runtime plan once we have the canonical AL2023 repo source validated.
