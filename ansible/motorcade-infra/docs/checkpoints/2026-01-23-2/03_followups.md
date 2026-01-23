# Follow-ups

## Recommended next cleanup (optional)

If you want to fully eliminate warnings/noise:

1. `http2` directive deprecation warning  
   - Update modern Nginx configs to use `listen 443 ssl;` and `http2` as appropriate in newer syntax, or leave as-is (non-blocking).

2. Audit conf.d for drift  
   - After PLAT_06, review `/etc/nginx/backup/` and decide whether older HTTP vhosts should be deleted from the host (after confirming they’re no longer needed).

## Guardrail

Keep this rule:
- **Only one** HTTP:80 vhost for `motorcade.vip` should remain active and it should only redirect to HTTPS.
