# Apply Steps — PLAT_06

1. **Merge** the files from this checkpoint into your `motorcade-infra` repo (preserve repo structure).

2. Run the playbook from `motorcade-infra/ansible`:

```bash
ansible-playbook -i inventories/prod/hosts.ini \
  playbooks/PLAT_06_nginx_http80_canonical_redirect.yml \
  --ask-vault-pass
```

3. If `nginx -t` fails, the playbook will stop before reload. Review the error output and fix upstream config conflicts, then re-run PLAT_06.
