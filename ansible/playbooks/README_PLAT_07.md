# PLAT_07 — Modernize Nginx `http2` Directive (SSL Vhost)

## Goal
Remove the non-blocking warning from `nginx -t`:

- `the "listen ... http2" directive is deprecated`

…by switching the SSL vhost to the modern syntax:
- Replace: `listen 443 ssl http2;`
- With: `listen 443 ssl;` plus `http2 on;`

## What this playbook changes
Target file:
- `/etc/nginx/conf.d/motorcade-ssl.conf`

Actions:
1. Create `/etc/nginx/backup/` if missing
2. Backup `motorcade-ssl.conf` (timestamped)
3. Replace deprecated `listen 443 ssl http2;` line with `listen 443 ssl;`
4. Ensure `http2 on;` exists immediately after the listen line (marked block)
5. Run `nginx -t`
6. Reload nginx **only if** config is valid

## Run
From the `motorcade-infra` repo:

```bash
cd ~/Repos/motorcade-infra/ansible
ansible-playbook -i inventories/prod/hosts.ini \
  playbooks/PLAT_07_nginx_http2_directive_modernize.yml \
  --ask-vault-pass
```

## Verify
On the server:

```bash
sudo nginx -t
```

Expected:
- No more `listen ... http2` deprecation warning
- Config test successful

## Rollback
Restore the last backup:

```bash
ls -1t /etc/nginx/backup/motorcade-ssl.conf.* | head
sudo cp /etc/nginx/backup/motorcade-ssl.conf.<TIMESTAMP> /etc/nginx/conf.d/motorcade-ssl.conf
sudo nginx -t && sudo systemctl reload nginx
```
