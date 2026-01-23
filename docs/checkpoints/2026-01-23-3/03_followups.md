# Follow-ups

After PLAT_06A succeeds, re-check:
- `sudo nginx -t` warning output (should be clean of duplicate port 80 server_name conflicts)
- If any warning remains, identify the remaining conf file with:
  ```bash
  sudo nginx -T 2>/dev/null | grep -n "server_name motorcade.vip"
  ```
