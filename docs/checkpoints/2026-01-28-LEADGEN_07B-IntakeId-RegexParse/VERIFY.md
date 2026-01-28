## Verify
1) Apply zip to repo root:
   - `unzip -o <zip> -d ~/Repos`

2) Confirm parsed-id section exists:
   - `grep -n "Parse | intake ids" -n ansible/playbooks/LEADGEN_07B_wave3_psycopg_driver_fix_and_persistence_verify.yml`

3) Run playbook:
   - `ansible-playbook -i inventories/prod/hosts.ini playbooks/LEADGEN_07B_wave3_psycopg_driver_fix_and_persistence_verify.yml --ask-vault-pass`

Expected:
- Output includes `parsed_request_id=req_...` when the intake response contains a request_id.
- Persistence poll still may fail (0|0) if the application is not persisting; in that case use printed diagnostics.
