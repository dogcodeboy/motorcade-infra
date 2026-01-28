Run the playbook:

ansible-playbook -i inventories/prod/hosts.ini playbooks/LEADGEN_07B_wave3_psycopg_driver_fix_and_persistence_verify.yml --ask-vault-pass
