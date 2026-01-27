SESSION HANDOFF — motorcade-infra — LEADGEN_05/06

Status:
- LEADGEN_06 is GREEN and ensures all three keys are present in /etc/motorcade/leadgen.env and the container.
- LEADGEN_05 Wave3 E2E is GREEN after FixV7.

What was wrong:
- LEADGEN API returned HTTP 202 Accepted (success), but LEADGEN_05 compared status as a string ("202") to an int list ([..., 202, ...]) and failed.

Fix in this checkpoint:
- LEADGEN_05: assert now uses `(leadgen_intake_status | int) in leadgen_accept_status`.

Next:
- Proceed to the next LeadGen step/runbook item (Wave 4+) once this checkpoint is committed.

Commands (copy/paste):
cd ~/Repos/motorcade-infra/ansible
ansible-playbook -i inventories/prod/hosts.ini playbooks/LEADGEN_06_configure_api_keys.yml --ask-vault-pass
ansible-playbook -i inventories/prod/hosts.ini playbooks/LEADGEN_05_wave3_intake_e2e_validation.yml --ask-vault-pass -v

Suggested commit message:
"LEADGEN_05: accept 202 by int-casting status (FixV7)"
