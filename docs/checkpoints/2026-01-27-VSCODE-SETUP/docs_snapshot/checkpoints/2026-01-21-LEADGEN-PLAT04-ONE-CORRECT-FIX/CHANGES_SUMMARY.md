# Changes Summary (PLAT_04 only)

## 1) repo-root ansible.cfg
- Adds:
  - `roles_path = ansible/roles:ops/ansible/roles`
- Sets:
  - `stdout_callback = default`

## 2) ansible/playbooks/PLAT_04_lead_intake_api.yml
- Uses `podman_static` role (existing, non-standard static podman install)
- Ensures `/opt/motorcade` exists
- Clones/updates LeadGen repo into `/opt/motorcade/motorcade-leadgen`
- Builds image with a plain `podman build` from that directory
- Starts container on `127.0.0.1:8000`
- Waits for `/lead/health` 200

## Not changed
- No other playbooks
- No inventory
- No vault content modified
