SESSION HANDOFF — motorcade-infra (PLAT_06 ready)

Checkpoint created: `docs/checkpoints/2026-01-23-2/`

Goal: remove nginx warning:

- `conflicting server name "motorcade.vip" on 0.0.0.0:80, ignored`

by ensuring a single canonical HTTP(:80) redirect vhost exists and scrubbing/quarantining duplicate `motorcade.vip` port-80 server blocks.

What PLAT_06 does

1) Writes canonical HTTP→HTTPS redirect vhost:

- `/etc/nginx/conf.d/motorcade-redirect.conf`

2) Scans `/etc/nginx/conf.d/*.conf` (excluding the canonical redirect file) and identifies **server blocks** that:

- `listen 80;` AND
- `server_name ... motorcade.vip ...;`

3) For each file containing duplicates:

- Backs up the original to `/etc/nginx/backup/<filename>.<timestamp>`
- Removes the duplicate server block(s) from the file
- If the file becomes empty (or only comments), moves it to:
  - `/etc/nginx/backup/<filename>.<timestamp>.disabled`

4) Runs `nginx -t` and reloads nginx only when valid.

Repo files involved

- `ansible/playbooks/PLAT_06_nginx_http80_canonical_redirect.yml`
- `ansible/playbooks/README_PLAT_06.md`

Recommended commit message

PLAT_06: canonicalize HTTP:80 redirect vhost; scrub/quarantine duplicate motorcade.vip port-80 vhosts

How to run

```bash
cd ~/Repos/motorcade-infra/ansible
ansible-playbook -i inventories/prod/hosts.ini \
  playbooks/PLAT_06_nginx_http80_canonical_redirect.yml \
  --ask-vault-pass
```

Verify

```bash
sudo nginx -t
curl -I http://motorcade.vip/
```

Expected

- No more `conflicting server name ... :80` for `motorcade.vip`
- HTTP returns 301 redirect to HTTPS

```bash
cd ~/Repos/motorcade-infra/ansible
ansible-playbook \
  -i inventories/prod/hosts.ini \
  playbooks/PLAT_06_nginx_http80_canonical_redirect.yml \
  --ask-vault-pass
```

Verify

```bash
sudo nginx -t
curl -I http://motorcade.vip/
```

Expected

- `sudo nginx -t` no longer reports the `conflicting server name ... :80` warning for `motorcade.vip`
- HTTP requests to `motorcade.vip` return a 301 redirect to HTTPS
