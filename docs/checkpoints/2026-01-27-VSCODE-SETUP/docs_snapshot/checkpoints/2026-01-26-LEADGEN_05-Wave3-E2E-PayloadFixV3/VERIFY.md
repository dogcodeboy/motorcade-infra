# VERIFY — LEADGEN_05 Wave 3 E2E (v3)

Run:
- `cd ~/Repos/motorcade-infra/ansible`
- `ansible-playbook -i inventories/prod/hosts.ini playbooks/LEADGEN_05_wave3_intake_e2e_validation.yml --ask-vault-pass`

Success criteria:
- Play ends with no failures.
- Intake POST returns status 200 or 201.

If failure:
- Re-run with `-v` and note:
  - status
  - error code
  - error message (truncated)
- Confirm the service still sees keys:
  - `sudo podman exec motorcade-leadgen-api sh -lc 'env | egrep -i "^(LEADGEN_(INTAKE|ADMIN)_API_KEY|LEADGEN_API_KEY)=" | sed "s/=.*$/=SET/"'`
