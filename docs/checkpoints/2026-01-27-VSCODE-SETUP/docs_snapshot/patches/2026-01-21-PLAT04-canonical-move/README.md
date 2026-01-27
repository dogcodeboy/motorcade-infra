PLAT_04 — Canonical Fix

This zip performs ONE action only:

• Moves PLAT_04 into the canonical Ansible root:
  ansible/playbooks/PLAT_04_lead_intake_api.yml

It intentionally does NOT include:
• ops/ansible/playbooks/*
• any vault changes
• any inventory changes

How to apply:

  cd ~/Repos
  unzip -o PLAT_04_MOVE_TO_CANONICAL_ANSIBLE_ROOT.zip

How to run:

  cd ~/Repos/motorcade-infra
  ansible-playbook \
    -i ansible/inventories/prod/hosts.ini \
    ansible/playbooks/PLAT_04_lead_intake_api.yml \
    --ask-vault-pass

Expected:
• group_vars auto-loads
• LEADGEN_API_KEY assertion passes
• image builds
• container starts
