# Apply Steps (PLAT_07A)

From your **local** repo:

```bash
cd ~/Repos/motorcade-infra
# unzip the merge ZIP into this repo root (if not already)
```

Run the playbook:

```bash
cd ~/Repos/motorcade-infra/ansible
ansible-playbook -i inventories/prod/hosts.ini \
  playbooks/PLAT_07A_nginx_http2_directive_modernize.yml \
  --ask-vault-pass
```

Verify:

```bash
sudo nginx -t
```

Expected:
- No `listen ... http2` deprecation warning
- `syntax is ok` and `test is successful`
