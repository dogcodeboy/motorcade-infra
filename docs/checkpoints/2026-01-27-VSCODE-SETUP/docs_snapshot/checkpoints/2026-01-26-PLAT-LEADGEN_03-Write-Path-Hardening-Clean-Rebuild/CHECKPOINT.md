# ✅ CHECKPOINT PACKAGE — LEADGEN_03 (Wave 1)
## Checkpoint ID
**2026-01-26 — PLAT / LEADGEN_03 — Write-Path Hardening (Clean Rebuild)**

## What This Checkpoint Represents (Authoritative)
This checkpoint captures the successful, validated rebuild of the LeadGen Wave 1 write-path hardening playbook after resolving config drift, vault resolution failures, and YAML corruption.

This is the first clean, production-safe version of **LEADGEN_03_wave1_write_path_hardening.yml**.

---

## ✅ VERIFIED STATE (DO NOT REWORK)

### 1. Ansible Configuration
- ❌ Duplicate / stray `ansible.cfg` removed
- ✅ Single authoritative config resolved at:
  - `~/Repos/motorcade-infra/ansible/ansible.cfg`

Verified via:
```bash
ansible --version | sed -n '1,6p'
ansible-config dump --only-changed
```

### 2. Inventory & Group Resolution
Inventory file:
- `inventories/prod/hosts.ini`

Verified group membership for `motorcade-web-01`:
- `motorcade`
- `motorcade_platform`
- `web`

Verified using:
```bash
ansible -i inventories/prod/hosts.ini motorcade \
  -m debug -a "var=group_names" --vault-id @prompt
```

### 3. Vault Resolution (CRITICAL)
Vault file location (correct and authoritative):
- `ansible/group_vars/motorcade/vault.yml`

Vault decrypted successfully using:
- `--vault-id @prompt`

Required vault keys present, defined, and non-empty:
- `vault_leadgen_intake_api_key`
- `vault_leadgen_admin_api_key`
- `vault_postgres_password`

⚠️ Any future failure here indicates vault content, not config.

### 4. Playbook: LEADGEN_03 (Clean Rebuild)
File:
- `playbooks/LEADGEN_03_wave1_write_path_hardening.yml`

Status:
- Fully rebuilt from scratch
- No editor artifacts
- Single YAML document
- Deterministic execution order
- Idempotent

Execution Result:
```
PLAY RECAP
motorcade-web-01 : ok=11 changed=0 failed=0
```

### 5. Enforced Filesystem State (Verified)
Created & hardened paths:
- `/opt/motorcade`                 `0750 root:root`
- `/opt/motorcade/leadgen`         `0750 root:root`
- `/opt/motorcade/leadgen/config`  `0750 root:root`
- `/opt/motorcade/leadgen/data`    `0750 root:root`
- `/opt/motorcade/leadgen/logs`    `0750 root:root`
- `/opt/motorcade/leadgen/tmp`     `1770 root:root` *(sticky bit)*

World-write removed everywhere except `tmp` (by design).

Permissions confirmed by playbook report task.

### 6. Git State (Locked In)
Commit:
- `PLAT: LEADGEN_03 write-path hardening (clean rebuild, fixed vault + config)`

Changes:
- ✅ `playbooks/LEADGEN_03_wave1_write_path_hardening.yml` (rebuilt)
- ❌ Removed stray `ansible.cfg` that caused inventory + vault drift

Branch is clean and synced with `origin/main`.

---

## 🔒 Recommendation (Not Action Yet)
At a later point, consider adding a preflight guard that fails if multiple `ansible.cfg` files are detected up the directory tree. Not required now — just noted.
