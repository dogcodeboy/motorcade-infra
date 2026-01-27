# Apply Steps (local)

1. Unzip into repo root:
   ```bash
   cd ~/Repos/motorcade-infra
   unzip -o ~/Downloads/motorcade-infra_PLAT_06A_FIX_MERGE_2026-01-23-3.zip
   ```

2. Confirm file exists:
   ```bash
   ls -la ansible/playbooks/PLAT_06A_nginx_http80_canonical_redirect.yml
   ```

3. Run:
   ```bash
   cd ~/Repos/motorcade-infra/ansible
   ansible-playbook -i inventories/prod/hosts.ini playbooks/PLAT_06A_nginx_http80_canonical_redirect.yml --ask-vault-pass
   ```
