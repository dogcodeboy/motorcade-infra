# Follow-ups (post-PLAT_05)

These are **not required** for PLAT_05 to work, but are worth cleaning for long-term health.

## 1) Fix the duplicate HTTP :80 vhost warning
You saw:
- `conflicting server name "motorcade.vip" on 0.0.0.0:80, ignored`

This indicates there are *two* `server { listen 80; server_name motorcade.vip ... }` definitions loaded.

From your server output, one is in:
- `/etc/nginx/conf.d/motorcade.conf` (lines ~4–6)
- and another is the HTTP redirect block in `/etc/nginx/conf.d/motorcade-ssl.conf` (lines ~59–81)

### Recommended long-term decision
Keep **one** canonical HTTP→HTTPS redirect.
- Preferred: keep the redirect in `motorcade-ssl.conf` and remove/disable the duplicate in `motorcade.conf` (or vice versa).

We should handle this in the **next playbook** (do not hand-edit), since it impacts the broader site vhost layout.

## 2) Address http2 deprecation warning
You saw:
- `the "listen ... http2" directive is deprecated, use the "http2" directive instead`

This is cosmetic. We can update later in a dedicated Nginx hygiene playbook so we don’t mix concerns.
