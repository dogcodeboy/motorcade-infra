# VERIFY — LEADGEN_07B Authoritative PASS

## 1) Run the playbook (pinned app ref)

From your workstation:

```bash
cd ~/Repos/motorcade-infra/ansible

ansible-playbook -i inventories/prod/hosts.ini   playbooks/LEADGEN_07B_wave3_psycopg_driver_fix_and_persistence_verify.yml   --ask-vault-pass   -e leadgen_git_ref=44a9d47
```

### Expected PASS markers

- `Health | GET /lead/health (local)` returns `health_status=200`
- `Intake | POST /lead/intake` returns **202** (or 200/201/409)
- `DB Verify | count rows and show newest` shows `lead_rows >= 1` and a recent `newest`

Example PASS excerpt (from the verified run):

- `intake_status=202`
- body contains `"status":"accepted"`
- DB shows `lead_rows | newest` with a fresh timestamp

## 2) Optional: verify schema + endpoint directly on server

On motorcade-web-01:

```bash
curl -fsS http://127.0.0.1:8000/openapi.json -o /tmp/openapi.json
python3 - <<'PY'
import json
d=json.load(open("/tmp/openapi.json"))
print("POST endpoints:", [p for p,v in d.get("paths",{}).items() if "post" in {k.lower() for k in v.keys()}])
PY
```

Expected: `/lead/intake` is present.

## 3) DB schema sanity (required fields exist)

```bash
sudo /usr/local/bin/podman exec -it motorcade-postgres psql -U postgres -d motorcade -c "
SELECT column_name, data_type, udt_name
FROM information_schema.columns
WHERE table_schema='app' AND table_name='leads'
ORDER BY ordinal_position;"
```

Expected to include:

- `payload` jsonb
- `idempotency_key` (unique index)
- `created_at`, `updated_at`
- contact/request denormalized columns
