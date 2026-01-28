# VERIFY — LEADGEN_07B — BuildContext-Fix

Run:
```bash
cd ~/Repos/motorcade-infra/ansible
ansible-playbook -i inventories/prod/hosts.ini   playbooks/LEADGEN_07B_wave3_psycopg_driver_fix_and_persistence_verify.yml   --ask-vault-pass
```

Expected:
- Build step uses `chdir` equal to the directory containing the Containerfile (e.g. `/opt/motorcade-leadgen/app/api`).
- Podman build no longer errors on `COPY requirements.txt ... no such file or directory`.
