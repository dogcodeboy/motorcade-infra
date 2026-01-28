## Run
cd ~/Repos/motorcade-infra/ansible
ansible-playbook -i inventories/prod/hosts.ini \
  playbooks/LEADGEN_07B_wave3_psycopg_driver_fix_and_persistence_verify.yml \
  --ask-vault-pass

## Pass criteria
- /lead/health returns 200
- /lead/intake returns 200/201/202/409
- A row is observed in app.leads within the poll window (by request_id preferred)

## If it fails
The playbook prints:
- latest app.leads rows
- systemd status for motorcade-leadgen-api.service
- journal tail for the service
- podman ps -a
