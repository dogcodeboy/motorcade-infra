## Apply (local)

```bash
cd ~/Repos/motorcade-infra
unzip -o ~/Downloads/motorcade-infra_PLAT_07_MERGE_2026-01-23-4.zip
```

## Run

```bash
cd ~/Repos/motorcade-infra/ansible
ansible-playbook -i inventories/prod/hosts.ini \
  playbooks/PLAT_07_nginx_http2_directive_modernize.yml \
  --ask-vault-pass
```

## Verify

```bash
sudo nginx -t
```
