## Verify

Run:
cd ~/Repos/motorcade-infra/ansible
ansible-playbook -i inventories/prod/hosts.ini \
  playbooks/LEADGEN_07B_wave3_psycopg_driver_fix_and_persistence_verify.yml \
  --ask-vault-pass

Expected:
- Playbook parses and proceeds past the build step without "failed at splitting arguments" errors.
