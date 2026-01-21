# Commands run (representative)

From repo root:
```bash
cd ~/Repos/motorcade-infra
ansible-playbook -i ansible/inventories/prod/hosts.ini ansible/playbooks/PLAT_04_lead_intake_api.yml --ask-vault-pass
```

If you see:
`Invalid callback for stdout specified: yaml`
Run:
```bash
unset ANSIBLE_STDOUT_CALLBACK
```
and re-run the playbook.
