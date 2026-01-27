SESSION HANDOFF — motorcade-infra

Status:
- systemd unit uses: --env-file /etc/motorcade/leadgen.env
- LeadGen container must have three env vars:
  - LEADGEN_INTAKE_API_KEY
  - LEADGEN_ADMIN_API_KEY
  - LEADGEN_API_KEY (canonical middleware key)

Next steps (copy/paste):
1) Apply merge zip into repo root:
   cd ~/Repos/motorcade-infra
   unzip -o ~/Downloads/motorcade-infra_LEADGEN_05_06_keys_e2e_fix.zip

2) Run LEADGEN_06 (writes keys to /etc/motorcade/leadgen.env + restart):
   cd ~/Repos/motorcade-infra/ansible
   ansible-playbook -i inventories/prod/hosts.ini playbooks/LEADGEN_06_configure_api_keys.yml --ask-vault-pass

3) Run LEADGEN_05 (Wave 3 E2E):
   ansible-playbook -i inventories/prod/hosts.ini playbooks/LEADGEN_05_wave3_intake_e2e_validation.yml --ask-vault-pass

4) Server verification (no secrets):
   sudo grep -nE '^(LEADGEN_(INTAKE|ADMIN)_API_KEY|LEADGEN_API_KEY)=' /etc/motorcade/leadgen.env | sed 's/=.*$/=SET/'
   sudo podman exec motorcade-leadgen-api sh -lc 'env | egrep -i "^(LEADGEN_(INTAKE|ADMIN)_API_KEY|LEADGEN_API_KEY)=" | sed "s/=.*$/=SET/"'

Commit message (GitKraken):
- "Fix LEADGEN_05 Wave3 E2E + LEADGEN_06 key alignment"
