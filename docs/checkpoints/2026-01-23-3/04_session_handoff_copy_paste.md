SESSION HANDOFF — motorcade-infra (PLAT_06A fix)

Problem encountered:
- Running PLAT_06 failed with:
  `ERROR! failed at splitting arguments ... set -euo pipefail ... <<'PY'`
  due to heredoc parsing in an Ansible `shell:` task.

Solution:
- Use PLAT_06A which writes a python scrubber script to /tmp and runs it via `command:`.

Next command:
```bash
cd ~/Repos/motorcade-infra/ansible
ansible-playbook -i inventories/prod/hosts.ini playbooks/PLAT_06A_nginx_http80_canonical_redirect.yml --ask-vault-pass
```
