# README — PLAT_06A (Nginx HTTP:80 Canonical Redirect + Duplicate Vhost Scrubber)

## Purpose
Remove the Nginx warning:

`conflicting server name "motorcade.vip" on 0.0.0.0:80, ignored`

by ensuring there is **exactly one** canonical HTTP:80 vhost for `motorcade.vip` that redirects to HTTPS, and by scrubbing/quarantining any duplicate HTTP:80 server blocks in `/etc/nginx/conf.d/*.conf`.

## Why PLAT_06A exists
PLAT_06 (original draft) used a heredoc inside a `shell:` task, which can trigger Ansible's argument-splitting parser.  
PLAT_06A replaces that with a **temp Python script** written via `copy:` and executed via `command:` (more reliable long-term).

## What it does
1. Writes canonical HTTP redirect vhost:
   - `/etc/nginx/conf.d/motorcade-redirect.conf`
2. Writes a scrubber script:
   - `/tmp/plat06a_scrub_http80_duplicates.py`
3. Scrubs or quarantines duplicates in:
   - `/etc/nginx/conf.d/*.conf`
   - Backups/quarantines are placed in `/etc/nginx/backup/` with a timestamp
4. Runs `nginx -t` and reloads nginx only if valid.

## Run
```bash
cd ~/Repos/motorcade-infra/ansible
ansible-playbook -i inventories/prod/hosts.ini playbooks/PLAT_06A_nginx_http80_canonical_redirect.yml --ask-vault-pass
```

## Verify
On server:
```bash
sudo nginx -t
curl -I http://motorcade.vip/
```
Expected: HTTP returns 301/302 to HTTPS and the prior "conflicting server name" warning disappears.
