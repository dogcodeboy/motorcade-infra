# What Changed

- Added playbook: `ansible/playbooks/PLAT_07A_nginx_http2_directive_modernize.yml`
- Added doc: `ansible/playbooks/README_PLAT_07A.md`
- Updated index: `ansible/playbooks/README.md` (documents PLAT_07A supersedes PLAT_07)

Server-side behavior (when playbook runs):
- Backup `/etc/nginx/conf.d/motorcade-ssl.conf` to `/etc/nginx/backup/` (timestamped)
- Replace `listen 443 ssl http2;` → `listen 443 ssl;`
- Ensure `http2 on;` is present
- Run `nginx -t`; reload only if valid
