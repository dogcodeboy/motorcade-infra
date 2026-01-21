PLAT_02B HOTFIX — vars_files path resolution

Symptom:
- Preflight fails: vault_postgres_password is missing/too short
- But ansible-vault view group_vars/motorcade/vault.yml shows vault_postgres_password exists.

Root cause:
- vars_files used a relative path that can resolve differently depending on execution context.
Fix:
- Use "{{ playbook_dir }}/../group_vars/motorcade/vault.yml" so the vault file is always loaded.

Run:
cd ~/Repos/motorcade-infra/ansible
ansible-playbook -i inventories/prod/hosts.ini playbooks/PLAT_02B_postgres_foundation.yml --ask-vault-pass
