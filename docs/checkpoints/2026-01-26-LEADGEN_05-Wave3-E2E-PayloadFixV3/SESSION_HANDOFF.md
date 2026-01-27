# SESSION HANDOFF — motorcade-infra (LeadGen)

Current state:
- LEADGEN_06 (API keys) is succeeding and the container sees:
  - LEADGEN_INTAKE_API_KEY
  - LEADGEN_ADMIN_API_KEY
  - LEADGEN_API_KEY
- LEADGEN_05 Wave 3 E2E was failing due to:
  1) payload schema mismatch (fixed to nested contact/request)
  2) YAML parsing error from an over-escaped diagnostic line (removed)

Next step (run LEADGEN_05 v3):
1) Apply this merge zip in repo root:
   - cd ~/Repos/motorcade-infra
   - unzip -o ~/Downloads/motorcade-infra_LEADGEN_05_wave3_payload_fix_v3_checkpoint.zip

2) Run the playbook:
   - cd ~/Repos/motorcade-infra/ansible
   - ansible-playbook -i inventories/prod/hosts.ini playbooks/LEADGEN_05_wave3_intake_e2e_validation.yml --ask-vault-pass

If it fails again:
- Re-run with safe diagnostics:
  - ansible-playbook -v -i inventories/prod/hosts.ini playbooks/LEADGEN_05_wave3_intake_e2e_validation.yml --ask-vault-pass
- Capture the printed status + error code/message.

Notes:
- The intake POST task remains `no_log: true` to avoid leaking secrets.
- Safe diagnostics prints only status + code/message (no headers, no bodies).
