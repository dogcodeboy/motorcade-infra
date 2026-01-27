# 2026-01-21 — PLAT_04 Fix

This patch updates only:

- `motorcade-infra/ansible/playbooks/PLAT_04_lead_intake_api.yml`

Changes:

1. Loads the existing encrypted vault explicitly from `ansible/group_vars/motorcade/vault.yml` using a playbook-relative path.
2. Builds the LeadGen image using `podman build` via `ansible.builtin.command` for maximum compatibility.
