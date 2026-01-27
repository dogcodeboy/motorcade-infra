# Checkpoint — LEADGEN_05 Wave 3 E2E Payload Fix (v3)

Purpose:
- Fix YAML parse errors from prior diagnostic line (escape sequences).
- Use the correct *nested* intake payload schema (`contact` + `request`).
- Provide SAFE failure diagnostics (status + error code/message only) when run with `-v`.

What changed:
- `ansible/playbooks/LEADGEN_05_wave3_intake_e2e_validation.yml`

How to apply:
1) From your repo root:
   - `cd ~/Repos/motorcade-infra`
   - `unzip -o ~/Downloads/motorcade-infra_LEADGEN_05_wave3_payload_fix_v3_checkpoint.zip`

2) Run:
   - `cd ~/Repos/motorcade-infra/ansible`
   - `ansible-playbook -i inventories/prod/hosts.ini playbooks/LEADGEN_05_wave3_intake_e2e_validation.yml --ask-vault-pass`

If it fails:
- Rerun with verbosity to see SAFE diagnostics:
  - `ansible-playbook -v -i inventories/prod/hosts.ini playbooks/LEADGEN_05_wave3_intake_e2e_validation.yml --ask-vault-pass`
