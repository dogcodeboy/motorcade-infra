# Verify — LEADGEN_05 + LEADGEN_06

## 1) Keys exist in env file (server)
```bash
sudo grep -nE '^(LEADGEN_(INTAKE|ADMIN)_API_KEY|LEADGEN_API_KEY)=' /etc/motorcade/leadgen.env | sed 's/=.*$/=SET/'
```

Expected: 3 lines (intake/admin/api).

## 2) Container sees keys (names only)
```bash
sudo podman exec motorcade-leadgen-api sh -lc   'env | egrep -i "^(LEADGEN_(INTAKE|ADMIN)_API_KEY|LEADGEN_API_KEY)=" | sed "s/=.*$/=SET/"'
```

Expected: 3 lines.

## 3) E2E validation
Run LEADGEN_05 playbook; it should pass health and intake POST with a 200/201/409 status.
