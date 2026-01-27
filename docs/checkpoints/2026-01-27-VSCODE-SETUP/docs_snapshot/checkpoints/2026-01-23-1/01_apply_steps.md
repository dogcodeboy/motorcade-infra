# Apply Steps (local control machine + target server)

## Where to unzip
Unzip into the **repo root** on your local machine:

- `~/Repos/motorcade-infra`

This zip is a repo-merge checkpoint (docs only + artifact copies). It does **not** deploy by itself.

## Confirm PLAT_05 is already merged
You already ran the “stable” PLAT_05 playbook successfully (nginx config test passed and `/api/lead/health` returned 200).

If you need to re-run it later:

```bash
cd ~/Repos/motorcade-infra
./scripts/run_playbook.sh motorcade-web-01 ansible/playbooks/PLAT_05_nginx_reverse_proxy_leadgen_api.yml --ask-vault-pass
```

## Verify on server
```bash
ssh motorcade
sudo nginx -t
curl -k -i https://127.0.0.1/api/lead/health
```

Optional external verify:
- Open in browser: `https://motorcade.vip/api/lead/health`
