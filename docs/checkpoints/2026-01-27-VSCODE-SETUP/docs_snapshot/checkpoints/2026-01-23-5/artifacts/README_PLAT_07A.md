# PLAT_07A — Modernize Nginx HTTP/2 Syntax (SSL vhost)

## Purpose

Remove the non-blocking Nginx warning:

- `the "listen ... http2" directive is deprecated`

by modernizing the SSL vhost syntax in `/etc/nginx/conf.d/motorcade-ssl.conf`.

This playbook **supersedes PLAT_07**. The earlier PLAT_07 targeted `hosts: motorcade_web`, but the authoritative inventory in this repo uses the `motorcade` group.

## What Changes

1. Creates a timestamped backup of `motorcade-ssl.conf` in `/etc/nginx/backup/`.
2. Replaces:

   - `listen 443 ssl http2;`

   with:

   - `listen 443 ssl;`

3. Ensures `http2 on;` is present (inserted after the `listen 443 ssl;` line).
4. Runs `nginx -t` and reloads only if the config is valid.

## Safety Guarantees

- No reload occurs unless `nginx -t` succeeds.
- Original SSL conf is backed up before any edits.

## How to Run

```bash
cd ~/Repos/motorcade-infra/ansible
ansible-playbook -i inventories/prod/hosts.ini \
  playbooks/PLAT_07A_nginx_http2_directive_modernize.yml \
  --ask-vault-pass
```

## Verify

```bash
sudo nginx -t
```

Expected:
- No `listen ... http2` deprecation warning.
- `syntax is ok` and `test is successful`.
