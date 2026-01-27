# Files (merge list)

This checkpoint is documentation + packaging only. It does **not** introduce new logic beyond what is already committed on `origin/main`.

Authoritative items referenced by this checkpoint:

- `ansible/ansible.cfg` (single authoritative config; duplicates removed elsewhere)
- `ansible/inventories/prod/hosts.ini` (inventory + group membership validated)
- `ansible/group_vars/motorcade/vault.yml` (authoritative vault; decrypted via `--vault-id @prompt`)
- `ansible/playbooks/LEADGEN_03_wave1_write_path_hardening.yml` (clean rebuild, idempotent)
- `docs/checkpoints/{this folder}/*` (checkpoint docs)
