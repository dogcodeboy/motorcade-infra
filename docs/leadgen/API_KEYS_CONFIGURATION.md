# LeadGen API Keys — Wave 1/2/3 alignment

## Why this exists
Wave 3 E2E validation (`LEADGEN_05`) calls `POST /lead/intake` using an `X-API-Key` header.

Inside the LeadGen API container, the middleware expects a configured **canonical** env var:

- `LEADGEN_API_KEY`

Historically, Wave 1 used split keys:

- `LEADGEN_INTAKE_API_KEY`
- `LEADGEN_ADMIN_API_KEY`

To prevent churn and keep compatibility, we maintain **all three**:

- `LEADGEN_INTAKE_API_KEY` (client uses this for intake)
- `LEADGEN_ADMIN_API_KEY` (reserved for admin endpoints)
- `LEADGEN_API_KEY` (canonical key expected by middleware)

By default, `LEADGEN_API_KEY` is set equal to `LEADGEN_INTAKE_API_KEY` unless you provide a separate `vault_leadgen_api_key`.

## Files
- `ansible/playbooks/LEADGEN_06_configure_api_keys.yml` — writes keys into `/etc/motorcade/leadgen.env` and restarts the service
- `ansible/playbooks/LEADGEN_05_wave3_intake_e2e_validation.yml` — validates health + intake POST

## Expected systemd env-file
The unit should include:

- `--env-file /etc/motorcade/leadgen.env`

You can confirm on the server:

```bash
sudo systemctl cat motorcade-leadgen-api.service | sed -n '1,200p'
```

## Run order
1) Configure keys (server-side) + restart:

```bash
cd ~/Repos/motorcade-infra/ansible
ansible-playbook -i inventories/prod/hosts.ini playbooks/LEADGEN_06_configure_api_keys.yml --ask-vault-pass
```

2) Run Wave 3 E2E validation:

```bash
cd ~/Repos/motorcade-infra/ansible
ansible-playbook -i inventories/prod/hosts.ini playbooks/LEADGEN_05_wave3_intake_e2e_validation.yml --ask-vault-pass
```

## Server-side verification (no secrets)
```bash
sudo grep -nE '^(LEADGEN_(INTAKE|ADMIN)_API_KEY|LEADGEN_API_KEY)=' /etc/motorcade/leadgen.env | sed 's/=.*$/=SET/'

sudo podman exec motorcade-leadgen-api sh -lc   'env | egrep -i "^(LEADGEN_(INTAKE|ADMIN)_API_KEY|LEADGEN_API_KEY)=" | sed "s/=.*$/=SET/"'
```
