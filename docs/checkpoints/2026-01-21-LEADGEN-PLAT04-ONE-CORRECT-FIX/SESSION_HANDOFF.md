# SESSION HANDOFF — LeadGen PLAT_04

Host: `motorcade-web-01`

You are **not** crazy — we hit multiple independent issues. We are now down to **one remaining, real blocker**.

## What is fixed (now stable)
1. **Role discovery**
   - `podman_static` exists in this repo under `ops/ansible/roles/podman_static`
   - Root `ansible.cfg` now includes:
     - `roles_path = ansible/roles:ops/ansible/roles`

2. **stdout callback breakage**
   - Root `ansible.cfg` sets `stdout_callback = default`
   - If you still see `Invalid callback for stdout specified: yaml`, it is coming from your **shell environment**.
   - Fix (local machine, before running ansible):
     - `unset ANSIBLE_STDOUT_CALLBACK`
     - `env | grep -i ANSIBLE_STDOUT`

3. **Podman install method**
   - We **do NOT** install podman via `dnf`.
   - We rely on your repo's existing **static podman** role (`podman_static`).

4. **Module drift**
   - We do not rely on `containers.podman.podman_image` args.
   - We build using a plain shell command: `podman build ...`

## Current blocker (what is still failing)
The playbook is reaching the build step, but `podman build` fails with one of:
- No Dockerfile/Containerfile found in the build context
- Build context directory missing (repo not present where expected)

Example failure:
- `no Containerfile or Dockerfile specified or found in context directory`
- or missing `/opt/motorcade/motorcade-leadgen`

## Next steps (do these in order)
### 1) Verify where the LeadGen repo is on EC2
SSH to the server and check:
- `sudo ls -la /opt/motorcade`
- `sudo ls -la /opt/motorcade/motorcade-leadgen`

### 2) Verify Dockerfile location
- `sudo find /opt/motorcade/motorcade-leadgen -maxdepth 4 \( -iname Dockerfile -o -iname Containerfile \)`

Outcomes:
- If Dockerfile exists but is **not at repo root**, PLAT_04 must `cd` into the correct subdirectory before building.
- If Dockerfile does **not** exist anywhere, the LeadGen repo needs one added (LeadGen repo task, not infra).

### 3) Re-run PLAT_04 (canonical)
From repo root:
```bash
cd ~/Repos/motorcade-infra
unset ANSIBLE_STDOUT_CALLBACK
ansible-playbook -i ansible/inventories/prod/hosts.ini ansible/playbooks/PLAT_04_lead_intake_api.yml --ask-vault-pass
```

## What to paste into the next session if it fails again
Paste **only the failing task block** and the output of:
- `sudo ls -la /opt/motorcade/motorcade-leadgen`
- `sudo find /opt/motorcade/motorcade-leadgen -maxdepth 4 \( -iname Dockerfile -o -iname Containerfile \)`
