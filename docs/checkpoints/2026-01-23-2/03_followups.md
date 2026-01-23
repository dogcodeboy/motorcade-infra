# Follow-ups (after PLAT_06)

## If nginx still warns

Run on the server:

```bash
sudo nginx -T 2>/dev/null | grep -n "server_name" | grep -n "motorcade.vip"
```

If you see more than one HTTP(:80) `server {}` claiming `motorcade.vip`, capture the file paths and we can extend PLAT_06 to handle unusual layouts (e.g., vhosts defined outside `conf.d/*.conf`).

## Recommended long-term cleanup (optional)

- Remove stale/unused `conf.d` files and keep:
  - one canonical HTTP redirect file
  - one canonical SSL vhost file
- Update deprecated `http2` listen syntax when convenient (cosmetic).
