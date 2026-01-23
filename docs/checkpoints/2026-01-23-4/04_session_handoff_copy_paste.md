SESSION HANDOFF — motorcade-infra (PLAT_07 ready)

Checkpoint created: docs/checkpoints/2026-01-23-4/
Goal: remove non-blocking Nginx warning about deprecated `listen ... http2` syntax by switching SSL vhost to modern syntax.

Playbook:
- ansible/playbooks/PLAT_07_nginx_http2_directive_modernize.yml

What it does:
- Backs up /etc/nginx/conf.d/motorcade-ssl.conf (timestamped to /etc/nginx/backup/)
- Replaces `listen 443 ssl http2;` with `listen 443 ssl;`
- Ensures `http2 on;` exists right after the listen line (marked block)
- Runs nginx -t and reloads only if valid

Verification:
- sudo nginx -t should no longer show the http2 deprecation warning.
