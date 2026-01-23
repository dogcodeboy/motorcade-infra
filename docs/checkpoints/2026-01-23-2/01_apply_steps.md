# Apply steps (PLAT_06)

## 1) Merge files into repo

Unzip the provided merge ZIP **into the repo root**:

```bash
cd ~/Repos/motorcade-infra
unzip -o /path/to/motorcade-infra_PLAT_06_MERGE_2026-01-23-2.zip
```

Verify the playbook exists:

```bash
ls -la ansible/playbooks/PLAT_06_nginx_http80_canonical_redirect.yml
```

## 2) Commit

Recommended commit message:

> PLAT_06: canonicalize HTTP:80 redirect vhost; scrub/quarantine duplicate motorcade.vip port-80 vhosts

## 3) Run

```bash
cd ~/Repos/motorcade-infra/ansible
ansible-playbook -i inventories/prod/hosts.ini \
  playbooks/PLAT_06_nginx_http80_canonical_redirect.yml \
  --ask-vault-pass
```

## 4) Verify

On the server:

```bash
sudo nginx -t
curl -I http://motorcade.vip/
```

Expected:

- No `conflicting server name ... :80` warning for `motorcade.vip`
- `curl -I http://motorcade.vip/` returns `301` to `https://motorcade.vip/...`
