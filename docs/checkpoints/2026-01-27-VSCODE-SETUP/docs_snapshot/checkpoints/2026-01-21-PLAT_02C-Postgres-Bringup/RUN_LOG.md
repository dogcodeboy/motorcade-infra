# RUN LOG (PLAT_02C)

Command (from ~/Repos/motorcade-infra/ansible):

```bash
ansible-playbook -i inventories/prod/hosts.ini playbooks/PLAT_02C_postgres_bringup.yml --ask-vault-pass
```

Notes:
- This playbook updates the systemd unit to a bring-up variant and starts the service.
- The container is removed on stop (data persists in /srv/motorcade/volumes/postgres).
