# PLAT_06 — Canonical HTTP:80 redirect vhost (motorcade.vip) + scrub/quarantine duplicate port-80 vhosts

## Purpose

After PLAT_05 stabilized the HTTPS-only `/api/lead/*` proxy path, nginx may still emit a **non-blocking** warning like:

- `conflicting server name "motorcade.vip" on 0.0.0.0:80, ignored`

That warning means **multiple** HTTP(:80) vhosts are claiming `server_name motorcade.vip`.

**PLAT_06** makes the HTTP layer deterministic and long-term stable by:

1. Creating **one canonical** HTTP:80 vhost whose only job is to redirect to HTTPS.
2. Removing (scrubbing) duplicate `motorcade.vip` **HTTP(:80)** `server {}` blocks found in `/etc/nginx/conf.d/*.conf`.
3. Quarantining a file entirely if it becomes empty after scrub (moved into `/etc/nginx/backup/` with a timestamp + `.disabled`).
4. Running `nginx -t` and reloading **only when** the config validates.

## What this playbook changes

### Canonical redirect vhost

Writes:

- `/etc/nginx/conf.d/motorcade-redirect.conf`

With a single server block:

- `listen 80;`
- `server_name motorcade.vip www.motorcade.vip;`
- `return 301 https://$host$request_uri;`

### Duplicate detection / cleanup

Scans every `/etc/nginx/conf.d/*.conf` (except the canonical redirect file) and locates top-level `server { ... }` blocks that contain:

- `listen 80;`
- a `server_name` line that includes either `motorcade.vip` or `www.motorcade.vip`

For each file containing duplicates:

- Creates a timestamped backup copy in `/etc/nginx/backup/<filename>.<timestamp>`
- Removes only the matching duplicate `server {}` blocks
- If the remainder is only whitespace/comments, the file is quarantined to:
  - `/etc/nginx/backup/<filename>.<timestamp>.disabled`

## Safety and rollback

- Every touched file is backed up into `/etc/nginx/backup/` before changes.
- `nginx -t` is executed.
- Reload occurs only if validation succeeds.

To rollback:

1. Restore a timestamped backup file from `/etc/nginx/backup/` back into `/etc/nginx/conf.d/`
2. Run `sudo nginx -t`
3. `sudo systemctl reload nginx`

## How to run

From the **motorcade-infra** repo on your workstation:

```bash
cd ~/Repos/motorcade-infra/ansible
ansible-playbook -i inventories/prod/hosts.ini \
  playbooks/PLAT_06_nginx_http80_canonical_redirect.yml \
  --ask-vault-pass
```

## Verify

On the server:

```bash
sudo nginx -t
curl -I http://motorcade.vip/
```

Expected:

- `sudo nginx -t` has no `conflicting server name ... :80` warning for `motorcade.vip`
- `curl -I http://motorcade.vip/` returns a 301 redirect to HTTPS

## Notes

- This playbook intentionally does **not** modify HTTPS (`listen 443 ssl`) vhosts.
- It targets only duplicates involving `motorcade.vip` on port 80.
