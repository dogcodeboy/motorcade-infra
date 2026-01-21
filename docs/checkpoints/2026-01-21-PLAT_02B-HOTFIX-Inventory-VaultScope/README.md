PLAT_02B FIX-PACKAGE (Inventory + Vault Scope)

What this fixes:
1) Removes the corrupted '...' entry in ansible/inventories/prod/hosts.ini and ensures the host is in the 'motorcade' group.
2) Updates PLAT_02B playbook to explicitly load group_vars/motorcade/vault.yml via vars_files so vault_postgres_password is always visible.

How to apply:
- Unzip into ~/Repos/motorcade-infra (overlay)
- Re-run:
  cd ~/Repos/motorcade-infra/ansible
  ansible-playbook -i inventories/prod/hosts.ini playbooks/PLAT_02B_postgres_foundation.yml --ask-vault-pass
